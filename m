Return-Path: <stable+bounces-76664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F3297BCB2
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 15:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2E3284EFE
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 13:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6089189F3C;
	Wed, 18 Sep 2024 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvQ5Colc"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066817E019
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664568; cv=none; b=Aw3miE1UcNPhyfkQMIUanC+uXz0GugP97r2PGWW+7GvugL9AaXdardoBW2HVS+4CYff0W3tRv1I2PN3YSqCllhlTDNrRY9/GjVwCd5KUQTyZR1sM0c3WWLt9ZHmuZ2rpvcNDGNZuHdkUTeKsxvpZGnq2CM9u+mJPTS9CerRRN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664568; c=relaxed/simple;
	bh=fkxNactTtfPV+pF7AYrystjYaIivYRerWOIrN2LwuIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aSZ14hT6m0LgpKbI1wudafyHhkZddSc4GfAcarCZbftRJ0MwiXS6mD+apaKJYjHWr8iLR6OD+N6QzL8cMgYXzBIl8pSktwPJv+X3JcYPGUdfgPb79NCDhF+OIz3sIGz4ETBZ/0LsL2J9Nbkta6OJk/sgaqoHTbXtNowYCx74Pzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dvQ5Colc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f752d9ab62so55334341fa.3
        for <stable@vger.kernel.org>; Wed, 18 Sep 2024 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726664565; x=1727269365; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ATW44ntMNC19RTiT79RitfHTSID/tcZoZ+wLlD8HpFA=;
        b=dvQ5ColcUAnUV6vMCVFgGiBBzfWzxR+5ryql1kscafWxhDmveFIShuyoiSv1Umqonh
         fxgQM317EUU9waXcPAix7Nt9UGCn7NJwGeqzCGdQHw9sUVdIbEjKBZPWr6yJd/JQ0m8i
         IpxMbPRtLnXEBASHxXvCRG9OxeGAITfcweSXWuTMXuMzcYEzo/m61ADacv0D9XC8HmlH
         /u2cXhUBtNnOCwrYCxVUx8ecXI2va1o961HSzI1TDKORYqdZfs5xppubNBicdXPp94yD
         ovJFrConANtyHAvVzunKnqyQGERhhTdv0W1Zi0pzW1iS5QiJKiz0TRpRhN3iqcG9oydg
         kF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726664565; x=1727269365;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATW44ntMNC19RTiT79RitfHTSID/tcZoZ+wLlD8HpFA=;
        b=DFk8gjJuGPKxvjFbWUsm1DnZlBjtSqcC3FmB3BXg4Ggjhg6yD6dIO0F9JxlRKk2M0/
         1AM4hwo3V/8Af5jvP6EhA9jJ8jv97i/NMo5tbOmBWhw3YD3UrDSKC8LHBTmtgUxc0pto
         k+bA/SHFPs1a1APSbmUMQaV52SKoyw3Gwk6/8l5NfrtKMRZUlE0Kc8FiTa0zlPMgeHil
         NMGKyY5lPLrbFViPeRoFd5RTr2J79lGWvMb604e6FlCBqS2MNtOIJSjJDvQkIGBjeWug
         8uWmwpYD6pFjtj/fCYDR/GRuoO0gpvZU3ltS3j9aZbnDZjUDtkjipYRjwyNLUyi9K0+w
         QfQg==
X-Forwarded-Encrypted: i=1; AJvYcCW/IQm/J60WBBIxIffjtzWPLlYEPN1oHeIv+gVLi9zscIVJcw65eJ31fbafR5LCW2sjJM6kr0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJyJzsTYbOmNxqbVhoXOxpgqmrihER0TzwyxLZDtIQDbwLnYY6
	4X7LmQ8k9H4i/wWVFMxg+n6KE5RrMfPdZTDFHZ7JCbG3C6INHW+cM8Rwc/qdM7A=
X-Google-Smtp-Source: AGHT+IENvkLCRJ6PgUKbcBNDttzRMjlvQEm33+uhx9+i/+f7XgInowOISmKP2l/jOslrFqUCcHWCPw==
X-Received: by 2002:a05:651c:2208:b0:2f6:5921:f35b with SMTP id 38308e7fff4ca-2f791a0d2d0mr106357291fa.27.1726664564786;
        Wed, 18 Sep 2024 06:02:44 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d485c57sm13181811fa.109.2024.09.18.06.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 06:02:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 18 Sep 2024 16:02:39 +0300
Subject: [PATCH] soc: qcom: pd_mapper: fix ADSP PD maps
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-x1e-fix-pdm-pdr-v1-1-cefc79bb33d1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAG7P6mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0ML3QrDVN20zArdgpRcIC7STTJPNkmxNLdITEwzVgLqKihKBUqDTYy
 Ora0FALKNxF5hAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=fkxNactTtfPV+pF7AYrystjYaIivYRerWOIrN2LwuIQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm6s9yWIoJMvUmfey0hpRsOxNUQUFmdSXLFwiYM
 FTFD77VoAiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZurPcgAKCRCLPIo+Aiko
 1ZEHCACQgxEjTJtoCYuxeGuePeXLJn3K8bG5i7Np30n4hEb8LHST6j+h5b8Ult7yL3fI4XhXLMR
 9b7vYGNQxUd7x7zo5gEcDnRllKBezAgqcG3vQNTB6VSjtdwJ508ahxStFd8lnVxuEAffJCQK62J
 7y1pwFi7bvxFpZLtIcTpA08Aoj+1NWJJHdJKoExnhSvOJBYdyLRU+C+slK5rOjVwfcoB10lPLNM
 S9wnK2vUXhhBCWgK6PLpTs5ivEcXF8TEX5g/1HVI3FDDSWrqu7lJuANFYgY4VrOBR7VozwmNMJw
 vpDYyu+iI3yJiavKcxi3erCkLq33wwLg3B6Bu9lkhTPc7nwN
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On X1E8 devices root ADSP domain should have tms/pdr_enabled registered.
Change the PDM domain data that is used for X1E80100 ADSP.

Fixes: bd6db1f1486e ("soc: qcom: pd_mapper: Add X1E80100")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/qcom_pd_mapper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_pd_mapper.c b/drivers/soc/qcom/qcom_pd_mapper.c
index c940f4da28ed..9d33a8c71778 100644
--- a/drivers/soc/qcom/qcom_pd_mapper.c
+++ b/drivers/soc/qcom/qcom_pd_mapper.c
@@ -519,7 +519,7 @@ static const struct qcom_pdm_domain_data *sm8550_domains[] = {
 
 static const struct qcom_pdm_domain_data *x1e80100_domains[] = {
 	&adsp_audio_pd,
-	&adsp_root_pd,
+	&adsp_root_pd_pdr,
 	&adsp_charger_pd,
 	&adsp_sensor_pd,
 	&cdsp_root_pd,

---
base-commit: 32ffa5373540a8d1c06619f52d019c6cdc948bb4
change-id: 20240918-x1e-fix-pdm-pdr-b7c4d978aaf3

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


