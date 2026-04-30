Return-Path: <stable+bounces-241987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJoxAfbb8mnUuwEAu9opvQ
	(envelope-from <stable+bounces-241987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 06:35:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A6649D525
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 06:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAAD23013D4E
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 04:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128D2287263;
	Thu, 30 Apr 2026 04:34:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E018FC80;
	Thu, 30 Apr 2026 04:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777523662; cv=none; b=lK33ACYVqHNgJB+t1DRD4/HkbNMHfFJZW9ZQBQsU4rpTfWH5n43qc2Y50oFpPdTqc28hfAZU19727I9IqaGFvljWOd91K+vWpoFp2XPE8f/eMWtFC9Drbi17CzDQ8B69rJ+xaau/Hcm/fbX68Eh1vHzWr8mXY9NR3fLdBMsHID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777523662; c=relaxed/simple;
	bh=lVH/o/wvIbAmHU9Ncn31aqgJu7ZUTF0l3hAbIddGMQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QlzCnohGEcJL5oh1uo3QNgfryVMFKIzJNo/HGu1eA2465YHlz9UQNBQqOxDmcEdCXHl6X4S8lLfgJoi/vwmTfTtpcXumYcLhUibxiMI8v+E55WzrJBf42hXQoSNtNLEBE2lFNOQj/ChlI21LeegtGvt0OqiVQPuvtwx11evTj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [36.163.144.42])
	by APP-05 (Coremail) with SMTP id zQCowAAXqg292_JpXhv9Dg--.5878S2;
	Thu, 30 Apr 2026 12:34:06 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v3] bpf: crypto: snapshot params before string validation
Date: Thu, 30 Apr 2026 12:34:04 +0800
Message-ID: <20260430043404.58221-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXqg292_JpXhv9Dg--.5878S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1Duw4UWr17Jw4kGr1ftFb_yoWxWFykpF
	yrW398Kw1rJr47CryxWF4rXF1rAFyxZF13GrW3GF1YyF9xXr92gF1IkrWUZFy3ta93Ww1Y
	yrZYkrWUuw13JrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRiSdgUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Queue-Id: 54A6649D525
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241987-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,vger.kernel.org,iscas.ac.cn];
	NEURAL_SPAM(0.00)[0.982];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

bpf_crypto_ctx_create() receives a BPF-supplied params pointer. The
current selftests use static initializers, but BPF programs can also
build the struct in writable BPF memory before calling the kfunc. The
verifier checks that the memory is accessible; it does not prove that
the fixed type[] and algo[] fields are NUL-terminated strings.

Copy the params once into a local snapshot, validate the reserved fields
and fixed-width strings there, and then use the same snapshot for all
later checks and crypto API calls. This also keeps key_len and authsize
stable across validation and use if params points at mutable BPF memory.

Clear the local snapshot before returning because it contains key
material.

Add a selftest that fills algo[] completely and expects -EINVAL.

Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v2: https://lore.kernel.org/all/20260424070105.1-bpf-crypto-v2-pengpeng@iscas.ac.cn/
- clear the local params snapshot with memzero_explicit() on success and
  error paths because it contains key material
- remove the redundant fd > 0 check from the added selftest; skeleton
  open_and_load() already validates the program, and fd 0 is valid

 kernel/bpf/crypto.c                             | 49 ++++++++++++++++---------
 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c | 16 ++++++++
 tools/testing/selftests/bpf/progs/crypto_sanity.c      | 28 ++++++++++++++
 3 files changed, 76 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 51f89cecefb4..72e5707c1ead 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -147,31 +147,47 @@ bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
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
+		goto err_clear_params;
+	}
+
+	if (strnlen(params_copy.type, sizeof(params_copy.type)) ==
+	    sizeof(params_copy.type) ||
+	    strnlen(params_copy.algo, sizeof(params_copy.algo)) ==
+	    sizeof(params_copy.algo)) {
+		*err = -EINVAL;
+		goto err_clear_params;
+	}
+
+	type = bpf_crypto_get_type(params_copy.type);
 	if (IS_ERR(type)) {
 		*err = PTR_ERR(type);
-		return NULL;
+		goto err_clear_params;
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
+	if (!params_copy.key_len ||
+	    params_copy.key_len > sizeof(params_copy.key)) {
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
 
@@ -207,6 +222,7 @@ bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
 
 	refcount_set(&ctx->usage, 1);
 
+	memzero_explicit(&params_copy, sizeof(params_copy));
 	return ctx;
 
 err_free_tfm:
@@ -215,7 +231,8 @@ bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
 	kfree(ctx);
 err_module_put:
 	module_put(type->owner);
-
+err_clear_params:
+	memzero_explicit(&params_copy, sizeof(params_copy));
 	return NULL;
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
index 42bd07f7218d..2ef1e276a63a 100644
--- a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
+++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
@@ -117,6 +117,18 @@ void test_crypto_sanity(void)
 	udp_test_port = skel->data->udp_test_port;
 	memcpy(skel->bss->key, crypto_key, sizeof(crypto_key));
 	snprintf(skel->bss->algo, 128, "%s", algo);
+
+	pfd = bpf_program__fd(skel->progs.skb_crypto_setup_bad_algo);
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (!ASSERT_OK(err, "skb_crypto_setup_bad_algo") ||
+	    !ASSERT_OK(opts.retval, "skb_crypto_setup_bad_algo retval"))
+		goto fail;
+
+	if (!ASSERT_OK(skel->bss->status, "skb_crypto_setup_bad_algo status"))
+		goto fail;
+
+	opts.retval = 0;
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


