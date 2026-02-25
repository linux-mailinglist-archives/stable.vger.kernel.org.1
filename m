Return-Path: <stable+bounces-218125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC/YIc5QnmmNUgQAu9opvQ
	(envelope-from <stable+bounces-218125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:30:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717918ED34
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AAC1302C6F8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E36224A06D;
	Wed, 25 Feb 2026 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TwsM7fnt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC921D596;
	Wed, 25 Feb 2026 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982904; cv=none; b=esxCAQJTZWkc8QgvHmoFBnskNeDe/eUGfyHX7h7DG3KEoXZZYCike1nk/7x9Vk96ZgC8s8U7oho2otWcvEDJe4Y/FoC50BTrV6fcCHQUBhYtb/j0OsiQfaHRA7DZFW6kAqGvdJlDdaPyDDkbWStVtWpTaZTDKtvd9zizvDwpYYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982904; c=relaxed/simple;
	bh=6gRxyYxyy7F5Om8dJDI+UXd8wl/bIrODdPjMKVnfNW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6JHEo03A2xpPhJzi+sa70eyjNRztZn8MAh8aa292ik7nqPJlXW/sGVQFz+7WZHnSu+zGo6TAfV6szHuQOCQzsdTi6JYnrDfK1U+MsQf0RG/OkPeBXyxdJpjAYeBJDgxqIu8drBSdKnlp6X3dIIryASJhr4mF1YFEtieixlLLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TwsM7fnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BB2C19423;
	Wed, 25 Feb 2026 01:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982904;
	bh=6gRxyYxyy7F5Om8dJDI+UXd8wl/bIrODdPjMKVnfNW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwsM7fnt7wXk8XsHbXw+4Fe70Lhv9i+WgeLnBAfNqGrpjZsUuJ0VP8xY/1TfabfQp
	 RRBI88aZo+kHhxY7IkF+QVd9SqF+L2K3LLURLkKjtBtTbuASoWcxzcnrJ2GlrQ9Z/x
	 Ir/IyteogJ4ci6iYTB90Sg1GZI883XB8d0Do5jzc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenghai Huang <huangchenghai2@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 087/781] crypto: hisilicon/zip - support fallback for zip
Date: Tue, 24 Feb 2026 17:13:16 -0800
Message-ID: <20260225012401.828861636@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218125-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0717918ED34
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenghai Huang <huangchenghai2@huawei.com>

[ Upstream commit 73398f85a430cfebc2ff06ab836d6d9eb1484c79 ]

When the hardware queue resource busy(no shareable queue)
or memery alloc fail in initialization of acomp_alg, use
soft algorithm to complete the work.

Fixes: 1a9e6f59caee ("crypto: hisilicon/zip - remove zlib and gzip")
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/Kconfig          |  1 +
 drivers/crypto/hisilicon/zip/zip_crypto.c | 50 +++++++++++++++++++----
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 4835bdebdbb38..a0cb1a8186ac9 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -57,6 +57,7 @@ config CRYPTO_DEV_HISI_ZIP
 	depends on UACCE || UACCE=n
 	depends on ACPI
 	select CRYPTO_DEV_HISI_QM
+	select CRYPTO_DEFLATE
 	help
 	  Support for HiSilicon ZIP Driver
 
diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 2f9035c016f3f..5fc2ed9d5eef3 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -84,6 +84,7 @@ struct hisi_zip_sqe_ops {
 struct hisi_zip_ctx {
 	struct hisi_zip_qp_ctx qp_ctx[HZIP_CTX_Q_NUM];
 	const struct hisi_zip_sqe_ops *ops;
+	bool fallback;
 };
 
 static int sgl_sge_nr_set(const char *val, const struct kernel_param *kp)
@@ -110,6 +111,24 @@ static u16 sgl_sge_nr = HZIP_SGL_SGE_NR;
 module_param_cb(sgl_sge_nr, &sgl_sge_nr_ops, &sgl_sge_nr, 0444);
 MODULE_PARM_DESC(sgl_sge_nr, "Number of sge in sgl(1-255)");
 
+static int hisi_zip_fallback_do_work(struct acomp_req *acomp_req, bool is_decompress)
+{
+	ACOMP_FBREQ_ON_STACK(fbreq, acomp_req);
+	int ret;
+
+	if (!is_decompress)
+		ret = crypto_acomp_compress(fbreq);
+	else
+		ret = crypto_acomp_decompress(fbreq);
+	if (ret) {
+		pr_err("failed to do fallback work, ret=%d\n", ret);
+		return ret;
+	}
+
+	acomp_req->dlen = fbreq->dlen;
+	return ret;
+}
+
 static struct hisi_zip_req *hisi_zip_create_req(struct hisi_zip_qp_ctx *qp_ctx,
 						struct acomp_req *req)
 {
@@ -313,10 +332,15 @@ static int hisi_zip_acompress(struct acomp_req *acomp_req)
 {
 	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(acomp_req->base.tfm);
 	struct hisi_zip_qp_ctx *qp_ctx = &ctx->qp_ctx[HZIP_QPC_COMP];
-	struct device *dev = &qp_ctx->qp->qm->pdev->dev;
 	struct hisi_zip_req *req;
+	struct device *dev;
 	int ret;
 
+	if (ctx->fallback)
+		return hisi_zip_fallback_do_work(acomp_req, 0);
+
+	dev = &qp_ctx->qp->qm->pdev->dev;
+
 	req = hisi_zip_create_req(qp_ctx, acomp_req);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -334,10 +358,15 @@ static int hisi_zip_adecompress(struct acomp_req *acomp_req)
 {
 	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(acomp_req->base.tfm);
 	struct hisi_zip_qp_ctx *qp_ctx = &ctx->qp_ctx[HZIP_QPC_DECOMP];
-	struct device *dev = &qp_ctx->qp->qm->pdev->dev;
 	struct hisi_zip_req *req;
+	struct device *dev;
 	int ret;
 
+	if (ctx->fallback)
+		return hisi_zip_fallback_do_work(acomp_req, 1);
+
+	dev = &qp_ctx->qp->qm->pdev->dev;
+
 	req = hisi_zip_create_req(qp_ctx, acomp_req);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -546,7 +575,7 @@ static int hisi_zip_acomp_init(struct crypto_acomp *tfm)
 	ret = hisi_zip_ctx_init(ctx, COMP_NAME_TO_TYPE(alg_name), tfm->base.node);
 	if (ret) {
 		pr_err("failed to init ctx (%d)!\n", ret);
-		return ret;
+		goto switch_to_soft;
 	}
 
 	dev = &ctx->qp_ctx[0].qp->qm->pdev->dev;
@@ -571,16 +600,20 @@ static int hisi_zip_acomp_init(struct crypto_acomp *tfm)
 	hisi_zip_release_req_q(ctx);
 err_ctx_exit:
 	hisi_zip_ctx_exit(ctx);
-	return ret;
+switch_to_soft:
+	ctx->fallback = true;
+	return 0;
 }
 
 static void hisi_zip_acomp_exit(struct crypto_acomp *tfm)
 {
 	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(&tfm->base);
 
-	hisi_zip_release_sgl_pool(ctx);
-	hisi_zip_release_req_q(ctx);
-	hisi_zip_ctx_exit(ctx);
+	if (!ctx->fallback) {
+		hisi_zip_release_sgl_pool(ctx);
+		hisi_zip_release_req_q(ctx);
+		hisi_zip_ctx_exit(ctx);
+	}
 }
 
 static struct acomp_alg hisi_zip_acomp_deflate = {
@@ -591,7 +624,8 @@ static struct acomp_alg hisi_zip_acomp_deflate = {
 	.base			= {
 		.cra_name		= "deflate",
 		.cra_driver_name	= "hisi-deflate-acomp",
-		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_flags		= CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
 		.cra_module		= THIS_MODULE,
 		.cra_priority		= HZIP_ALG_PRIORITY,
 		.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
-- 
2.51.0




