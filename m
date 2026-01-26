Return-Path: <stable+bounces-211552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CProKP5Sd2mdeAEAu9opvQ
	(envelope-from <stable+bounces-211552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:41:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CB387B96
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E1F03019B80
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A434332ED1;
	Mon, 26 Jan 2026 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7CeY/hK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942D3331A70
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427691; cv=none; b=RDdxTlT9KZDFmd5ERA9DpqXa7NxZB6nB19xhIOydmw+zcm6r/soQ96q7vUcpvGPpa1y4D48PMzL3StJ+WU47B3W8UmIqreNA6QixLHx2o6ZdbEH5tsxuAjK5P2tm793CEtERktYc/bAyePRb8G8C3K9DmT1iWmW+xFhkr6rZijE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427691; c=relaxed/simple;
	bh=AxiyoaABzXqMP4w/uMab+PrtYh1Z0TFJQkq97Gw4i8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lai8utYN+RVjeYV4j4w/V4gJuXNsfcM6ZezfoET4gs0vv8aqpP3BwtEsc3EhyNbWeskz58vJeuMAugtd6EHbUJuO4alnNDPQwNLVIRJcSMIH5NVKfx6yOcvM8cOQB1hT+u2F6wrxyyN7cFZ+f2LFbnEvzYb/jRYB/vXwh2PcKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N7CeY/hK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fb5810d39so2786000f8f.2
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 03:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769427688; x=1770032488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rN1oSNDkGLBy6EHwhjHDF6Jrov42HwjEw9RdQlJcNw0=;
        b=N7CeY/hKava6XQQ/h38THONZbwLfrd8ykCvvjqfwdFmS+pBHPJdSfjuMd+EVN4HD/Z
         pg/fnlUkjlQ5nMT575LsObgYKXv+a+Qna1IHm8/ge+4UT+nwcswITHgmt5RHab7965PK
         vh462n6WONI3ZQX2IRclp0bTd+c3qHsLzUcvr+Jym2knvMeB3ClEXVhm+aAh1M4irkVz
         o/rL2K/+9wWGPwX0GYGYedwpw/1IoNzqRV00cQqTi1lgQyN1wQX4v75HmaDd4aHxT/9e
         auPsRzPHtfa2d68Su6Rb+XGAkejiLTUClBfQ6mnhUG+FAyOYmui2gU6Leri8kf3LlNrB
         Kucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769427688; x=1770032488;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rN1oSNDkGLBy6EHwhjHDF6Jrov42HwjEw9RdQlJcNw0=;
        b=pTZdA8/O+OSjPmWEk7TEG9JMosUNxO27A/X1eDQMip/IHvoP8nAX7gHdBUom84HTe/
         lLGwMMsiR60TQT9SZDDnrsIKfPDSW7glViU/BkwmcAie593dNjuv+trOxuSYh1jEMm3a
         4adSDmm20YwBdzwKlIm4zmqYJJI/Q5U8twG8NXRGNAmfKWxX4APpboYzKNkb1/tHcHvP
         e0oo/e/dnYxLEn+mDQUWknsitiZ2zoggUPWQlxLp6gys0OiXxX6ei2RV1qBo/iMfmSs0
         K2xH3WaymhQpjCDvptY7ol78KuQCVf68izc+R9PDefCh8tgCL75Wc7R55jznKLedDF2z
         X+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWGYKSgVD+x3DpKdtYcqnQaxlfrVY3IcEkuAr8dDTcBFvbFw2mG30upcVAsbwSghbG5t7Kf0rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIO1ORWrF+di7SU+N3YyhlSYSrORc8v5+IdN3eP92HthFEwZPY
	2tkETr8Z9HFd/PMFbUvQf4Sl3QhQAMJSQk3wPPx/sqIvkoSXrNLzpiGDw8VrO6RO2dU=
X-Gm-Gg: AZuq6aKbzq99TYAvdkHawh3TP4tAw3CpykIyrdw08NH/kiqjN9H1f7G+RFoVeB43TLE
	FSxNPSdQmZdJ/KmB6/az97ahRbAQuFUhfpd5N+D3KtZYqdczqEUArdE6v4t2DcN3+z7tZ/tQdql
	CkovfTyHJOhGK2QCwKNIbbbJW05h4Uu/CRmt6lfOWmGnAYehzds2sPKaoYK4HvydWtvb5LO3Stu
	QEoQ0u5AT9AZu42giWUI9/huO7I1CQVgb3qqLwPhjMZrPwgC2dKt9XEeOXXQuBEIAm/d7OCYDOV
	3AuR7Etv6Nd6TXcyC4cnMK7YMfo376wt8b7PDqhtJ6wyN3h0RwS1/ntT8t1EpZ6r9LMEVzfbGuJ
	PgMS57v3NWJRfp+Y2HPq5J0c/uNXlWe134NGLcZe/I5rFxJq9wA8XXgf2BHmlwZmowWVyoLZ14A
	rs8ARXmQB0RaSoZr5A3P8iUfDnBcgQJjaqU/u2UPdfmTfMyZzx8Lsg
X-Received: by 2002:a05:6000:230e:b0:432:c0e6:cfcc with SMTP id ffacd0b85a97d-435ca0ef509mr6845789f8f.23.1769427687426;
        Mon, 26 Jan 2026 03:41:27 -0800 (PST)
Received: from [192.168.0.40] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f73855sm28803758f8f.29.2026.01.26.03.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 03:41:26 -0800 (PST)
Message-ID: <b699fcf5-5cb0-41eb-b9de-e5c6e98aefaa@linaro.org>
Date: Mon, 26 Jan 2026 11:41:25 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] media: i2c: ov02c10: Keep power on and use reset
 for power management
