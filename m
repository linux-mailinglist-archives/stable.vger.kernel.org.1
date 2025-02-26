Return-Path: <stable+bounces-119743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E292A46B37
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 20:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7FE188A223
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 19:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047CD242928;
	Wed, 26 Feb 2025 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO25zdUB"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6413D23906A;
	Wed, 26 Feb 2025 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598641; cv=none; b=QIyRlmqyXH+bJ2H0h2e9qT5bm3MGJcAnWdIfXh0iGVffOXY2bF+0f5O7Taf8q8F/5G/NVgDZowhvybud9yVgEpZ735a3HIGroXuOlu3bUGchwR8B+Y41Sg41VOBoQ8u9yiZ/uspU/wvZJYa/E4n3SYMAUdHfvEWXOD/6i0BXm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598641; c=relaxed/simple;
	bh=YE+cRK4zyn2ubWZrhENb1sLOMs4gBjGYQUSYhCNc7dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lBd6vffGj61HrdVuWEXoAIZKSCrESXrV1CrFwF5u88R//d0TbaNicWLrxmMCUqoKVevBm0LzETcAXdqQ1xCIKmmkwCxKAY0KlqGp4BWfAbIjIUX3D5KT+aTqoVmp0iYcJN4di94ORblNktamAWPi9gQREvHXMoOWRjoVUWl0Wq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KO25zdUB; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e573136107bso120602276.3;
        Wed, 26 Feb 2025 11:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740598638; x=1741203438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af7Z/uod+QrlIDt3obhpdUxVK99B/wRpb7oWjrxGf7c=;
        b=KO25zdUB4wYcwg/QL8ZwvIYJsXOe6i0uoxC5OwnrQBb3Gaf5XnF3R+Mbtc+I5c9ama
         QjMZRLAIc5TQivP/gfQypN8A1M73AEHCNQqxJdEzqEZfxR9/KYRQ5qiAnsm7cyJ4M/gr
         UbnrF3qYv56rmrlEj8aAcTzOWYLvJqltkZ4RrpLsIUBKKOWHqFO7QkPSKnqLfhtl34ki
         e+jQwUR6Xjq4mO6hMbzMQjoN3sTFce0CDeKZn763oAsl1PpS09HzTBJM/bbYEot0T2u2
         XBJO0DogZV7FrMyDqO31ALTyFJkpycQRy4L3dUZuqRLZamSZmADOLs/owZ9LPJ5VZm8E
         2cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598638; x=1741203438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=af7Z/uod+QrlIDt3obhpdUxVK99B/wRpb7oWjrxGf7c=;
        b=QXYpl+pLqtszE5p05hemlgtjrZjxAvjmJmGC7MfaXRpDcfYUIChxXKWv3ETxKY78PQ
         WLL79gY4U9pyEtJvmoWFNUogDWISPDxsClOQ3L+8MksM6jtp5MzdVu+1YQ4ydL5/J2C/
         TABUUufhvwSCLRnSZaLAXA+iFMu0fjPIJ5NOp/lpbiBKXTn4DsKjHh06RJAUqdmGYYYQ
         7QwDfR2WapJ+Fhkz4/C1NT63Zv1We5kDzam1W+CzPPDGHaITlzG+mXqDCys5WoV+X8VV
         Yw7QFTN4mVft+u5YLYMt/18I7a7kse1qIgkuV6L3pXll+leM5dpOR/DMlLJicAWlUr0b
         4R/A==
X-Forwarded-Encrypted: i=1; AJvYcCUua9pTOKOVuX5CMwf1xcIL9fge30kx4+/LQ+NhV+O03tUZK2dePNvpDdVjBwe8WkUwhnQTppeU+HgINXs=@vger.kernel.org, AJvYcCV2GAaqg8Ie2fmBsQ2gfmKO/8ZWhpAcU8ubN718zXPNxCVbtcjUqnKV++inrgHFh+OAYrxkKVIy@vger.kernel.org, AJvYcCWH8OYmUSi2jPcLLvd7PRuh5YUR5KraT9QiAfJr9X9pPjvnm8TRFehOuS0r7r0GkaPGk+dFjads@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/lVlTsvMDNz49U2jSaQOcalaLr5Tm/MFelqc9l0sBWHF00HY
	IsYWiqVVJehz/vrWDeRu7iwb00rXLk/gkhSAxBV8Un6kPJj4YgoL
X-Gm-Gg: ASbGncuNATzp4dV4D2I65PprW28ikPwXr9j04xRcYBSE6aiIgNeropbpJqkaWn+TdJA
	eMS5bm5gq0lV+AEriLXnjlj0J+a8DKeFVBzR2iXPveQ52WJAnKBosP8OMpQ5C+YT9cA23x8qKv7
	gZkpiFNLJF8dAYZp1r92JAVr4Ftscko5PQnDfL4syJeBxj5l9E8h/gmSiTjI/w7GP4D5K4fSTei
	hHQAha8x1VygddkNs70ytNbm49kk7SjHN3PeesV2XiD80xkT4hMIttFZqAwcuaSDQPSVFSp+LMd
	j6OTg0UvJk6ncoXFpVGb3gb2sG9N4YsogrkDzeyMChdElGgr
X-Google-Smtp-Source: AGHT+IH/iVmbXhijR8cCJH0qOLEnyZLD2rz1SQR+7kMgMGXP244dpk25WIWHsI+xPT969fM88oO3rg==
X-Received: by 2002:a05:690c:6d13:b0:6f9:82fa:6d96 with SMTP id 00721157ae682-6fd21de835emr50605317b3.11.1740598637950;
        Wed, 26 Feb 2025 11:37:17 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd1167e553sm11428247b3.33.2025.02.26.11.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:37:17 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: jiri@resnulli.us
Cc: arkadiusz.kubalewski@intel.com,
	davem@davemloft.net,
	jan.glaza@intel.com,
	jiashengjiangcool@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: [PATCH v3 net-next] dpll: Add an assertion to check freq_supported_num
Date: Wed, 26 Feb 2025 19:37:15 +0000
Message-Id: <20250226193715.23898-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <74xcws6rns5hrmkf4hsfuittgzsddsc3hnqj6jbfsfu3o2vvol@gy32jyg75gmd>
References: <74xcws6rns5hrmkf4hsfuittgzsddsc3hnqj6jbfsfu3o2vvol@gy32jyg75gmd>
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

v2 -> v3:

1. Add "net-next" to the subject.
2. Remove the "Fixes" tag and "Cc: stable".
3. Replace BUG_ON with WARN_ON.

v1 -> v2:

1. Replace the check with an assertion.
---
 drivers/dpll/dpll_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 32019dc33cca..0927eddbd417 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -443,8 +443,9 @@ static void dpll_pin_prop_free(struct dpll_pin_properties *prop)
 static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
 			     struct dpll_pin_properties *dst)
 {
+	WARN_ON(src->freq_supported && !src->freq_supported_num);
 	memcpy(dst, src, sizeof(*dst));
-	if (src->freq_supported && src->freq_supported_num) {
+	if (src->freq_supported) {
 		size_t freq_size = src->freq_supported_num *
 				   sizeof(*src->freq_supported);
 		dst->freq_supported = kmemdup(src->freq_supported,
-- 
2.25.1


