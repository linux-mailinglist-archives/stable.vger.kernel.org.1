Return-Path: <stable+bounces-211559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FdP1DpNdd2kcegEAu9opvQ
	(envelope-from <stable+bounces-211559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:26:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB50E882E6
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 026013025923
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F443358B5;
	Mon, 26 Jan 2026 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLz3YAmu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D0335573
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430285; cv=pass; b=EjTJ7mm7AecFXOB2G3rxrMZIwKTPu7pzfXFEzaoxyesUqTUfOqUiA67NNyG9FTwTNS+x7CvD3BYZ7yLw9f75Xlyan70mTAf9fVz2dER2ZIrf5kR7G0AwYrJ7CbzKzaxPyhlrpws+enqhQsgLaJurHti2TPQCo+056DxKmTE08/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430285; c=relaxed/simple;
	bh=pzEneNpTk24st2dNwgbOBX5hZQcJWkd60X7CUk/G2rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LW9bmWDBLxDmDcu3D7WEqZcSiS/ZcoeP4t6ktIDGh3R9+flJmEFS4GWvCyVilWbPM+Wg1ozISUwZCiYO9XzHOu5XqI8S2dwTQzRhyduI39d0ZjisOTj/sz/I4nt1ngaJeQILeEdMcrtT3hpYCYC4MjGg3vEpAZttUBSZmYpYxlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLz3YAmu; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a2ea96930cso27064795ad.2
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 04:24:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769430283; cv=none;
        d=google.com; s=arc-20240605;
        b=lB2YRrycrWNLv0qfKVilllhC1Rxsx2qdId9fnb5zlF/6H1SvkD5pWlE4SgD0UtSyKZ
         p2vPUpzrPJnYpsyDaJAwB0jERnZO7Vut9grhpGQjhxQyw6y5PXVwKB5QQG4yg59mhPag
         +q2NftcdsVfQYT8iBHul2A/0fgKeg0dFH7BE3MXErL1HSqEQem97un6pKfWyJwVoVvho
         fN2Dt+3s0WHJ3/A0vqy5w1UVxMFhpT/IK8wesiYrp6b7jLDXGPmGDbBr995DjMrpJgRA
         NWeGKATG4KVX17ziGjxXlHMZIhd4Ij5f0awF7/XoCpTGW17QjIkrhG6PrPS3KrwpfuHl
         mwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pzEneNpTk24st2dNwgbOBX5hZQcJWkd60X7CUk/G2rQ=;
        fh=v5S+pwgDuBtaCgWloCM22Wd2TxrE/FQGJ2xC7rzM2D0=;
        b=PnIK77YARhtojCM4PPFIpP1jSKQhgeKx1QyzMjxC6T8vOx8Y/yAO4MTkM9gqUDwFsP
         ydx1k2DVJU1Sl1aIqwRUcsI7qxlLy4bHfntS37zLy+2F+XVxYDPsUyu3FKVBjwi7vwwj
         Dqcr5ItdfPps68KtXurNDK7mj/Jt0oltRiFC86tXfBScdptS1PPvn1l08DL8U7FQfTfH
         N3Qa0MUfnSs/o8l1o4C6y3jauAC0wvyhgICxHvn7yVjY+vwxMMPZO4EdCpXlFxrIpooZ
         3OZV+aWhynnepFnB7oSEBb7sp9GEqaq9dZSuRvoWKytu5VCCrQsYYKaIP8Zj7dVokORC
         m3gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769430283; x=1770035083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzEneNpTk24st2dNwgbOBX5hZQcJWkd60X7CUk/G2rQ=;
        b=iLz3YAmuzSnCSXHanRGXQqHDw18UU7W/Hvm2du6ZXz1x7IA2I0HAQi6ck2hLJOOwX7
         4gDB46312Blh7ZDvF6EPC9XbEY8jzlNWj+cSFICCdULqsXtZji25t8g/8X7RU9eFLoZO
         oDUL/iMYXizEIZPSy5w0HDhqPofzi2uacWMsEqkkfjRSKMp+c+kPYEY0UxkESV87BeAY
         PPuLa8LgYmhsdTEh63tGADiMcYSMdZduKz9QQ5Ffm99ERXlhzi+R8fz6WhMg+0PCsDoF
         86IiCfG7ENpe11vnd1RcnU2fzC3WqtA6BoOAiD2/r2wN5TQvEzVgWIHYv4MVqULrvpns
         LThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769430283; x=1770035083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pzEneNpTk24st2dNwgbOBX5hZQcJWkd60X7CUk/G2rQ=;
        b=NxVI5zyaTLKDd2fdRSs3MJT1aw2ySQYM4YsPV+HrVE6/qsopb/fZ6cwL324xipOOFG
         xCYdoSpnmKiNN7Q5AEsFuuO/dTVhjfJYG3g/zeNTzxDmNlmQGfZnoPZrXi7wSiI/QuMn
         nMP+PEQuB5j/1t+OcofgYqhauNu1nTzwzzdFOuc49kjjhH2Kj0XabB1sBByEUJbvRFMr
         bBXtgLNiSM0/qU7b1ptDctZ+mryrCFRgPZtvkNuWiX76F8vIOXwyAf4ox86zWiojGgJa
         /rwiDFebNX7HkrjAdQARh0keLyoNkzITpBjs+DQkaEmokycPOc8g/Im3N/Z27y5BWLTc
         T2CA==
X-Forwarded-Encrypted: i=1; AJvYcCWcTBF1YPXVujXxaJo/wtlnIYGO501s6n+pQcAqYhryRc1o2S1fLAF/kS+qUkYqNkmx7fxX0Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfEyx6q4tD12IowVCmcEeXm7T35iYiA1FZYHr/fWMOmcRuk4B4
	ZwRUDokT7/H8FEjuFx/hO/B1q2W1dQOQxo4lsSuU3MRVfOrkLoSnODSZkh1IKGZ91Ig4LXHQ2IQ
	Wn2wmTtcCEOWz9fAL236ay1Qtug6zhmw=
X-Gm-Gg: AZuq6aJxd/VM0VEoORWBKYtwXXG0WXzv9eDzrp5nwH1cV1bjzlR8Puy/tfzl1t/7g/J
	qs1jsfZzP26UV2ft/phroOOsG33jX7ouTjpDaEGjB8DDKbYewnpFJ8hrhNwGsyBCLtB+JI5vaut
	g7xDkIrbwbOxoREQunFmqKsTY0atdYOZSt5/t+d549lzLBc/7ZOeRZeYU4b6ql4rpsNh7aU2BB6
	Vs07D4FDqOJA+J1MyiXYDpcpNSWGg0aecYwk5Q+7OTdtVo060xOMdRirqchLHiuDn8D2U5He/lU
	KpZPfkQfWasyjV03g9FaK+MJiVBV
X-Received: by 2002:a17:903:246:b0:2a7:561e:690c with SMTP id
 d9443c01a7336-2a845282b8fmr33020475ad.27.1769430283160; Mon, 26 Jan 2026
 04:24:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125171745.484806-1-bjsaikiran@gmail.com> <20260126061528.63785-1-bjsaikiran@gmail.com>
 <20260126061528.63785-2-bjsaikiran@gmail.com> <ef6cf6c5-3b5d-45f2-af67-0567262a4561@linaro.org>
 <CAAFDt1spRkj7kySCa8P=jehQHbYVT2j+nxLira1vwYkiCJ7LDw@mail.gmail.com>
 <b699fcf5-5cb0-41eb-b9de-e5c6e98aefaa@linaro.org> <IlpLwcSSsQ89AZYFUkWtRcUkztg6PClgkVOyWG0StiDOUCE93t7KlF9q18JPi3GutJ1OQWj_2igjYq1OD8FLZg==@protonmail.internalid>
 <CAAFDt1tjiEXbuChcY73+NYxPW=rB83P4Bks1TPGsHTTqoSzOuw@mail.gmail.com> <ed1421d9-f094-4306-ae6d-e07b3a72f82b@kernel.org>
In-Reply-To: <ed1421d9-f094-4306-ae6d-e07b3a72f82b@kernel.org>
From: Saikiran B <bjsaikiran@gmail.com>
Date: Mon, 26 Jan 2026 17:54:32 +0530
X-Gm-Features: AZwV_QjNdCq-r5XwMpcjdCkf8_9YDAdSFKTs6hBD0gL-ZHCx8M9dBvql7jzyq10
Message-ID: <CAAFDt1ukAdXwADuFVoZrs6Ay2fB_sq6LMW5FCnsjqUL7V62mfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] media: i2c: ov02c10: Keep power on and use reset
 for power management
