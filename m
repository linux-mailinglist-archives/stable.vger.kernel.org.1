Return-Path: <stable+bounces-94859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE32B9D6FBD
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2201622DC
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E98D1F9425;
	Sun, 24 Nov 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6zjNjXJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E21DEFC0;
	Sun, 24 Nov 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452839; cv=none; b=K7KX1miiLBqxGjj7j5RSGTsVXMVf6etFZyaeyhEb7/LQAjzEXcNrr82eecPh1eq2qYxF1+v68vdg4JvNnjxmB0Gtg8IwSvtiknUvNHMO4CTdbnFYPRLdG9TI5XD8RT5TprfS1U4F0W/jauqQxhu1IwykwqZQKO84j3aBAgRWuyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452839; c=relaxed/simple;
	bh=/wvMxT3t64anURdRebvqqCvN+x70v8LFq801MdFRNBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJ8+K0VFmoaOJSD5ru8cDrm3/0QXIuAMYfZeJZMqA4M2pLIBglZDS4UgjMYdN1pozAEwiq7Y8E5gGURiJzg17TLD7fvBYCKzaxJCKhiXTSMSbeVpoAi+2BlgStuU25n9T39zjgiGWKvcglTJHpnTn+pNts8oTl30qXvvDEQMF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6zjNjXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EDCC4CECC;
	Sun, 24 Nov 2024 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452838;
	bh=/wvMxT3t64anURdRebvqqCvN+x70v8LFq801MdFRNBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n6zjNjXJEc2swcfDCUhvrcDhVECgATdlsrGwLJlkaKtCF3qXzUcVwxBwTiETdwM9y
	 YymZ4E6dgBVruHF4BXapr5+8NNv5+N2wzhJzienWnqNdKFdwGXLEcgvfoJvI+L5RRT
	 FvHbdk+rN85Yr+hderweA3E+FYVSB7q0SkB7geemqlwYAuQouXoAtGVm0NIHKwCM+w
	 ivV5agojfh+7ugipZD+GmHlEgwIWadcEjNK2/klLA/ov+ZSA3IkJGggzIVB9Dv9vE5
	 hyVDwXd51PVmA/UHCNouxQ3LKmNSfCwgPZIUe/AYlqXjWAcanbiDZPNjPUgRW2/Ps1
	 AdKTh1PK55jBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	neil.armstrong@linaro.org,
	linus.walleij@linaro.org,
	quic_jjohnson@quicinc.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 11/16] soc: imx8m: Probe the SoC driver as platform driver
Date: Sun, 24 Nov 2024 07:52:29 -0500
Message-ID: <20241124125311.3340223-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124125311.3340223-1-sashal@kernel.org>
References: <20241124125311.3340223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marex@denx.de>

[ Upstream commit 9cc832d37799dbea950c4c8a34721b02b8b5a8ff ]

With driver_async_probe=* on kernel command line, the following trace is
produced because on i.MX8M Plus hardware because the soc-imx8m.c driver
calls of_clk_get_by_name() which returns -EPROBE_DEFER because the clock
driver is not yet probed. This was not detected during regular testing
without driver_async_probe.

Convert the SoC code to platform driver and instantiate a platform device
in its current device_initcall() to probe the platform driver. Rework
.soc_revision callback to always return valid error code and return SoC
revision via parameter. This way, if anything in the .soc_revision callback
return -EPROBE_DEFER, it gets propagated to .probe and the .probe will get
retried later.

"
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1 at drivers/soc/imx/soc-imx8m.c:115 imx8mm_soc_revision+0xdc/0x180
CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-next-20240924-00002-g2062bb554dea #603
Hardware name: DH electronics i.MX8M Plus DHCOM Premium Developer Kit (3) (DT)
pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : imx8mm_soc_revision+0xdc/0x180
lr : imx8mm_soc_revision+0xd0/0x180
sp : ffff8000821fbcc0
x29: ffff8000821fbce0 x28: 0000000000000000 x27: ffff800081810120
x26: ffff8000818a9970 x25: 0000000000000006 x24: 0000000000824311
x23: ffff8000817f42c8 x22: ffff0000df8be210 x21: fffffffffffffdfb
x20: ffff800082780000 x19: 0000000000000001 x18: ffffffffffffffff
x17: ffff800081fff418 x16: ffff8000823e1000 x15: ffff0000c03b65e8
x14: ffff0000c00051b0 x13: ffff800082790000 x12: 0000000000000801
x11: ffff80008278ffff x10: ffff80008209d3a6 x9 : ffff80008062e95c
x8 : ffff8000821fb9a0 x7 : 0000000000000000 x6 : 00000000000080e3
x5 : ffff0000df8c03d8 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : fffffffffffffdfb x0 : fffffffffffffdfb
Call trace:
 imx8mm_soc_revision+0xdc/0x180
 imx8_soc_init+0xb0/0x1e0
 do_one_initcall+0x94/0x1a8
 kernel_init_freeable+0x240/0x2a8
 kernel_init+0x28/0x140
 ret_from_fork+0x10/0x20
---[ end trace 0000000000000000 ]---
SoC: i.MX8MP revision 1.1
"

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/imx/soc-imx8m.c | 107 ++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index ec87d9d878f30..1ff8c7d847a9e 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -30,7 +30,7 @@
 
 struct imx8_soc_data {
 	char *name;
-	u32 (*soc_revision)(void);
+	int (*soc_revision)(u32 *socrev);
 };
 
 static u64 soc_uid;
