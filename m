Return-Path: <stable+bounces-250040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAmKIzriDWop4gUAu9opvQ
	(envelope-from <stable+bounces-250040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:32:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBF4592114
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 688F3307D785
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DEE3A3E9C;
	Wed, 20 May 2026 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JPOS226z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0436F418;
	Wed, 20 May 2026 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294386; cv=none; b=coSC/d29CKr9bgOgls6zV21kEgxD91MKqEJFrj435wg9nka05eIAN+pJKetHbUqkeI1+oD45oxgFtu6vKrV8Nb5mIkm4M75CZyGHgaeKxNBu0thaMDwu8F6ZIE/DLr6GkQ/PK5Sq7ZcqUpmzaN3n+wm5q23Rzw+sI+6bKEyQpm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294386; c=relaxed/simple;
	bh=LwHK8fIEGuozMCKNUz6nu5xqngMCfPnZlcEZbnq3OKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CW3ZYwVq7NKG1XfkBMEWoWXT4q63IszBXbxQoGI8OW7p4/Vjjs74+Y9IfRYVeB68R7dDx/PHPWHKiopKaSlAANNsEV45ZuVjDAKCYlZtGw7rSCCh8YmVuW9Piy+WfsKfDNLHOKoxYSJPTG9XbUSLCuLSydtL6iMuuyL1b1Z4aJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JPOS226z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CE41F00893;
	Wed, 20 May 2026 16:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294384;
	bh=soBNOMBJqhTq3+7ATVyXyanyUW2w66gxgspM+8fReHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JPOS226z8lICpf17PoEQ8ACfuZFxR2KETbGgJI/0rcvaAj/iI3EcV7AG0crmKLHKP
	 HVQmBhKcPbW7LtDbuS3c9qlxwiLu/MOZNszHkv33UvFZ677e0UGnJfCpNSP2GgvCY4
	 W58hzDFiE5eiWFGhErXUfQrT1J8bGU4LPq3kcNUQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tj <tj.iam.tj@proton.me>,
	Chen Cheng <chencheng@fnnas.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Yu Kuai <yukuai@fnnas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0002/1146] md: suppress spurious superblock update error message for dm-raid
Date: Wed, 20 May 2026 18:04:12 +0200
Message-ID: <20260520162148.451131860@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250040-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3EBF4592114
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Cheng <chencheng@fnnas.com>

[ Upstream commit eff0d74c6c8fd358bc9474c05002e51fa5aa56ad ]

dm-raid has external metadata management (mddev->external = 1) and
no persistent superblock (mddev->persistent = 0). For these arrays,
there's no superblock to update, so the error message is spurious.

The error appears as:
md_update_sb: can't update sb for read-only array md0

Fixes: 8c9e376b9d1a ("md: warn about updating super block failure")
Reported-by: Tj <tj.iam.tj@proton.me>
Closes: https://lore.kernel.org/all/20260128082430.96788-1-tj.iam.tj@proton.me/
Signed-off-by: Chen Cheng <chencheng@fnnas.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Link: https://lore.kernel.org/linux-raid/20260210133847.269986-1-chencheng@fnnas.com
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3ce6f9e9d38e6..c2cc2302d727d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2788,7 +2788,9 @@ void md_update_sb(struct mddev *mddev, int force_change)
 	if (!md_is_rdwr(mddev)) {
 		if (force_change)
 			set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-		pr_err("%s: can't update sb for read-only array %s\n", __func__, mdname(mddev));
+		if (!mddev_is_dm(mddev))
+			pr_err_ratelimited("%s: can't update sb for read-only array %s\n",
+					   __func__, mdname(mddev));
 		return;
 	}
 
-- 
2.53.0




