Return-Path: <stable+bounces-25451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1963F86BC18
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 00:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE858B24E82
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 23:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD6872901;
	Wed, 28 Feb 2024 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbKFe5Zz"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B1713D31E
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162489; cv=none; b=VbgNBrFLuVDL1G8hAxxm/zvzk0rxfQvfCUPyYQ7FmmLqW2Z49tFBPGW4Q7hWzb2rw4JuBGh9Wryy0t02uGG1W3v6YMdzpuEiGQW4zbigWo8LUXuuRDw910WzrQl/rgz3FpKPrTgWzcJcOqF4ed+9mqo+PG1hRUkHXFLSCG+4DtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162489; c=relaxed/simple;
	bh=7tJEoT7UeieYnDrUIelxhTjT/DTW8yYe3f7+9yRHQ0g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=B20T59yk7KiGDF8sC+jIIvKFLx6tSxZ1gRuVVgXocSUR5Gx8yFXBdfCIm4fBKRTuw6gTXOSceLUNNm8xVxSkphy6GZDYB8+ouMRrDepHrhnWQFP3HYdmSH97zIcp6X3JV+Mjvf+lzpSciNBb9X7k+pVE/OPu8lp4eRWcshsrdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TbKFe5Zz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60810219282so4674457b3.0
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 15:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709162487; x=1709767287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E3VOyu5h5VNnqIC5C1wAkPY2R8kjBMsntg/JOJOAxJU=;
        b=TbKFe5ZzuvbIQBSmu8WfhzGno/ATX/w/sPE4xH39dKwN9JRJg5wYCkNAI46qDP013H
         tjd4rlPzbspnfaIqImPDH7JP/b6fTqDy19AxsEg9zoP7PLpIizW71kTLE+dhk62U0F/A
         DiEQjTImWs/j2GfzpMrsKKvNzBBZE95myM8BvRAcDWlBYN9ah2ag5ddtQST3WBkNeysW
         tey985fSKlMSB1mbEz+L1XSJEDK9hnkgpaWFGORxexuFNzUw1GybGnHoIth78Q+NaokH
         MSYLtbtYd70QgppYWUouTyZVGw8ZWH1+Wx2+sf2IgykhE4OUovzpcO0o2hQNaBkXAytr
         zi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162487; x=1709767287;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3VOyu5h5VNnqIC5C1wAkPY2R8kjBMsntg/JOJOAxJU=;
        b=gjjO1DWxQq1Mx6WG7JrydZpOLqu+mYltP9niZsnQhZ25WJtR8wfit4Tn5JRSuzQAVy
         hNi0T8+l2CJT0a/JbQiCAs8BJ44aBTmV8sN3CcOgg/alRjHdf7NTO3p+tGzbpy/uHC0E
         uIURPi9cR8kGSBO5c0HJtG8tTn7by+zgqbCfm2yu/3fBuyEYgjD2ziFmfbhkcKEdCWc9
         lpmwAXYz1RsZ+ZJAv0Pcsfm9E5EoM25gDCjtcLTbDsSkO10H466Wx0XBYL84LzRgle4C
         VJqb6c268/oG3BptLPQ1tNbHKkzB/6YDPRwzDJEzF4Y68c/E/dumedqAF4yH7prTE6ln
         r90g==
X-Forwarded-Encrypted: i=1; AJvYcCVSL/TYVf+Zzt9wvvwC1f7pMLHzRZEHLFH9ctkx25IZejNDyupWypyYRv1CCY2tUkq7qGdWJCM331urjOOILLu2XCO9n35d
X-Gm-Message-State: AOJu0Yy3acflARvAil77ud3zPllUt/SlBnIp4pjORdaUMuS3fI8kyvIa
	xbR+7lEhw/5rmSesJ3TP4nTSwCObLb4LxGCA2liwqu1QswJaa1TDmgrYnPZh9/jjCFYRY3OHow5
	Yug==
X-Google-Smtp-Source: AGHT+IEjIkixgTa8DId0CyvT1s+vLXoCDX+hWBxpSWRQuUpZ98olYdyqzr4CrCW0CfuHkrk8xv51EhpjUis=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:10c2:b0:dc6:e823:9edb with SMTP id
 w2-20020a05690210c200b00dc6e8239edbmr41694ybu.12.1709162487685; Wed, 28 Feb
 2024 15:21:27 -0800 (PST)
Date: Wed, 28 Feb 2024 23:20:34 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228232034.3630838-1-jthies@google.com>
Subject: [PATCH v3 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Clean up UCSI_CABLE_PROP macros by fixing a bitmask shifting error for
plug type and updating the modal support macro for consistent naming.

Fixes: 3cf657f07918 ("usb: typec: ucsi: Remove all bit-fields")
Cc: stable@vger.kernel.org
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jameson Thies <jthies@google.com>
---
Changes in v3:
- Fixed CC stable.

Changes in v2:
- Tested on usb-testing branch merged with chromeOS 6.8-rc2 kernel.

 drivers/usb/typec/ucsi/ucsi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 7e35ffbe0a6f2..469a2baf472e4 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -259,12 +259,12 @@ struct ucsi_cable_property {
 #define UCSI_CABLE_PROP_FLAG_VBUS_IN_CABLE	BIT(0)
 #define UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE	BIT(1)
 #define UCSI_CABLE_PROP_FLAG_DIRECTIONALITY	BIT(2)
-#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	((_f_) & GENMASK(3, 0))
+#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	(((_f_) & GENMASK(4, 3)) >> 3)
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_A	0
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_B	1
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_C	2
 #define   UCSI_CABLE_PROPERTY_PLUG_OTHER	3
-#define UCSI_CABLE_PROP_MODE_SUPPORT		BIT(5)
+#define UCSI_CABLE_PROP_FLAG_MODE_SUPPORT	BIT(5)
 	u8 latency;
 } __packed;
 
-- 
2.44.0.rc1.240.g4c46232300-goog


