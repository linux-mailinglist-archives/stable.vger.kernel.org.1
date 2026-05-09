Return-Path: <stable+bounces-244905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uERFJ6Ct/mnJuwAAu9opvQ
	(envelope-from <stable+bounces-244905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:44:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 402394FDF0B
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 308D43018BDF
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 03:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA5F37B01A;
	Sat,  9 May 2026 03:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go5XZ+Hy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9437AA63
	for <stable@vger.kernel.org>; Sat,  9 May 2026 03:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778298264; cv=none; b=ZvezZx5rd5m7qfqMw+08loBBdzNwktndrGVk+UL7d1XaDCf0pEzMVlnxgH65Vu9fONo9kj2uaLKeoCZjyxqB0G+mQHHoMSgByjNX1nd/PewWMcNkRRpp9uNnjoHcnkE5S0myCO2js20H4ZY/J/Ueifd/cAVsKSIz5FLQphs4xKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778298264; c=relaxed/simple;
	bh=o3C6xJ7/4iGyWpJzHS9L+d9ncfgLwdr82OvV17YNDbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaJ0hew+Iot01lmqT6sCZsAStul82ys3CBQdeOBDJeEs5qm2ZeiE6oDiERSWNxPSzMM0pFL0XeDln9ieM8lvWq1+KlivHYTwfmIHuDSCPiWLTdGHLfPUygRl/Mw8m9QC19V3rCZdNREEZNOGb/gtPPn2c5SY/cZz7j0bohAuw7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go5XZ+Hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F6FC2BCF5;
	Sat,  9 May 2026 03:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778298264;
	bh=o3C6xJ7/4iGyWpJzHS9L+d9ncfgLwdr82OvV17YNDbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Go5XZ+HyuNnQsl7AImBgzHv9XD34tQAgB0TAt3nAyxU/wVVKDOhHRqESqf4lwBJNA
	 ZLSg8guxqJe7LXkLsWuengBsXF/bUi98ZhR5vlk5hA+CCwtJrc403+3QEfAAmDKZna
	 zdXU+8np2OB4puQ+9XirZIWcON1FijWuYSdRpUGt7v9t9SIlbScAiqE64OWmHyPoT9
	 wUsfkiICMSMvqhWsXGuTgpYS/dca6xDanDaiR+qWLEYCtzI7BPBHOFTRblLzofXY4t
	 TU64biIRDspbv0JBcvQVL6Jvlj48J9/omJEws31kQsNLSSHIsq747/JWwa6sB4kMmG
	 GUPpemMx6ouAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] crypto: nx - Migrate to scomp API
Date: Fri,  8 May 2026 23:44:18 -0400
Message-ID: <20260509034419.3105450-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509034419.3105450-1-sashal@kernel.org>
References: <2026050440-situation-phosphate-8856@gregkh>
 <20260509034419.3105450-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 402394FDF0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244905-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit 980b5705f4e73f567e405cd18337cc32fd51cf79 ]

The only remaining user of 842 compression has been migrated to the
acomp compression API, and so the NX hardware driver has to follow suit,
given that no users of the obsolete 'comp' API remain, and it is going
to be removed.

So migrate the NX driver code to scomp. These will be wrapped and
exposed as acomp implementation via the crypto subsystem's
acomp-to-scomp adaptation layer.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: adb3faf2db1a ("crypto: nx - fix bounce buffer leaks in nx842_crypto_{alloc,free}_ctx")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/nx/nx-842.c            | 33 +++++++++++++++------------
 drivers/crypto/nx/nx-842.h            | 14 +++++++-----
 drivers/crypto/nx/nx-common-powernv.c | 31 ++++++++++++-------------
 drivers/crypto/nx/nx-common-pseries.c | 33 +++++++++++++--------------
 4 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index 82214cde2bcd9..b950fcce8a9be 100644
--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -101,9 +101,13 @@ static int update_param(struct nx842_crypto_param *p,
 	return 0;
 }
 
-int nx842_crypto_init(struct crypto_tfm *tfm, struct nx842_driver *driver)
+void *nx842_crypto_alloc_ctx(struct nx842_driver *driver)
 {
-	struct nx842_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct nx842_crypto_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
 
 	spin_lock_init(&ctx->lock);
 	ctx->driver = driver;
@@ -114,22 +118,23 @@ int nx842_crypto_init(struct crypto_tfm *tfm, struct nx842_driver *driver)
 		kfree(ctx->wmem);
 		free_page((unsigned long)ctx->sbounce);
 		free_page((unsigned long)ctx->dbounce);
-		return -ENOMEM;
+		kfree(ctx);
+		return ERR_PTR(-ENOMEM);
 	}
 
-	return 0;
+	return ctx;
 }
-EXPORT_SYMBOL_GPL(nx842_crypto_init);
+EXPORT_SYMBOL_GPL(nx842_crypto_alloc_ctx);
 
