Return-Path: <stable+bounces-203268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67833CD838F
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 06:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DEE3305DCC3
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 05:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCC12E62CE;
	Tue, 23 Dec 2025 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="ZIY9rLj3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44599288C2F
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468960; cv=none; b=Lh/Spd8spNvXGuqc24NOJQuNN8XXdj0ElGOFgTne2je0hts+v/OTcMwp7inocRTJzESQ34+8qjmM7S+NRlHrGyiCVBDLraLgTZQ/sOLjN8aswLsvyEAYJdbva24HmfUFr+K2g/2SWcKgOT6L0r4ye8g/2yKQ/5R2Snq/XWWMvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468960; c=relaxed/simple;
	bh=xY8s6ztPgI0v3eE5F9o/RQZ+CCnOvINklT570r72Aho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWiub92kfCQjh6LHZz3L1Hxaz8ihfw/ztREvVNCZ54MrQkdBVAI+nbtcNuKXSQCOHDUGkmzXOND1gpLYkUMZYuU+kIbiutBnPRBs5AK/BmTdnza8SCyUegZ8ZstsZ8Dy1fczRt2CWwbwi3FgegPjBoLj/kiIwGPGtkOBwtE14Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=ZIY9rLj3; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aab7623f42so5354568b3a.2
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 21:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1766468956; x=1767073756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ghnk27Lh375IVPczUN98HcLESFSEZJiCHxM52A0wZU8=;
        b=ZIY9rLj3RneCyEkq0PyYBRJLRQxlOQaeHcMBbQBCoky7Oks1vxhaRnqVJp6BV86DkR
         KM0bXXvmJVufvCsc9b6X16CwxNfhnJOKC5BingKtfUrcP8n52S9LItFQDiFpomjZzaPu
         yTo5jqW8rG8kNPPykLhiFAj71NfCx0cnWRbd6aP5wwXp5a5PC2M0hljzY3eQsmWTwbff
         fSo2VILb1FFCu5yp7ItdSUy6vgvry6Wnhbs6yCQVxMHhYFQm4eP+i6KNcrqxHr2l7xW2
         PdQX8WTKQT2tIgyb6IlwuPDI1dsgfGSb1m2SF7M7yttaIgvCGFgk3zYD/ktGzFgeoe3Y
         lKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468956; x=1767073756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ghnk27Lh375IVPczUN98HcLESFSEZJiCHxM52A0wZU8=;
        b=N0z/CTA+Z80/GMH1JR88At84XJdZBRkRNwtZpYY+G9ERRlSeE2tF18bdY3QRdd9zvi
         38z+AkPGnS5+JQJ369TvhDPx60ZkNZ//Z9CXusdF8FpqVeYfYKiMwxBNjp0Az/TeebkD
         bPqyYTmHzMur/RwcW17T5wkVot3tdH//BAoCbUXiG5KyiNELYp9giLgb2UnCxqBtdKzr
         Ixj/F/V3OfuxbNCKy2Ej+f34ZEqM4/U+NExGygEyvHS/lW5oFnxUKORu43IV7wtqDWCh
         uKthjSEDbl8UGSvDIp1WKxSN/Ec8qUfsMspinPehtDkT+0L5o6ObB0dpXCJDWICXQ0q1
         jajQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaPiTQd7InDpbKBwh3nsVsLhPaGjjacs6S5Zz5yG+S4AejjXzasN0voFO27hIzgLts3kA00Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8deTy4E2qVuqOSjXVIrdo2FpJaKTQIUFvsoAavC3GM+j0MTMH
	eok6LnSY75EC2+aRT9USKq3PGSjIUe/Qk04aPgiarjxRoIx4uXekfMRoZ4zZXmalIhU=
X-Gm-Gg: AY/fxX4N3gFoxK0MutpjKadW2J8Rld8MqepR2BkNMxwfmvgbElOBcXpGpE7/kJxxsuC
	uKNRjgHia/B6/aPqm+imqN3wi1YRfIixfROf2N3JIBX/DbgoJQDf0YO3RwvKZz/0cabbJ0pfNG4
	UF77hXYuO/ffCYHEt9ZTxEUsLZnlPdwOBi3YaiJURzvqkuyidz0CzdFVg22ZHRTolLB8fHd4OZV
	vp0SBrLIHgdPWu9sHvbghNLpBph9Rw4qIpq/w76cg+AZi9QEaiqdbrdjcLYIHuN0bAD4blKaCME
	UEwzwtO5s4922rPrRCB3fEK7rCnV+R/yTZtaAU2JoukUapeZUl4Q20a2nPn985I1cOQ+jq+Qy3n
	SYRoSq8vPjEPTzFhmJm/HTeYpPy4A81rxMa217L1mpttnIHhQVNzvvcE+DQ4ZIv0TzhRoWDP/GT
	1NoJ3LnA99NrVIy8Xx5stZWyMp
X-Google-Smtp-Source: AGHT+IESOyjjQEV9cmHpzOZNpIr+8MrRuRllRcSqhZYjGKbchs0xAx7vP4yzg/aNsBH7TSdefCA1sg==
X-Received: by 2002:a05:6a20:244c:b0:361:3bdd:65f7 with SMTP id adf61e73a8af0-376a75ef393mr13550597637.13.1766468956481;
        Mon, 22 Dec 2025 21:49:16 -0800 (PST)
Received: from localhost.localdomain ([103.158.43.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a2f3d5d3fasm115282995ad.69.2025.12.22.21.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 21:49:16 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: mchehab@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c/tw9906: Fix potential memory leak in tw9906_probe()
Date: Tue, 23 Dec 2025 11:19:01 +0530
Message-ID: <20251223054903.69043-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In one of the error paths in tw9906_probe(), the memory allocated in
v4l2_ctrl_handler_init() and v4l2_ctrl_new_std() is not freed. Fix that
by calling v4l2_ctrl_handler_free() on the handler in that error path.

Cc: stable@vger.kernel.org
Fixes: a000e9a02b58 ("[media] tw9906: add Techwell tw9906 video decoder")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/media/i2c/tw9906.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/tw9906.c b/drivers/media/i2c/tw9906.c
index 6220f4fddbab..0ab43fe42d7f 100644
--- a/drivers/media/i2c/tw9906.c
+++ b/drivers/media/i2c/tw9906.c
@@ -196,6 +196,7 @@ static int tw9906_probe(struct i2c_client *client)
 
 	if (write_regs(sd, initial_registers) < 0) {
 		v4l2_err(client, "error initializing TW9906\n");
+		v4l2_ctrl_handler_free(hdl);
 		return -EINVAL;
 	}
 
-- 
2.43.0


