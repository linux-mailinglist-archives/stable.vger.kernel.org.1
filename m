Return-Path: <stable+bounces-109494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F98BA16310
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 17:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9737B164174
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 16:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93951DF97D;
	Sun, 19 Jan 2025 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUChneSB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EEB184
	for <stable@vger.kernel.org>; Sun, 19 Jan 2025 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737305976; cv=none; b=hrxTh+vb9N/d6P1stpMbmou563O5CWu7603nUwTZhgB29FUktLrq0m1NiZw6eeH4ADPq89U1C+OBPtOmkZ229L/MZNJheKF10hynuxPYZXFVbVO3r7RloyCC+20NeTnUQwr2ocyAJ8k6lW9hJyLfsMmti1ZZDhe6Qux4+T41aqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737305976; c=relaxed/simple;
	bh=i8jlXieaT8KmwtG6JYMZ97nlaBgdfnq052Onnm3ehjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVrG8/p6zbBVOCJpagKm09aeyuMJmiAIS80PUsxUd9pWciWteeYx4/yFM0Urumdmi2NkrLgrbHKEnoGa9L393QhzlduKPy2qEx2H2VXl79ISbAAtxWig6dlaDSWOmUmtP1+Z2uW7HaBPECML/9CuRLbAPUWmvVn94YL6I/Fo8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FUChneSB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-386329da1d9so1931430f8f.1
        for <stable@vger.kernel.org>; Sun, 19 Jan 2025 08:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737305973; x=1737910773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ryjgud0Cu35z0KcZwYmKJ/fOZn2jkkwEjHOVTa8VYFo=;
        b=FUChneSB8WMSrip1HVHKA0Q561mFMhPSUJA1Z0H6szMZvIUQifM3FatltyLCCl7v6N
         EP10NuSTsSqy2u8I81TlmCIOjVnNUkv1ixHJ3K8Uag42wakz+YDQPbIWbbOV8/YqYPR+
         on0jYC2oD52kJDkBIBieVl06KyCDIn5ld8F6VFf+WaNg39rkZeZv4Q7VHZeVXny7uuwG
         ucrKzLoJKbLePEL5cG0V/vXw40dHqB13c4n5e+Ckk25S7bukpCReW6QA6UCNNnM3feQ5
         lZ5xJhFTl9Bo7C5br7hJFpcOAGO6HhcuQZwrf2OMDQfEkPO+SUe7m509RT0IBJXz1/Hb
         8oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737305973; x=1737910773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryjgud0Cu35z0KcZwYmKJ/fOZn2jkkwEjHOVTa8VYFo=;
        b=wHK1unMEo0BvYBhxXZPIEfxr++ZqTU1WJFd2NgA6iOCNJ/wx8F9iK+QdxAzI4xaZqQ
         7+yhyZ9MW0V2GMslcDnFyD+hVe/NWeJzjl4gU/29YnkyN/bnlEpT4ytyclmSFmDVeLHh
         WymqZfZ3gNxX6DJQRwFgjRFUg336NUBtlR7BDWakHwkfpKjy4MMNV074vV+sSFzuGSKq
         tPnYy09scXMgKD59y1J//DpDuN8/Vt2RUwxlWnTkdlMxqZFQfxZ8c1x2+CjTjP8croqW
         6qrlHOjwale8SC+5TW/gJl6eAf1ZSx+uFJmBf55hJzwP9BullHLt9BTogZ8mhtNRJN1Z
         3DQg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Fg+Cu7CUSmJLguEfc6m5qhlc6GAxeo3bH9RcSfmqamej/alU3KMsRmNhEJyGYEoJxYKaV1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys3Qw6voWj5uHVXxMLIe0AqUTQC33vuV0FnizL19cKPwM8xUij
	2ZyyYzXIcpF0/OyxgNcP4QT3+J7wGsLfavZzWo84azXaGL4vzFrgi0ZCpl7+ums=
X-Gm-Gg: ASbGncssmhsETr9tiuuSoI+G1RmCEHRLOBEahHcCZ4hlPhUJ1AdT3eFvWv1Ef815n/C
	Cfs1BEF2GNUioF3O5q/eVIQUxDjjS0obLgL8k55BeymBZTOsFENSDj5m9zKh9Qt9nftgsFXD81L
	zf4T0SSLJO7PBgMXT96sGeQxMS4iGra/slg0s1TYIgbv+ol3Mj/PCJtWYXZm4IHDOzVIwIhMa7o
	qSowlDf7VRJa8D8CGsLQzqriKbd83yFjcBG1v8vylSu5roYyGu4u1fm78pJIl9q9ItJ
X-Google-Smtp-Source: AGHT+IEHlfbUYzo6uXopuyotVKVif1ubxn0HrljJb34K7NGGjfxPHjuaD8j+8GTb1rrlbJmGX092oA==
X-Received: by 2002:a5d:4568:0:b0:385:decf:52bc with SMTP id ffacd0b85a97d-38bf5671bc4mr6755803f8f.32.1737305973017;
        Sun, 19 Jan 2025 08:59:33 -0800 (PST)
Received: from linaro.org ([86.123.96.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3214df8sm8077337f8f.4.2025.01.19.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 08:59:32 -0800 (PST)
Date: Sun, 19 Jan 2025 18:59:30 +0200
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
Subject: Re: [PATCH v2 3/4] scsi: ufs: qcom: fix dev reference leaked through
 of_qcom_ice_get
Message-ID: <Z40vcpkMg50OWL/u@linaro.org>
References: <20250117-qcom-ice-fix-dev-leak-v2-0-1ffa5b6884cb@linaro.org>
 <20250117-qcom-ice-fix-dev-leak-v2-3-1ffa5b6884cb@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117-qcom-ice-fix-dev-leak-v2-3-1ffa5b6884cb@linaro.org>

On 25-01-17 14:18:52, Tudor Ambarus wrote:
> The driver leaks the device reference taken with
> of_find_device_by_node(). Fix the leak by using devm_of_qcom_ice_get().
> 
> Fixes: 56541c7c4468 ("scsi: ufs: ufs-qcom: Switch to the new ICE API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/ufs/host/ufs-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 23b9f6efa047..a455a95f65fc 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -125,7 +125,7 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
>  	int err;
>  	int i;
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

