Return-Path: <stable+bounces-172311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5BFB30F02
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E131CE48AA
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 06:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B022E543E;
	Fri, 22 Aug 2025 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4KbKQRD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4C2E4273
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844420; cv=none; b=pIVh6YdSlqGAnv3aXYF1wmkSNlmRxMIB/Xjte00ov5f863HWxffdxvujguNANaEuLaVBm6Fb5xnug/AVp7kuP+2ImTox9zzZsSCMqSUNO45RCqc1BkzsTC0oCslGzh6VufHQd+iD9B41RDRteU/1JtLTFLXHcaEzzkH4f+iVUiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844420; c=relaxed/simple;
	bh=ec81Mnup6E9CTBV0CcRVRgQ9sKckqNBArRQI10Bt5iE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oleWwnsM6Nsqe/jMS3U4XiVrmzaj9fxr0GangHomFK0EbAfknk8t2VHnkPq/amYIF7+QflOqc3U+WRvjo1dypthr5XH4/istghZkzHrCZgqS1NPoF93P50mQSRR9YPy0oR516oY3Xl/Gc5HLlqdmSqOeZbee/AGVNCFWO2YXr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4KbKQRD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61c14b1689eso1255375a12.1
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 23:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755844417; x=1756449217; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYgWrTDKeCSkoPnBZGqn59HSOrAsr0K77JqRZD3h0Wk=;
        b=N4KbKQRDJlrqvt4N/AsiKOMBvnyU71mtR1Bb+ghCk19brb5Ff/Cb/n1cYNAR0gZkoH
         vhf14xoouIu9Rp05MYAY/hJ+E6VQwfVo24/mL6UETupf+RWXU3QIsNGsuUKdc2doRyA5
         7/cdTJsJoHIzfqkL2yBio3q2zr2Fra7TPZgFfTMJL0iZAQ0XlTSNOX8Rr2huBpRICMtM
         zIJiLYLF7HFDJGibApH4Wamivvo1LVc99W+VWpxQf5n9OeQuJxCHc47YDtdkLevyp2Yd
         jHYhY1yLCUYRAsB6BFK7O0XyfonLL6/kHE+rY+xvGiV/outR/AmwpUIcfouCVnRvHE7i
         kCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755844417; x=1756449217;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYgWrTDKeCSkoPnBZGqn59HSOrAsr0K77JqRZD3h0Wk=;
        b=EgCszz+2vZ0EBDclY59XYcbcnEaM+h/P0933KlWRgWD9O429KpA4r5P+7MbEokNlKM
         j00sPN8J/h/Z3ilptFcqas5Se5lvAU0QXWf1dIIfVTbijHK//7613rroUDTeXX/YQr+1
         2/R/tIqYmv7Z8EgTEVd8oab67xAMu1w6e7F4wxJoxhH1Nr+NPRMy/FD0VguCs8q+89hV
         3iQDKtztHr/ceWuz7ZnfFm1gy7sRGOZcUzFbY3AGlPGGwVbU7bld55fEnkg9XdKw23ij
         f+oLmvza9jMVhAeVav4334Sp/3hynLO28MMrulnxxglfWvuNBWrF2GGfYCVtMN0w0k1j
         MBGw==
X-Forwarded-Encrypted: i=1; AJvYcCWTbxM81eUZPEuR1BQVSmfySQePavbWDKhFLNs/W0eYu1PQfeYOjz0pbWCFesT3AZTPos312cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDKhcYqGfNxS6R+T7hkg+DphgGihHnD5Mc9/ykqxPayPzkjXxd
	+e7cfSMDhqCdAjjfJAa/5U2gmI1j6iCqi1AqCJf9TDkqdNrxYH8Ptwnk
X-Gm-Gg: ASbGncvR/ipldhr50YiNhfUxilOhcBGSjpNShSvyPqA4rbs8icqRmlp3Gzt4gg41sgl
	m7pGNhLiQLMljv85zHFELIZI8zYTRDDEJ8w4WPW3IvTdYoOxZWKlpdCCs0hTGEf4XLih4BezTpZ
	HtSXWC2QvnC0Dj2oYM4K60tKTm+0Ul9l2PIgMc1PXypGBqtcaGDC2a0Gaj8vsTSTqurNDEEIvtc
	tTGtyzCTeE4aev+wiCfGP1h6d7n58SjjlNhd7xxdNbMakPBaxAp4yOxuX11lJACcII9o/l5QiHx
	GajK3aspculINAs1kE0eorGF3P6/coACxTzds3Mp4fWFeWK8U199l/lWqwRVJSqxCnJF99h0ZI1
	g5x+GJ1BjKSjLFBdDZg6hWFFzXkA6Xo1lTUn3
X-Google-Smtp-Source: AGHT+IH9r+KFcy5AFRt3q+bnI1jzb1hmCjNuSgGHLfGMNgn5kympgvMzvvGImWzn/C5lT7w7/btAtw==
X-Received: by 2002:a17:907:72d4:b0:afd:d9e4:5a4a with SMTP id a640c23a62f3a-afe296b7cafmr157878166b.62.1755844416438;
        Thu, 21 Aug 2025 23:33:36 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2fc568sm542472066b.38.2025.08.21.23.33.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Aug 2025 23:33:36 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/khugepaged: fix the address passed to notifier on testing young
Date: Fri, 22 Aug 2025 06:33:18 +0000
Message-Id: <20250822063318.11644-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Commit 8ee53820edfd ("thp: mmu_notifier_test_young") introduced
mmu_notifier_test_young(), but we should pass the address need to test.
In xxx_scan_pmd(), the actual iteration address is "_address" not
"address". We seem to misuse the variable on the very beginning.

Change it to the right one.

Fixes: 8ee53820edfd ("thp: mmu_notifier_test_young")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
CC: <stable@vger.kernel.org>

---
The original commit 8ee53820edfd is at 2011.
Then the code is moved to khugepaged.c in commit b46e756f5e470 ("thp:
extract khugepaged from mm/huge_memory.c") in 2022.
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 24e18a7f8a93..b000942250d1 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1418,7 +1418,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		if (cc->is_khugepaged &&
 		    (pte_young(pteval) || folio_test_young(folio) ||
 		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
-								     address)))
+								     _address)))
 			referenced++;
 	}
 	if (!writable) {
-- 
2.34.1


