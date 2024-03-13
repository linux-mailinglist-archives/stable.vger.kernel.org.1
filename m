Return-Path: <stable+bounces-27561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CB287A208
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 04:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A664E1C21B09
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 03:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CABD52B;
	Wed, 13 Mar 2024 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N//dqGSF"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE810A25
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 03:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710302067; cv=none; b=NyZ8mGB5InasvtzkaAwCAZleMIFwc54OEdqXMtKvdGXcm2wEW3XL7JlN1f2aZ79l4+yJC9HPLHWKGI2xh0PyClGuIbVCFvuIFIE0Kw3AdQheE5yqno01konkgJMKNWCtWx8dUl48/3oGGKTa7mh0eX5bC5EyUG26xvfUeMWPT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710302067; c=relaxed/simple;
	bh=b4TOdcAfpKP7c8TtSew/74QZD84OuH+/13I9UVvWj6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P96igeTKvw0w34avIOHujG/RGXY8x+FCQMeQcq/uqD2bGWsduw+pjP27OLJzl4EQou8GkQs5FglpEXFyF9Z6TVAmjMXeRnqtJqSsSUCXTxRc2H0sB1y5HQD+675qvnqRRs9MUfenwwBsk5I3OtIZAds06stO+MvoqP2srhw8rIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N//dqGSF; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d2509c66daso73702821fa.3
        for <stable@vger.kernel.org>; Tue, 12 Mar 2024 20:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710302063; x=1710906863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFntvUmfQrQoD9JhHP4a9IiBrKarY81qZUG6+LdJaJU=;
        b=N//dqGSFTGZvAunpZjEUrPCDR0QAy+0xIvChTBMKfVysAt17fMBVWca1U/DE6hmJFo
         AZE7RnQOrdAiy1nfH43OuJBJ3loRlKATQS+f3JoY9Ct07oJQ6ACDV54vwx2Ql66uoNHM
         27t3+kD7wxgrwF4lL8emztXUM+CY8mnXeHuA3sWunwWVeNp5nR998/WaXMN7IHjPWd/b
         ACbQOG2tQVVLeBabOfoDjpLyb2du6+7d//2Ltzpw+/5ZPJcQZX3I+DaBfbBZBWm8i9mG
         iCsGjea1ADQWIO7ehcjkQ06irnS7aw3iQcw1mWKVKbinon62i2gXiyQNrhM7wJVoGfFd
         Ujrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710302063; x=1710906863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFntvUmfQrQoD9JhHP4a9IiBrKarY81qZUG6+LdJaJU=;
        b=SNmT3G62x1wA/VbA2uBN8tKN0UjKP1CK/+LE9l3SFivzx7JA1w5N12D2LWkUmDrDuA
         7oUw6cl6yH/qAd3BeTph/gwwg6TSCX/KBGnvVcjF+xHY0Z/nItfF7Ms4ICwtalyL+I9t
         8VLJ49uil4ZDp/oVujiTXE8pYgV4GfE3xEolM+wWxXKFj4NbyoEQuUoLacwnlWdM1bXb
         Vuqu0lm2yNnk/PUTH9gIVaA3ohO8WBLTXnnm8rPYVHGVNeJPqUdzN2VNgiZvmWv9rDBz
         zxKz6vQ+7sq5pOa0qw2ruYDmIHdEYEP9ddMKd55mv8y1W0RSK8sJaZo4b9zwithXFVf8
         dMJA==
X-Forwarded-Encrypted: i=1; AJvYcCV/7hORboMnRT53JABHdw8RRlwAuhyV7IiCeXLIRAg/Khm972NJ3OlrIluD3i6IiEdD4Jg7y3i0HXzbu398vvDYfUyelnCZ
X-Gm-Message-State: AOJu0YxuO8lYupuCn2huHn0LE19UGE40VkbdKFav82K3e2pkOrqtZY8G
	A4TTtAmILPSbx22pAtlDZggDxNb8sGeZfnUm/k5XHtw3XTubWc6tm2jvjCg9FBA=
X-Google-Smtp-Source: AGHT+IF7ZptzPxSTf58/lAJjw4Oo4QhbXQNkZBdrDCZziYkkXuk84yKwMDenXbJyp736hIssvaOTAQ==
X-Received: by 2002:a2e:8e3c:0:b0:2d3:fca:dae8 with SMTP id r28-20020a2e8e3c000000b002d30fcadae8mr1200502ljk.16.1710302063642;
        Tue, 12 Mar 2024 20:54:23 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id f25-20020a05651c02d900b002d0acb57c89sm1854319ljo.64.2024.03.12.20.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 20:54:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 13 Mar 2024 05:54:12 +0200
Subject: [PATCH 2/7] usb: typec: ucsi: acknowledge the
 UCSI_CCI_NOT_SUPPORTED
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240313-qcom-ucsi-fixes-v1-2-74d90cb48a00@linaro.org>
References: <20240313-qcom-ucsi-fixes-v1-0-74d90cb48a00@linaro.org>
In-Reply-To: <20240313-qcom-ucsi-fixes-v1-0-74d90cb48a00@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>, Bjorn Andersson <andersson@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, linux-usb@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=b4TOdcAfpKP7c8TtSew/74QZD84OuH+/13I9UVvWj6I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBl8SNqeJcoJB/Iq7ScN3gQPd6nqFh0TtyF56Qo1
 NIzkt2f3CaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZfEjagAKCRCLPIo+Aiko
 1a3NCACwe1UaBtfp8zYIFp97vnTMJ/Rftih1EHQpFoHrXfy+q8GjM7W55FJWQ0tAJYAHneww/11
 rW0r6zoOWO0hGH6L9wScIb2k5fsy8RgV7e5FOj/Yu8QMY/f0FYoQl15l8AUfhF8BWYhgWll8tf/
 ipldJqj9i7EgaY0Qr2FdwICG5H2Y2LePyZRb5HljYaW4ABjjn6ojloi0+4f9nExQG7K9bdOkYMb
 q3EwJ6XFQlbJCSnMjN2nAp+f5lYuWmFria6qyf/FXgkYqO0NJSZ+cETuzQ9B4MG7uYbNwehvcII
 vndULkoE+/G27inrpaRG3Q2Nyyn9uNwE75AcIJ4co7trqJew
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

When the PPM reports UCSI_CCI_NOT_SUPPORTED for the command, the flag
remains set and no further commands are allowed to be processed until
OPM acknowledges failed command completion using ACK_CC_CI. Add missing
call to ucsi_acknowledge_command().

Fixes: bdc62f2bae8f ("usb: typec: ucsi: Simplified registration and I/O API")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 4abb752c6806..bde4f03b9aa2 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -167,8 +167,10 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	if (!(cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;
 
-	if (cci & UCSI_CCI_NOT_SUPPORTED)
-		return -EOPNOTSUPP;
+	if (cci & UCSI_CCI_NOT_SUPPORTED) {
+		ret = ucsi_acknowledge_command(ucsi);
+		return ret ? ret : -EOPNOTSUPP;
+	}
 
 	if (cci & UCSI_CCI_ERROR) {
 		if (cmd == UCSI_GET_ERROR_STATUS)

-- 
2.39.2


