Return-Path: <stable+bounces-180656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADFEB89813
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 14:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E243175725
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 12:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294B120B7E1;
	Fri, 19 Sep 2025 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCljUI7S"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F26208961
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285760; cv=none; b=odeeb1xgMpmHjSgIIZXlpvdruI0V5NqHy7ilfuMVCrWeuunLZGsjHWyz2JLrKzMgNg90Q8v5lpAcaA6RMKFkV/hlz4TVlgvWXvHs0U2+30ddZHObcSd6El8SRwij2qFldMxE9tONZDO3ugFh9Ns4dIoicZ8qvLGmPmnS9J0TSHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285760; c=relaxed/simple;
	bh=JORA1gDfS/Nfb7H4WI1KAIpM6/cjUQBA5RYJUWYUP9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFRBaBUACGCaPhW0Hqg49zu5w63hNXqa1R4lbwnOeV4xIjfM8QEU+LBMlyhAUWCrrxT1rOY8Mb2uD0Ems0YpeLKB4YQ599S9ESdUu2sGpgopXGOfYrfJd3XZR+GwmdQyB/B+K8okXsU8uRYVFkOD3/6enAzlycPiTd+3+qi4S98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aCljUI7S; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7a16441so307221166b.2
        for <stable@vger.kernel.org>; Fri, 19 Sep 2025 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758285757; x=1758890557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wj7WblQsPSyrGWWKSxzzmKooYDH1YcR0H73P9e5XZO4=;
        b=aCljUI7STkPyEukgZZAazRPsrTzQEjbXQEU6IzopLcU+4Hr1YOYw/ixEpVvlR4HTdg
         MfVwABzulYp49S0vJeRxHQx6PtSfH9RAhuQk/WEFAOsuuqhnGwBwRtOLlMOnasTMGLqE
         +sQUysf2+9H415KMdNcXwlCNhXiZL54wZiAjDTUnWSRQd0ZnkW7u8fTcYNlLT9unFtBq
         aCGkvh8ly7ei7v8BVcHdBHdKjk95u6+y6UNNA7ZY8VFdSB1nYeSQRfvN0kp1GSzOI6to
         /YP42qwD186nLOLVb3lb+/ki2thixPOTVAFQ/jZm1DRqu9sQqfGCl67r5uqEyBWZdrlg
         WoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758285757; x=1758890557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wj7WblQsPSyrGWWKSxzzmKooYDH1YcR0H73P9e5XZO4=;
        b=m6z0IUAFHvqoV/ZJ9SOvBTvyZ+PqsAHdqtwjJ7BjrD6OdDvcCii+ESM3rRCKoLRSEp
         c+G6uB0vn4HT/BVplIoMmEO2MMtghiYnCqzxxkbRhpdYWDy7SEsBMH88fYcp+3oHxDAa
         48i2npQ6p04tNr9K4caGimI558Wf3DhTCod6qdieDW40DQC5FsbmOl1L269dIQ/UbHnC
         GquProa465uLJTKb+69RDbfi6BOCsjPqMrrgBHClyNjYogqmtfBYULzxhEq8hIeo8Cd7
         7C3uD8XcEgdm+58jF0J8Oqw4ZFdWnaoGrdUcJeSP6QMoF6wBaGGjdzZuZp0baLXGtnPk
         OfoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLp+kiE4YphGixrZy0MLdpH0CJDwwqDerWQq8gLF7SELdQ6rUlpXI7clle5UGqMD5hjMcwHzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZd4jdljGNbW+B+7/GGBF+WzCUJGVx+bV4cpkht12L3WRZoxRH
	1P/5mqDp6CtSftsVytI7hNwBvIlQ4laf1QHeYSlbfb9byb1xzLhQ804qN3xEo1flT88=
X-Gm-Gg: ASbGncs4wtABnczP/R3XVkBqL5g+Nkbmm7gdkSM0u+Qq9632Uz4PBCZ9gHiyv4YNjfY
	cCJfzka8aCuqJLwzKx/67CkMa6linpGBUqgLOXV4oZ18a8RweUrf80yqEQldgKJX20znxGXrmks
	rQBWCh8+nP6m8uY7POJu1P/1/YQZrD6vjYOw3e+kfDQneJCsiwOkyMtNacRkFeAdGYAQLZFcRq2
	Zfybv/8dz4uW4k5V+QDXfM78hNsTec76ljyKHvOoGO3qJ0aIA4xZRC2hB5A9T7g5BPkZQVcVNXD
	5ISuUxWS6vKas86qtY/aqVIKPDN1h+U8eVSf0Ao0iJy7Ucl7g+KK919WuHD3U3WIz66ATLw1Q/7
	BjqFWWXmD+/jo39xzvYfevO/wI7s2lxaG4RAb059Co1fXfb6vI7k7LmVxmOfQvfdrV1e0j4oye3
	0=
X-Google-Smtp-Source: AGHT+IFr1BTounEptyjlbKSLG3yb0rrKq8OODXhqwAInRGVZzvO/n5qSDVMOGac6sdWkTXPIaFNEFQ==
X-Received: by 2002:a17:907:2da2:b0:b04:6e60:4df1 with SMTP id a640c23a62f3a-b24f50aa963mr308717466b.53.1758285757281;
        Fri, 19 Sep 2025 05:42:37 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd262993asm429170166b.94.2025.09.19.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 05:42:36 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Sumit Garg <sumit.garg@kernel.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	stable@vger.kernel.org,
	Masami Ichikawa <masami256@gmail.com>
Subject: [PATCH] tee: fix register_shm_helper()
Date: Fri, 19 Sep 2025 14:40:16 +0200
Message-ID: <20250919124217.2934718-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In register_shm_helper(), fix incorrect error handling for a call to
iov_iter_extract_pages(). A case is missing for when
iov_iter_extract_pages() only got some pages and return a number larger
than 0, but not the requested amount.

This fixes a possible NULL pointer dereference following a bad input from
ioctl(TEE_IOC_SHM_REGISTER) where parts of the buffer isn't mapped.

Cc: stable@vger.kernel.org
Reported-by: Masami Ichikawa <masami256@gmail.com>
Closes: https://lore.kernel.org/op-tee/CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTjJAvUbEiQfq=u9W+-g@mail.gmail.com/
Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..6ed7d030f4ed 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -316,7 +316,16 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 
 	len = iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pages, 0,
 				     &off);
-	if (unlikely(len <= 0)) {
+	if (DIV_ROUND_UP(len + off, PAGE_SIZE) != num_pages) {
+		if (len > 0) {
+			/*
+			 * If we only got a few pages, update to release
+			 * the correct amount below.
+			 */
+			shm->num_pages = len / PAGE_SIZE;
+			ret = ERR_PTR(-ENOMEM);
+			goto err_put_shm_pages;
+		}
 		ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
 		goto err_free_shm_pages;
 	}
-- 
2.43.0


