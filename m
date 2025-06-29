Return-Path: <stable+bounces-158858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C232AED16E
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 23:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDCA174829
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 21:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349B24166B;
	Sun, 29 Jun 2025 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBs4oQol"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648A241114;
	Sun, 29 Jun 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751234048; cv=none; b=tZiOxIvFSDkgKifI1Mefw/JKKhc8unASLcyH236RNJTQsce7BN+sNsvdHK3yYyFua/4ISD9ktFofTGZE4YWSg563SG+p3Z7k5Ajxqv56M2mNPR0V/tGWvGzt+eHqUeBFZ52zUjjEmCdMikZiY1ijHvYOxvQJ0k9mJ7gzUeuGD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751234048; c=relaxed/simple;
	bh=yCwguoRkXNC0/cqyRSOcs/kGHQRYviQaus+cpwdd2Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irinnHwcR6uPhwhGIeSoVGSHxFcAvEvAx/V0lEFFqCiUlxGsoOi9yF+64JnmcMqJwG9It0E4zOrk0jdTn4bgBep7NJ+c981vMfV6YxqYrAHoj1XSeELGqgvmYzdFSyI/Eq6+Gg+9WWITIWqgcptfgypygNxUvXjCfUkASDTpGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBs4oQol; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so15023296d6.1;
        Sun, 29 Jun 2025 14:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751234045; x=1751838845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSoc6um4fj9fbTNru0L559gFTCmIRL8yZh5n8pLuklM=;
        b=kBs4oQolLkmz/RK4K18KQTaatSBu/HPKfg0sgLtCYXo3zqj+iW707b2EgOtGljWb+H
         Dr6AzwjpjCiku1LKi+9EuCNYdDYIWl8pXoBpE50gQ/7cC+5NnREnSpMjKIwoX9hVkt6N
         61ugffUNKXADigr61yokoUBjnEUGsn2zsIu5NQ7sacs0JLPKF9UzJKB5MnfeJVcCI35u
         CxXrmN7E/UU1KHp+V24hytKdEGt9FPZnHuzygJIsz+nJ5dvX6hNfzg02jHOBvp72Q5ZG
         T4rBqcklpa8xMlYpfjxrvvqwCDLPlCa4vTsO3ZYuFmU3dbLUCJNrFxKCJB1fVOKVddM1
         o7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751234045; x=1751838845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSoc6um4fj9fbTNru0L559gFTCmIRL8yZh5n8pLuklM=;
        b=fOIMSovlPHpfv1f2tx4xAUePsPA9gkuA+mcl+FXlNLKUuZp7RGkZ+T2URpt10jjpso
         CW3EsLZL24hVSLvuVgUNUxircvADbBoiXU0SGrKk2nYUgzIm9xpUaeaYSJzuNjTzVwEO
         OMZh83ey3MIm8PsoL4eNOS6zH7p7XZo7h2EqbSATzkGvtaPwAipUF6LFTWcFQvqCEG+/
         elT/lXSjHBc367e3LYRIs9FC4DOgyy6o1TDi41dspAQC0nX81tV2MfBXj2Zmyl4PO/iH
         ifqYJnEb8fO2lX2FZv3liJE67dZkP8GcJsJHQgI1a8dC3gmoTGfPuS0NW8V6LaGk3/0Z
         Jh4w==
X-Forwarded-Encrypted: i=1; AJvYcCVaPHHmfDoCxlI5Yxyl9jjq2IxLxbgEk1KRyTYFdvgfeyMra5TDdITbr8wZcX+a4PpQiTgMfuZ3@vger.kernel.org, AJvYcCWFM+7StfYkajjqRPSCGo2xwKU4GGRn0joAC61q+YI3HffkdOxJ98ctOPtE2Rkx3bkJbNnHem5gPKDLFGM=@vger.kernel.org, AJvYcCWlyGlnLKGam1w7ZT6uyhwaEGpYrRftUQORV7tPbVqEQLl+aAdkgR587MvOu8UW+ggNiydVm3SxkKT5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+MluhWSR6xQQalga8BfuAH2CuHWsRITsUeJuvQPWr+P0ygwc
	BxSFwZjtVy3++paCjGBbu68isx6Pd5TUmKk/YUKy2A1XYd0DcNgRuVKt
