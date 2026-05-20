Return-Path: <stable+bounces-252638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mERGAM0mDmpq6gUAu9opvQ
	(envelope-from <stable+bounces-252638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:25:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8123B59AD29
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD74A3441549
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D3B3F8706;
	Wed, 20 May 2026 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OASv7O1X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB43CCFB0;
	Wed, 20 May 2026 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301200; cv=none; b=iQ6MHNhIjjNbWDVnDBZv2vKVyj3EFvUlmeSzppkYN2xvIby1gxP+cI9DmqMCNZzBC0shdkPMZsuiwSVPxim1S74i9gmX3RCNEv8BsJIVkZzdLgbh3O6KUU6JLRPemfwDyZJdyB9t2p3uXL6ah40MSlgxu36jI6itkKv0kLUG+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301200; c=relaxed/simple;
	bh=d11wPmMI1arD6u1/DrSVrey4fi4KMbQ7MAHRW6trfb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmB+vnfvObDSiSnQ5uBmhskEs43uZSBvrPPPmoiz1Mjc3LpC00R4fvolEJl8V0MijyHiKlWjWNO6ikjNdHVHAPJ+2/fMIBjk+MWRcCmp4RfE9+dyXf4p4+nfXfIMlOZn8PiuhO1rKV6QAShOWh58htVBHZzN5zWUr2sWbLoTglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OASv7O1X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B921F000E9;
	Wed, 20 May 2026 18:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301199;
	bh=35zIdpgJ72VRTi7UAVXCypVerHzCP++IXego4F3xmq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OASv7O1XnbvEtod53+HzpIacdOTLftsPqWe7KHU8+rVbp8+EdS6mMd/iH6VVxfkeU
	 dIoxDhpYe0xhE688+02QcENKU5sWM2Gk2tUwOM99uRiDNIZrHsbwB0Ai1ErjfRjS7e
	 KpSdHwGmypKqEiBE6FjWCk/OMrBy0J86KABJTLDU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 463/666] sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
Date: Wed, 20 May 2026 18:21:14 +0200
Message-ID: <20260520162121.304709222@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252638-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 8123B59AD29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 0cf004ffb61cd32d140531c3a84afe975f9fc7ea ]

sctp_getsockopt_peer_auth_chunks() checks that the caller's optval
buffer is large enough for the peer AUTH chunk list with

    if (len < num_chunks)
            return -EINVAL;

but then writes num_chunks bytes to p->gauth_chunks, which lives
at offset offsetof(struct sctp_authchunks, gauth_chunks) == 8
inside optval.  The check is missing the sizeof(struct
sctp_authchunks) = 8-byte header.  When the caller supplies
len == num_chunks (for any num_chunks > 0) the test passes but
copy_to_user() writes sizeof(struct sctp_authchunks) = 8 bytes
past the declared buffer.

The sibling function sctp_getsockopt_local_auth_chunks() at the
next line already has the correct check:

    if (len < sizeof(struct sctp_authchunks) + num_chunks)
            return -EINVAL;

Align the peer variant with its sibling.

Reproducer confirms on v7.0-13-generic: an unprivileged userspace
caller that opens a loopback SCTP association with AUTH enabled,
queries num_chunks with a short optval, then issues the real
getsockopt with len == num_chunks and sentinel bytes painted past
the buffer observes those sentinel bytes overwritten with the
peer's AUTH chunk type.  The bytes written are under the peer's
control but land in the caller's own userspace; this is not a
kernel memory corruption, but it is a kernel-side contract
violation that can silently corrupt adjacent userspace data.

Fixes: 65b07e5d0d09 ("[SCTP]: API updates to suport SCTP-AUTH extensions.")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20260416031903.1447072-1-michael.bommarito@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c8038b4b67c71..6b562dd1aae11 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7003,7 +7003,7 @@ static int sctp_getsockopt_peer_auth_chunks(struct sock *sk, int len,
 
 	/* See if the user provided enough room for all the data */
 	num_chunks = ntohs(ch->param_hdr.length) - sizeof(struct sctp_paramhdr);
-	if (len < num_chunks)
+	if (len < sizeof(struct sctp_authchunks) + num_chunks)
 		return -EINVAL;
 
 	if (copy_to_user(to, ch->chunks, num_chunks))
-- 
2.53.0




