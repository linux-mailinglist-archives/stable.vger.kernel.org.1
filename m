Return-Path: <stable+bounces-218536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WABUEg9Tnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA5018F690
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 899C73112136
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D9D25228D;
	Wed, 25 Feb 2026 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mdN1q5tH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F34242D9B;
	Wed, 25 Feb 2026 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983374; cv=none; b=qO9LJPDdChx2Qwz4ETWYK1Clcjmj4OYy+M7wFd4nXnjddjl+y4vffhTiZ1llvl+6wckrDDc73u3F0JbtWxd7OZlm1V9q6zBLFjFJodtAQnjxaE9t6sZ2n+cZfu4cQF1pQ39Hjv6oJeaxHkOUH0zOCeTYvJTzup5oZAUFgQHE1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983374; c=relaxed/simple;
	bh=6tPBoOCApVicR+1mFAGVYTkXAyMjAMSJ0iXyZe3j8wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+FvACLtnQuYTGd+2gYOp2cYn3E5tg6hGNxef8+6q9ATMeG79vbQkE7balvGzDx0FWLTuzacIBtVgGzzWZPgITsYQDQ+Yocb16yP87mefaFlhqK9lBt+8VKLCxQbZKqfOhsOuLS4VTeRvaWeb7rZTgGWo/BGePHkR16KaKSLRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mdN1q5tH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DFCC116D0;
	Wed, 25 Feb 2026 01:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983373;
	bh=6tPBoOCApVicR+1mFAGVYTkXAyMjAMSJ0iXyZe3j8wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mdN1q5tHQno6v8DovqwQshglRQmgKewpTEAIi9eTaF0icjnMMZJUflSuu9/wOV6vK
	 H6N1whiSJuNy4qVmFDV4Y+KD8HAdlKwhKB6XtrIp+WPRQoLm/OW39erseFbVkNUoxe
	 iYvnuFq/WRgc8ORvY7jkDNIn3gQJbTzuIObWButY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 499/781] scsi: ufs: host: mediatek: Require CONFIG_PM
Date: Tue, 24 Feb 2026 17:20:08 -0800
Message-ID: <20260225012412.040083289@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218536-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,msgid.link:url,arndb.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BA5018F690
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit bbb8d98fb4536594cb104fd630ea0f7dce3771d6 ]

The added print statement from a recent fix causes the driver to fail
building when CONFIG_PM is disabled:

drivers/ufs/host/ufs-mediatek.c: In function 'ufs_mtk_resume':
drivers/ufs/host/ufs-mediatek.c:1890:40: error: 'struct dev_pm_info' has no member named 'request'
 1890 |                         hba->dev->power.request,

It seems unlikely that the driver can work at all without CONFIG_PM, so
just add a dependency and remove the existing ifdef checks, rather than
adding another ifdef.

Fixes: 15ef3f5aa822 ("scsi: ufs: host: mediatek: Enhance recovery on resume failure")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patch.msgid.link/20260202095052.1232703-1-arnd@kernel.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/host/Kconfig        |  1 +
 drivers/ufs/host/ufs-mediatek.c | 12 +++---------
 include/ufs/ufshcd.h            |  4 ----
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
index 7d5117b2dab4a..964ae70e7390d 100644
--- a/drivers/ufs/host/Kconfig
+++ b/drivers/ufs/host/Kconfig
@@ -72,6 +72,7 @@ config SCSI_UFS_QCOM
 config SCSI_UFS_MEDIATEK
 	tristate "Mediatek specific hooks to UFS controller platform driver"
 	depends on SCSI_UFSHCD_PLATFORM && ARCH_MEDIATEK
+	depends on PM
 	depends on RESET_CONTROLLER
 	select PHY_MTK_UFS
 	select RESET_TI_SYSCON
diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 66b11cc0703bd..b3daaa07e9252 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -2437,7 +2437,6 @@ static void ufs_mtk_remove(struct platform_device *pdev)
 	ufshcd_pltfrm_remove(pdev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int ufs_mtk_system_suspend(struct device *dev)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
@@ -2484,9 +2483,7 @@ static int ufs_mtk_system_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-#ifdef CONFIG_PM
 static int ufs_mtk_runtime_suspend(struct device *dev)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
@@ -2525,13 +2522,10 @@ static int ufs_mtk_runtime_resume(struct device *dev)
 
 	return ufshcd_runtime_resume(dev);
 }
-#endif
 
 static const struct dev_pm_ops ufs_mtk_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ufs_mtk_system_suspend,
-				ufs_mtk_system_resume)
-	SET_RUNTIME_PM_OPS(ufs_mtk_runtime_suspend,
-			   ufs_mtk_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(ufs_mtk_system_suspend, ufs_mtk_system_resume)
+	RUNTIME_PM_OPS(ufs_mtk_runtime_suspend, ufs_mtk_runtime_resume, NULL)
 	.prepare	 = ufshcd_suspend_prepare,
 	.complete	 = ufshcd_resume_complete,
 };
@@ -2541,7 +2535,7 @@ static struct platform_driver ufs_mtk_pltform = {
 	.remove = ufs_mtk_remove,
 	.driver = {
 		.name   = "ufshcd-mtk",
-		.pm     = &ufs_mtk_pm_ops,
+		.pm     = pm_ptr(&ufs_mtk_pm_ops),
 		.of_match_table = ufs_mtk_of_match,
 	},
 };
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 19154228780b2..8e15c3a70ed41 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1342,17 +1342,13 @@ static inline void *ufshcd_get_variant(struct ufs_hba *hba)
 	return hba->priv;
 }
 
-#ifdef CONFIG_PM
 extern int ufshcd_runtime_suspend(struct device *dev);
 extern int ufshcd_runtime_resume(struct device *dev);
-#endif
-#ifdef CONFIG_PM_SLEEP
 extern int ufshcd_system_suspend(struct device *dev);
 extern int ufshcd_system_resume(struct device *dev);
 extern int ufshcd_system_freeze(struct device *dev);
 extern int ufshcd_system_thaw(struct device *dev);
 extern int ufshcd_system_restore(struct device *dev);
-#endif
 
 extern int ufshcd_dme_reset(struct ufs_hba *hba);
 extern int ufshcd_dme_enable(struct ufs_hba *hba);
-- 
2.51.0




