Return-Path: <stable+bounces-136707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6743DA9CB2D
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 16:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5682B7B6F86
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 14:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC439253941;
	Fri, 25 Apr 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+4Wlk6c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B571747;
	Fri, 25 Apr 2025 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590266; cv=none; b=qnaXEzsY/hdzdYpGeZ7kojRqYP9Y8VsWKTycgtuWIV3F2U6dlyA1eqkMLz+iPRHaUTqzzUNYK+5K2vm/CNQG5z27XM7w24BjSTdL0VQqGhx6beXfzdh024Al0v3TZQoYqNGKek8b8VAV80HRavl2BpPkF66wlRA74OCzPKXUkZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590266; c=relaxed/simple;
	bh=D/fhKblNOpPNIWKJTvWP9sKhNkDTvsdfku2TDqTRhLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Mz1BT2TcU2Tl32vUI2/McfIR7zrF+8znKsiWjBvvN7lTd7K7fQgMsMZWSuLAZxRZhqit/YPBVUAzEVUU98/UzRkwUhFvZrVzAc/3VcW9VEd8ic319CsEy6dpprcNUJbi7PNidv4lsMC0HIl7k1odMdFxEpVgenzy7FESilHoVQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+4Wlk6c; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b0b2d1f2845so1630200a12.3;
        Fri, 25 Apr 2025 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745590262; x=1746195062; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcFGunDGFlBnoHlVsGllCJdfq+5mLDS70Q12Us2qJLo=;
        b=b+4Wlk6cFFQLdLVTvNdDE7xMqQadB5Vx+qjraT13Qmo0KScjy29oeKgGqYnfmHsEZ4
         Oa7og+EqDTlo+ugu0zIOsz59AJzazVnujDNpkAgt2xSBi+J0MQobWBxBOQ152BGaNK8H
         +RhAkWmz7awPEKklGXCcwKvNrkZdVL+SWIDZkgt6EmOspDw7XWmTBgOXwX6tN33Kfm+h
         MQIw0jHFpLiYhZLiAAkkBYwOkYx1II5kRfHz6yZqSG9Vq+736Tj1FnSQOfAwxCX0tNMO
         9K7jGboHkkpO/lK0rzhY89KlEfaK+4vaSv5n5o6Sy8t8XMRvNfQVWhUeHjp8JI1QD9PS
         o31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745590262; x=1746195062;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcFGunDGFlBnoHlVsGllCJdfq+5mLDS70Q12Us2qJLo=;
        b=DE7jNdoLBGi83sXh58bP3tRAdzezTJnVOgvnOOJje7YW/wsAsriK+lWZqT4/gI1aZw
         UxyWEL1veagcivQxxoFTuG9exL6pUbsJewXU23G7MJ5efQK/rAXUvi5cKIfmXWxw6Vjs
         oS1SGaljgbptglm43Q71eqJfx5Rw5PSzx/aFZR1GCJ7g6jswJeuUJVEAIYEhLs1lkdCt
         379/+g3Zrmb4woe58r1XhADH4LHw27Ya6zj60PIuLqdwO8PofdvgbTZVSQeYqDTNGihf
         GXaNoPxDPMouVn5QjzzI9r0tvQY+WerZR8ViHEJb4HeKlD3ANgvrXuZqMZWQgfnvOwOr
         OLIA==
X-Forwarded-Encrypted: i=1; AJvYcCUsU+HsD7ipu02cLghVf1YosWuP6GeZm4g7AR0uWdX+R9difHZzJQv9PHFB12g5PhRIvDqfkVsX@vger.kernel.org, AJvYcCVY20TezbGNOzhnr3tyLDwVQ+kfZ+DoABkC+zYMtDdI6uAXDfrleWzOlMACppa6C2/8zfPuiKNZH7mHM7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU43TYCwNqs5KOnDAPU8GPHbhkLn8zu1a0e5ymosO2cZMlmSwN
	YMEurKzAtqQzGGoCkPL0y+96MH36GkaRLsnWEnvqcRmKkMf23wiBwEfEYn0/wls=
X-Gm-Gg: ASbGnctXpAPnbZcXYON7zXZ+vj6VlB9UTAj4xQMBnh4YIlvLarTqMaf92fTyfbH0W+W
	QpW/QhGOB50f4bs3OUIZWhlol23w3T8tSKfVlfsBmBGw8hzjCwme6tdH47LuSubOEzzPRff6r9O
	MU9bhTSQmRPsLlFOcfu1HcmXrEGpWmPuaAyVtHCCXdhD8UQ/19E639h83o70ZyrHdbmZjUqq7Ea
	IACjyqVrXvou0AawiPQGGqos3LEJsnlu3K++oXCmBjUrY/hKoKJBh34BcdeqlFcCJ3ndd3bVxBZ
	nW/bMLCkiEx3D/oHVet3fG9UEOh0de8tNjzSBdnxf3b5UJecjcdN
X-Google-Smtp-Source: AGHT+IEySxlPoPMDlFK9RIIxEb+5JKl+/kuCEAuk78G+bHa0i52eqx6+rjh8qLR5d7YVJIV18DYOag==
X-Received: by 2002:a17:90a:bb8f:b0:305:5f32:d9f0 with SMTP id 98e67ed59e1d1-309f8db391amr2573185a91.19.1745590262515;
        Fri, 25 Apr 2025 07:11:02 -0700 (PDT)
Received: from NB-GIGA003.letovo.school ([5.194.95.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb1asm3494350a91.7.2025.04.25.07.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 07:11:02 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 25 Apr 2025 18:11:11 +0400
Subject: [PATCH] usb: uhci-platform: Make the clock really optional
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-uhci-clock-optional-v1-1-a1d462592f29@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP6XC2gC/x2MQQqAIBAAvxJ7bsEkC/tKdBDdckkytCKI/p50H
 JiZBzIlpgxD9UCiizPHrUBTV2C92RZCdoVBCqlEKxWe3jLaEO2KcT+KbQJqo53QqhPU9FDKPdH
 M938dp/f9AM7fsUllAAAA
X-Change-ID: 20250425-uhci-clock-optional-9a9d09560e17
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745590280; l=1431;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=D/fhKblNOpPNIWKJTvWP9sKhNkDTvsdfku2TDqTRhLM=;
 b=pOSFN8QvFDDI0Udc46ceGEG6LC+FxW7I/XRS8DDi9pfRjmFsWh7McOM2IAyGHwyMXl4s5TsJI
 jGBEotWD+xEAaXMFoNbKm+ql4GkByofhffdASaoxqXblmD8iiDxOkEk
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

Device tree bindings state that the clock is optional for UHCI platform
controllers, and some existing device trees don't provide those - such
as those for VIA/WonderMedia devices.

The driver however fails to probe now if no clock is provided, because
devm_clk_get returns an error pointer in such case.

Switch to devm_clk_get_optional instead, so that it could probe again
on those platforms where no clocks are given.

Cc: stable@vger.kernel.org
Fixes: 26c502701c52 ("usb: uhci: Add clk support to uhci-platform")
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/usb/host/uhci-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index a7c934404ebc7ed74f64265fafa7830809979ba5..62318291f5664c9ec94f24535c71d962e28354f3 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -121,7 +121,7 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
 	}
 
 	/* Get and enable clock if any specified */
-	uhci->clk = devm_clk_get(&pdev->dev, NULL);
+	uhci->clk = devm_clk_get_optional(&pdev->dev, NULL);
 	if (IS_ERR(uhci->clk)) {
 		ret = PTR_ERR(uhci->clk);
 		goto err_rmr;

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250425-uhci-clock-optional-9a9d09560e17

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


