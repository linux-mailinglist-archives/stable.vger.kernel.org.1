Return-Path: <stable+bounces-12205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15620831F08
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 19:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C7528638E
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 18:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8712D619;
	Thu, 18 Jan 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlWjCP1q"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F1E2D60E
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602030; cv=none; b=tB9ctBw+51hArC6wYyABjNIKo5eSdYPuEjT0FQhWv/mBWMZeqBZmzl2u3BrusBYVBKcHgY+zG5Ca7jNB9we4JoTKO/jnp0PXtbWOuwiTilsgqOJdPCJO5JAujvAAeReE1NQGrbDk4zzMvvEp7yI7hf+doTa60M3YBC5uYXlcuag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602030; c=relaxed/simple;
	bh=Y4wmMazQYQJZUJH7gTHSE/jgCDvQWE1mnVYqHc036PU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UV/6QgGXGk9B7PDcM7DrSBuqkzEkQ1vAY/sfWea1ELw+Jfh47DMjWr7almHVXWJTQmiKqAUvyoWpyIJpjGIHYGJ8lZWbmsd3R8VsZt4UECzd3BsqXXyR/NVF4hpJOk5MzT14MOu1QjN3i+ArytYUQGmL+UNPCNwc1PGpa9z9INc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zokeefe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlWjCP1q; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zokeefe.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f250d8f876so229131897b3.3
        for <stable@vger.kernel.org>; Thu, 18 Jan 2024 10:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705602027; x=1706206827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q4qEVRx2ddSU7H+X65h3lnAP0N9W1FBS+7gcr4VsH4g=;
        b=mlWjCP1qM64P8Kge4a/CapRQne+ORn8IAAvnAnQm128jFDVKElCrP+mNNQs93C+18D
         ffi+RJh4/8UTnHZmPPjUeYbjg6azzPhlyKFcFJs4toF1QQj2b5uMPnPD+XwwRKlyQmq+
         ifpSdcOckKcpTssqitaUs7BEjzVbSM6pJaT71y1ePOxTy22CpoxTv0RASie3UPInvkQZ
         z+jg8wiQ48tsZwXkK3VjhF75FOYaItxisSQRyG5QHTVd4e9MAivUiQoRT2YTIhvRj20Q
         nbF2wntuLIBx4ACAhursubRgCbFqnLwPCUIQbMZHTtlhd+gOyxKDfktao4xyuZ76zFL7
         ZcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705602027; x=1706206827;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4qEVRx2ddSU7H+X65h3lnAP0N9W1FBS+7gcr4VsH4g=;
        b=ON1+3jXdZ9GybhIt98Q9cKHc9GubQdVCtKOTpY6wTLuoRKyS0zQyc7hBEMC4GtRYsi
         DTte1o65TSmTAgsX0RVprXNoXB4OiIOE0YEGMlrbhJCQt+LUQ+8j590lAx+ftblTzIxQ
         6VFbof0WNHsuclDHN4GuU/KTKjkLplhbTUgm/GR2/Ik3Be7ShykFx1opztX0GcAObghR
         uKKFLNfyqt3EvDqCI05s/YvnrXiRB0ow34dTYUIvrrmQbvVo5bCS64B+iRAvgL9Ai5jJ
         hjOF5tJQqoDprHUGK7mjNg8dyMqiuPqzqJJfIzXfmUPR2BIhqApPGwANC5+wEGn3z0Ql
         aNkg==
X-Gm-Message-State: AOJu0Yx+V/cBJnkUm0Kr/LRGWqIhspcx+qfZnfmXmkSrO7QaCdGeY7sz
	OMKPokQh83UbGXZNrmmd4T03k/5Oivxcxz53UKm5X7DrBd7vjxZckI3zBTG56+ooMNsXW33RS17
	52SrmqA==
X-Google-Smtp-Source: AGHT+IGLUNghu6mxF3SS7FJWjiDaHrXi0fENYH/7FmfNi5ZJUccLxbTU4wHujCNx5nF1YSmUscKnrwovWwgK
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2971])
 (user=zokeefe job=sendgmr) by 2002:a05:6902:181f:b0:dbd:b91e:9b87 with SMTP
 id cf31-20020a056902181f00b00dbdb91e9b87mr525809ybb.2.1705602027541; Thu, 18
 Jan 2024 10:20:27 -0800 (PST)
Date: Thu, 18 Jan 2024 10:19:53 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240118181954.1415197-1-zokeefe@google.com>
Subject: [PATCH] mm/writeback: fix possible divide-by-zero in
 wb_dirty_limits(), again
From: "Zach O'Keefe" <zokeefe@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	"Zach O'Keefe" <zokeefe@google.com>, Maxim Patlasov <MPatlasov@parallels.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

(struct dirty_throttle_control *)->thresh is an unsigned long, but is
passed as the u32 divisor argument to div_u64().  On architectures where
unsigned long is 64 bytes, the argument will be implicitly truncated.

Use div64_u64() instead of div_u64() so that the value used in the "is
this a safe division" check is the same as the divisor.

Also, remove redundant cast of the numerator to u64, as that should
happen implicitly.

This would be difficult to exploit in memcg domain, given the
ratio-based arithmetic domain_drity_limits() uses, but is much easier in
global writeback domain with a BDI_CAP_STRICTLIMIT-backing device, using
e.g. vm.dirty_bytes=(1<<32)*PAGE_SIZE so that dtc->thresh == (1<<32)

Fixes: f6789593d5ce ("mm/page-writeback.c: fix divide by zero in bdi_dirty_limits()")
Cc: Maxim Patlasov <MPatlasov@parallels.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index cd4e4ae77c40a..02147b61712bc 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1638,7 +1638,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
 	 */
 	dtc->wb_thresh = __wb_calc_thresh(dtc);
 	dtc->wb_bg_thresh = dtc->thresh ?
-		div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
+		div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
 
 	/*
 	 * In order to avoid the stacked BDI deadlock we need
-- 
2.43.0.429.g432eaa2c6b-goog


