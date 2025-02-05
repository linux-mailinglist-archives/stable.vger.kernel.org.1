Return-Path: <stable+bounces-112258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DD3A2803D
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 01:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F443A72CA
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 00:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B33227B9D;
	Wed,  5 Feb 2025 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYALZiu5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5C227B96;
	Wed,  5 Feb 2025 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716228; cv=none; b=YHgZtVZEbgpMMQKRObS2pnsutSMSMISbJsvrsgCApYDAK/VDfEZFCVXR+AR2WdiZ7gmQrobwXSn51bG62Cko3Vn7zPxmNQX4hWNnaEtPmM/IzZ0MnDxjM5DHGRsSQfu4ceVsV4UneaMNbJv/W2JeK3YXPtPzdqDWYT/SDnhorVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716228; c=relaxed/simple;
	bh=wFF0buE+n4Z/W/TPm3SY/2G4F0JfmZg9zxSGIJD935Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/swapQijlAsY1QneMUyPIFvuSG7Q7TFMYMoXfjvM//9TGf000i5Nn6AFjcl+rEQMZ+QtHEkYpcRl1WOWSIML56mWhtHV9yLnETS+Iw9slikfmXYfri3PBTWOrHw+SQ2t6ps6wwB8V7W69AoGqKIBxYvLV+4j/3LpMOYS3mEgVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYALZiu5; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6eeff1fdfso559149485a.2;
        Tue, 04 Feb 2025 16:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738716226; x=1739321026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzb4zP7i5IlmoBFgUs4VvFMiHfPg3IAAZoeV+R5bjfU=;
        b=IYALZiu5Xfsad8/EgYEC2QSjlCk6Ydw0JVZj95V7RFsc9nGdwgyTc1nwxIWvnqEJbP
         OsHi85TZWPAE9TSS/rWGmYaGiWwcVrVZIYm8anoMmEyMmF6lJRfCZOB6tqy/2oKLMPzL
         8fuqFHKF/fNPrerlEebBHOso8A60Z8lgisS29fuWwT3KBEFS4zmJTk/yCaVt/gmh1a4J
         r2/iwd0mjdGSzgAMYO8sMV5Q7QUcADfc5J0JOWOOiRyKjvj06Af8XdFiuQavvCAZBr3B
         0h7JCpxKNl9kYH81ztxi/bDFtYWK/m7Mhys06tp0H/DNeGzGB2Wu5yXegTpG42tumnu8
         dDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738716226; x=1739321026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzb4zP7i5IlmoBFgUs4VvFMiHfPg3IAAZoeV+R5bjfU=;
        b=lhVluUxgBLzk/0DRkwyoN7XfP/QC7zoa7LqwY2x33zX07vhM1wExsqPs8nAYlo4Hlw
         sRB075Ei0fFgdThWOSD3utj3brDXJI3X6Eps+/HJp2ZVe5r7/3yPaGlW4rqiGJLSddhD
         ZCAESUq8nxHMJy0q/k3+5xZflYYWFtapoE7MNXyoDVWchBAtDbWdR9VovWFkX0jdl+nn
         NH5dF87Bku0GDO0BmQKmviR55Tdqw3O+TAxyfzJmonOY0iw9XQ/uzMyzAnJ2krMGSYfT
         2U61kAyM7ZlLF2Lc4bJ+Dz1VZIlkrROnFcYgzt9HBnA2mm/4UdvabxTI6eHBUwWk0fKB
         Y5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCV7b1kMoRmfVVw3lEePgVSk43RJ7xXqSyRCkfKPNXDV7Y8pB9NpDKTzqHvYj3ScNR88PhcF/t5KzwScCK0=@vger.kernel.org, AJvYcCWseUauT09d4f6jH0kb20Xwe84dgtzAuvIuXDKEbWPYG1pp8ODdK0w1uoDbkgwOWJdTJIZAyGZv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1YG7M0RLB3OGbO33YrPjuq3kZMyJLCLP9O2BACJfJkAUu7HbK
	U4eLjtvhRuqK4iVGOfSZPm/QqhTYvr1pm+Z05L6d8PUgWLlmWilRMAftkw==
X-Gm-Gg: ASbGncsZfF0oIHfJ0UNvlfkFq7E7FquWIkU7cj6gO+n2lpghW6EmEPy5xxZtWmj2pTq
	ogI76ugaHJq8P5uuPWzC1k4BN6gnWTzseaKzPduQy22/3uj7yPP7biG8zujMCUurroA2LKbr9i9
	Wyd5ugusdA+tIDATPKvSq2ZexJ/J92u9rGhrA+9jHFFM7z129g7oXT4aeNq9GZDfeH6bTdVRwYL
	IitZ65ulihbD75TlJfDulr9NQfY4q+Ge5byX3BeENPs1LKsJei9FN+tL9GBV02gWip5wf3Skjba
	LpPtPEK2ZVfnzCF29fEG0KQYIJGaWLiAIbUZbg==
X-Google-Smtp-Source: AGHT+IHQkCCCoOux0E0BbQEUJQrZgCHT7xAEg04wqTGE8APKZbAnrbAeal3eznjICMcqTm3namTOxw==
X-Received: by 2002:a05:620a:6011:b0:7be:8304:f24b with SMTP id af79cd13be357-7c03a02f29fmr178738685a.56.1738716225783;
        Tue, 04 Feb 2025 16:43:45 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a904810sm691868885a.66.2025.02.04.16.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:43:45 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: mazziesaccount@gmail.com
Cc: broonie@kernel.org,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	jiashengjiangcool@gmail.com,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] regmap-irq: Add missing kfree()
Date: Wed,  5 Feb 2025 00:43:43 +0000
Message-Id: <20250205004343.14413-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <27dd749e-712f-46eb-9630-660a8f8f490d@gmail.com>
References: <27dd749e-712f-46eb-9630-660a8f8f490d@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kfree() for "d->main_status_buf" to the error-handling path to prevent
a memory leak.

Fixes: a2d21848d921 ("regmap: regmap-irq: Add main status register support")
Cc: <stable@vger.kernel.org>  # v5.1+
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v2 -> v3:

1. Add kfree() to regmap_del_irq_chip().

v1 -> v2:

1. Add a cc: stable line.
---
 drivers/base/regmap/regmap-irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 0bcd81389a29..978613407ea3 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -906,6 +906,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	kfree(d->wake_buf);
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
+	kfree(d->main_status_buf);
 	kfree(d->status_buf);
 	kfree(d->status_reg_buf);
 	if (d->config_buf) {
@@ -981,6 +982,7 @@ void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
 	kfree(d->wake_buf);
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
+	kfree(d->main_status_buf);
 	kfree(d->status_reg_buf);
 	kfree(d->status_buf);
 	if (d->config_buf) {
-- 
2.25.1


