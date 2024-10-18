Return-Path: <stable+bounces-86819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F25E39A3CE6
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 13:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1F31C23CA1
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 11:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5252038A1;
	Fri, 18 Oct 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FH1LdWY9"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559902036E8
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249772; cv=none; b=eC0XZm9QS/ICoGfGZm7u6XfMGoHJpYZszUY44MUBfZBqMDi89ho+enwp4yi/noxILoo1Y0Gb/p2oQ/QG2zVoddUNAURkoGVpHaOBVeLxgghvgXAQGN2dsO91Z66+DSxhK/UEtkQwZoTbO5lVfYjsjENw21AjKg8T37ZBr4dSjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249772; c=relaxed/simple;
	bh=hIRhsvJSIxKZNH+0yh8CMfYQrQrPteNJdkQamPRSlyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad9bc0aWf7OLdHfY8BmzPnkFmWaEE61H890IkiyLlVj5SbfmS/diF9B5KmudvLXnjXGozbXYutGooWzvSTgZ2dUBG5QXubPWLdekWbZyV29aWfGdzQc9d4w/NfHAgEcTzsfjE3O2mTQtixeZh5/7hURwQmjh9/Xu3iF7RyXpPZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FH1LdWY9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so2257834e87.1
        for <stable@vger.kernel.org>; Fri, 18 Oct 2024 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729249767; x=1729854567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XIt2ZgCz6/2u04try8W/s+t9Roe8RkNgbgiZjheFS+w=;
        b=FH1LdWY9YLpTuXCq7TfzDZZcykgIwMOGrzwa98+sU0/yhfJKlOrqnt9YQZH5OJF2JI
         m1xVdqAehwL1RS+VwR2rp+0l4F+gUeCPVMtUYKsJxtlqtgLsC8KQnxiOUjP3LHGxZhDe
         He7Yq8lR0NtrXjbnxQwfyZuLGouxhmb0dtLVQyPDC22vzqtQWD7bKz3cU2C5PWiZ29rL
         9jZtXM2G2QUlpTsTi68Eyjr9RPpIET9a2TKRLZ6L5x1Ecn8AKd0goNARxBPxGfdA3qo/
         bgCIUgQ2HFIQwkxHYUsGnFmvGwG7V3cXIhls2X/OAor5u3MTsvXytBoMPTRge+nVYl79
         8IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729249767; x=1729854567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIt2ZgCz6/2u04try8W/s+t9Roe8RkNgbgiZjheFS+w=;
        b=rNfopcPOJxey1g5nEPi+qaQmUKxvxw1NyjQaxTeLUd+sj9HFUbcStTa1UgkXAB6iN5
         z65+0ENWwisAW+r77H52oSUGaIlw08gNw9/L90sDAvAjK6zWj//UW9K3F4Rg56ABKQjc
         G3LEoxy9WssGLyJ9meYlwaIAUjQ8OXbedgr6GsCxMddge2BlgSOMnzX5DeNPhT2ZRyPs
         d5zex6rfgH0K/hNRN1lk4QG7xueBtUD1HEbTB9V6131PO3WlZoHPBNk0SgiAVVCXfRrV
         B3SYBnR+DAAh3cXWlG1XvjktIHTCR3HzIUKykyeQd0I+r+NPBRrwG9GGKyB/1pbYhpZj
         OVEg==
X-Forwarded-Encrypted: i=1; AJvYcCUbPdg+07dOwi+1GtuyGEn1YhQv11//qbF/+bRyri4fzpxpSEgIn3bg3IDlYxy0k2j/GUu9wdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTchiBI1iKLrSbbLmKgOBvjglxIEfY5Hu+ggMUjDfoHAuxKd5G
	GPOkbSR4vKwJAsSF6LBYWcS/+KeqZ0OORJnm4fi15s3MYHJLv0ysNx+wybOJDVc=
X-Google-Smtp-Source: AGHT+IGQcoRjkME8sB/QzR808hEBcFeX1bRQ7Ps+vQJxPs0k7IOBUWWNJ5veYpKKDLhJoGJiAwODNg==
X-Received: by 2002:ac2:4c48:0:b0:539:f699:4954 with SMTP id 2adb3069b0e04-53a1546ca04mr1270371e87.58.1729249767449;
        Fri, 18 Oct 2024 04:09:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15214e7esm190571e87.259.2024.10.18.04.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 04:09:26 -0700 (PDT)
Date: Fri, 18 Oct 2024 14:09:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Balaji Pothunoori <quic_bpothuno@quicinc.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ath11k@lists.infradead.org, kvalo@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: qcom_q6v5_pas: disable auto boot for wpss
Message-ID: <ho24wc35ssaecs4hqqbyuqizfamr6fffrzp62v6eevprzbjmx5@qx7urvuaptqq>
References: <20241018105911.165415-1-quic_bpothuno@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018105911.165415-1-quic_bpothuno@quicinc.com>

On Fri, Oct 18, 2024 at 04:29:11PM +0530, Balaji Pothunoori wrote:
> Currently, the rproc "atomic_t power" variable is incremented during:
> a. WPSS rproc auto boot.
> b. AHB power on for ath11k.
> 
> During AHB power off (rmmod ath11k_ahb.ko), rproc_shutdown fails
> to unload the WPSS firmware because the rproc->power value is '2',
> causing the atomic_dec_and_test(&rproc->power) condition to fail.
> 
> Consequently, during AHB power on (insmod ath11k_ahb.ko),
> QMI_WLANFW_HOST_CAP_REQ_V01 fails due to the host and firmware QMI
> states being out of sync.
> 
> Fixes: 300ed425dfa9 ("remoteproc: qcom_q6v5_pas: Add SC7280 ADSP, CDSP & WPSS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
> ---
> v2: updated commit text.
>     added Fixes/cc:stable tags.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