To: Saikiran B <bjsaikiran@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 bod@kernel.org, rfoss@kernel.org, todor.too@gmail.com,
 vladimir.zapolskiy@linaro.org, hansg@kernel.org,
 sakari.ailus@linux.intel.com, mchehab@kernel.org, stable@vger.kernel.org
References: <20260125171745.484806-1-bjsaikiran@gmail.com>
 <20260126061528.63785-1-bjsaikiran@gmail.com>
 <20260126061528.63785-2-bjsaikiran@gmail.com>
 <ef6cf6c5-3b5d-45f2-af67-0567262a4561@linaro.org>
 <CAAFDt1spRkj7kySCa8P=jehQHbYVT2j+nxLira1vwYkiCJ7LDw@mail.gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <CAAFDt1spRkj7kySCa8P=jehQHbYVT2j+nxLira1vwYkiCJ7LDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linaro.org,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211552-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryan.odonoghue@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.36:email]
X-Rspamd-Queue-Id: 08CB387B96
X-Rspamd-Action: no action

On 26/01/2026 11:23, Saikiran B wrote:
> "Where do you get this conclusion from ? Are you inferring it from
> what you see on the platform or can you point to some known
> data-source for this ?"
> 
> This is determined on the Lenovo Yoga Slim 7x (X1E80100). I tested
> extensively and found that if I attempt to power-on the sensor less
> than ~2.3 seconds after power-off, it fails to identify or times out
> on I2C (brownout behavior). If we wait >2.3s, it works reliably 100%
> of the time.

I don't think we've established the regulator is at fault. That's the 
feedback I'm giving you here.

I think it is far, far, far more likely the power-on sequence of the 
sensor needs tweaking.

> 
> "2 seconds to discharge ? These regulators are PM8010 anyway - so
> you're saying the PMIC takes two seconds to discharge ?"
> 
> Yes. I checked the regulator driver
> (drivers/regulator/qcom-rpmh-regulator.c) and found that unlike other
> Qualcomm regulator drivers (e.g., spmi/glink), it currently lacks
> active_discharge / pull-down support. Without active discharge, the
> voltage rails float and decay very slowly via leakage current when the
> load (sensor) is in reset/high-Z.


Right so looking at the power for this part we have:

&cci1_i2c1 {
	camera@36 {
		compatible = "ovti,ov02c10";
		reg = <0x36>;

		reset-gpios = <&tlmm 237 GPIO_ACTIVE_LOW>;
		pinctrl-names = "default";
		pinctrl-0 = <&cam_rgb_default>;

		clocks = <&camcc CAM_CC_MCLK4_CLK>;
		assigned-clocks = <&camcc CAM_CC_MCLK4_CLK>;
		assigned-clock-rates = <19200000>;

		orientation = <0>; /* front facing */

		avdd-supply = <&vreg_l7b_2p8>;
		dvdd-supply = <&vreg_l7b_2p8>;
		dovdd-supply = <&vreg_cam_1p8>;

		port {
			ov02e10_ep: endpoint {
				data-lanes = <1 2>;
				link-frequencies = /bits/ 64 <400000000>;
				remote-endpoint = <&csiphy4_ep>;
			};
		};
	};
};

// qcom standard RPMh -> PMIC LDO regulators
// these are not the droids you are looking for
vreg_l7b_2p8: ldo7 {
	regulator-name = "vreg_l7b_2p8";
	regulator-min-microvolt = <2800000>;
	regulator-max-microvolt = <2800000>;
	regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
};

// this OTOH
vreg_cam_1p8: regulator-cam-1p8 {
	compatible = "regulator-fixed";

	regulator-name = "VREG_CAM_1P8";
	regulator-min-microvolt = <1800000>;
	regulator-max-microvolt = <1800000>;

	gpio = <&tlmm 91 GPIO_ACTIVE_HIGH>;
	enable-active-high;

	pinctrl-0 = <&cam_ldo_en>;
	pinctrl-names = "default";
};

Dell has used - likely reused - part of the x86 design in the qcom 
implementation - and toggles 1v8 via a GPIO directly.

If your theory about brown-out is correct then

vreg_cam_1p8: regulator-cam-1p8 {
	// add this
	off-on-delay-us = <20000>;
};

Then please let us know how she goes.

---
bod

