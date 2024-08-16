Return-Path: <stable+bounces-69346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A0D955176
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 21:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E69B239A7
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 19:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FA41C4610;
	Fri, 16 Aug 2024 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOb03rvt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4561C3F3E;
	Fri, 16 Aug 2024 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836483; cv=none; b=DkghdvMQU4Ox/ZcRXi8+cNqsfnc4sie8ZlnGA4eRpdFrMxSGMl7QB9QfWx6tByf5FIaiBx5zvRVVdkjS60PrAgP9B1SMrsG6Jt3GVEveLagLA82BTKccoF3beBRqKys+V4g3WA6cef9DmsnjSBOodvTGA+hmYcHCzq3RyLo6CaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836483; c=relaxed/simple;
	bh=CIw9DPk2JTHUJqxqpuLOS7kldbV+bgDrJlwd4gP3AOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ft1idvIj8niLnq8f0zyr+eLeH8mlkm0dNA1vcntKwmaVChj588VB81rtPQoegacZwIyq1XyHtfoe2og41tIcAssUBUWPT/5QMF94c+5A7smMZxDbwDzV3KTZF/8edZ1Iyetnq7N9Nfx1iKb59t4ohJ2p+oeDvmjvkMDiiEPr0ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOb03rvt; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-530d0882370so2409245e87.3;
        Fri, 16 Aug 2024 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723836480; x=1724441280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CE6XtGp7KoeNdDNBrlXqZpr1Iyoicx4DxbmZrRjkjss=;
        b=YOb03rvt4TUwVdO2gTTsyj6rtiRfLQhiEh1EMlTS7akdB2t0q5xjmnVXQpHtX2HSZh
         2jJ0gBlRgDZSsbTGjNuGizMmY/CLZhZzDJBJxy8UnXCm84mVE3mB0AT8ENaSM35sohZM
         iz0NcfMvXfpBh0CNcC2yP/u/NHkjb9NaRg3hPioqkxK51moq6iO5JGS267MaqB9pvI75
         8wHioyQc0Pd8w3CEA8cs0qfLv4i1wXwzSl1cmLyIOlWVh2ZxJjOxXWmYy/pkx7QpvDhY
         x7uzV3VkdRgWYx4bVskHTzFh7ihQWgu1WhBVSSoBKKS9oxsym0uN404UCvgSAhsq7VMb
         lECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723836480; x=1724441280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE6XtGp7KoeNdDNBrlXqZpr1Iyoicx4DxbmZrRjkjss=;
        b=FVy7EfpV2Ag882ZaG+fI6k03mN+Z3lvBfRMcfzT7ZySuuDqzyZZZghBF9PZXqsdgtc
         ycSBmWzwGZ+jAnu5FAY0KtVTZvA3ziF4DapwVxxQw92AEcmdGi4wQDvAzYNYfVpAy9WP
         7Mhm+FZLiHxOJP02ZDZpIQLO84Gh/4NQTTrBPDDGvKu9Lr3BNB8EtON8MzK+bkROHP5o
         ZuCYLBZZ6JWHWc096mkcTLvEkzdUSmPQmxBnCi8DbLDCqvjY5T39+KoRLh+KTWelnrL0
         1HYQYueVBxsMnR/05zEs4rBL041NtasGiv2q1aJdjxD5N73+/SYVRmLVjwoGqsdCibvY
         3l/w==
X-Forwarded-Encrypted: i=1; AJvYcCWv4GDpJpphM9oTRsH7uHBrrKmgKg7hPGVip/D+BUbfnSeOJ1/9ddKzQy0h5dVuwpSBBa50zcIHh+ddRL/TF/HVidUWZmDWT+rDMjH9MjMVvAXOCYU/UhkUr5juJMKFq2R3+JMKGpLo
X-Gm-Message-State: AOJu0Yz2XgNv7T4oqpCjxuHRZ4i+dC4whmOHNZ6dUqrAH995adZwfJdi
	cNymNyVp6HXdH0rTBMoRTt/hCXltXs7ScUks4VHLzhGE+BMlz8Kn6Gfj5Q884BJLVQ==
X-Google-Smtp-Source: AGHT+IEymvjbBVzQIV0kHSXsyBKvbYFRUuVdZNg1ZdOqlMhK2EiiNqpaLjZQcYNP5PbzUZWCqF1gqw==
X-Received: by 2002:a05:6512:104a:b0:52e:7f09:aaae with SMTP id 2adb3069b0e04-5331c6b0286mr2768812e87.27.1723836479323;
        Fri, 16 Aug 2024 12:27:59 -0700 (PDT)
Received: from localhost.localdomain ([178.69.224.101])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d3afb15sm655960e87.21.2024.08.16.12.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:27:59 -0700 (PDT)
From: Artem Sadovnikov <ancowi69@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Artem Sadovnikov <ancowi69@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v5 5.10/5.15] ata: libata-scsi: check cdb length for VARIABLE_LENGTH_CMD commands
Date: Fri, 16 Aug 2024 22:27:52 +0300
Message-Id: <20240816192752.9488-1-ancowi69@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No upstream commit exists for this commit.

Fuzzing of 5.10 stable branch reports a slab-out-of-bounds error in
ata_scsi_pass_thru.

The error is fixed in 5.18 by commit ce70fd9a551a ("scsi: core: Remove the
cmd field from struct scsi_request") upstream.
Backporting this commit would require significant changes to the code so
it is better to use a simple fix for that particular error.

The problem is that the length of the received SCSI command is not
validated if scsi_op == VARIABLE_LENGTH_CMD. It can lead to out-of-bounds
reading if the user sends a request with SCSI command of length less than
32.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Acked-by: Damien Le Moal <dlemoal@kernel.org>
Co-developed-by: Mikhail Ivanov <iwanov-23@bk.ru>
Signed-off-by: Mikhail Ivanov <iwanov-23@bk.ru>
Co-developed-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
---
Link: https://lore.kernel.org/lkml/20240711151546.341491-1-ancowi69@gmail.com/T/#u
unfortunately, stable@vger.kernel.org wasn't initially mentioned.
 drivers/ata/libata-scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 36f32fa052df..4397986db053 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3949,6 +3949,9 @@ static unsigned int ata_scsi_var_len_cdb_xlat(struct ata_queued_cmd *qc)
 	const u8 *cdb = scmd->cmnd;
 	const u16 sa = get_unaligned_be16(&cdb[8]);
 
+	if (scmd->cmd_len != 32)
+		return 1;
+
 	/*
 	 * if service action represents a ata pass-thru(32) command,
 	 * then pass it to ata_scsi_pass_thru handler.
-- 
2.34.1


