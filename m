Return-Path: <stable+bounces-109495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D5BA16317
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 18:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3C73A6092
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 16:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3351DF988;
	Sun, 19 Jan 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKaV1550"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD891DF721
	for <stable@vger.kernel.org>; Sun, 19 Jan 2025 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737305992; cv=none; b=aox900LFTTxij+OeR8HBiESoMHluzMDs1S1zlb6WK+j5sdaMh6QOaaUoEiIdjRI+ZzxbXF0TafYX25fZDp3wUtrdHMlGh5u5tQfYm2deHe1thk61aUDYODFr99VQVbwmirhnMmma5XtoNf4DUbrkRXizb7eCBubIlSKyfXuOS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737305992; c=relaxed/simple;
	bh=moQ4Sx1R9uDF15Ros1s1+SmGuBjFhQZ7Ns8wG2ntmxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6OsygO/uhEr69ys90O7JktVV/4hKlUzzlv6p1zooqZN+9KDSK2PgDiIsYREq2uoe9L6h1nXZrZDnqkK6qwn31KPBQTaO59jxoS+S10cFsNJHNB6e2ZTwHaB+QyMRZmJYDY/8JSSKoFHGWFcgaaWVx+St/uO5HkzMkiAOJ7FWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NKaV1550; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-437a92d7b96so36516115e9.2
        for <stable@vger.kernel.org>; Sun, 19 Jan 2025 08:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737305989; x=1737910789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gU2K4r4ZzM/BRR+Tyo710S/yU02b9d5jbFwsNMfd6eQ=;
        b=NKaV1550pNQjUbFDK6asjoj7qqXbwZ3MOAucx0FuXEkIQHLix1SuyidZnP9cjtrque
         URgsqlqYkf/SXwhMB6xyf9d5eHop8jgyWcoy3+Fhk7Xur2023UBq1nfQOrKRkbVOdYN3
         3Hd5tkWS8rFwkdlF8ndBkURsYNlFqRtjWJfgHd0nCFLnjhT3gTLZ4Z4UWrKaZP7qJa/z
         98r6SruD/3BuHT76vhsgUzGEZR0k9zysLqM6TRWOC/w2CkcEAexcS1DLVZdFZaM0Jfhx
         KIzMIv7FK4tE/DcDd8VzuAc1Rhs+MJTFAOMZWFAnUmg5jo3nSXjh4UEKRdZLqDac09ly
         nNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737305989; x=1737910789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gU2K4r4ZzM/BRR+Tyo710S/yU02b9d5jbFwsNMfd6eQ=;
        b=jXYyxnKjyGHueQy3tR/GMHzuiiGgi2UvDhhSCq6rPJunwWjs7jnjaQu/BAme5jHqhH
         W9CWOHs032KP2+YdoYW5gU68GmA6zol4BQ26Nk4yqDAGtNJ+hJNSbW4fE79tIJmDEBsi
         AUIV4VyMU+lmc6cHglvtVG+93/UEL59OFvBfFou3BISDp7rs2wo9xApKTyqWnjHV2W2n
         ZNIreFFa0VkoVlXH8b4nk0KHH5I3AhfGKRn0euDUpOG//l1w2PhxHxd29R9zuK6HIaUF
         l1ALECV1CIiqsUECQe6RAN8rY9g9L5ioID2LSrcFvnxCxyXgSRUXzPdi80cYSvFrrjvM
         7s/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFwayti+vVhxeFBADe3DdpJOUrAEeT0ZPuqgFC+BGD83A9YKiMNnhgfikzqGA8K0t+6s2uLH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwutkFrQW/KXIfkO/AsQr48v/CSTx+wvNntuhg361Af162yar/S
	cmU9grO4xbv8gQiyuXgxgU7gUGzQCBDcQqE48vNXWLJ9PMkMuh78aePScA10Y1c=
X-Gm-Gg: ASbGnctpHi6XkEnN+/5MBukg7Vak0ig1RxVWDSXf6TKSZtURm0FovBpbi1hyTCBaXmD
	Czt7sHSjx8Wqoofk+lDysHCK0rTwlkIuwqp2tDBx/+4ukgR5dEW/19KKen/id2cnxPlW2zoEEx2
	CUWELF826LpN1eM+uZro0bwEBZzYmXD89jyPEPrShVYqFGQcxkDbgTMbdiNuAHbdcavWydp+dFp
	Vaouv+NG7isiPmXl6osg7mS44xf3+fMSusyG1JGzTKnKCsEW+m8ETrzRKdr6v+7GNki
X-Google-Smtp-Source: AGHT+IGecv9i+IP+93WZa2OpzfUcrFBdgsvIOe06ZTegWk6SGd3ckOy9AuooWsDdbYCE9mFC7/pmGQ==
X-Received: by 2002:a05:600c:4510:b0:434:a30b:5455 with SMTP id 5b1f17b1804b1-4389144f671mr88149435e9.27.1737305989481;
        Sun, 19 Jan 2025 08:59:49 -0800 (PST)
Received: from linaro.org ([86.123.96.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221b5asm7939547f8f.21.2025.01.19.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 08:59:48 -0800 (PST)
Date: Sun, 19 Jan 2025 18:59:47 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Eric Biggers <ebiggers@google.com>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-scsi@vger.kernel.org, andre.draszik@linaro.org,
	peter.griffin@linaro.org, willmcvicker@google.com,
	kernel-team@android.com, stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 2/4] mmc: sdhci-msm: fix dev reference leaked through
 of_qcom_ice_get
Message-ID: <Z40vg9CZQ60HRBoa@linaro.org>
References: <20250117-qcom-ice-fix-dev-leak-v2-0-1ffa5b6884cb@linaro.org>
 <20250117-qcom-ice-fix-dev-leak-v2-2-1ffa5b6884cb@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117-qcom-ice-fix-dev-leak-v2-2-1ffa5b6884cb@linaro.org>

On 25-01-17 14:18:51, Tudor Ambarus wrote:
> The driver leaks the device reference taken with
> of_find_device_by_node(). Fix the leak by using devm_of_qcom_ice_get().
> 
> Fixes: c7eed31e235c ("mmc: sdhci-msm: Switch to the new ICE API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4610f067faca..559ea5af27f2 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1824,7 +1824,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>  	if (!(cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS))
>  		return 0;
>  
> -	ice = of_qcom_ice_get(dev);
> +	ice = devm_of_qcom_ice_get(dev);
>  	if (ice == ERR_PTR(-EOPNOTSUPP)) {
>  		dev_warn(dev, "Disabling inline encryption support\n");
>  		ice = NULL;
> 
> -- 
> 2.48.0.rc2.279.g1de40edade-goog
> 

