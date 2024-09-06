Return-Path: <stable+bounces-73690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 924B396E709
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 02:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6C3286F53
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 00:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22951B5AA;
	Fri,  6 Sep 2024 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1jR/33C"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D1B1BC20
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584289; cv=none; b=czPa61mfqt7j9dytAQwS5HYtVRLUrDfJUL8QtvQZRZvfDa01/7sH+AXSV7YPZ19bDY6dbtNf3FmsWDV9H9jdVuOgHFH1xWhUkvUE98f3O2g1zk3Yrn06Db+GSqCk08HlBS9y020XvKVjZH+3ZGK1Wpafyw+u9AR83ubAUsfLE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584289; c=relaxed/simple;
	bh=dY+RGFX+cNu9X2vO0IcaDdSj9wfnP28ZjHbh6T05zQU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hMPQPqw98zhx26oXbtdAIr6youZmtQoSIh2tS/hRsUNuQbr3oFEFDb5aj8vnJ2fsr9zyKcLMHJPE/1T6/BUOiXZ68PwpjVBvuOGEopEWxYQrbcSGoXUw26vRy/6tijtGwQRAHQbORBOOTMFfudBt4lj5Q5YjoAba+jGBWQmMHPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E1jR/33C; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-69a0536b23aso51804147b3.3
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 17:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725584285; x=1726189085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZUr9RBTogku73PpkKtYXYUmUx+8qMZI1152dmkaX1tc=;
        b=E1jR/33CRoNd/D1dUy3lucYZ8nmj9hWbH8nXQms2qGhZO2xkjxfDvP6FD4FDOCSuik
         1eWkTmsIWSV2fCz9/F76F6hLO9g2+IM4xINR99NTBEYuK9mM0deOBXrVwPklVB5qikYO
         gyCq+v+D1LxE3hQ9E0jsj70GkHOzz3Rg4UZyRe+23uLuaw3tWKwQLglQmFwRW4+zbICs
         BE2wG31AKHASjX+1VDncNl2KcbfUVWzJKFppxzspqHirZjBTbYM4ANPfelACOaZFE8sB
         4Eyv1M2k8jhDOYlFscqm4QgWtBGycjh3fugGYQDrnW04Z2FhnxNvZlVuFmE+1R7a5k9h
         nVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725584285; x=1726189085;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUr9RBTogku73PpkKtYXYUmUx+8qMZI1152dmkaX1tc=;
        b=Gb7aXn+RJbN4dYybZt2nDxCOmqwXE6iatA5Rp/Fd+ht4VlCvItOJsa5VqSY2aXfXLF
         2leor2rHygDiKsbDqvy4QWHat61g3SvjHoQK8qGVh1X9Tk4RW2mOh01j+r+CDvUQQnq2
         dGtq5EymE0G7/O+ndQq95+m8nqKqxCeGgrKHiybPj3ojq11rzDWocMaTTrAszXubUUyU
         wBMnCG5ymP145S2GvAaPba0jtpvLBGuPkxlrp8v1YrzHJygLwBYhukr8LjQ20biKdlFu
         qrTJlxsrBgPNoYPrfCBJXGu9MnCTZJ5z072dHIWg39Ry2XMdhJCXwq/QFCpqYe777wB9
         O3iA==
X-Gm-Message-State: AOJu0YyHjNEiiEjWSshW4VWb2SD45u0/sbF7V0ERt82AIsTTE+faCXTC
	ka+u9UyvNgvEY+Z470jsvPy/SVpYl0fCQCfowPPRX56eHCxM+RkTqTQi9DMR/ozFzCizfsC2y4A
	Oig==
X-Google-Smtp-Source: AGHT+IFVaGdYnqoxmzpMhrlWdS8//ypdRlOXtb1ajgUGqzHC+RrjmGKaMalfJQrOLZyrYX6KIzs5g5zguF4=
X-Received: from royluo-cloudtop0.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:bb8])
 (user=royluo job=sendgmr) by 2002:a25:aa90:0:b0:e16:57bc:ac26 with SMTP id
 3f1490d57ef6-e1d3489de68mr2283276.5.1725584285560; Thu, 05 Sep 2024 17:58:05
 -0700 (PDT)
Date: Fri,  6 Sep 2024 00:58:03 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906005803.1824339-1-royluo@google.com>
Subject: [PATCH v1] usb: dwc3: re-enable runtime PM after failed resume
From: Roy Luo <royluo@google.com>
To: royluo@google.com, Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	badhri@google.com, frank.wang@rock-chips.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When dwc3_resume_common() returns an error, runtime pm is left in
disabled state in dwc3_resume(). The next dwc3_suspend_common()
should be skipped as the device is already in suspended state but
it's not because power.disable_depth is non-zero.
Ensures runtime PM is always re-enabled even after failed resume
attempts.

Fixes: 68c26fe58182 ("usb: dwc3: set pm runtime active before resume common")
Cc: stable@vger.kernel.org
Signed-off-by: Roy Luo <royluo@google.com>
---
 drivers/usb/dwc3/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ccc3895dbd7f..1928b074b2df 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2537,7 +2537,7 @@ static int dwc3_suspend(struct device *dev)
 static int dwc3_resume(struct device *dev)
 {
 	struct dwc3	*dwc = dev_get_drvdata(dev);
-	int		ret;
+	int		ret = 0;
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -2547,12 +2547,11 @@ static int dwc3_resume(struct device *dev)
 	ret = dwc3_resume_common(dwc, PMSG_RESUME);
 	if (ret) {
 		pm_runtime_set_suspended(dev);
-		return ret;
 	}
 
 	pm_runtime_enable(dev);
 
-	return 0;
+	return ret;
 }
 
 static void dwc3_complete(struct device *dev)

base-commit: ad618736883b8970f66af799e34007475fe33a68
-- 
2.46.0.469.g59c65b2a67-goog