@@ -51,24 +51,29 @@ static u32 imx8mq_soc_revision_from_atf(void)
 static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
 #endif
 
-static u32 __init imx8mq_soc_revision(void)
+static int imx8mq_soc_revision(u32 *socrev)
 {
 	struct device_node *np;
 	void __iomem *ocotp_base;
 	u32 magic;
 	u32 rev;
 	struct clk *clk;
+	int ret;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
 	if (!np)
-		return 0;
+		return -EINVAL;
 
 	ocotp_base = of_iomap(np, 0);
-	WARN_ON(!ocotp_base);
+	if (!ocotp_base) {
+		ret = -EINVAL;
+		goto err_iomap;
+	}
+
 	clk = of_clk_get_by_name(np, NULL);
 	if (IS_ERR(clk)) {
-		WARN_ON(IS_ERR(clk));
-		return 0;
+		ret = PTR_ERR(clk);
+		goto err_clk;
 	}
 
 	clk_prepare_enable(clk);
@@ -88,32 +93,45 @@ static u32 __init imx8mq_soc_revision(void)
 	soc_uid <<= 32;
 	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
 
+	*socrev = rev;
+
 	clk_disable_unprepare(clk);
 	clk_put(clk);
 	iounmap(ocotp_base);
 	of_node_put(np);
 
-	return rev;
+	return 0;
+
+err_clk:
+	iounmap(ocotp_base);
+err_iomap:
+	of_node_put(np);
+	return ret;
 }
 
-static void __init imx8mm_soc_uid(void)
+static int imx8mm_soc_uid(void)
 {
 	void __iomem *ocotp_base;
 	struct device_node *np;
 	struct clk *clk;
+	int ret = 0;
 	u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
 		     IMX8MP_OCOTP_UID_OFFSET : 0;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
 	if (!np)
-		return;
+		return -EINVAL;
 
 	ocotp_base = of_iomap(np, 0);
-	WARN_ON(!ocotp_base);
+	if (!ocotp_base) {
+		ret = -EINVAL;
+		goto err_iomap;
+	}
+
 	clk = of_clk_get_by_name(np, NULL);
 	if (IS_ERR(clk)) {
-		WARN_ON(IS_ERR(clk));
-		return;
+		ret = PTR_ERR(clk);
+		goto err_clk;
 	}
 
 	clk_prepare_enable(clk);
@@ -124,31 +142,41 @@ static void __init imx8mm_soc_uid(void)
 
 	clk_disable_unprepare(clk);
 	clk_put(clk);
+
+err_clk:
 	iounmap(ocotp_base);
+err_iomap:
 	of_node_put(np);
+
+	return ret;
 }
 
-static u32 __init imx8mm_soc_revision(void)
+static int imx8mm_soc_revision(u32 *socrev)
 {
 	struct device_node *np;
 	void __iomem *anatop_base;
-	u32 rev;
+	int ret;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
 	if (!np)
-		return 0;
+		return -EINVAL;
 
 	anatop_base = of_iomap(np, 0);
-	WARN_ON(!anatop_base);
+	if (!anatop_base) {
+		ret = -EINVAL;
+		goto err_iomap;
+	}
 
-	rev = readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX8MM);
+	*socrev = readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX8MM);
 
 	iounmap(anatop_base);
 	of_node_put(np);
 
-	imx8mm_soc_uid();
+	return imx8mm_soc_uid();
 
-	return rev;
+err_iomap:
+	of_node_put(np);
+	return ret;
 }
 
 static const struct imx8_soc_data imx8mq_soc_data = {
@@ -184,7 +212,7 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
 	"unknown"
 
-static int __init imx8_soc_init(void)
+static int imx8m_soc_probe(struct platform_device *pdev)
 {
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
@@ -212,8 +240,11 @@ static int __init imx8_soc_init(void)
 	data = id->data;
 	if (data) {
 		soc_dev_attr->soc_id = data->name;
-		if (data->soc_revision)
-			soc_rev = data->soc_revision();
+		if (data->soc_revision) {
+			ret = data->soc_revision(&soc_rev);
+			if (ret)
+				goto free_soc;
+		}
 	}
 
 	soc_dev_attr->revision = imx8_revision(soc_rev);
@@ -251,5 +282,37 @@ static int __init imx8_soc_init(void)
 	kfree(soc_dev_attr);
 	return ret;
 }
+
+static struct platform_driver imx8m_soc_driver = {
+	.probe = imx8m_soc_probe,
+	.driver = {
+		.name = "imx8m-soc",
+	},
+};
+
+static int __init imx8_soc_init(void)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	/* No match means this is non-i.MX8M hardware, do nothing. */
+	if (!of_match_node(imx8_soc_match, of_root))
+		return 0;
+
+	ret = platform_driver_register(&imx8m_soc_driver);
+	if (ret) {
+		pr_err("Failed to register imx8m-soc platform driver: %d\n", ret);
+		return ret;
+	}
+
+	pdev = platform_device_register_simple("imx8m-soc", -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		pr_err("Failed to register imx8m-soc platform device: %ld\n", PTR_ERR(pdev));
+		platform_driver_unregister(&imx8m_soc_driver);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
 device_initcall(imx8_soc_init);
 MODULE_LICENSE("GPL");
-- 
2.43.0


