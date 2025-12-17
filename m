Return-Path: <stable+bounces-202816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43681CC7B6F
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E967830A1813
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 12:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B389A34A3D9;
	Wed, 17 Dec 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv9ns7cC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E1834A3C9
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975661; cv=none; b=WTxRUDfb897XYA2S5wjq70r1e6IzKxgLpAGEu5ZH9fwln+QSwxKTjuJuppzM3qrGPB81MB//nlxCo/WOmvuhf7QS91E18EPsHR8PM0aog5IscebfV+o4KAMFw5RtWnfChYW0MzUSMJYGtQhfbskDwq4T9ljSAN/iz49JhaTg1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975661; c=relaxed/simple;
	bh=JR4+kJaBlmpbY4kjmuT+WtD5sCcuiWQvS1lbYm26OEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XMUVlChCeAe/fXBmIEk7FPwqHUCeYyPUG51gWFyspfCZg1pbqycIUJ3D1Qh45cGzT89GWdmX7JInLubh4vJ/0P6PDgQmj0YQCLOzelmka1dIUCQ2jMHKJf17Kt+cpqg5W2D7hVk7HWtHhpvmHErnZRUQZwEJWZxyyXYmJaxuF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cv9ns7cC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a08c65fceeso7719355ad.2
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 04:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765975659; x=1766580459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3j0D4wFBpoCqxcj3+92dqkBBHNQldTemKoyK60bvQY=;
        b=cv9ns7cCE11T2uc7BE/THK0dhyaErs2Z8WdzvHVhc9cxS/MwTYHfDTFmchqUSF+c6a
         2rv9+2/9yFYpbDFme7rnXi0GC7HMGYj+GchWN/8RbtHu+1QH85/dtnh5Bdg93iW+nGRU
         f/zHZNcgMSwqaAEddSHydnhvwGiGd9aH58LRkbBzgHB37O9v3ikzh07H/1cXClZlO+Ci
         0E590474L5Zm4Kje38WwgID1gB1E1WA2MHZp/lKSblLokucQ4yj9M4lWIozDhxUr63x5
         by3r1D08kAFy07kr6ncQO+4CiA4t9IHfAouV8nL1CQUx4B7Tt7KOKg1gauIsAOmpyrSt
         eb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765975659; x=1766580459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3j0D4wFBpoCqxcj3+92dqkBBHNQldTemKoyK60bvQY=;
        b=f7m8XnRsGdp+pVYJnQMFwW5bbXpp8yY91JWbIDK3Y2szPwycrZyo8gauB33dMkMKGx
         Wy8q6L3V7o6lAqTrwWSGwdsMCsvqwV63t20s9Or6jd6Tuib1/D5pi0pcLAkkREy+w0Jr
         K2zFVMLdxuwxFsMZURZyKdp3s53uIhO0mIAUUhUQNS4v6zcxamw0nWlLmS2j6GflRH2C
         JJsIgR5KEPewiOCt91rGdAHF2TsdaJEVvjzT/yTIG4RyrwzY4fzdc+sB7bKbUtqsQzKz
         Qo1eaRmUFZ+jCCM1vbmaj00a56sJMspVtSP5gFRSJZ83MxeX/v1GbYJXBiUc+KruaNxr
         mVZg==
X-Forwarded-Encrypted: i=1; AJvYcCUgeHdvbsTX/j43EYHiBNTOiHif//yAbhDZEFASMGCmED7k1bFppOVGO7tKWoUcBFydUlr4gQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxngsmHFS7Y7ngCqU3yG2O/ONn7VK1czu4SIQyh/HiLSRwLSycF
	NQj3YSG4A/2seV81FURBgJNMLBoMk3n0BAyYkR8pJqDQ2LyHazK2XUrh
X-Gm-Gg: AY/fxX4+xnp0m6MTr+N8Cq4Y35XBhR+ng00kSqHRfH66DmLUhMps+wNMhdgfCraW8b1
	htbeEhBScezYzsb2XoajX6tRTkMFpxexWMk/ODz68fkSUOt6LqTKhRvYlksWVl/W4LoGBBgH7TM
	w70RqrVSeXdKs88TNvJpiQs3j+uzAMOSY9B2Tkd5Ug4UPuoxuizpj9pO1p1N2OBmDisxhZvtR3H
	SMoOK1ud3+NpHMTvVAkLJfY7rwApp9DVRFY7dnU+eKKCor4IN41KVvMo/5BUNpe6VUzlDrBFfb0
	wm7B9rQd8LWiqAb0vVctMsbfJ2Go0DLYTk/Jlzlvq16jStYe3fscRfsPuttBVOCJ0GlYiRnhEpX
	Y/Sd2MFIzo1JmbKSrG2MtdG+PyVT4JJbbn7DkmNuS2+oiURn/aVK6/5tiSbahRydMl1z8DrzeMH
	jCUy2aqXneUlUNJRqQlMNzQzmiketQkoTEIKS5BM6K7k/mrW8JUic/Rh7hrF2y/9ToQs0Mndi0
X-Google-Smtp-Source: AGHT+IH2v3JUr3tYGdDGzF39tRQhcdxW5++x3/G76FKsq3X0gc2QFhfLukE8mQjsMLw71amUacV/Gg==
X-Received: by 2002:a17:903:8cc:b0:298:2237:7b9b with SMTP id d9443c01a7336-29f24388becmr116421805ad.7.1765975659178;
        Wed, 17 Dec 2025 04:47:39 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0e96df1c9sm98306795ad.39.2025.12.17.04.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:47:38 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: linux-nfc@lists.01.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH v2 0/2] nfc: llcp: fix double put/unlock on LLCP_CLOSED in recv handlers
Date: Wed, 17 Dec 2025 21:46:57 +0900
Message-Id: <20251217124659.19274-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a refcount/locking imbalance in NFC LLCP receive handlers
when the socket is already in LLCP_CLOSED.

nfc_llcp_recv_disc() used to perform release_sock()/nfc_llcp_sock_put() in the CLOSED
branch but did not exit, and then performed the same cleanup again on the common
exit path. Drop the redundant CLOSED-branch cleanup so the common exit path runs
it exactly once, while keeping the existing DM_DISC reply behavior.

nfc_llcp_recv_hdlc() performed the CLOSED cleanup but then continued processing
and later cleaned up again on the common exit path. Return immediately after the
CLOSED cleanup.

Changes in v2:
- Drop Reported-by tags
- Add missing Fixes tags

Build-tested with: make M=net/nfc (no NFC HW available for runtime testing).

Qianchang Zhao (2):
  nfc: llcp: avoid double release/put on LLCP_CLOSED in
    nfc_llcp_recv_disc()
  nfc: llcp: stop processing on LLCP_CLOSED in nfc_llcp_recv_hdlc()

 net/nfc/llcp_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.34.1


