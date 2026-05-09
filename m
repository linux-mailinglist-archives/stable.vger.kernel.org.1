Return-Path: <stable+bounces-244899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOiJKq+q/mkyuwAAu9opvQ
	(envelope-from <stable+bounces-244899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:31:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE284FDE09
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22D3830180B7
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 03:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E782701C4;
	Sat,  9 May 2026 03:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+9e54C7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADDE2F8E8D
	for <stable@vger.kernel.org>; Sat,  9 May 2026 03:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778297514; cv=none; b=BGbWP9tFxg7TjT147SeHdKwNRMxvo5iDYfLU548eJBrsDtb6vaGT3pbolzaGH08J1V5hT0DJb4am2TSvCG158n3QkE4WGsf/L8z/accLOiU/L1mnKBHom7mqq97jClOaGzMdIl74lp/2/HE/yJL6xoV7oSlm31MhDZcDem8aCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778297514; c=relaxed/simple;
	bh=rfN+7MHIISicvWPqeZYkNXikuxZmOS+gSl4+AOuNUQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMcySZdycCb8mEBl1okqlfhWJbixYS6quqbRKGxnLhlSyyVFHXwtkDNXnHUAncWHtHlOiZV1cSelq1SueCzzTlRWJnqMRhcvvcFE1zCo44b4ZALefJsSQW+IvzQwPcd3SzbcTwGkYWxSDlnL9/H2KqUFSshxiFYYavetbhNM1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+9e54C7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B251AC2BCB8;
	Sat,  9 May 2026 03:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778297514;
	bh=rfN+7MHIISicvWPqeZYkNXikuxZmOS+gSl4+AOuNUQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+9e54C737fOPGKy6CbCETTvIk/Qm9dtfNSBe3hgapeARpnWa2NYPR/bxj68Bhy0E
	 YOmObA7XLp3keo7feoLqt7cgOu6kO1kC8/2lSe6GJvnaArC5DBx6G+xtKCAh7GMNNx
	 r5kQR9AWaaaCPUgOBO8A5rEmXmrLMJEkT9V1BK8qPSQobrlKtG151WWz+G/ynIlS7a
	 4Lju09Uce6Y/AJwOpHOXibDZXXFzXY73cPrYHFhVFLLQCaeJWSrhG9P+cDsxt9a2J2
	 Q1FbBLqOnx7DNOqVnKOemgAPvml7U943kKUUDbXOyw4q0eDiv5wkttjIhUy+SiQWyP
	 WUzm3GhRAvrFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] crypto: nx - Migrate to scomp API
Date: Fri,  8 May 2026 23:31:49 -0400
Message-ID: <20260509033150.3082044-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509033150.3082044-1-sashal@kernel.org>
References: <2026050440-dude-evade-6747@gregkh>
 <20260509033150.3082044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4AE284FDE09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-244899-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
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
 drivers/crypto/nx/nx-842.h            | 15 ++++++------
 drivers/crypto/nx/nx-common-powernv.c | 31 ++++++++++++-------------
 drivers/crypto/nx/nx-common-pseries.c | 33 +++++++++++++--------------
 4 files changed, 58 insertions(+), 54 deletions(-)

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
index 25fa70b2112cf..58137ffd3835b 100644
--- a/drivers/crypto/nx/nx-842.h
+++ b/drivers/crypto/nx/nx-842.h
@@ -3,7 +3,6 @@
 #ifndef __NX_842_H__
 #define __NX_842_H__
 
-#include <crypto/algapi.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -101,6 +100,8 @@
 #define LEN_ON_SIZE(pa, size)	((size) - ((pa) & ((size) - 1)))
 #define LEN_ON_PAGE(pa)		LEN_ON_SIZE(pa, PAGE_SIZE)
 
+struct crypto_scomp;
+
 static inline unsigned long nx842_get_pa(void *addr)
 {
 	if (!is_vmalloc_addr(addr))
@@ -179,13 +180,13 @@ struct nx842_crypto_ctx {
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
index 8c859872c1839..fd0a98b2fb1b2 100644
--- a/drivers/crypto/nx/nx-common-powernv.c
+++ b/drivers/crypto/nx/nx-common-powernv.c
@@ -9,6 +9,7 @@
 
 #include "nx-842.h"
 
+#include <crypto/internal/scompress.h>
 #include <linux/timer.h>
 
 #include <asm/prom.h>
@@ -1031,23 +1032,21 @@ static struct nx842_driver nx842_powernv_driver = {
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
@@ -1107,7 +1106,7 @@ static __init int nx_compress_powernv_init(void)
 		nx842_powernv_exec = nx842_exec_vas;
 	}
 
-	ret = crypto_register_alg(&nx842_powernv_alg);
+	ret = crypto_register_scomp(&nx842_powernv_alg);
 	if (ret) {
 		nx_delete_coprocs();
 		return ret;
@@ -1128,7 +1127,7 @@ static void __exit nx_compress_powernv_exit(void)
 	if (!nx842_ct)
 		vas_unregister_api_powernv();
 
-	crypto_unregister_alg(&nx842_powernv_alg);
+	crypto_unregister_scomp(&nx842_powernv_alg);
 
 	nx_delete_coprocs();
 }
diff --git a/drivers/crypto/nx/nx-common-pseries.c b/drivers/crypto/nx/nx-common-pseries.c
index 7e98f174f69b9..0d26aafd08863 100644
--- a/drivers/crypto/nx/nx-common-pseries.c
+++ b/drivers/crypto/nx/nx-common-pseries.c
@@ -11,6 +11,7 @@
 #include <asm/vio.h>
 #include <asm/hvcall.h>
 #include <asm/vas.h>
+#include <crypto/internal/scompress.h>
 
 #include "nx-842.h"
 #include "nx_csbcpb.h" /* struct nx_csbcpb */
@@ -1008,23 +1009,21 @@ static struct nx842_driver nx842_pseries_driver = {
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
@@ -1072,7 +1071,7 @@ static int nx842_probe(struct vio_dev *viodev,
 	if (ret)
 		goto error;
 
-	ret = crypto_register_alg(&nx842_pseries_alg);
+	ret = crypto_register_scomp(&nx842_pseries_alg);
 	if (ret) {
 		dev_err(&viodev->dev, "could not register comp alg: %d\n", ret);
 		goto error;
@@ -1120,7 +1119,7 @@ static void nx842_remove(struct vio_dev *viodev)
 	if (caps_feat)
 		sysfs_remove_group(&viodev->dev.kobj, &nxcop_caps_attr_group);
 
-	crypto_unregister_alg(&nx842_pseries_alg);
+	crypto_unregister_scomp(&nx842_pseries_alg);
 
 	spin_lock_irqsave(&devdata_mutex, flags);
 	old_devdata = rcu_dereference_check(devdata,
@@ -1252,7 +1251,7 @@ static void __exit nx842_pseries_exit(void)
 
 	vas_unregister_api_pseries();
 
-	crypto_unregister_alg(&nx842_pseries_alg);
+	crypto_unregister_scomp(&nx842_pseries_alg);
 
 	spin_lock_irqsave(&devdata_mutex, flags);
 	old_devdata = rcu_dereference_check(devdata,
-- 
2.53.0