To: "Bryan O'Donoghue" <bod@kernel.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, rfoss@kernel.org, todor.too@gmail.com, 
	vladimir.zapolskiy@linaro.org, hansg@kernel.org, sakari.ailus@linux.intel.com, 
	mchehab@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211559-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linaro.org,vger.kernel.org,kernel.org,gmail.com,linux.intel.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BB50E882E6
X-Rspamd-Action: no action

Yes, I implemented your suggested sequence in power_on():

Assert XSHUTDOWN (Reset GPIO =3D 1)
Enable Regulators
Enable Clock
Wait 2ms+
Release XSHUTDOWN (Reset GPIO =3D 0)

Even with this sequence, the brownout prevents detection if the
off-time was ~2.3s (I got this 2.3s number by conducting extensive
stress tests on the platform starting from 50ms to 3s. At 2.3s the
success rate was 100%. Anything below 2.3s, the sensor entered a
brownout state atleast once.)

Thanks & Regards,
Saikiran

On Mon, Jan 26, 2026 at 5:36=E2=80=AFPM Bryan O'Donoghue <bod@kernel.org> w=
rote:
>
> On 26/01/2026 11:58, Saikiran B wrote:
> > "I don't think we've established the regulator is at fault. That's the
> > feedback I'm giving you here. ... vreg_cam_1p8: regulator-cam-1p8 {
> > compatible =3D "regulator-fixed";"
> >
> > Just to clarify on the regulators: on the Slim 7x, the camera supplies
> > (avdd, dvdd, dovdd) are all RPMh-controlled LDOs (pm8010 and pm8550),
> > not generic fixed regulators.
>
> Slim7x - not the Dell right ;)
>
> > As I've confirmed that the qcom-rpmh-regulator driver doesn't natively
> > support active discharge or parsing off-on-delay-us (generic
> > property), which explains why the physical discharge constraint wasn't
> > being respected.
>
> No, the RPMh firmware should know how to do that. Not the Linux side,
> this is the part of your brown-out story that doesn't make sense.
>
> BTW, did you try my given sequence - particularly the XSHUTDOWN in
> power_on(); ?
>
> If the XSHUTDOWN pin is for example floating or not in the correct
> logical state when you power-on, the chip may not initialise correctly.
>
> Which could lead you to conclude - you are having a regulator problem,
> when in fact you are having a sensor state-machine init problem.
>
> ?
>
> ---
> bod

