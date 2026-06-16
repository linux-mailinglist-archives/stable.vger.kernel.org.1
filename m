Return-Path: <stable+bounces-266245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4i+EGlyZMWp8nwUAu9opvQ
	(envelope-from <stable+bounces-266245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:43:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF31694630
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:43:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="PMLV/PIu";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266245-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266245-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5274F3099D3C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A2478E3E;
	Tue, 16 Jun 2026 18:43:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B487738C437;
	Tue, 16 Jun 2026 18:43:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635414; cv=none; b=d23FA0E3/W3PalL/v9BrCHtCysSMcPyGWQGvs1qIaq0YBqomon+fmvaz8sDyhEJZA6oAJk0E2EpvfLPh/Y7CdvpZaw7DdPZ2D/2KZNrLBPbErhbA0CKRd8BrErxD7kdqp0f3SNhhCWyt0QeS8irUVQ7ZqbzNfq74z1mB5EUsPtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635414; c=relaxed/simple;
	bh=dUdMb8Ap8P2TAxFA86d/1QjUmfEm+nVlHWokXYqfymI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKGhkj8Tv/hOZnVHstKHFdxDvJMbw9FuiCZySUMMlPOV6PdsHn964elp8vmARf4aZ/Kr5uf5tnPyTzjijWCnmrFPBEYafYdGDZblrLcKd4zB3H14j7J2JP7DamnBiJGmFtaAumitOy5/h8UEjoOAjmBHaPvEqrCrMrpjlm2xbVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PMLV/PIu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B971F000E9;
	Tue, 16 Jun 2026 18:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635413;
	bh=V9wMoyQqU1WViNCRjFa5pY+TxWwmNJSm+yJM/bcidhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PMLV/PIug2IG9g3UbSDfpAo5DcPjBb1hzwWQ+pYzzzhZM12UPNpBkLKEk66i9DXag
	 DubzofQbp6KwnCg4buZ0WQm33bYMzJRcp6SVu4MAWJvw5odxDgv+sk6k9HhXzTwJxV
	 bXwtSOwT60izeabe0xF72grCKBPPVNN8ViPdlf2E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Stefan Metzmacher <metze@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 043/342] smb: client: fix smbdirect_recv_io leak in smbd_negotiate() error path
Date: Tue, 16 Jun 2026 20:25:39 +0530
Message-ID: <20260616145050.263486060@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-266245-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:smfrench@gmail.com,m:tom@talpey.com,m:longli@microsoft.com,m:linkinjeon@kernel.org,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:metze@samba.org,m:stfrench@microsoft.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,talpey.com,microsoft.com,kernel.org,vger.kernel.org,lists.samba.org,samba.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,talpey.com:email,samba.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBF31694630

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Metzmacher <metze@samba.org>

[ Upstream commit daac51c7032036a0ca5f1aa419ad1b0471d1c6e0 ]

During tests of another unrelated patch I was able to trigger this
error: Objects remaining on __kmem_cache_shutdown()

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Fixes: f198186aa9bb ("CIFS: SMBD: Establish SMB Direct connection")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smbdirect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index ae332f3771f634..e273f3b9efcb63 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -1083,8 +1083,10 @@ static int smbd_negotiate(struct smbd_connection *info)
 	log_rdma_event(INFO, "smbd_post_recv rc=%d iov.addr=%llx iov.length=%x iov.lkey=%x\n",
 		       rc, response->sge.addr,
 		       response->sge.length, response->sge.lkey);
-	if (rc)
+	if (rc) {
+		put_receive_buffer(info, response);
 		return rc;
+	}
 
 	init_completion(&info->negotiate_completion);
 	info->negotiate_done = false;
-- 
2.53.0




