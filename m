Return-Path: <stable+bounces-106785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC6AA0208F
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 09:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAEA1882E52
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 08:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC451D7E30;
	Mon,  6 Jan 2025 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghtj0Ebr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF6515886D
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151768; cv=none; b=CvS0kewsl7XP74esK9sBx5t3ejopHVxMtq0+MqqQwpwmc14wmCbuHLtYASuQnNmLbr+LnZSuoWrKFoNHLlWO3wDISuGniNqzADyvbiW01cjo7eORrIAmNuJddyQATShaxeR3anGk+9P8deEV7R1nsI5kOgYVbz4LPVi8FejejUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151768; c=relaxed/simple;
	bh=xgnzeomWE7uMqNRrmeQoXEkFyyw5GPqG4aj5suU4g20=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F6llUzoVwx/09eILdlrlgNnOIZZkE96tJW4SBt6TO5dh6vw7BAYW9Q2ju1wF/A0jj7iYr7ys1r3rbIyNWL6fY2ZkdYK1G71wX051Fc0kCRAmo0GcsGBLW/MnkplE4ol7BdGBOfWB3bUorEiQLMArTvksnt5tARynzs8RhxR2iSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--raychi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ghtj0Ebr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--raychi.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216750b679eso158533585ad.1
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 00:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736151766; x=1736756566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kLcY5dYvYA+U3xZ+KKGVQ0TL38zqS9Oi8od1Fn2VGlA=;
        b=ghtj0EbrOMPiYP9w/ePx4WaWqQ3Kea6XIIYwDxYGRVMrS1hkYFpO4d7ywmIuqOazw9
         edvqo9h88vaB1PBo2+qZfFiH2Z3Z9zPNv935gD6X1YwdOFWCm/YzWC9YMhZDSO1Yz/k6
         G9P1fTyyrWGwj8j92URXhCJ66fKxY1U2lZXi2cjdTvcm6uDSNaMca52A32oCDjJyFMN7
         N6E8HNSjGmPjEeNLA9SOvW6R/gHsUVgHpiiaMnpPqPi95ezePm1RAWfP2p09kdbQh9uu
         o+X4nIdRjLXOxvCrUmG6fmBoW0REqTI/cw22zUDbYMTB3eEvdJR3+BcxXTr1AFT8Xq/I
         H7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736151766; x=1736756566;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLcY5dYvYA+U3xZ+KKGVQ0TL38zqS9Oi8od1Fn2VGlA=;
        b=Im2AWNMO8vNoUCHkfdLJn/wAabVmwPAEHZ+PIc4DP3fNCcPMb44ktpEkIWnejUGN0c
         LyQx1udwjEScCBHZ1PZN8TVaDayCg4e4JMMTEv92XEsdn4XnrkFw7FCrGUgR/fVo4NUQ
         lGMYh+HUmfvvJzAF5ZpIpUWgs+VGtdR1q443j8GjP6Xm+bL6/kgRt85Uja1HGbbBTUiY
         c6U6hIeYlrxqnTo9L/Exj5i9BZ48zm2pgNk+dfoiW6hvW7Po3yPf5VduZ9p9IOh/MgfZ
         BH2t0q6/Ske9b7xkcr3W7cH2zLH2xnlzqVgwSkF82oZCStgwunMAKi9X0kJu2ayc/NMD
         VFmg==
X-Forwarded-Encrypted: i=1; AJvYcCXR19+X16KpYCjgrbTjTZG4nx8HDO6eihaNPiLHaVFaLE+XjytZuuHN9K4GE3rC09qXTyR2aC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmnIEOMu8jtg8t6sKePF4iap2XJqYSiG9McTKHmzT0mz3UDPJ4
	/aiJAw969XI4XX74Y+2d4PHnw4trSIhiNiD0yMo4LAre3GLAgbambgZkYpoewNkeVqK1UXl6P/Q
	BNA==
X-Google-Smtp-Source: AGHT+IFkODRVqzcq3JPVmBdGE7hRQbifWf7dOsu2AtQlu9+rJsceIy5DnsyKzJUIK3TEg6NjKQXEzEe/hLU=
X-Received: from pfhu9.prod.google.com ([2002:a62:ed09:0:b0:72a:c48a:eefd])
 (user=raychi job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3a41:b0:1e0:d8c1:cfe2
 with SMTP id adf61e73a8af0-1e5e08012e0mr94100948637.34.1736151766375; Mon, 06
 Jan 2025 00:22:46 -0800 (PST)
Date: Mon,  6 Jan 2025 16:22:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250106082240.3822059-1-raychi@google.com>
Subject: [PATCH] usb: dwc3: Skip resume if pm_runtime_set_active() fails
From: Ray Chi <raychi@google.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org
Cc: albertccwang@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pumahsu@google.com, Ray Chi <raychi@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When the system begins to enter suspend mode, dwc3_suspend() is called
by PM suspend. There is a problem that if someone interrupt the system
suspend process between dwc3_suspend() and pm_suspend() of its parent
device, PM suspend will be canceled and attempt to resume suspended
devices so that dwc3_resume() will be called. However, dwc3 and its
parent device (like the power domain or glue driver) may already be
suspended by runtime PM in fact. If this sutiation happened, the
pm_runtime_set_active() in dwc3_resume() will return an error since
parent device was suspended. This can lead to unexpected behavior if
DWC3 proceeds to execute dwc3_resume_common().

EX.
RPM suspend: ... -> dwc3_runtime_suspend()
                      -> rpm_suspend() of parent device
...
PM suspend: ... -> dwc3_suspend() -> pm_suspend of parent device
                                 ^ interrupt, so resume suspended device
          ...  <-  dwc3_resume()  <-/
                      ^ pm_runtime_set_active() returns error

To prevent the problem, this commit will skip dwc3_resume_common() and
return the error if pm_runtime_set_active() fails.

Fixes: 68c26fe58182 ("usb: dwc3: set pm runtime active before resume common")
Cc: stable@vger.kernel.org
Signed-off-by: Ray Chi <raychi@google.com>
---
 drivers/usb/dwc3/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c22b8678e02e..7578c5133568 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2609,12 +2609,15 @@ static int dwc3_resume(struct device *dev)
 	pinctrl_pm_select_default_state(dev);
 
 	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		goto out;
 
 	ret = dwc3_resume_common(dwc, PMSG_RESUME);
 	if (ret)
 		pm_runtime_set_suspended(dev);
 
+out:
 	pm_runtime_enable(dev);
 
 	return ret;
-- 
2.47.1.613.gc27f4b7a9f-goog


