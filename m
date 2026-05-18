Return-Path: <stable+bounces-249270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPWbHHEGC2r4/QQAu9opvQ
	(envelope-from <stable+bounces-249270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:30:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491156CADE
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF766301E368
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 12:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47F4402B8B;
	Mon, 18 May 2026 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPKk2ezY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923AA402B9B
	for <stable@vger.kernel.org>; Mon, 18 May 2026 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106786; cv=none; b=b5UGHERnVgnZBjwD8HcUNWYkgD+N0p6bCmnGSHutcy4771ls+vCQtz7PfA7QanXGW6zeBhJTZFsl0/uSrWIszpMvN0u953wP3eLnu4zQN4WiQCejf2avt35H9Lcr3hH8GDdqsByEAsbi4CoEOBs93U8sG7Uz5TOS3884c1Wra6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106786; c=relaxed/simple;
	bh=eLcdcZxrys2ehNx0yNlSxMilAqifYutDFaWElvOpaFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxGE45FvHEJgxDoLPJRzbAo6PMOk5EY2hcMb0NJ5lLP3jV3xAl3ZOXaVVvv5ndIVwLLF3J6IjYYdH991qWaZIZshS5iStuAcwD9DavXTvdlIDZ7KF+rHGjw5B/fpbaicEuQGzbeHpamTKvV2Xw3yYRd+mzEAAQhy/fDL7qkbHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPKk2ezY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67be871ed3fso5188789a12.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779106783; x=1779711583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVDi3PTBIMFWhncpu/t25cZzFWgAxfyBAa2471yPkMM=;
        b=OPKk2ezYSFGkS8dFH9tW4Xd6KdpAdlQmcpKRYtqssEwQPZd2ZC8nOlC0vl9gkeEP+2
         avMmUFGnU/nuR08jdlTsho5YJ6ytzB6t0mSKtdWBscD/b8afGcKIJPGzKbj1fIl54bDC
         TbyG83AvgWSSJSOamOZZXc5AyVZtV1R5j5U/K9TK1URqJFkTpz33A8IoiG1XLqRvOVMm
         EvQaZuNr8u4l4HCvNqdicMhsqteF658Wo1VBMWqCmDLM1HYGuLF/cHgZlxHDDqfYlz/w
         SGYcJEK2y2B4e+I42nr/0mHB8ZN9TO4KogNwPxw1ZyJaBeE0EGc2KLt0Drhz1pIOHu9p
         Zhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106783; x=1779711583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVDi3PTBIMFWhncpu/t25cZzFWgAxfyBAa2471yPkMM=;
        b=UzGpC9KTEKrGN1nuTDZgKfuAec3fJRrUZilVP0qHUoPrtdFAgNeYtgosxRRX00GzX2
         e6wKQ33QjaQyRz0TciU1OLQ0d0oxJWzc7bxujB7wnQHOQ4J5m6tIuzCl6CNefNNIIirr
         ECu/QvkQqEED5SPx7pVB2xYpn0COcU4VQsmpWcKxl1vEES+mnrRduK1wa90y9f99jxoW
         vNV6LhfFjpq9OAvzj5uy9C3HRCkKEM7xj9oNf6b+wkSe5Im/d3b8M7BVjErJV+7VgIMV
         Sy9jYNWC52IEdMn/LK84Ij7kZnW2Oj6mc54ac8opxg9dRSXrgIKF4T/AW5Kgm+rENded
         4CPg==
X-Forwarded-Encrypted: i=1; AFNElJ82zwp8y+CU1tfMF6of419ET3SbLlnA/hS9XDjuihmJDBtKbjUJQiUUFre+jDF9XpWz9DxrWaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn8i8AJtbcUS1lQlbUbi5ujCSNEmIRDrP+PUboHt1KVtq0lEzC
	BvA/qFzaxzZkDv1S/670TWqafGnoNLhRANEdrBagdOjQKqW9qGrnxM4c
X-Gm-Gg: Acq92OFMWdKi7+e0Ev3OTZRZw7PX5StSPrZvmm77oxcOxlcxjfYxeHkioGVAQpmZ52K
	2CWJhQxbjpZjWROAJxA8pnT10sr9koApG8dEjZWmypncGNKV1QZAu7v6oWBrccsEYCZtypWlM/E
	dPhvoPrwrTQS3XqZLs+tpAQWiNJx09gq7c/IY5mVfTJvWxd6M2oBPWFlXZn4sdTlHPM991jkUfZ
	QNS47p0VqtDT8kqKbCjadVPpwHZdoZnOkxAHHrm1rc8kn1pJ0huuxhyIC7esQ1xMCzzT/9rKSQv
	zfD+RLrngVX1WPsNubpUkxlWcoo2nI48Uw11EsR0UBEl2M++X/DtStbuxm4TSTqfCjO2cqeYX8K
	RswgOKFSqBzGPjKmWTusSh7B3A2utjsi1C21jhrYB/CptJNqVI54CCsoTvmTsrfBd04LoMPj8v/
	xM57gDy2fK9Iejio+I5ldt7ZlVPae+/g==
X-Received: by 2002:a17:907:3d11:b0:bb9:c23:573d with SMTP id a640c23a62f3a-bd517964d61mr715072566b.31.1779106782560;
        Mon, 18 May 2026 05:19:42 -0700 (PDT)
Received: from nixbug.lan ([146.120.47.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bcf7f3sm551533266b.2.2026.05.18.05.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:19:42 -0700 (PDT)
From: Andrii Kuchmenko <capyenglishlite@gmail.com>
To: linux-modules@vger.kernel.org
Cc: chleroy@kernel.org,
	mcgrof@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Andrii Kuchmenko <capyenglishlite@gmail.com>
Subject: [PATCH v2] module: decompress: check return value of module_extend_max_pages()
Date: Mon, 18 May 2026 15:18:58 +0300
Message-ID: <20260518121858.3071-1-capyenglishlite@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7491156CADE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249270-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[capyenglishlite@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

module_extend_max_pages() calls kvrealloc() internally and returns
-ENOMEM on allocation failure. The return value is never checked.
The decompression loop then continues calling module_get_next_page(),
which writes struct page pointers into info->pages[]. When used_pages
reaches the stale max_pages value (not updated due to the failed
extend), a subsequent write to info->pages[used_pages++] goes out of
bounds into adjacent heap memory.

Adjacent slab objects in the same kmalloc cache (pipe_buffer,
seq_operations, cred) can be corrupted, potentially leading to local
privilege escalation on kernels without SLAB_VIRTUAL mitigation.

The call order in finit_module() is:

  module_decompress()    <- vulnerable, runs FIRST
  load_module()
    module_sig_check()   <- signature check, runs SECOND

Decompression happens before signature verification. A crafted
compressed module submitted via finit_module(MODULE_INIT_COMPRESSED_FILE)
reaches this code path before any signature gate is applied. On kernels
with module.sig_enforce=0 (default without SecureBoot) or with
unprivileged user namespaces (Ubuntu, Debian default), this is
reachable without CAP_SYS_MODULE.

Confirmed present in mainline (tested on v6.14-rc3).

Fix: add the missing error check after module_extend_max_pages() and
return immediately on failure. This matches the pattern used by every
other kvrealloc() caller in the module loading path.

Fixes: 169a58ad824d ("module: add in-kernel support for decompressing")
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Andrii Kuchmenko <capyenglishlite@gmail.com>
---
 kernel/module/decompress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -XXX,9 +XXX,12 @@ int module_decompress(struct load_info *info,
 				const void *buf, size_t size)
 {
 	unsigned int n_pages;
 	int error;
 	ssize_t data_size;
 
 	n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;
 	error = module_extend_max_pages(info, n_pages);
+	if (error)
+		return error;
 	data_size = MODULE_DECOMPRESS_FN(info, buf, size);
 	if (data_size < 0) {
 		error = data_size;
-- 
2.39.0

