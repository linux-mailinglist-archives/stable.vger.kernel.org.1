Return-Path: <stable+bounces-228644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDjdGEpVwWlTSQQAu9opvQ
	(envelope-from <stable+bounces-228644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:59:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A272F5945
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD6A631BC020
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1F1F91F6;
	Mon, 23 Mar 2026 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0U11uFXP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7077199FAB;
	Mon, 23 Mar 2026 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275698; cv=none; b=AbWLDKBK79SKZ3Xxz/gLaNCwL5XS61hs+Rc9tVV9IxvrKYjjQsY09Vda4gJU0mGpd2Yt/UnSoEuKALrtEFLlBVKLI8Or5mFkBstqst8xoYx3BOmgXIZlkdqJYeHEzMvyME5j9BRV42bTQiPhmBBUFi07Z1SrU7oB3U8KQsOzb/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275698; c=relaxed/simple;
	bh=jUgPesj+ge/XYaz711lGru/H+O4B3mT5aW1VJydIKeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOqi2vmi8QS/JwBTA6C7QB6voz7O/egNIs9AdEcUyuhhgDCEty0sq+2ZPIKJt28ZBycEsKmrt1RBmoBO/uVCdEoSjyU7xs02cfmfgCtFzme8tx7Nt6uWin7l4LqyVqWQrVunq/Rv9bRVsRN8R9AO4CZHeWmf+0WfeD32yBHXcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0U11uFXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDFFC4CEF7;
	Mon, 23 Mar 2026 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275698;
	bh=jUgPesj+ge/XYaz711lGru/H+O4B3mT5aW1VJydIKeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0U11uFXP2VjY4VmhgYBim5c6FxLatoBG87IAZNq17kJU1ZIxBvg+WF7j49/eLjllS
	 JpKi+Vtyn9+RvlTH4giDuFkLHMBZnwastw5q8MopU2y2NhvVtp/mteaX9d5/wPeytS
	 QK3o9GyE1w1JWtSAH1+sfNnWd5aeUZT3kPpogG6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bharath SM <bharathsm@microsoft.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 186/460] cifs: make default value of retrans as zero
Date: Mon, 23 Mar 2026 14:43:02 +0100
Message-ID: <20260323134531.121647504@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228644-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B4A272F5945
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

commit e3beefd3af09f8e460ddaf39063d3d7664d7ab59 upstream.

When retrans mount option was introduced, the default value was set
as 1. However, in the light of some bugs that this has exposed recently
we should change it to 0 and retain the old behaviour before this option
was introduced.

Cc: <stable@vger.kernel.org>
Reviewed-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/fs_context.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1847,7 +1847,7 @@ int smb3_init_fs_context(struct fs_conte
 	ctx->backupuid_specified = false; /* no backup intent for a user */
 	ctx->backupgid_specified = false; /* no backup intent for a group */
 
-	ctx->retrans = 1;
+	ctx->retrans = 0;
 	ctx->reparse_type = CIFS_REPARSE_TYPE_DEFAULT;
 
 /*



