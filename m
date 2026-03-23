Return-Path: <stable+bounces-228706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MgcMeJmwWlESwQAu9opvQ
	(envelope-from <stable+bounces-228706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:14:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E932F7C8A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BC89322955B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB63AE70E;
	Mon, 23 Mar 2026 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dcXvFPuM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48843AEF58;
	Mon, 23 Mar 2026 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276904; cv=none; b=FqiBb9+l9gMU1esRZaSC7d4l5Ky/4L+HPkqm2yP51A4BPrNIpz5bCrB+XX1zaxMhTosbNv+YwhQS0WrO41rLu1jfLzJDnpA3WmP5iMU6adVngz0SBjUeeUfGq59N2E36/V0W6T97Le4cGABm0K4clHBbUKXfr7hPVhgS76hLI7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276904; c=relaxed/simple;
	bh=dYKn953fiaqymhgFXUsdtjV3482I0OKqZL3k7ErKtVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXrxFmImCAy43yqafmafNxItBo/inyEF+k4hqIbG25oPL9oTj+thOEgB6LvwJ3AYTZS3N+k1E4K8ApatO1rA8c53n444Aykjmv4VSCracFUapAFZ6InAfpXnuIeEtH5j2ElgbkU+wajO7xk1MiZm9XT6xMJyFGCuFtNWIMcaXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dcXvFPuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ADAC4CEF7;
	Mon, 23 Mar 2026 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774276903;
	bh=dYKn953fiaqymhgFXUsdtjV3482I0OKqZL3k7ErKtVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dcXvFPuMmILsZsWvC7i9Qb9pnDcVeJ9Qk93ylfGa9/+7wByOMKIr/RPc/UlxH5NML
	 Oyyuym6f8h1LcsYLC0Pd4kUB1xv1AwmdOw9vhv3xy+Yt5k2Z+WIoc97PpGrJNeYdkV
	 RyNYbk4FlzOFU+aDIM1Q4JaaSlPfJee9eegdAFoc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Marco Schirrmeister <mschirrmeister@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 249/460] mmc: dw_mmc-rockchip: Fix runtime PM support for internal phase support
Date: Mon, 23 Mar 2026 14:44:05 +0100
Message-ID: <20260323134532.615228123@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,rock-chips.com,gmail.com,sntech.de,linaro.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-228706-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rock-chips.com:email,sntech.de:email]
X-Rspamd-Queue-Id: 40E932F7C8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 6465a8bbb0f6ad98aeb66dc9ea19c32c193a610b ]

RK3576 is the first platform to introduce internal phase support, and
subsequent platforms are expected to adopt a similar design. In this
architecture, runtime suspend powers off the attached power domain, which
resets registers, including vendor-specific ones such as SDMMC_TIMING_CON0,
SDMMC_TIMING_CON1, and SDMMC_MISC_CON. These registers must be saved and
restored, a requirement that falls outside the scope of the dw_mmc core.

Fixes: 59903441f5e4 ("mmc: dw_mmc-rockchip: Add internal phase support")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Marco Schirrmeister <mschirrmeister@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/dw_mmc-rockchip.c |   38 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -37,6 +37,8 @@ struct dw_mci_rockchip_priv_data {
 	int			default_sample_phase;
 	int			num_phases;
 	bool			internal_phase;
+	int                     sample_phase;
+	int                     drv_phase;
 };
 
 /*
@@ -573,9 +575,43 @@ static void dw_mci_rockchip_remove(struc
 	dw_mci_pltfm_remove(pdev);
 }
 
+static int dw_mci_rockchip_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_mci *host = platform_get_drvdata(pdev);
+	struct dw_mci_rockchip_priv_data *priv = host->priv;
+
+	if (priv->internal_phase) {
+		priv->sample_phase = rockchip_mmc_get_phase(host, true);
+		priv->drv_phase = rockchip_mmc_get_phase(host, false);
+	}
+
+	return dw_mci_runtime_suspend(dev);
+}
+
+static int dw_mci_rockchip_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_mci *host = platform_get_drvdata(pdev);
+	struct dw_mci_rockchip_priv_data *priv = host->priv;
+	int ret;
+
+	ret = dw_mci_runtime_resume(dev);
+	if (ret)
+		return ret;
+
+	if (priv->internal_phase) {
+		rockchip_mmc_set_phase(host, true, priv->sample_phase);
+		rockchip_mmc_set_phase(host, false, priv->drv_phase);
+		mci_writel(host, MISC_CON, MEM_CLK_AUTOGATE_ENABLE);
+	}
+
+	return ret;
+}
+
 static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
-	RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
+	RUNTIME_PM_OPS(dw_mci_rockchip_runtime_suspend, dw_mci_rockchip_runtime_resume, NULL)
 };
 
 static struct platform_driver dw_mci_rockchip_pltfm_driver = {



