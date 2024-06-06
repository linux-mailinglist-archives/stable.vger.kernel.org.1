Return-Path: <stable+bounces-49923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A65E8FF590
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 21:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D87F8B2499D
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 19:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0C77346B;
	Thu,  6 Jun 2024 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="Zvfs0+og"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D377316E
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703906; cv=none; b=JxbJAu6dPThnt4V9578DYchIg4nLutkWu6WSZSKkM0Ymcv1rC+Ar3fVTxtOYse2F8MFR52wX2Q2BIGqmytw7AvordQ/8sWCajlmFHlx91inb/4hW1hr0qzIh2fOnd0YpBfBUx4EWvYGiZ4zKKcZ8hTZeo7Nqxj5P24gEFdQuZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703906; c=relaxed/simple;
	bh=Vs2VSZfdTFzFBYmrEYnYORUiXjngtp2QIi7p2bd1T9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qPjBCKLQBrDTC9hhBAp1PF5S+q58J8D6vbYOjH3FIuix4dcUm/5s2K6OpgYz3sV4xPtSRHIPsobTKn44g4dWM/sRryOR2IsssG+N35HWRwwkmTDDfUmaR3wyL6yVSxK+UDMUVD+dZHD5NExgLjCWMh9is0Bb0e7hiAMwIVVchRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=Zvfs0+og; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6c94f2d0902so114774a12.3
        for <stable@vger.kernel.org>; Thu, 06 Jun 2024 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1717703904; x=1718308704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0/VzEhoXRFXg030r8DGFCIJL7QCo862n6SDAAE5DMM=;
        b=Zvfs0+ogTLAn6S8GUz5ppAobvly5DGWEbwsXgGPmJ/Err3RiV+7H4sKbfGU6tKE4z7
         yrhk6VKN57ab8Sf8gPtesR5DQoTcEoRZrpskgpu09zRrsV4aCTz62gxBmdw5dbQ6MKpu
         vNH/Bq+RL3uZKbuh+8oeXWHhOCOi7AOueLaX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717703904; x=1718308704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0/VzEhoXRFXg030r8DGFCIJL7QCo862n6SDAAE5DMM=;
        b=Zv4n0nCsQH7a2l1FY7QcqjCYLDmJNL17w35+jh1nC6onw7mHH5HzddBwZlnJHjB0Kv
         Uk/klw9j61Nhhgj4h/3phmQTXS+PKVbrIoP5YcqPiN5gnYog88YAuKWBGO7MyBi7evef
         /6yRQj7aHOcJOg1jEpfJIr3CLIydlx8dZE64oj273DlzLWt4QBVFbshammsnJN3BGfu4
         RevEiFZJJ5QUF2MHqe8ybrnIjEAhfLS6k6TaYuH4lysEolnyCvnt+p17zMl/KW+uyDmM
         FrX8Dqq4fncc5ks2vpFSE2aK4j+hFX3Z9GmdfaXiQygahfUkv9zavnXmN7wWPJIpoWfl
         cA/A==
X-Forwarded-Encrypted: i=1; AJvYcCUUNl3mMvrxL4lDJ6xOdqTuyy79fQrJkfNWNX/VWw5AbvLmSxRgmYohny7OMFt4loOCc87RRYxHeSbqU5IJoIYoIEPxwa+I
X-Gm-Message-State: AOJu0YzhuIkakH1/HVrEVxHIrVeHBBuw738Q5FJ6LHm1FOmi25wabAye
	I1Jpsx0TrB4xknhYfFe1TVutdgP+hFRNGmvo5m+l/71HJ6RFVvRgqEHwlYp+/CKfXMuQUTRdYF5
	ANxb5CA==
X-Google-Smtp-Source: AGHT+IHJmig2k/ZbzPrTMzdlYfQWU1c0lOnEnpHiDWCvb3lDcleTaZABQ2jMYmV09x0fOxrLqRXwNg==
X-Received: by 2002:a05:6a20:6a23:b0:1af:cc80:57b6 with SMTP id adf61e73a8af0-1b2f9c7e449mr731905637.3.1717703904014;
        Thu, 06 Jun 2024 12:58:24 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.206.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd394f20sm1446787b3a.55.2024.06.06.12.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 12:58:23 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Doug Brown <doug@schmorgal.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] Revert "serial: core: only stop transmit when HW fifo is empty"
Date: Thu,  6 Jun 2024 12:56:31 -0700
Message-Id: <20240606195632.173255-2-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606195632.173255-1-doug@schmorgal.com>
References: <20240606195632.173255-1-doug@schmorgal.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 7bfb915a597a301abb892f620fe5c283a9fdbd77.

This commit broke pxa and omap-serial, because it inhibited them from
calling stop_tx() if their TX FIFOs weren't completely empty. This
resulted in these two drivers hanging during transmits because the TX
interrupt would stay enabled, and a new TX interrupt would never fire.

Cc: stable@vger.kernel.org
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 include/linux/serial_core.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 8cb65f50e830..3fb9a29e025f 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -811,8 +811,7 @@ enum UART_TX_FLAGS {
 	if (pending < WAKEUP_CHARS) {					      \
 		uart_write_wakeup(__port);				      \
 									      \
-		if (!((flags) & UART_TX_NOSTOP) && pending == 0 &&	      \
-		    __port->ops->tx_empty(__port))			      \
+		if (!((flags) & UART_TX_NOSTOP) && pending == 0)	      \
 			__port->ops->stop_tx(__port);			      \
 	}								      \
 									      \
-- 
2.34.1


