Return-Path: <stable+bounces-240543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFZsF4Sh6mlF1gIAu9opvQ
	(envelope-from <stable+bounces-240543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 00:47:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FAE458384
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 00:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F49E3033D1D
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 22:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13589377EC1;
	Thu, 23 Apr 2026 22:46:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA162D23A6;
	Thu, 23 Apr 2026 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984412; cv=none; b=N16DyVp2q26rLvfIV1e4riNjgmmKE6KpAROnTpah90AOVBBFTqDo0HBhpZjA4BZuRW3AsIW4s20EvyYdi6hEoMqqbARUW6o8gPZqpF3ySh4sM3K3hDuMaZr3M/IH0gB8dNtbX3DX7qRKHn/dSWmEbZ2L47tfvAL45MrQLlK4S7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984412; c=relaxed/simple;
	bh=4SbV4uHU0godCT1/3NGT36CdwDD9N3zEjz7VsiGEAZo=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References; b=YJGfA42sI03M5lR+tBSI6dypXTmSYZLhgrrNG0Hx/JHwfW/+Oqcvk6EebciPkVm2Kf76alLU6pMZk43Ct0p/G3uCEy2eMFtoqXY7f0Hhq9LxZEw+5FiSTyYzbrWjzMvSEdJ3iBjbMBlbmnHivjB27FtTgmuM+VmYIQuGBzy0BXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 05-bpf-crypto-v2.eml (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowADndwtMoeppMXtsDg--.13949S2;
	Fri, 24 Apr 2026 06:46:37 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Thu, 23 Apr 2026 23:34:00 +0800
Message-ID: <20260424070105.1-bpf-crypto-v2-pengpeng@iscas.ac.cn>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH v2] bpf: crypto: snapshot params before string validation
In-Reply-To: <20260417073128.91029-1-pengpeng@iscas.ac.cn>
References: <20260417073128.91029-1-pengpeng@iscas.ac.cn>
X-CM-TRANSID:zQCowADndwtMoeppMXtsDg--.13949S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1Duw4UWr17Jw4kGr1ftFb_yoW7Cryrpa
	4rW3yqk34rJr47Cry8XF4rZr1rAFyxZF13GrW5GF15KF9xXr92gF1IkrWUZFy3Xa9xWw1Y
	yrZYk3yUuw13J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK6x804I0_JFv_Gryl8cAvFVAK0II2c7
	xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjc
	xK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRMv31DUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240543-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,vger.kernel.org,iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 08FAE458384
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bpf_crypto_ctx_create() receives a BPF-supplied params pointer. The
current selftests use static initializers, but BPF programs can also
build the struct in writable BPF memory before calling the kfunc. The
verifier checks that the memory is accessible; it does not prove that
the fixed type[] and algo[] fields are NUL-terminated strings.

Copy the params once into a local snapshot, validate the reserved fields
and fixed-width strings there, and then use the same snapshot for all
later checks and crypto API calls. This also keeps key_len and authsize
stable across validation and use if params points at mutable BPF memory.

Add a selftest that fills algo[] completely and expects -EINVAL.

Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1:
- copy struct bpf_crypto_params into a local snapshot before validation
- use the snapshot for all string, key_len and authsize checks and uses
- add a BPF selftest for an unterminated algorithm name

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 51f89cecefb4..e2dc3dfb4d85 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -147,31 +147,46 @@ bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
 		      int *err)
 {
 	const struct bpf_crypto_type *type;
+	struct bpf_crypto_params params_copy;
 	struct bpf_crypto_ctx *ctx;
 
-	if (!params || params->reserved[0] || params->reserved[1] ||
-	    params__sz != sizeof(struct bpf_crypto_params)) {
+	if (!params || params__sz != sizeof(params_copy)) {
 		*err = -EINVAL;
 		return NULL;
 	}
 
-	type = bpf_crypto_get_type(params->type);
+	params_copy = *params;
+
+	if (params_copy.reserved[0] || params_copy.reserved[1]) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	if (strnlen(params_copy.type, sizeof(params_copy.type)) ==
+	    sizeof(params_copy.type) ||
+	    strnlen(params_copy.algo, sizeof(params_copy.algo)) ==
+	    sizeof(params_copy.algo)) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	type = bpf_crypto_get_type(params_copy.type);
 	if (IS_ERR(type)) {
 		*err = PTR_ERR(type);
 		return NULL;
 	}
 
-	if (!type->has_algo(params->algo)) {
+	if (!type->has_algo(params_copy.algo)) {
 		*err = -EOPNOTSUPP;
 		goto err_module_put;
 	}
 
-	if (!!params->authsize ^ !!type->setauthsize) {
+	if (!!params_copy.authsize ^ !!type->setauthsize) {
 		*err = -EOPNOTSUPP;
 		goto err_module_put;
 	}
 
-	if (!params->key_len || params->key_len > sizeof(params->key)) {
+	if (!params_copy.key_len || params_copy.key_len > sizeof(params_copy.key)) {
 		*err = -EINVAL;
 		goto err_module_put;
 	}
@@ -183,19 +198,19 @@ bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
 	}
 
 	ctx->type = type;
-	ctx->tfm = type->alloc_tfm(params->algo);
+	ctx->tfm = type->alloc_tfm(params_copy.algo);
 	if (IS_ERR(ctx->tfm)) {
 		*err = PTR_ERR(ctx->tfm);
 		goto err_free_ctx;
 	}
 
-	if (params->authsize) {
-		*err = type->setauthsize(ctx->tfm, params->authsize);
+	if (params_copy.authsize) {
+		*err = type->setauthsize(ctx->tfm, params_copy.authsize);
 		if (*err)
 			goto err_free_tfm;
 	}
 
-	*err = type->setkey(ctx->tfm, params->key, params->key_len);
+	*err = type->setkey(ctx->tfm, params_copy.key, params_copy.key_len);
 	if (*err)
 		goto err_free_tfm;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
index 42bd07f7218d..044711e7263a 100644
--- a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
+++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
@@ -117,6 +117,19 @@ void test_crypto_sanity(void)
 	udp_test_port = skel->data->udp_test_port;
 	memcpy(skel->bss->key, crypto_key, sizeof(crypto_key));
 	snprintf(skel->bss->algo, 128, "%s", algo);
+
+	pfd = bpf_program__fd(skel->progs.skb_crypto_setup_bad_algo);
+	if (!ASSERT_GT(pfd, 0, "skb_crypto_setup_bad_algo fd"))
+		goto fail;
+
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (!ASSERT_OK(err, "skb_crypto_setup_bad_algo") ||
+	    !ASSERT_OK(opts.retval, "skb_crypto_setup_bad_algo retval"))
+		goto fail;
+
+	if (!ASSERT_OK(skel->bss->status, "skb_crypto_setup_bad_algo status"))
+		goto fail;
+
 	pfd = bpf_program__fd(skel->progs.skb_crypto_setup);
 	if (!ASSERT_GT(pfd, 0, "skb_crypto_setup fd"))
 		goto fail;
diff --git a/tools/testing/selftests/bpf/progs/crypto_sanity.c b/tools/testing/selftests/bpf/progs/crypto_sanity.c
index dfd8a258f14a..32977b797042 100644
--- a/tools/testing/selftests/bpf/progs/crypto_sanity.c
+++ b/tools/testing/selftests/bpf/progs/crypto_sanity.c
@@ -82,6 +82,34 @@ int skb_crypto_setup(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+int skb_crypto_setup_bad_algo(void *ctx)
+{
+	struct bpf_crypto_params params = {
+		.type = "skcipher",
+		.key_len = 16,
+	};
+	struct bpf_crypto_ctx *cctx;
+	int err = 0;
+
+	status = 0;
+
+	__builtin_memset(params.algo, 'a', sizeof(params.algo));
+	__builtin_memcpy(&params.key, key, sizeof(key));
+
+	cctx = bpf_crypto_ctx_create(&params, sizeof(params), &err);
+	if (cctx) {
+		bpf_crypto_ctx_release(cctx);
+		status = -EIO;
+		return 0;
+	}
+
+	if (err != -EINVAL)
+		status = err;
+
+	return 0;
+}
+
 SEC("tc")
 int decrypt_sanity(struct __sk_buff *skb)
 {
-- 
2.50.1 (Apple Git-155)


