Return-Path: <stable+bounces-94094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C349D3387
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 07:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8691E281AEF
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 06:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193D11581F2;
	Wed, 20 Nov 2024 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZVk6w30w"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD6156C62
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 06:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732083927; cv=none; b=uiXL7TDIv2x1/RrRpCvak9lC/SG+3n5Dn5QIm38hp4QDf5jF+HVvtnN9LGJp/eySm8xZroQVHlBSx3T5DMLfICe9eT0uB6uPGzd2tt8xqrRnpF5GX8OaJI2o4qt5Mk2hEpFx0YuOhX1lMttwNGDyXDUPiPiTOUoozA8Ir7+90j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732083927; c=relaxed/simple;
	bh=R017cpge8ees2gqYK6x3gZ7yFo6Pw6vwX/ZyOP/0MNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRxBrdOB8JPLW+7mhebggsoxBJVSJa/crkzgevHn95ECp9hkdc3bV5LIZLBtCYS0eust0XoRGV5DTdt++3pdNSSCri0IJqEdWfeDYkCNWhsYCoEkoMHeROvg10cXpR4Ty+6ZxMFSZDa5e9WYhhdrVax4mDIu5pfqGbrOeVKKgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZVk6w30w; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fb632bfc0eso2767244a12.0
        for <stable@vger.kernel.org>; Tue, 19 Nov 2024 22:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732083925; x=1732688725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTmi6jByBjzNktXwXkJRmpSHct0ei4O8K+9JqDiETss=;
        b=ZVk6w30warozuAQ2/pcqEIk89tr70uN+ln/CTbVyNnJXIfkaN57k0AYZLdLp0g2KOM
         36jjY98wdCSkbP9fkoiOCy6xV4oeFVjH3jB01jBa+q/ZUERW+aw10sBujP0AzTCN4vbZ
         OC9HdfvTOvhhOmCfJbey3hn/0o/ZPzXZS09mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732083925; x=1732688725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTmi6jByBjzNktXwXkJRmpSHct0ei4O8K+9JqDiETss=;
        b=wObwdKo3nPJY5UqExMED3DGTTIv0/5JDptkrmtjvpnYvcdAyaRIB1TAW/lIhtcbu/7
         tc5SybFwOcWuEcU3Cs9orWh5pRPXZHfl+iwR8XqRHiFxHXc3lwzkSJqXvZ9PymYUzVgf
         AjUFSQrLZJNgbxOwf9D3YMTXwBKVFw1DsncUvEL89hDXlD0rTrTC8f6xVmQYE8Uk2MTf
         IcfhQ8hpoeYXYdujNi2mStIK/Hj26UXKk40arYfJUQIP/bRABjvmYH1yjpV9tjWWKlmh
         cRprZW3VKOZjZbn8UujXsPLBe8TXPFtVQbMeuWBaYpqE4D+kVVxqIR1xEWvg/sexbMwb
         eyRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsMc9ACw9hs0pvjJiYp4piMlLfw7LCxox4OnsYuV3K1VzOh1GHqK3F8q7me8OYbqObhZb7AbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuRKi2kTv4s89/zEK//FFr+qfZo/aBDYsnvMt7nXRLswhFZLSk
	mVpZjnkr9m+d15ZbOB40L2lw23O8tE9jwsO1hsqLBlIZFg4dFEUda0MD/8sDkA==
X-Google-Smtp-Source: AGHT+IGiwmdc/aUVbve0b+8Rm2RprkONKeB9ZnpHILarTBjNfALPsI6VOgfIsP96w9G1VB+vrxirUQ==
X-Received: by 2002:a05:6a20:244a:b0:1d9:c615:944e with SMTP id adf61e73a8af0-1ddadff9cdcmr2873506637.4.1732083925669;
        Tue, 19 Nov 2024 22:25:25 -0800 (PST)
Received: from localhost ([100.107.238.250])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ead03c939csm488386a91.52.2024.11.19.22.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 22:25:25 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
To: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	quic_cang@quicinc.com,
	daejun7.park@samsung.com
Cc: linux-scsi@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: ufs: core: sysfs: Prevent div by zero
Date: Tue, 19 Nov 2024 22:25:22 -0800
Message-ID: <20241120062522.917157-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent a division by 0 when monitoring is not enabled.

Fixes: 1d8613a23f3c ("scsi: ufs: core: Introduce HBA performance monitor sysfs nodes")

Cc: stable@vger.kernel.org
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/ufs/core/ufs-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index c95906443d5f9..3692b39b35e78 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -485,6 +485,9 @@ static ssize_t read_req_latency_avg_show(struct device *dev,
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	struct ufs_hba_monitor *m = &hba->monitor;
 
+	if (!m->nr_req[READ])
+		return sysfs_emit(buf, "0\n");
+
 	return sysfs_emit(buf, "%llu\n", div_u64(ktime_to_us(m->lat_sum[READ]),
 						 m->nr_req[READ]));
 }
@@ -552,6 +555,9 @@ static ssize_t write_req_latency_avg_show(struct device *dev,
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	struct ufs_hba_monitor *m = &hba->monitor;
 
+	if (!m->nr_req[WRITE])
+		return sysfs_emit(buf, "0\n");
+
 	return sysfs_emit(buf, "%llu\n", div_u64(ktime_to_us(m->lat_sum[WRITE]),
 						 m->nr_req[WRITE]));
 }
-- 
2.47.0.338.g60cca15819-goog


