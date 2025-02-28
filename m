Return-Path: <stable+bounces-119952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA42A49CB9
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 16:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AAA189A737
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5A81EF385;
	Fri, 28 Feb 2025 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO/YnkT1"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC701EF363;
	Fri, 28 Feb 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754938; cv=none; b=LigcuBSbqjd27C4kEFNctNsLX+33TEZWuhOZD3K/lkdBlfwpToSyLoSVwfDmqQ19ujatrCWVmlNx9IXFMDBcFH0ApqfWbNN0IBGuZjNeSRmUnwlXcWQ3ElR3ry4mAEp6+h4zDhoQmwMD8wY6AT8ebSljhmsMzvZaJsbqrHSkDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754938; c=relaxed/simple;
	bh=Fr0Kcp6QDqAQkV+lMeqmYBHQenokCWygdszblwnmvIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y60wuD23s8OIInHH7lISepnVDys3y+sxu6IHk+KFdDH2yLooIb96AblME/WKpUxSMvfUBbIP5OqUgCXCef5+71Q5Wy0Op/oLBgMuoYrVvDsVSTRNFsSJFRTlssFr5vaZgO0D18DhF/xkXIXQ3TC5hN1kFcqeIwPXvUqG8X85rdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO/YnkT1; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6f4bc408e49so20550757b3.1;
        Fri, 28 Feb 2025 07:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740754934; x=1741359734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QU4BPFF3iVqQaLnqO+lftu/JhDH2027oRJaOrlL5uEk=;
        b=kO/YnkT1QNyhal6sCBJiDwzwDJ0+xQ+PkPuxGgnPIRl/Vlm1ANXckoprHGmh+PKSPJ
         4X46by8EwqDPibkrQj3LhpnTiA3jRWt5iODgI0SXRR6SIztBRSkUfej/+AHfxj/CqtXA
         TH3k/YhwGETfrr8GZocwiTflc0RqIv4APBCZCC6795e6Yp/ZZ+7Pef/yRd7yIwKWe6Zv
         hnYvzDvS7F2DR5MoTA6RS4GhYY32u0tyVFy7r4+TsduAikM4gYyZVMYOZbkgBTCFvUOL
         ugWNVUoCkd0Ry2ZmFJ9b0zHTbw9ZhFC/akxqIk1AQ0uHQ0I9qYCuXkikI3wJEgYNzHmQ
         uboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740754934; x=1741359734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QU4BPFF3iVqQaLnqO+lftu/JhDH2027oRJaOrlL5uEk=;
        b=V2kwB1pkb569wNhjyLvDfFE+SVEOuvB1vKYxSViNzfCYHoFSL5pBABGiz4NPZMTb9t
         0utfXN9cbn/MxwQdrau41p/MToPXQYEo2I8JAlF3hDw7PbqPoo9VhZbbu9oQlRGMwBOg
         bW7ir1jEJctpMxnuGMWVYJfVdrk2sd8+fiwu3/YpkZzTebQZn3tQeqemgK+/QWvKAMaM
         kZMG0qHG7P5rxJoz7UwN49zv7ymVGHHLfQVPuR65tqQbyUQwdt15vHlUBvlup8yemYOm
         yV69FZ9DgxcIJ5WcVi5N9PihLb48PSRC1HgnCXIKALDLSB06Tm0Puy3sCB3UxaHizKww
         etLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx0GiUCGiEoYdYfsqNAdos4OAt3L9YjxYMNxnmY5bPiV7Y4SAj7qh9GsI8+QXOqe79sKf+LQnvSU3sDjg=@vger.kernel.org, AJvYcCWoHq3+HfRIAAnyJrxDjKOmQ0OxhcZhErdCXW/uLzEoPk9InbixVficgdJDzyFX4Vx/mjGohu9t@vger.kernel.org, AJvYcCXmTregfjYiiKzlZfg7EZFKvifJeGyV8b45TPkgRnzyiMUL1sfNV0f8Gc9vFLH6p/ZryfrBvjCk@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQ4QgKSnvCuZUZl1f8vyqFa/Hwo7PTmHwnlNBUgfgm8/r9+IU
	IEefB5115G1bO5rgmamNahmO1SUbQurMkIMfGf/ULMgU/dbCVUul
X-Gm-Gg: ASbGncsZflKwZU20yEGrZvlQVTSkcbHKLp4r59gIwgDHV2eumaL1MqHAppKwQ19vmBi
	8B48JVRSK0YrX8Jle6bLgxHfqkGpsRsBKP5nWeN4dAQ6zdKv7VMoOj886oXpJcgXywI5w46PZvI
	m4cQ5W0sch7Bs37QaxCW5UouKbFLGb4tt86zcdW9y9hUiCtPs+gBs7fqM88P9xd2FsLFG3DJcBO
	U36GIvudn0sMZxk2cNKQz69PXgz45U86CfAMeaXJqNX+NsG0v8Ljnmuj4mSyy6UIEFsq2e9dY4m
	CJx+ahd8Q9MqO65JIvIG599TWQDD72MvzGhmhKdOLPkE/I9O
X-Google-Smtp-Source: AGHT+IEaKtUsiUXwdolE2DT2oFTOm0jau+e7kIBoYGtLYSYVGhb/VMQmuizvHERwzhKgYu84pFAY1Q==
X-Received: by 2002:a05:690c:4b02:b0:6f9:8605:ec98 with SMTP id 00721157ae682-6fd4a1b5b85mr50874637b3.28.1740754934205;
        Fri, 28 Feb 2025 07:02:14 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3ca43145sm7575227b3.33.2025.02.28.07.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 07:02:13 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: przemyslaw.kitszel@intel.com
Cc: arkadiusz.kubalewski@intel.com,
	davem@davemloft.net,
	jan.glaza@intel.com,
	jiashengjiangcool@gmail.com,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: [PATCH v4 net-next] dpll: Add an assertion to check freq_supported_num
Date: Fri, 28 Feb 2025 15:02:10 +0000
Message-Id: <20250228150210.34404-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the driver is broken in the case that src->freq_supported is not
NULL but src->freq_supported_num is 0, add an assertion for it.

Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v3 -> v4:

1. Add return after WARN_ON().

v2 -> v3:

1. Add "net-next" to the subject.
2. Remove the "Fixes" tag and "Cc: stable".
3. Replace BUG_ON with WARN_ON.

v1 -> v2:

1. Replace the check with an assertion.
---
 drivers/dpll/dpll_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 32019dc33cca..940c26b9dd53 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -443,8 +443,11 @@ static void dpll_pin_prop_free(struct dpll_pin_properties *prop)
 static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
 			     struct dpll_pin_properties *dst)
 {
+	if (WARN_ON(src->freq_supported && !src->freq_supported_num))
+		return -EINVAL;
+
 	memcpy(dst, src, sizeof(*dst));
-	if (src->freq_supported && src->freq_supported_num) {
+	if (src->freq_supported) {
 		size_t freq_size = src->freq_supported_num *
 				   sizeof(*src->freq_supported);
 		dst->freq_supported = kmemdup(src->freq_supported,
-- 
2.25.1