X-Gm-Gg: ASbGncsWg35gRyMbAKWDAWWaCrTTVM0ccwY4V2SI5iGXlisfzfH1PVT/avYBNCyzB11
	FDpo1J0Zx5WDfMAcujgWLDwagf09kZHBUmt8fvkowpcmEiq7fO8mFuMkP7eFY9eu08SxlRMU5RQ
	+VOqZpu9JWhcwTXkakyOZLTCXEgrGLEAZOkUFOkNU2k4OzTrxbuxUJxLAu3zwxLtvbYJjbO/7KW
	dfQkOSMzYHm7fqy6TbwrQk4tGcOvS4vM2hMwboQudBvzpkwpyTjM3j9nT6WXhjXOWEmwdTYKCmB
	9P51St/GoNRcAvySbFQ2F9fZidV+U2uqnwsovUkEzgyXxsbyHcEpjKNbpNG2l6ImjbcVTnu+rZf
	6Jw792VPFlT06NP/CS7AF1Tpss9peSVhmKB5quVJbt/BQSOaUwUuhm7NhWbb48zEtfARq
X-Google-Smtp-Source: AGHT+IFJpNw6tlpwh806rj7OtEbWSnaeJ82dyANG/riA46oRJRHygpgtGapJTqqgsj6/APi15VmJKQ==
X-Received: by 2002:a05:6214:540a:b0:6fd:5f35:9c84 with SMTP id 6a1803df08f44-7000174dc41mr206413746d6.9.1751234045446;
        Sun, 29 Jun 2025 14:54:05 -0700 (PDT)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771b50e1sm56878656d6.34.2025.06.29.14.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:54:05 -0700 (PDT)
From: Seungjin Bae <eeodqql09@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: pip-izony <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Felipe Balbi <balbi@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] usb: gadget: max3420_udc: Fix out-of-bounds endpoint index access
Date: Sun, 29 Jun 2025 17:49:47 -0400
Message-ID: <20250629214943.27893-6-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250629201324.30726-4-eeodqql09@gmail.com>
References: <20250629201324.30726-4-eeodqql09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to max3420_set_clear_feature() function, the max3420_getstatus() function also fails to validate the endpoint index
from wIndex before using it to access the udc->ep array.

The udc->ep array is initialized to handle 4 endpoints, but the index derived from the `wIndex & USB_ENDPOINT_NUMBER_MASK`
can be up to 15. This can lead to an out-of-bounds access, causing memory corruption or a potential kernel crash.
This bug was found by code inspection and has not been tested on hardware.

Fixes: 48ba02b2e2b1a ("usb: gadget: add udc driver for max3420")
Cc: stable@vger.kernel.org
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 v1 -> v2: Added a second patch to fix an out-of-bounds bug in the max3420_getstatus() function.
 
 drivers/usb/gadget/udc/max3420_udc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index e4ecc7f7f3be..ff6c7f9d71d8 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -536,6 +536,7 @@ static void max3420_getstatus(struct max3420_udc *udc)
 {
 	struct max3420_ep *ep;
 	u16 status = 0;
+	int id;
 
 	switch (udc->setup.bRequestType & USB_RECIP_MASK) {
 	case USB_RECIP_DEVICE:
@@ -548,7 +549,10 @@ static void max3420_getstatus(struct max3420_udc *udc)
 			goto stall;
 		break;
 	case USB_RECIP_ENDPOINT:
-		ep = &udc->ep[udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK];
+		id = udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
+		if (id >= MAX3420_MAX_EPS)
+			goto stall;
+		ep = &udc->ep[id];
 		if (udc->setup.wIndex & USB_DIR_IN) {
 			if (!ep->ep_usb.caps.dir_in)
 				goto stall;
-- 
2.43.0


