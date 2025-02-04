Return-Path: <stable+bounces-112111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D6EA26A5D
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 03:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86438162B2A
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 02:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCE01487FA;
	Tue,  4 Feb 2025 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAx7iZHb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428925A634;
	Tue,  4 Feb 2025 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738637857; cv=none; b=JCXpuQhOzimJZas/YpuOPR9SlT/7QykDsg7wL9AyMCsbaxPqjpQujyygJidnUbtoa1tQHPxOfxP5QPdJ4OlHUaDlwgiOdi2+7Nbn/5XfAFeBELPuWqRHv4z0zJsKjqwz6Vn5Qaq7Ops9vHBVXqHWkmPlTJZOtNwJc/+4lFNnFfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738637857; c=relaxed/simple;
	bh=0DLw6WPwVpiVcGlmfsPFaoECS5bCzCsop0nSPwE/tug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSNMkb1/TrRGc8YNbk7gk6SDO2NTWcP+TqTLcEIjyF2TcqVNTuZOW9N8LsHwxgGRAVGZEx3OqnUgjHECuxO4HSVZF9pCcUIcwJF75A9EqzBt80IybZSH7meecnfPw/8qH7ROH2tJ75tql18Vl5J+7Lav+w4II8OqmkvRiX24KNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAx7iZHb; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d8e773ad77so39060066d6.2;
        Mon, 03 Feb 2025 18:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738637854; x=1739242654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01xYVOcn3Et3qzgKrEqNkTk/ecuaNp4dEEFyUxrN4Ao=;
        b=lAx7iZHbwQbe0uurZDU14Yy627V5NgnIpSAlX/Bdcneh1FA6ixcFWtzj9Y9aWIN+AD
         sJChxQy8OY4TwvQfixGr9o6KDfIA8L1YrY7Iv1ORJ0jYo0mX+0vKkKa12sRXfr9A0UGn
         FBxc3s3q4SN81csldTc4vw6Zf1Fy9xzpsTYxY0hxaU49xc/NC02fUvD7lQFMtSN9tbBy
         bnE0SSCNDkScsZofHpRiqfUi/p727jOyaUs/cW4GsmKf8/7AaptsIEVqcIRGNBeMztKV
         jYDNYNkR/LPiwXlzoVmOj/VeznUWMO/V6aTvgjULsFqDMBsaGrQ081dMOWwLZ0rM2upg
         jHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738637854; x=1739242654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01xYVOcn3Et3qzgKrEqNkTk/ecuaNp4dEEFyUxrN4Ao=;
        b=GGPov+HFGy2kBS/3P9ZPBH6m0xbX6Y+73yq6inOKr3oj0zU2d41cz1qXlgROHyYxQM
         jwFjX/Meh73djFC+bF37i7xfZceSAVLN5v+5NljBpifZwcX1+m6IEBdA0Oq/ECDlGyRO
         tPZPNgTv2y3EgZcNo0F89hUvExt7GnCufscYmpYxreZzZ9iUDHM8X/vG39Ogvve/j8Dn
         +tOOWbsdBuzXtnpOzrJZqE5ZIb6Qc1d/NEQSKHVf2NqVKLRBdQuhdsavc4rrYCrD9ZwY
         b+soXLBQdwdS9vQIl0XG5Eod/vLNRTDbFEIxGWFZ+54flH3t1VvgQAmA60DaFtvJMGmA
         dsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk2h5D33qK5FewADwMLuIHu5xv4zIFk1PE33DU6/KkFm2kMuRizwlLkA1UEnaDXD44PlbVcbYFj0FcAuM=@vger.kernel.org, AJvYcCWlaRl+WTUGYQb9ghXWkRDrqsDZjR0ea1nmwMgoVV+0lh5auF82UOnEaKcBZl8csdgCPO3Fh7a3@vger.kernel.org
X-Gm-Message-State: AOJu0YwabburZr9fCITzlV/h04jaJoJ1iaGWuDB86/Y7i3JlEn4mrMHf
	7yxzZW0ixOsxUB6auvMwllsViuI0EwYccvI04z6kMe4Ud2jzTgiVrYPb/w==
X-Gm-Gg: ASbGncviJjD1PUHRyY+EYafIbfba3E6c4uaC3rdghokXOJXXHQkurnDzprhAeZTef+L
	uOe/JNqrHYxsMM5ESLIICizNqPlaDPh0obRqnKZjDht5njTd8wNpvm+6kikCnLvYneBXqkBKU+W
	LVwX52bxSs+ukwJ2flxrdTjsYFX0lWaD95vN5RtUCahkfrrjOMALefKlonWs9Kne9LD4RVw+pg8
	PutCLz+E7DbQt3+WsXQ2tlMW1ioRpxE3kCLYj3NoE5Z8ycp7BqZkXUuuLmcrHoUoY72190beU5L
	YYDN9nPJuBEth3oK1Fctj1OBx/YVtWV7zdDn7A==
X-Google-Smtp-Source: AGHT+IHCach5jexaOHlT3bnTIphC30SUeVwyDsbpxGeQLNbAqTu5zE6J9qUZOMu3pfZdQFAfsrU8dA==
X-Received: by 2002:a05:6214:29ea:b0:6d8:80e8:d567 with SMTP id 6a1803df08f44-6e243c2b69bmr364788876d6.18.1738637853015;
        Mon, 03 Feb 2025 18:57:33 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2547f3df9sm57609116d6.23.2025.02.03.18.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 18:57:32 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org,
	dakr@kernel.org,
	jiashengjiangcool@gmail.com,
	linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com,
	rafael@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] regmap-irq: Add missing kfree()
Date: Tue,  4 Feb 2025 02:57:28 +0000
Message-Id: <20250204025728.15347-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025020351-cornfield-affix-8cf4@gregkh>
References: <2025020351-cornfield-affix-8cf4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kfree() for "d->main_status_buf" in the error-handling path to prevent
a memory leak.

Fixes: a2d21848d921 ("regmap: regmap-irq: Add main status register support")
Cc: <stable@vger.kernel.org> # v5.1+
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2:

1. Add a cc: stable line.
---
 drivers/base/regmap/regmap-irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 0bcd81389a29..b73ab3cda781 100644
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
-- 
2.25.1


