Return-Path: <stable+bounces-233143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM4gDoFQz2mjvAYAu9opvQ
	(envelope-from <stable+bounces-233143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 07:30:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FD0391172
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 07:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0AC930160E2
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 05:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1134D3B0;
	Fri,  3 Apr 2026 05:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBHBwHmr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C51218845
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 05:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194159; cv=none; b=kH83wxNlqLpACkokH/C0kya/0BEBwiNggmy5V/3FeJPRp7B+naURgND0Ad8JQInnyWaCNF/W2NJyRYO7mX6/8piekhL77HLnkT07Xr4fMEeeEXg1S26Jh0kcNWnXppgjS+j7Gz3/mA1PGYrIrSubuPnshtJNLHTzuPNQ2IUBPAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194159; c=relaxed/simple;
	bh=L9P5HPs487AtJ8kBrpPKeljjzTpp/dQMO3aXJB8rDRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okoP2YcIFTu94c6agXq5k7e3PoNAsM4cCIcCO9oX0U7kGOTwUQ8KARuHo173EB+O0qJ78Ga5OMVHaOK++fFQr/0fWACRUyRFDuhFPfuV43RdS5AWfOx0+9YqGOqNWSpPesOfo2p4F1l768VIi1WSvoNdDNmblIbYaZ3QkMckBLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBHBwHmr; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82ce49785a0so701363b3a.2
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 22:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775194158; x=1775798958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mI7v9qZF+UUx3+2SXpVgBfGXsaFsLAnRc4Dei9eFP8E=;
        b=JBHBwHmr8jdW8vod5/B9k7fvrTQfSCugByeWHA4JSXptqLwQ7QwfKytX4wKBEcXs4R
         M1jH0raMuNJRWayxyyLoWPrgQ34+C+4e+y4M+vGBuX7gI1QxsVmRI23iuwFNgLDGEcEd
         vdY12zDyiUOOXNjm9pqanYZdvWlsXmBhv8oL07JPFC9bp/YGrAnOz2FGp4PVrARc6Rbg
         dmCa0UwPb50iAaBkmDqgrXJN7k2XOp7a9HZJPIDdhh1Pr9okBMD1OFbkyibiYb5q35gS
         jm/HsuZtGF7GQRIT3Dq+dYbCHRpKgPAKmZO9hZSj5Gh+rNNiR2dFysW1oqxiK8br8oXW
         2w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775194158; x=1775798958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mI7v9qZF+UUx3+2SXpVgBfGXsaFsLAnRc4Dei9eFP8E=;
        b=AF1mqQ/vtmjoWMmPV6sjC5bbBzzhyMLE0ROoJioPdzGjq8DMx3h/0YZJzps2I1dUh/
         2YDRjtejH84NfR5/8BS5RVINiKX18qRJkRie/u32xZ5mAVGJIAMUTvY8hkTvdLwhupdH
         emYjWFxEuaoh5GOkxRPENxXzIfAbnarnH0Iav/ei65XZFmwzhaABN/PE7UY8fogs3Tu6
         wfxUW+FsFVrUCRfLs4+7OTDtWD7oYOWpOfBKxkhXjNsPQYedQ5gytPQIMwLzxL1wIlzf
         pvK14TztK8Kc5v+lDLd7WyAXTas+WsCa/801KhQygkL2XuvCESmT2irWQyEJeT7owUtX
         y3AA==
X-Forwarded-Encrypted: i=1; AJvYcCW+5+wh2TTtd9mXCXw7A4yT+j+btIXsXtjmsVVgzPCRrDtu550q5aH7almSVFVEMAE2N4frzS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYu2S1MIkPQwq8EnC1qS49b5oZQYrEd522tYvUN+87mRhyYBpo
	WTgOu/Og5x2XpltVyf2BtEEh5yzowHRAHxL5Ta9OUwZmH0jsZW3G1DIF
X-Gm-Gg: AeBDiet54Pz9DOA3Ywr2cdvmlO2Dy7JeS6Aj4gVuJDhfjgkA0hfqi5xoC6kFZaEvnpx
	1EM5mBn7QxzullwlRNvRSYd5vrHg40zBWzt5jcsX+DyComr6uSMuYtNngOFGCzHHJMvckVcvu3M
	DgcshkPEXka0c0FAYLT7xHeAr90dL4ErgN3LhUdnPtJOw1fwCeXQX5tsJYyBw1X5v5em863t37p
	17A2dXwRGqnJOEW263nxZCs3DKCWUJ3A48X4FVzbN4ky2tACVnd5FW9tdJkI8gWM17BNNdVKCEz
	xu9mF0ZWs9OPcWcVEK2uEuDX1YZSBs4xxG1ZiZbsDUEvXzvjJVBc4fmwhFe1notsh+KWsALDovT
	yOipdVCrqUL7YGGt6qnrbiMkgmugghDs+WfU9hzIstk7+RM0+TDkeaju/FXzQiyU8U80rCrSVZj
	Bv5y3kD2wfqnfi+fc8Ism4UGvUuHM=
X-Received: by 2002:a05:6a00:2d02:b0:82c:6cbe:7935 with SMTP id d2e1a72fcca58-82d0db53ea7mr1762098b3a.28.1775194157683;
        Thu, 02 Apr 2026 22:29:17 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82d11cd2ce2sm782120b3a.6.2026.04.02.22.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 22:29:17 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: yanquanmin1@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 13:23:49 +0800
Message-ID: <20260403052837.58063-2-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403052837.58063-1-aethernet65535@gmail.com>
References: <20260403052837.58063-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[huawei.com,lists.linux.dev,kvack.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-233143-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aethernet65535@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93FD0391172
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The damon_commit_ctx() checks if 'min_region_sz' is a power-of-2.
However, if an invalid input is provided via the DAMON_LRU_SORT
interface, the validation failure occurs too late, causing kdamond to
terminate unexpectedly.

To reproduce:
1. Enable DAMON_LRU_SORT.
2. Set an invalid 'addr_unit' (e.g., addr_unit=3) so that
   'min_region_sz = DAMON_MIN_REGION_SZ / addr_unit' becomes
   non-power-of-2.
3. Commit parameters, and observe kdamond termination.

This patch adds an early check in damon_lru_sort_apply_parameters() to
validate 'min_region_sz' and return -EINVAL immediately if it is not
a power-of-2, preventing unexpected kdamond termination.

Fixes: 2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/lru_sort.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..3fd176ef9d9c 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -294,6 +294,11 @@ static int damon_lru_sort_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	if (!is_power_of_2(param_ctx->min_region_sz)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.53.0


