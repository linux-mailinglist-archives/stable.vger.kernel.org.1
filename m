Return-Path: <stable+bounces-249074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI5YBhWgCWqLiQQAu9opvQ
	(envelope-from <stable+bounces-249074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:01:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A435C5609E6
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94CEC300B554
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1257359A6D;
	Sun, 17 May 2026 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgNrJ1F6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A235695
	for <stable@vger.kernel.org>; Sun, 17 May 2026 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779015692; cv=none; b=TwIXEY6QSrVCKXyRKhT6lgqAA6MUxUKBEUj/0SWLPnlayhvw6EJUPGCsB988ClhU9ZkGrEpWs0/N8XlgWgLA2tkFM1OUabdxUa0NHI+3L/MadsCXDuR5MI6UwvQC0y5rqB+jS1UgJC7Pz4OLiFoPCZkOWCe/qvOSw8hVWN+DY9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779015692; c=relaxed/simple;
	bh=5iTJ6uUs213eNLp86NK1cVHRd1P1kMFXqZ3zZMN3vh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQxnSDRqgcEZGcGu5UPzPBSyBBIjwGhkaaqleK8yKWFuHnId1bjDx4be3fOCU3fT1kgdVj+RnU7uKnC2nZsN68eesD/0sWxDD2RMLEcFO2/bbDNyWjD5ZouGlnxqTbsfeTxmFoLLrvxfTAA4jrt7U92VFPYXJaCVX8OXHdDH5M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgNrJ1F6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b936331786dso166157066b.3
        for <stable@vger.kernel.org>; Sun, 17 May 2026 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779015689; x=1779620489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VgEt85dKjR1TEekAbfA62AOLv8dJx0ApoYmsOz+B63g=;
        b=GgNrJ1F6bpN1hiFSy5xi6WVSDXq8e6OP4CXq0Jbmc/jna36n0NxZnPhF8xckdDosIG
         Ba6zXCuLpCtSs3NVcxoPAdTOLZ/fwChDe9GuM3XfPbtVMo1lZSKiUjFwlyIpxQDvbwTj
         JxZL7LV1US+L2pyltnlx0V8kkpZsH/mHz5atGkM6do8EjtF/hlRz3Dip21XjwM6A72rQ
         rel8qyhOktBc2gwVr3WTaZ1ZdO1hOkq/SxV0qFj+FzIF5RnaCuv5L6qsTFV6g8ubbUx3
         IwTSdQ+GzwDHB5XgmfKY7DOvVurRohpUPMFt57SRydxHNZrM5SrP3pddCzoUezXsirpL
         F6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779015689; x=1779620489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgEt85dKjR1TEekAbfA62AOLv8dJx0ApoYmsOz+B63g=;
        b=KlgoXhf4F1nsc/MEVMB+khw9ETVx503MXW4onLD4hYEZivY0cvrUy2PXTznqf6AME3
         wx+Uk8meEZXo6Fq5HsIf1Pcon3c+ESx6p1NghPoJzdJsvp1PSvhpKs9luBcnoQV1XkC8
         DKZEotJu0aKOiiVnk5JMg+B5pajwnQlcrzldtcGesa6LyiorNVjHR/E3yf0LaKDOJ2WW
         7gHcwhbZeZBLzZPIiXKNdiBuQ36p4zewPNONKiUm6Z/5/7JQqTyt4ppuupCUC982TKYn
         7EGpvMUQOaOeZh4IVP10cPjLtKyLu5Ai2mdZlhSjUFg+nYfyTEfeSNzD5kzHBG017VAt
         b6eg==
X-Forwarded-Encrypted: i=1; AFNElJ8TUuJ9ynD7ZpKTf0nznb+BYNpqQTiItVxEFw8U9CgUfHnBfjAQxNAH+kegD26t6wDfm2n1bGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9cY+444dCRmmfeIl/B8IvREmjwYk4OyA/CNhLsNOndtj7nnWC
	LMhnllJCbp6NBiMf5vXrEYWlqana854vg2TcC4Sa7+J2gAU+isFQTOv1
X-Gm-Gg: Acq92OEKe/5CnjJqB20luy1/RWRdUMXLD12dq+FxlDkqU4457UHDPGuWxRu/mxJCvII
	f6qZnyYSSBlECYuogam28vTmGMDHM/khc8/yy2rAENClHDu6pklr05eDKofxceGL2uGJdZpG+s1
	U+9Iaokt/gjiXg7VJMygOpS2+JnbWYUnea4kqMWy3B322xXBJnyhWVY4SlFOVHHwFvtZU2X7cpZ
	Zuptuc2twlvRC0pJmWvhZjIbyWZMnbTxvlNLwpOslW/7zeUJyaMc1dfBRv0HJP3xbCnRa1xwv/E
	j3jgVvRAWLmNsbSLMzAzZO43PtKHnqr8/At92jphenDfNzzZu9lODC2RjQpivCkDPxX9tKG9tPG
	1JVTXS6MeMtnq29G9/51HaNp9nxTBg/7/NQaPmutAaguscm69UvXTXalQaoWTQUlBm1LH7TKbsJ
	3g//Yi5AFqZDgZY61RKIOtVHtXJwKcTg==
X-Received: by 2002:a17:906:6a03:b0:bd2:875d:a8d1 with SMTP id a640c23a62f3a-bd517955151mr502673066b.35.1779015689078;
        Sun, 17 May 2026 04:01:29 -0700 (PDT)
Received: from nixbug.lan ([146.120.47.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e4d54dsm435800966b.47.2026.05.17.04.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 04:01:28 -0700 (PDT)
From: Andrii Kuchmenko <capyenglishlite@gmail.com>
To: linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org,
	Andrii Kuchmenko <capyenglishlite@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] module: decompress: check return value of module_extend_max_pages()
Date: Sun, 17 May 2026 14:00:37 +0300
Message-ID: <20260517110037.21506-1-capyenglishlite@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A435C5609E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249074-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[capyenglishlite@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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
 kernel/module/decompress.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index a1b2c3d4e5f6..b7c8d9e0f1a2 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -XXX,10 +XXX,13 @@ int module_decompress(struct load_info *info,
 				const void *buf, size_t size)
 {
 	unsigned int n_pages;
-	int error;
+	int error = 0;
 	ssize_t data_size;
 
 	n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;
+
 	error = module_extend_max_pages(info, n_pages);
+	if (error)
+		return error;
+
 	data_size = MODULE_DECOMPRESS_FN(info, buf, size);
 	if (data_size < 0) {
 		error = data_size;
-- 
2.39.0

