Return-Path: <stable+bounces-211554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGvfMxZXd2nMeAEAu9opvQ
	(envelope-from <stable+bounces-211554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:59:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F8587EB3
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DED030075DC
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 11:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204D233372E;
	Mon, 26 Jan 2026 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNnqwP/o"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E132E724
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769428746; cv=pass; b=WBZMKDybtu2wbr9RtyW3pOCmmSY9J3UvEY7L/pqUN3IvHUoOQbIiqtMqZxsV1VoRs9QiemlVV+pSR1OGH+/oNLy6JJHxntROi1oo5lRAJXns8gChVrMAQSuQsEcNj6zCMiX1RCMHQEHScszSEDL6kI86N190ats5K35Ut2Hl88I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769428746; c=relaxed/simple;
	bh=ueDbZxfaJaRJBPNnQTV7LcSD+ot8kxI/8ecV5AaE3VI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukvxD8mQ/qRrCw0jQNC2TEKX79dNbAB8qqtcOqeP4aBRHIb8ikBn3uFZ4aTNsjuCHeytXinyM9fPhvyu1fI9tZmP7JVscjtzp/L/xAlV35Ao3jgAz0oZHiqNj9yOSE+7oCXPo4wi/Huk1nCkcT3qT++VJtBtQYy9Ld7Jyvp4l7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNnqwP/o; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35334ea1f98so1988009a91.1
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 03:59:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769428745; cv=none;
        d=google.com; s=arc-20240605;
        b=KnIvQ9WJmRdj6ofPC6Sp00yKixrMkLTN9tjbKSVE85lA8GUMMFF8zN/qh339aofw8y
         jRqjKCRTawhAXl+DjD0IJvwbxHU1k6gMfi6VCahBLKWqjr4upw+Mqif3PD4IAS07y7qg
         2bvoX5uBrt6Rbpamkqlrh2cpeOTLWz5oD/kXswAA+OZjTCNVRlCyfpm5PCEk4WzZkOX6
         WSd3/1sQcSzWFPJsYCA6bW54ggMeLvL0fMw660seGNfYEypHi+EjLn7xEtlRLz4VyjHD
         LtHaeMd03Cw1/+nVjUgnxmMwNGrCuArs+eeyYdi31LwP9f7Gwfi7BjB1ZJeHgxFrVYtl
         9oMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lxU49EsEPtxJDyA2uj8GOndna+YV7i2iNMjekZIsTLQ=;
        fh=eYGMWTRrz2bcdjBxhowGzyxgdhA3RDUihEYttjGJww0=;
        b=XOeGGjxUDXwEHY1e13KQolGfDYX4LDncnbgGrDsq+ah2DA4D7GnRylvr5UKt2pXefA
         2yOxOkTMaTjZCxMe0OL2YWTwxY3gS4SsX1XlbmhjbxT0wOZ/EgWeZoSlhJYl2BmclXHT
         VkfrGkbs5e7RlzWQDN+QHZP8djD1IZ5IXRZpT3bXUKh1GcXY4+30ndu6sULLI7IHOPN8
         6c/luY2v6ZgXFf4W6BT68TuD/gES2WbCl7sxHj0OmpcyzzhvliGQJ/30h0ZFB+YI79yj
         LE+w9mQDWFBtrxwWk1Gb4SRXXoDziNVAXBRbbkiqH068p1k5Kq1tnrC23DNygZjAM24Q
         TruQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769428745; x=1770033545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxU49EsEPtxJDyA2uj8GOndna+YV7i2iNMjekZIsTLQ=;
        b=GNnqwP/o3de3k+xzZsEBRPGU/J3QAslnMXgPHrKAgDC+4Y1slMotI6LqZHou0gO/s7
         7k0iHOsah8VReR/v7tqraP0kHjcNMYXkr8TPlZW8Ef60mIkZh0lfd3TL6iwwnwgo9m9K
         YRn1A7meFFaojlgQZofHbkags79+NFYAhfeia0BDj3vc9f3pcwfSrwzVYoApjgkPNVX2
         GcuLd7W38FExWcjaUPfe0YdZOXr1XXYgXkCNRR890ePj3n5Zc2DVV2+L487mjiMyrs35
         5VrTL/F99X+zlScU0jUMJtvPxK2kMpg73MVKooLOTdGlT4Orwcm0USGNucWe31WkNYAc
         5vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769428745; x=1770033545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lxU49EsEPtxJDyA2uj8GOndna+YV7i2iNMjekZIsTLQ=;
        b=FBxL6dVlGapU6WaExNuCWLAx1m0JvX1sdifdhWIbcQJAdatWl0V1MTXJUGRj3SFEHC
         3VyaiVEx23skhqf95cMIoAk24ad8fpjQQwo/pONBFE2B5VBg7aUwueJb9PywpzWbqoi4
         sw/MGZRSOrE1QQ0Q7suTcmx4OfpHNI5MGHNUZWa61OUwLdJhhHwwDG552Th+k8URxed7
         uelqtsix6bYvAAJ2KtG8a+Uj7ZQDGCiO5bnj/YPSbx+5jsomrTd+ordrUbxKbeAxjyBf
         ZKfX8/yQ6rWd/s/R3j4hRp6tMeAN/6n4AE2WOBmB8W2dzsbQuC5OtrLOBsMIjVWnNAk/
         AFjw==
X-Forwarded-Encrypted: i=1; AJvYcCWWuPQzZSP/1zjGal3WnQ5Xx8fj/tyBnClkGwxVtNBvYvbtou6nh9hqdHFyjR6xONsFdVJaKBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4g4azIZwGizmC1yZ2GenzgJaxwnofZ7a8r59cAToJSf7YD9LD
	WPRw3QAcs0+HGBMKweYRAmhx5eCFqoPGd0x1oZoL1VfupjVQoVm151pH4m9Jh/pOpCqz1RQ0j8k
	VMdxF0zjLAmMzXt+7UOUUXHig2u+OPBQ=
X-Gm-Gg: AZuq6aJNcl9b1fV4zi7tTCvSBRDUX8530N4YBi5YyC77/7OMd9d9M3KyHgSPZwOZ7M8
	rUVS1h0nd4kM6JcPcF1O9goZ5weo6mgzqP3KHPFtX9KZhtUzt0ef+6BCZttSgH7cXOCJXDjg3Ex
	SVFUlb0kpub2qYfJgtrRdBVwDy9CO01hn0SWAOvxVfc/Kl4Hdxth1bVgoZbHpThLjxVcZj2gAqa
	8E94t0cuo+kIIHWBRFYaFd2VlpjpHGrKwYDjFjiW1Rlub6i/UDmhw7pRJyDiIUAPVVGSCl4Xf5k
	7eMxotQEyWxbVcEwGLtUiVXjjTmi
X-Received: by 2002:a17:90b:1c11:b0:34c:7182:cf9d with SMTP id
 98e67ed59e1d1-353c41787efmr3269458a91.25.1769428744818; Mon, 26 Jan 2026
 03:59:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125171745.484806-1-bjsaikiran@gmail.com> <20260126061528.63785-1-bjsaikiran@gmail.com>
 <20260126061528.63785-2-bjsaikiran@gmail.com> <ef6cf6c5-3b5d-45f2-af67-0567262a4561@linaro.org>
 <CAAFDt1spRkj7kySCa8P=jehQHbYVT2j+nxLira1vwYkiCJ7LDw@mail.gmail.com> <b699fcf5-5cb0-41eb-b9de-e5c6e98aefaa@linaro.org>
In-Reply-To: <b699fcf5-5cb0-41eb-b9de-e5c6e98aefaa@linaro.org>
From: Saikiran B <bjsaikiran@gmail.com>
Date: Mon, 26 Jan 2026 17:28:52 +0530
X-Gm-Features: AZwV_QjRJQN9oQY4Bm_wvDz9C94tR-dF8CReD0RZ4DAvRDLQ6uVsM3VvLqo3HCI
Message-ID: <CAAFDt1tjiEXbuChcY73+NYxPW=rB83P4Bks1TPGsHTTqoSzOuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] media: i2c: ov02c10: Keep power on and use reset
 for power management
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, bod@kernel.org, 
	rfoss@kernel.org, todor.too@gmail.com, vladimir.zapolskiy@linaro.org, 
	hansg@kernel.org, sakari.ailus@linux.intel.com, mchehab@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211554-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linaro.org,linux.intel.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.36:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 79F8587EB3