-void nx842_crypto_exit(struct crypto_tfm *tfm)
+void nx842_crypto_free_ctx(void *p)
 {
-	struct nx842_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct nx842_crypto_ctx *ctx = p;
 
 	kfree(ctx->wmem);
 	free_page((unsigned long)ctx->sbounce);
 	free_page((unsigned long)ctx->dbounce);
 }
-EXPORT_SYMBOL_GPL(nx842_crypto_exit);
+EXPORT_SYMBOL_GPL(nx842_crypto_free_ctx);
 
 static void check_constraints(struct nx842_constraints *c)
 {
@@ -246,11 +251,11 @@ static int compress(struct nx842_crypto_ctx *ctx,
 	return update_param(p, slen, dskip + dlen);
 }
 
-int nx842_crypto_compress(struct crypto_tfm *tfm,
+int nx842_crypto_compress(struct crypto_scomp *tfm,
 			  const u8 *src, unsigned int slen,
-			  u8 *dst, unsigned int *dlen)
+			  u8 *dst, unsigned int *dlen, void *pctx)
 {
-	struct nx842_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct nx842_crypto_ctx *ctx = pctx;
 	struct nx842_crypto_header *hdr =
 				container_of(&ctx->header,
 					     struct nx842_crypto_header, hdr);
@@ -431,11 +436,11 @@ static int decompress(struct nx842_crypto_ctx *ctx,
 	return update_param(p, slen + padding, dlen);
 }
 
-int nx842_crypto_decompress(struct crypto_tfm *tfm,
+int nx842_crypto_decompress(struct crypto_scomp *tfm,
 			    const u8 *src, unsigned int slen,
-			    u8 *dst, unsigned int *dlen)
+			    u8 *dst, unsigned int *dlen, void *pctx)
 {
-	struct nx842_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct nx842_crypto_ctx *ctx = pctx;
 	struct nx842_crypto_header *hdr;
 	struct nx842_crypto_param p;
 	struct nx842_constraints c = *ctx->driver->constraints;
diff --git a/drivers/crypto/nx/nx-842.h b/drivers/crypto/nx/nx-842.h
index fee422865e512..21417774bd0bd 100644
--- a/drivers/crypto/nx/nx-842.h
+++ b/drivers/crypto/nx/nx-842.h
@@ -101,6 +101,8 @@
 #define LEN_ON_SIZE(pa, size)	((size) - ((pa) & ((size) - 1)))
 #define LEN_ON_PAGE(pa)		LEN_ON_SIZE(pa, PAGE_SIZE)
 
+struct crypto_scomp;
+
 static inline unsigned long nx842_get_pa(void *addr)
 {
 	if (!is_vmalloc_addr(addr))
@@ -179,13 +181,13 @@ struct nx842_crypto_ctx {
 	struct nx842_driver *driver;
 };
 
-int nx842_crypto_init(struct crypto_tfm *tfm, struct nx842_driver *driver);
-void nx842_crypto_exit(struct crypto_tfm *tfm);
-int nx842_crypto_compress(struct crypto_tfm *tfm,
+void *nx842_crypto_alloc_ctx(struct nx842_driver *driver);
+void nx842_crypto_free_ctx(void *ctx);
+int nx842_crypto_compress(struct crypto_scomp *tfm,
 			  const u8 *src, unsigned int slen,
-			  u8 *dst, unsigned int *dlen);
-int nx842_crypto_decompress(struct crypto_tfm *tfm,
+			  u8 *dst, unsigned int *dlen, void *ctx);
+int nx842_crypto_decompress(struct crypto_scomp *tfm,
 			    const u8 *src, unsigned int slen,
-			    u8 *dst, unsigned int *dlen);
+			    u8 *dst, unsigned int *dlen, void *ctx);
 
 #endif /* __NX_842_H__ */
diff --git a/drivers/crypto/nx/nx-common-powernv.c b/drivers/crypto/nx/nx-common-powernv.c
index f34c75a862f24..b7a23c2860282 100644
--- a/drivers/crypto/nx/nx-common-powernv.c
+++ b/drivers/crypto/nx/nx-common-powernv.c
@@ -9,6 +9,7 @@
 
 #include "nx-842.h"
 
+#include <crypto/internal/scompress.h>
 #include <linux/timer.h>
 
 #include <asm/prom.h>
@@ -1034,23 +1035,21 @@ static struct nx842_driver nx842_powernv_driver = {
 	.decompress =	nx842_powernv_decompress,
 };
 
-static int nx842_powernv_crypto_init(struct crypto_tfm *tfm)
+static void *nx842_powernv_crypto_alloc_ctx(void)
 {
-	return nx842_crypto_init(tfm, &nx842_powernv_driver);
+	return nx842_crypto_alloc_ctx(&nx842_powernv_driver);
 }
 
-static struct crypto_alg nx842_powernv_alg = {
-	.cra_name		= "842",
-	.cra_driver_name	= "842-nx",
-	.cra_priority		= 300,
-	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
-	.cra_ctxsize		= sizeof(struct nx842_crypto_ctx),
-	.cra_module		= THIS_MODULE,
-	.cra_init		= nx842_powernv_crypto_init,
-	.cra_exit		= nx842_crypto_exit,
-	.cra_u			= { .compress = {
-	.coa_compress		= nx842_crypto_compress,
-	.coa_decompress		= nx842_crypto_decompress } }
+static struct scomp_alg nx842_powernv_alg = {
+	.base.cra_name		= "842",
+	.base.cra_driver_name	= "842-nx",
+	.base.cra_priority	= 300,
+	.base.cra_module	= THIS_MODULE,
+
+	.alloc_ctx		= nx842_powernv_crypto_alloc_ctx,
+	.free_ctx		= nx842_crypto_free_ctx,
+	.compress		= nx842_crypto_compress,
+	.decompress		= nx842_crypto_decompress,
 };
 
 static __init int nx_compress_powernv_init(void)
@@ -1110,7 +1109,7 @@ static __init int nx_compress_powernv_init(void)
 		nx842_powernv_exec = nx842_exec_vas;
 	}
 
-	ret = crypto_register_alg(&nx842_powernv_alg);
+	ret = crypto_register_scomp(&nx842_powernv_alg);
 	if (ret) {
 		nx_delete_coprocs();
 		return ret;
@@ -1131,7 +1130,7 @@ static void __exit nx_compress_powernv_exit(void)
 	if (!nx842_ct)
 		vas_unregister_api_powernv();
 
-	crypto_unregister_alg(&nx842_powernv_alg);
+	crypto_unregister_scomp(&nx842_powernv_alg);
 
 	nx_delete_coprocs();
 }
diff --git a/drivers/crypto/nx/nx-common-pseries.c b/drivers/crypto/nx/nx-common-pseries.c
index 1b0308ce7ce76..88381d9aed3fa 100644
--- a/drivers/crypto/nx/nx-common-pseries.c
+++ b/drivers/crypto/nx/nx-common-pseries.c
@@ -11,6 +11,7 @@
 #include <asm/vio.h>
 #include <asm/hvcall.h>
 #include <asm/vas.h>
+#include <crypto/internal/scompress.h>
 
 #include "nx-842.h"
 #include "nx_csbcpb.h" /* struct nx_csbcpb */
@@ -1006,23 +1007,21 @@ static struct nx842_driver nx842_pseries_driver = {
 	.decompress =	nx842_pseries_decompress,
 };
 
-static int nx842_pseries_crypto_init(struct crypto_tfm *tfm)
+static void *nx842_pseries_crypto_alloc_ctx(void)
 {
-	return nx842_crypto_init(tfm, &nx842_pseries_driver);
+	return nx842_crypto_alloc_ctx(&nx842_pseries_driver);
 }
 
-static struct crypto_alg nx842_pseries_alg = {
-	.cra_name		= "842",
-	.cra_driver_name	= "842-nx",
-	.cra_priority		= 300,
-	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
-	.cra_ctxsize		= sizeof(struct nx842_crypto_ctx),
-	.cra_module		= THIS_MODULE,
-	.cra_init		= nx842_pseries_crypto_init,
-	.cra_exit		= nx842_crypto_exit,
-	.cra_u			= { .compress = {
-	.coa_compress		= nx842_crypto_compress,
-	.coa_decompress		= nx842_crypto_decompress } }
+static struct scomp_alg nx842_pseries_alg = {
+	.base.cra_name		= "842",
+	.base.cra_driver_name	= "842-nx",
+	.base.cra_priority	= 300,
+	.base.cra_module	= THIS_MODULE,
+
+	.alloc_ctx		= nx842_pseries_crypto_alloc_ctx,
+	.free_ctx		= nx842_crypto_free_ctx,
+	.compress		= nx842_crypto_compress,
+	.decompress		= nx842_crypto_decompress,
 };
 
 static int nx842_probe(struct vio_dev *viodev,
@@ -1070,7 +1069,7 @@ static int nx842_probe(struct vio_dev *viodev,
 	if (ret)
 		goto error;
 
-	ret = crypto_register_alg(&nx842_pseries_alg);
+	ret = crypto_register_scomp(&nx842_pseries_alg);
 	if (ret) {
 		dev_err(&viodev->dev, "could not register comp alg: %d\n", ret);
 		goto error;
@@ -1118,7 +1117,7 @@ static void nx842_remove(struct vio_dev *viodev)
 	if (caps_feat)
 		sysfs_remove_group(&viodev->dev.kobj, &nxcop_caps_attr_group);
 
-	crypto_unregister_alg(&nx842_pseries_alg);
+	crypto_unregister_scomp(&nx842_pseries_alg);
 
 	spin_lock_irqsave(&devdata_mutex, flags);
 	old_devdata = rcu_dereference_check(devdata,
@@ -1250,7 +1249,7 @@ static void __exit nx842_pseries_exit(void)
 
 	vas_unregister_api_pseries();
 
-	crypto_unregister_alg(&nx842_pseries_alg);
+	crypto_unregister_scomp(&nx842_pseries_alg);
 
 	spin_lock_irqsave(&devdata_mutex, flags);
 	old_devdata = rcu_dereference_check(devdata,
-- 
2.53.0


