Return-Path: <stable+bounces-229875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDEoG0l9wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:50:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CD22FA7CD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C80F3104799
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE5B3BC666;
	Mon, 23 Mar 2026 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dAEa+FtK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228563B3BE5;
	Mon, 23 Mar 2026 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283099; cv=none; b=TNZwGWPISePsXGvEeD4hELRsXMjNlfbyVz9yybn6SzYxjFwIg6LPHR2dFnDxs0Y/NYtdztIuTadNF1TUWfiZn1a0i5FnQBvjUF4PHkFu1ieqAPrh10vickUhWx9WykoYGxga6nljl8n0Mvn20pUQZajCJNbK6v0VmDm5ielYrGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283099; c=relaxed/simple;
	bh=ZugOfbjP6wF7409rPbt6gko0HqrAXQTAEaHdg3uHVUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXGh71vIyJo/LLgCZDikwQBJjyul1kW7gYgD+ioHtC6v76owR01F2QL5rRB86NLPxpqE9KZh1uiE4qu47zWG/R21fbDp3vpTB69KEHMDIN+knHvza33E93zNUG6LMnW7lZgYX+QzLHVGAIGCjI17K6swmJVyDi7SEIboNg6JLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dAEa+FtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EDCC4CEF7;
	Mon, 23 Mar 2026 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283099;
	bh=ZugOfbjP6wF7409rPbt6gko0HqrAXQTAEaHdg3uHVUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAEa+FtKpdZNqbV+EtleukuK00AqsFuBN9fov9ks9pYsFZpeS6F40/Sn12GMXEezA
	 cLgdGYcP/wQpFgoA7JSknuoP+syBeVNw0lXz1HuTwirqUqoqGRlkBV21C/3blPxE+c
	 hS1mKAZgCwcV3dCzM9zfQ6tLmGURy7phivOr7hrI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 374/481] smb: client: Compare MACs in constant time
Date: Mon, 23 Mar 2026 14:45:56 +0100
Message-ID: <20260323134534.246146321@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229875-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,manguebit.org:email]
X-Rspamd-Queue-Id: E0CD22FA7CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@kernel.org>

commit 26bc83b88bbbf054f0980a4a42047a8d1e210e4c upstream.

To prevent timing attacks, MAC comparisons need to be constant-time.
Replace the memcmp() with the correct function, crypto_memneq().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifsencrypt.c   |    3 ++-
 fs/smb/client/smb2transport.c |    4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -23,6 +23,7 @@
 #include <linux/fips.h>
 #include "../common/arc4.h"
 #include <crypto/aead.h>
+#include <crypto/algapi.h>
 
 int __cifs_calc_signature(struct smb_rqst *rqst,
 			struct TCP_Server_Info *server, char *signature,
@@ -243,7 +244,7 @@ int cifs_verify_signature(struct smb_rqs
 /*	cifs_dump_mem("what we think it should be: ",
 		      what_we_think_sig_should_be, 16); */
 
-	if (memcmp(server_response_sig, what_we_think_sig_should_be, 8))
+	if (crypto_memneq(server_response_sig, what_we_think_sig_should_be, 8))
 		return -EACCES;
 	else
 		return 0;
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -19,6 +19,7 @@
 #include <linux/mempool.h>
 #include <linux/highmem.h>
 #include <crypto/aead.h>
+#include <crypto/algapi.h>
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "smb2proto.h"
@@ -699,7 +700,8 @@ smb2_verify_signature(struct smb_rqst *r
 	if (rc)
 		return rc;
 
-	if (memcmp(server_response_sig, shdr->Signature, SMB2_SIGNATURE_SIZE)) {
+	if (crypto_memneq(server_response_sig, shdr->Signature,
+			  SMB2_SIGNATURE_SIZE)) {
 		cifs_dbg(VFS, "sign fail cmd 0x%x message id 0x%llx\n",
 			shdr->Command, shdr->MessageId);
 		return -EACCES;



