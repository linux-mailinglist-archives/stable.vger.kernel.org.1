Return-Path: <stable+bounces-95671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D63B9DB098
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 02:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E202F281943
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 01:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C137EEDD;
	Thu, 28 Nov 2024 01:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlG1c5gg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF96B125D5;
	Thu, 28 Nov 2024 01:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755823; cv=none; b=BBQpx1Bq6Rt4nKvvh6sOwR8X4ufb6JWd858N/HPxuu7nLDOZZZ3vvgO4y0xBdQnrQ59nho+FHjKHtYPqGXnlYrQA6m8VOtidoty8fdCGM4X4JClcCXJLn6IX1gUrS1tl6Wsnk4z5vga6aQntENPPooPgbtOQYn/sTTMCRYRPFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755823; c=relaxed/simple;
	bh=iOHE+N2VXbUCTw3j2RUyc1JZuBkRRyVqP0ClvvkWdmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pwouNlqf5FGlJzb+NGMGuonLPUdnjB3Xmfmr4QbJjP4F/S+w+RkyvL5QRn0pn/Tm0K+HNTZLc7TrdJmZQCz5dcfX0NBLti9/bbjSwErXXYPhc/7WXCFwkB5/m/qxixVpq0OcUrnKnBVUj9C3MddeCMlLPDOPlAOWozdIKtA0Tt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlG1c5gg; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-7b67441cf32so19492185a.0;
        Wed, 27 Nov 2024 17:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732755821; x=1733360621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5rQZ0lW5GxiG9M0cwURB0oYzpqAC0EZ6gbLq3UDMs4Q=;
        b=MlG1c5ggCT2XFzF5To5OVCy2NGtYl31GIL9ifh2EymOH3gRbHsYKKmibH9IAq5/lAk
         lKM41SYbxxL/Xu8cVJRe/r4ALU5Wk2HBG+HcQT2cCnvEaaaEBmwtGJs3VsbXNtFiHOtP
         /aDUQx0prbXkJezhgp8SXruRzeTAsPKxyUA0tbVQefPqQUWJB4bLoSvLdRXaIh787Zbh
         YshXbJYUiAZ2q2iI6Fxe2LiNQWsHIfSmXC2mMgUUJTmEIcM6lq0mxf2vadS5VfPwAu+D
         dihUjBwhr6akDePsRKVozG7CxBcmzwf/L+9ahMyYGFc5xvuMEQDnkfCLpujO0uk3wOc3
         CfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755821; x=1733360621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rQZ0lW5GxiG9M0cwURB0oYzpqAC0EZ6gbLq3UDMs4Q=;
        b=ehBqvX5EKMcdFbriyIgstkJex+kUsiYs96wE2kwsjbm4tg9tY84GoTkRBi1UMWDDg/
         FDJBekIXwQmUgbdQgqnqqhggiTpUkEmwlKh/gjyo5F1Nk3D91jxkykUycaI0OZWKC+3k
         Aitq7J0lFYko9VXYOmSWOMMel1XZv8ets4xd0ZdhFCKNGTqhCUrOuF+qB2SsI51le6nc
         YEtMppy49pcEAvk7ouq9yFcuW2NOzWfTO+L+uUcbCzxAOJQ0P4g1GvGvkg6ebFKp/6D9
         8TCvRIN26c1o0hUAtEJFEqTHwmgwyc86cBMRv3bojgxygk9gGvwouwVE7WH4OHHQeAuc
         VOrg==
X-Forwarded-Encrypted: i=1; AJvYcCXCr0x0FrS3XBTQSsHtA1gVGjbC8LL0TOAvGBb67oH+a3acUDRhjqSso+EZaOWQjhbgTCpn/Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2A+nBxoCUXdjvL35I3qPvK/wmFy1QlXZv2ah6f5kjGAbjnX1Q
	P/YyLKaXIES3XsaHLOD0clQ7pwoAvxKBHxdc0YCKp6JZxIAGqwI8ZrkdT+HT
X-Gm-Gg: ASbGncv/wnH+GzokcYnAKxJij+Akizh4VQu30upph08WQ8D3KoO7VkFpCCQQh7te89S
	BqNljnehdPF9nEgxdMQBLGT1EO83aakA6mYyyG8LtZGUajrorRIDbAnELKnCBtJt3LetsncO+iA
	yhjDubp7obNSnil8ziYOHW+d4vSa/lMwQplNrcd7208UoySgEiNtgMPqcAQIwe6vVYEmYQqkeXv
	PRYOVTIetmnXrZ0ovhORnMGDRhaK6ZmpXkHIe2VbMWRbm59juqNEcUJX+6apY2Tz+4=
