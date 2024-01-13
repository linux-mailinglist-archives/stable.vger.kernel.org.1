Return-Path: <stable+bounces-10741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B4182CB6E
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B661C21A5F
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A386C1848;
	Sat, 13 Jan 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WUdg+Kh0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDD0EC5;
	Sat, 13 Jan 2024 09:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21C4C43390;
	Sat, 13 Jan 2024 09:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705139967;
	bh=82WdXyrSyjvDb9GrgVmjvH7eVv5Bk/N8aZTylot5/hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUdg+Kh09SD+b2/HZ+kEOgP1aH8nBj5Z/tliIXOdDmhaUXlAs9ro5M8FwttvaFkfo
	 hLyU+j2VbyVLA//ptimO5yLPXccdi4KjCkHBCQJeQeIOu3QFBoTQ6sNCfBJMgcgvAA
	 3+Q//e5yZTHHjRtjtV+nJW9OmTSVB4/KutWAxOS0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Edward Adam Davis <eadavis@qq.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jeffrey E Altman <jaltman@auristor.com>,
	Wang Lei <wang840925@gmail.com>,
	Jeff Layton <jlayton@redhat.com>,
	Steve French <sfrench@us.ibm.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com
Subject: [PATCH 5.15 01/59] keys, dns: Fix missing size check of V1 server-list header
Date: Sat, 13 Jan 2024 10:49:32 +0100
Message-ID: <20240113094209.351127507@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094209.301672391@linuxfoundation.org>
References: <20240113094209.301672391@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Adam Davis <eadavis@qq.com>

commit 1997b3cb4217b09e49659b634c94da47f0340409 upstream.

The dns_resolver_preparse() function has a check on the size of the
payload for the basic header of the binary-style payload, but is missing
a check for the size of the V1 server-list payload header after
determining that's what we've been given.

Fix this by getting rid of the the pointer to the basic header and just
assuming that we have a V1 server-list payload and moving the V1 server
list pointer inside the if-statement.  Dealing with other types and
versions can be left for when such have been defined.

This can be tested by doing the following with KASAN enabled:

    echo -n -e '\x0\x0\x1\x2' | keyctl padd dns_resolver foo @p

and produces an oops like the following:

    BUG: KASAN: slab-out-of-bounds in dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
    Read of size 1 at addr ffff888028894084 by task syz-executor265/5069
    ...
    Call Trace:
      dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
      __key_create_or_update+0x453/0xdf0 security/keys/key.c:842
      key_create_or_update+0x42/0x50 security/keys/key.c:1007
      __do_sys_add_key+0x29c/0x450 security/keys/keyctl.c:134
      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
      do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
      entry_SYSCALL_64_after_hwframe+0x62/0x6a

This patch was originally by Edward Adam Davis, but was modified by
Linus.

Fixes: b946001d3bb1 ("keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry")
Reported-and-tested-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/0000000000009b39bc060c73e209@google.com/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: David Howells <dhowells@redhat.com>
Cc: Edward Adam Davis <eadavis@qq.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jeffrey E Altman <jaltman@auristor.com>
Cc: Wang Lei <wang840925@gmail.com>
Cc: Jeff Layton <jlayton@redhat.com>
Cc: Steve French <sfrench@us.ibm.com>
Cc: Marc Dionne <marc.dionne@auristor.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeffrey E Altman <jaltman@auristor.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dns_resolver/dns_key.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -91,8 +91,6 @@ const struct cred *dns_resolver_cache;
 static int
 dns_resolver_preparse(struct key_preparsed_payload *prep)
 {
-	const struct dns_server_list_v1_header *v1;
-	const struct dns_payload_header *bin;
 	struct user_key_payload *upayload;
 	unsigned long derrno;
 	int ret;
@@ -103,27 +101,28 @@ dns_resolver_preparse(struct key_prepars
 		return -EINVAL;
 
 	if (data[0] == 0) {
+		const struct dns_server_list_v1_header *v1;
+
 		/* It may be a server list. */
-		if (datalen <= sizeof(*bin))
+		if (datalen <= sizeof(*v1))
 			return -EINVAL;
 
-		bin = (const struct dns_payload_header *)data;
-		kenter("[%u,%u],%u", bin->content, bin->version, datalen);
-		if (bin->content != DNS_PAYLOAD_IS_SERVER_LIST) {
+		v1 = (const struct dns_server_list_v1_header *)data;
+		kenter("[%u,%u],%u", v1->hdr.content, v1->hdr.version, datalen);
+		if (v1->hdr.content != DNS_PAYLOAD_IS_SERVER_LIST) {
 			pr_warn_ratelimited(
 				"dns_resolver: Unsupported content type (%u)\n",
-				bin->content);
+				v1->hdr.content);
 			return -EINVAL;
 		}
 
-		if (bin->version != 1) {
+		if (v1->hdr.version != 1) {
 			pr_warn_ratelimited(
 				"dns_resolver: Unsupported server list version (%u)\n",
-				bin->version);
+				v1->hdr.version);
 			return -EINVAL;
 		}
 
-		v1 = (const struct dns_server_list_v1_header *)bin;
 		if ((v1->status != DNS_LOOKUP_GOOD &&
 		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
 			if (prep->expiry == TIME64_MAX)



