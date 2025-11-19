Return-Path: <stable+bounces-195204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C2CC7125A
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 22:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 146AC4E1652
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 21:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F072A2FC029;
	Wed, 19 Nov 2025 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JbFnhdDA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B32F8BFF
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763587765; cv=none; b=PTu039G04DCls4hlmqyCqMTV+HqEex8j4mc6xGGfxc3kqRLjzOhvh1LPo2bIGN4eb4DZIo/L8gg54fXVlxIeOB2d4x8lZyTJxe0OOhsgZeVJ+5vMIlVbKOVhbWiFKd5CfB7mTkDpJ5azt7Rko96boxxk5AdG4MZaQ0lSH3x9KFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763587765; c=relaxed/simple;
	bh=qZlWcf6iSVdCWX0jqzcFQAhJv1kY7V5LUAOq/ARDBHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SiLRKEQyfHsO62oqA1mAtdJVMaKgA5rHyr0l2EIYBGkzqQVH53zo5Hmzu2cH2IVYNiEmWe44PP4BfrFnDTb6KpTbaj/DLRs5p7PX2QT03VgmVGST0wt9LleuSNgURuP3uqU8p8/xJ9H7ZNoyhlNRfRuia8zRYKNtUlMQhmYz9O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JbFnhdDA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so286719a12.0
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 13:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763587762; x=1764192562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wsPUaZW+lWt4EDGBIFcaMFiCWPFFRuP/pCkDPZ3cF10=;
        b=JbFnhdDArRpGmF3ijJRjqh8jv66s4pg88Jk1oFRyZHXk3gxQSosUP/mtYH57Xqksd0
         PLi+LsfY5nttt4kA2EMHNZtKhXoILjqzZjEfK4/n9z4tUgfJ7D8cUWvPloVEMcxQPN1L
         3TCUOC6JIuVetJ75wN657kg99+ixStE9NidJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763587762; x=1764192562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsPUaZW+lWt4EDGBIFcaMFiCWPFFRuP/pCkDPZ3cF10=;
        b=upArKtLKb+3WvfDMSZR9Aic/geb9pDmlGL+NkMyUNE/lttIMEgKbWlF6JmIsm71Pxr
         iLuL3JLM8QRyp9XQUeNdocFzl0pELko0Q9UmuXaUtcCDlgtZL8EjisaR5zCYHRPLAxLB
         STb2Qc5H7VaL/clr9MJMjpuYp+McsKEfPylq1DeLcZjbafibs11DssVk5nCGs8O9p/z9
         20U8iwD4FDaMnrp7j/+hjTcI2Izy6q60RHifFXVC43U42K0a/qYUbWwUpTvZWlGkhcsG
         nsXFzk+zeTa1Y5f4EF1RGCTP0LA67as7CwoewDpcYCucuiAC6rsJ1l2yLl6OIR7x2PRl
         rllA==
X-Forwarded-Encrypted: i=1; AJvYcCXzsEZE0LWUus+RG+Ivf7pivfSLq3rPrGj5SbwAiT63NJ7AOyXqPAt1P9j+mtTJU96mZJSsE2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMURt2KfdLmSF9E1s+cwXyjjojhVRuwfeJoGAj38712JgGPKiV
	u3q0fBUSB37/Z5UE1gAJ1HkaCcMbTt+Q3JKr6ZsXSL6HeaZF0MX/m7Z2M4CTKuM6JvE0Qgfz4XD
	oypuu
X-Gm-Gg: ASbGncuW/P0QPOVtEP2ZJOz73Mz6FmD6utc9b8sszEWSw9ZSlj55J6oi7Z03yjkq0gT
	e1zdsJoc2eS1JVAVYKjmZOGmLp4tSn5IKIguHi/pZF6hWTV56Ei2xJiVjYb71AiGNguLl/hG2yl
	cUB3obFfqgFBfua+od1dv8adZWKovBAfp6khqpvasVkTT+tSrGLtJ6UUS5Spec5DDstJT2H4WyI
	NObGSm92XKL33+2pg0RlFDjOyDUisBZntcOIp2DMC1Y2FY4n13uc3OByTPGfc7T8kucwytoK5sK
	LDR+0w06koJzqnYvYj+NEGcmsZnV6UIsMOH6JvS7onDvUrKgzeHtmSsFenBzATkGuurJARMbD2I
	ZReGCcwueuGjbyxgvP+g4YSq/elexqKw92iXGLY8Z9nLxQvqa+k2zrwHKPTTIboU5GlqV2VTORr
	CWYGw8/5Xbp/GoYQzyMiHiJvybbQyZEHoKU+Vj2kqt0Y1FcnlKZdYzuaEbWcwPJGw=
X-Google-Smtp-Source: AGHT+IHbYGDmo+BdHdOCRgxP7WIVUSQS17wnJF3168P0UlZ9kD5pE+va199gFRzl/hENjd56EOiCug==
X-Received: by 2002:a17:906:7949:b0:b73:99f7:8134 with SMTP id a640c23a62f3a-b7654fbe7ccmr51298766b.45.1763587762277;
        Wed, 19 Nov 2025 13:29:22 -0800 (PST)
Received: from januszek.c.googlers.com.com (5.214.32.34.bc.googleusercontent.com. [34.32.214.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d7cb3bsm38816966b.27.2025.11.19.13.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 13:29:21 -0800 (PST)
From: "=?UTF-8?q?=C5=81ukasz=20Bartosik?=" <ukaszb@chromium.org>
X-Google-Original-From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@google.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] xhci: dbgtty: fix device unregister
Date: Wed, 19 Nov 2025 21:29:09 +0000
Message-ID: <20251119212910.1245694-1-ukaszb@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Łukasz Bartosik <ukaszb@chromium.org>

When DbC is disconnected then xhci_dbc_tty_unregister_device()
is called. However if there is any user space process blocked
on write to DbC terminal device then it will never be signalled
and thus stay blocked indifinitely.

This fix adds a tty_vhangup() call in xhci_dbc_tty_unregister_device().
The tty_vhangup() wakes up any blocked writers and causes subsequent
write attempts to DbC terminal device to fail.

Cc: stable@vger.kernel.org
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
Changes in v2:
- Replaced tty_hangup() with tty_vhangup()

---
 drivers/usb/host/xhci-dbgtty.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index d894081d8d15..ad86f315c26d 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -535,6 +535,12 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 
 	if (!port->registered)
 		return;
+	/*
+	 * Hang up the TTY. This wakes up any blocked
+	 * writers and causes subsequent writes to fail.
+	 */
+	tty_vhangup(port->port.tty);
+
 	tty_unregister_device(dbc_tty_driver, port->minor);
 	xhci_dbc_tty_exit_port(port);
 	port->registered = false;
-- 
2.52.0.rc1.455.g30608eb744-goog