X-Google-Smtp-Source: AGHT+IEp3abbG2Upl4tmPIxBi0/ZD0nXcGUDumhnjhhgm5TtRt12nKaBVlVq0aGdXg64gZf3ol6F8w==
X-Received: by 2002:a05:620a:838f:b0:7b6:6701:7a4d with SMTP id af79cd13be357-7b67c48df37mr578186685a.56.1732755820730;
        Wed, 27 Nov 2024 17:03:40 -0800 (PST)
Received: from localhost.localdomain ([50.217.163.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b684946bc8sm14294285a.56.2024.11.27.17.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 17:03:39 -0800 (PST)
From: Gax-c <zichenxie0106@gmail.com>
To: ivan.orlov0322@gmail.com,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	chenyuan0y@gmail.com,
	zzjas98@gmail.com,
	Zichen Xie <zichenxie0106@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: core: Fix possible NULL dereference caused by kunit_kzalloc()
Date: Wed, 27 Nov 2024 19:03:14 -0600
Message-Id: <20241128010313.7929-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

kunit_kzalloc() may return a NULL pointer, dereferencing it without
NULL check may lead to NULL dereference.
Add NULL checks for all the kunit_kzalloc() in sound_kunit.c

Fixes: 3e39acf56ede ("ALSA: core: Add sound core KUnit test")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
Cc: stable@vger.kernel.org
---
v2: Add Fixes tag.
---
 sound/core/sound_kunit.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/core/sound_kunit.c b/sound/core/sound_kunit.c
index bfed1a25fc8f..84e337ecbddd 100644
--- a/sound/core/sound_kunit.c
+++ b/sound/core/sound_kunit.c
@@ -172,6 +172,7 @@ static void test_format_fill_silence(struct kunit *test)
 	u32 i, j;
 
 	buffer = kunit_kzalloc(test, SILENCE_BUFFER_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 
 	for (i = 0; i < ARRAY_SIZE(buf_samples); i++) {
 		for (j = 0; j < ARRAY_SIZE(valid_fmt); j++)
@@ -208,8 +209,12 @@ static void test_playback_avail(struct kunit *test)
 	struct snd_pcm_runtime *r = kunit_kzalloc(test, sizeof(*r), GFP_KERNEL);
 	u32 i;
 
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, r);
+
 	r->status = kunit_kzalloc(test, sizeof(*r->status), GFP_KERNEL);
 	r->control = kunit_kzalloc(test, sizeof(*r->control), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, r->status);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, r->control);
 
 	for (i = 0; i < ARRAY_SIZE(p_avail_data); i++) {
 		r->buffer_size = p_avail_data[i].buffer_size;
@@ -232,8 +237,12 @@ static void test_capture_avail(struct kunit *test)
 	struct snd_pcm_runtime *r = kunit_kzalloc(test, sizeof(*r), GFP_KERNEL);
 	u32 i;
 
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, r);
+
 	r->status = kunit_kzalloc(test, sizeof(*r->status), GFP_KERNEL);
 	r->control = kunit_kzalloc(test, sizeof(*r->control), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, r->status);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, r->control);
 
 	for (i = 0; i < ARRAY_SIZE(c_avail_data); i++) {
 		r->buffer_size = c_avail_data[i].buffer_size;
@@ -247,6 +256,7 @@ static void test_capture_avail(struct kunit *test)
 static void test_card_set_id(struct kunit *test)
 {
 	struct snd_card *card = kunit_kzalloc(test, sizeof(*card), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, card);
 
 	snd_card_set_id(card, VALID_NAME);
 	KUNIT_EXPECT_STREQ(test, card->id, VALID_NAME);
@@ -280,6 +290,7 @@ static void test_pcm_format_name(struct kunit *test)
 static void test_card_add_component(struct kunit *test)
 {
 	struct snd_card *card = kunit_kzalloc(test, sizeof(*card), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, card);
 
 	snd_component_add(card, TEST_FIRST_COMPONENT);
 	KUNIT_ASSERT_STREQ(test, card->components, TEST_FIRST_COMPONENT);
-- 
2.34.1