X-Rspamd-Action: no action

"I don't think we've established the regulator is at fault. That's the
feedback I'm giving you here. ... vreg_cam_1p8: regulator-cam-1p8 {
compatible =3D "regulator-fixed";"

Just to clarify on the regulators: on the Slim 7x, the camera supplies
(avdd, dvdd, dovdd) are all RPMh-controlled LDOs (pm8010 and pm8550),
not generic fixed regulators.

As I've confirmed that the qcom-rpmh-regulator driver doesn't natively
support active discharge or parsing off-on-delay-us (generic
property), which explains why the physical discharge constraint wasn't
being respected.

I'm taking your advice to fix this properly at the platform level in
my local tree (patching the RPMh driver and DTS to enforce the
discharge delay).

For the media driver patch (v3): I will follow Hans's suggestion to
use Runtime PM Autosuspend. This handles the rapid open/close UX
problem gracefully by keeping the regulators on during quick toggles,
avoiding the need for the driver to "know" about the platform
regulator constraints.

I will proceed with my testing and will let you know of the results.

Thanks for the feedback.

Thanks,
Saikiran


On Mon, Jan 26, 2026 at 5:11=E2=80=AFPM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 26/01/2026 11:23, Saikiran B wrote:
> > "Where do you get this conclusion from ? Are you inferring it from
> > what you see on the platform or can you point to some known
> > data-source for this ?"
> >
> > This is determined on the Lenovo Yoga Slim 7x (X1E80100). I tested
> > extensively and found that if I attempt to power-on the sensor less
> > than ~2.3 seconds after power-off, it fails to identify or times out
> > on I2C (brownout behavior). If we wait >2.3s, it works reliably 100%
> > of the time.
>
> I don't think we've established the regulator is at fault. That's the
> feedback I'm giving you here.
>
> I think it is far, far, far more likely the power-on sequence of the
> sensor needs tweaking.
>
> >
> > "2 seconds to discharge ? These regulators are PM8010 anyway - so
> > you're saying the PMIC takes two seconds to discharge ?"
> >
> > Yes. I checked the regulator driver
> > (drivers/regulator/qcom-rpmh-regulator.c) and found that unlike other
> > Qualcomm regulator drivers (e.g., spmi/glink), it currently lacks
> > active_discharge / pull-down support. Without active discharge, the
> > voltage rails float and decay very slowly via leakage current when the
> > load (sensor) is in reset/high-Z.
>
>
> Right so looking at the power for this part we have:
>
> &cci1_i2c1 {
>         camera@36 {
>                 compatible =3D "ovti,ov02c10";
>                 reg =3D <0x36>;
>
>                 reset-gpios =3D <&tlmm 237 GPIO_ACTIVE_LOW>;
>                 pinctrl-names =3D "default";
>                 pinctrl-0 =3D <&cam_rgb_default>;
>
>                 clocks =3D <&camcc CAM_CC_MCLK4_CLK>;
>                 assigned-clocks =3D <&camcc CAM_CC_MCLK4_CLK>;
>                 assigned-clock-rates =3D <19200000>;
>
>                 orientation =3D <0>; /* front facing */
>
>                 avdd-supply =3D <&vreg_l7b_2p8>;
>                 dvdd-supply =3D <&vreg_l7b_2p8>;
>                 dovdd-supply =3D <&vreg_cam_1p8>;
>
>                 port {
>                         ov02e10_ep: endpoint {
>                                 data-lanes =3D <1 2>;
>                                 link-frequencies =3D /bits/ 64 <400000000=
>;
>                                 remote-endpoint =3D <&csiphy4_ep>;
>                         };
>                 };
>         };
> };
>
> // qcom standard RPMh -> PMIC LDO regulators
> // these are not the droids you are looking for
> vreg_l7b_2p8: ldo7 {
>         regulator-name =3D "vreg_l7b_2p8";
>         regulator-min-microvolt =3D <2800000>;
>         regulator-max-microvolt =3D <2800000>;
>         regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> };
>
> // this OTOH
> vreg_cam_1p8: regulator-cam-1p8 {
>         compatible =3D "regulator-fixed";
>
>         regulator-name =3D "VREG_CAM_1P8";
>         regulator-min-microvolt =3D <1800000>;
>         regulator-max-microvolt =3D <1800000>;
>
>         gpio =3D <&tlmm 91 GPIO_ACTIVE_HIGH>;
>         enable-active-high;
>
>         pinctrl-0 =3D <&cam_ldo_en>;
>         pinctrl-names =3D "default";
> };
>
> Dell has used - likely reused - part of the x86 design in the qcom
> implementation - and toggles 1v8 via a GPIO directly.
>
> If your theory about brown-out is correct then
>
> vreg_cam_1p8: regulator-cam-1p8 {
>         // add this
>         off-on-delay-us =3D <20000>;
> };
>
> Then please let us know how she goes.
>
> ---
> bod

