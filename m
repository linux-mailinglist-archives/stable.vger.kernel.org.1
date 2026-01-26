Return-Path: <stable+bounces-211561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGgpJsFid2n8eQEAu9opvQ
	(envelope-from <stable+bounces-211561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:49:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD568877D
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8A233008C84
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D960334C1C;
	Mon, 26 Jan 2026 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYpWi8RU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4BF33769F
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431726; cv=pass; b=nsuU6DzscxtqMox85PzJu3JnnkGAR03bWh2wVSVGNIIoZAcMgFGtHhq44oidE5fsQnQQzkends1yr+O7nG/aBJpxGh2a8t0EPSAC6w/7oARdIN/2eFXnx5124ko6o0DsUCKZ5EWqORdHlt1RnoDE4UDV9/3cROHJMLeSm6KBkvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431726; c=relaxed/simple;
	bh=4wbUefewEyt+Bxa1epr+p529X5zn/t+qG9ZDeOzVm8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y56jWBJOLPiEvHLOUHUlcg2aHoq6JO2liVm+StocA0LGtWDFbhlZMn+41+hHE5esr8cJuyKRypiuIWYinPoDjesSf1YZ9LzK2BPC2PsIVZrqWQPXhK0w5rDeoWKm/hDCBTjU8hgyyTi/g8q9xbAHERz9mq46pFImSqPb1w2FOBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYpWi8RU; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so3640474a91.2
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 04:48:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769431725; cv=none;
        d=google.com; s=arc-20240605;
        b=Ea0CIdW3Da4lA9jnDjpfrzy7AfoBmqngne/XmYr77BrIcfF9Xp1zOnaprDeafAgJn9
         4SveFZny5lcGr7F3WLQWAVaB5K31BeQiBUQUD6UN+69RKGOczN9QFVXCwpB+PxMFozW7
         KUr/2RrMsMGSrRAqq/qwfNGK8LDUoozMATZu5IBnz1CTTEphEpvRoKPhu2zQeyQfSVTP
         tEdenS1pR7v760qjYg5pAl/mEVIlzhTm6Y083vpBNHwMTrcU0XFEQXIIYucyJdXP5ro+
         6/8UntMDXG28OuDIliXtlqgIJ2Z7uMgt8uMptBHLI6VWumDrbV7ofiWvxcMmy5Da8IML
         W4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4wbUefewEyt+Bxa1epr+p529X5zn/t+qG9ZDeOzVm8Q=;
        fh=3nwrWrHh6Q0ooE3xr6MJx1vj2J/Hp9mDqloipmwH4OU=;
        b=NMjXey7reXEou0SnYVsLAIiLznsu0w8AY3Fsa+n0WH9sLNTdUArXaCgVJmuE+AqOBj
         SPDg9ciBdNnmA2QGIYnmYt4Vu3qNbGyLzj6LO+WKMf5WuNE5UEmbIk7WZn0jf1IaPdpF
         ecxf4RaP7ceaB3GDLlJqW8OsmsJFWZubCYVUPdYUP+1HtRYltwTNPeoDPcthZ2t6eUii
         8goB4ZyY7zKZjdUdp/p9DaPuioiXsOo9hZMbQlEn68+Dr9svn2k44IBCiKfItB/ttynd
         AXEcKbljIYmcB5ER0xQmDR9C67urfV5UdyPp1j8VAS3QdiFn7uTui43XfkNRa8p5gWJk
         Z2ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769431725; x=1770036525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wbUefewEyt+Bxa1epr+p529X5zn/t+qG9ZDeOzVm8Q=;
        b=KYpWi8RUg787QneWLKwB4NlSNNt9xJ/iiwz1p+mhJKvGzpGPQWZv0ZK9Y+2INa7Em4
         c5TD3qBEAEmPVbKHPMqHX1/O4Yye8fU/7W5T0VyC6MsrV3Qx5Q1aMF7wJrVWbqAotDXR
         bVdNMhVnp9sF3al4cN16ilESVGEHeD/ARzo/NqtWEftzaUoN9TWKkSdVbTeSO7eyfJ0u
         pIPVRVC3rPg16vhRs9oFBqWZHs+EdnOOfJQx4gg2QQF5xR6YGmN3Jzv4ICp50kpgJaYc
         AH2rlhJLtL3Pxaqyo65rSHzIGRabdgNnmL222SBTHl/sFkydYPrs3HHL7A1BNZvAYskw
         Mp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769431725; x=1770036525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4wbUefewEyt+Bxa1epr+p529X5zn/t+qG9ZDeOzVm8Q=;
        b=BV76HKqBfCzquKb2jxyOPDwTMopMehMoUIeXy4E2Kp4QwVGJTJPUQz3GM8d6shDtvB
         VwJ7Ed00oE5wK1GiCKRPxZbx3q0WnrNMG8p3puhofSRTKigyccWMKEd4M4TdKFmZ6kht
         Ym2DwLm50/HVOlEp3P8oAu+B6QyPscvjpZrQ4H+aw1JnUzN5elz6NV+QjqIDA256LeFx
         EJ0LGdbrmumC9Pl8MKAsKxgBsMambs45ygYITpfwKE7D/l1MqbWxEdbDStkjjUWtQ2fU
         4l/d1ilEARNZhfXY8DSfWK5KmFj+arOPXP4THdcLWpEV6CkYW5EJjYGFecStmCBdx8/o
         +ACw==
X-Forwarded-Encrypted: i=1; AJvYcCXBauiG2RmlcAi9gCztxnmxyFmCGoRbQN/sD3LhvzFTMP4zBbktSkcuF1OIaDV6ZvPFiUy/cvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuT2dspRqwvQ0cm95nLcs/3d0Kc32cB2N8nw8VECurNe3iDGWD
	rGOUMA/S1JG+IEi2XoCOxcIbZQ6XAfKwzaJzyN7Jx1IYUMMR2YF6orOdUzTbucwQ6OLcnPx+QCM
	xcjsNnELsryHlWSrjUqkwa16FYiMpSOs=
X-Gm-Gg: AZuq6aKtObANs8X4FW0za3LYOhRNTaULYVxXl7hjVwkONQH28N5mYVc3ksBCVvaONB1
	DzQHO1PQDKXQFEAdhyAZRVNU8ZislpuJ1cBofswJ/mTwlSbOf3kQjV2jPtCxqbtiqVV40a5ZkZi
	qfegVy6GMf697pL4YlY+b5tEAPPIYjtAKOWBs6fu3guW1/TqfkiyEOvJQoRXYRKR1KWOOj+b7/P
	Ib/wbzCccHej2eysjwnh3jHBG4DG0qigl2D62fpuHaMa/hftPOGCpZs0q48QETxRtVxo/Y32v0n
	75UnmL44KVHv+IrQPEBVAUFK0a6T
X-Received: by 2002:a17:90b:558e:b0:34e:808c:95eb with SMTP id
 98e67ed59e1d1-353c41bc40emr3364991a91.32.1769431724676; Mon, 26 Jan 2026
 04:48:44 -0800 (PST)
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
 <CAAFDt1tjiEXbuChcY73+NYxPW=rB83P4Bks1TPGsHTTqoSzOuw@mail.gmail.com>
 <ed1421d9-f094-4306-ae6d-e07b3a72f82b@kernel.org> <CAAFDt1ukAdXwADuFVoZrs6Ay2fB_sq6LMW5FCnsjqUL7V62mfg@mail.gmail.com>
 <eaf30b60-c0fb-4cf5-bc37-274faa187734@linaro.org>
In-Reply-To: <eaf30b60-c0fb-4cf5-bc37-274faa187734@linaro.org>
From: Saikiran B <bjsaikiran@gmail.com>
Date: Mon, 26 Jan 2026 18:18:33 +0530
X-Gm-Features: AZwV_QiImwHoTrhadZXSVk9XMUduYaFg4Doi8X11Lf0vWvPz9vytxnHCfMsQkoM
Message-ID: <CAAFDt1tgFf5MQcHm3s5DJEDHDtbTfj56_0-=fTz0ekDjSqY3CA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] media: i2c: ov02c10: Keep power on and use reset
 for power management
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: "Bryan O'Donoghue" <bod@kernel.org>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, rfoss@kernel.org, todor.too@gmail.com, 
	vladimir.zapolskiy@linaro.org, hansg@kernel.org, sakari.ailus@linux.intel.com, 
	mchehab@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211561-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,linaro.org,linux.intel.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BBD568877D
X-Rspamd-Action: no action

I used a 2ms delay for the initial reset assertion.

Thanks & Regards,
Saikiran

On Mon, Jan 26, 2026 at 6:11=E2=80=AFPM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 26/01/2026 12:24, Saikiran B wrote:
> > Yes, I implemented your suggested sequence in power_on():
> >
> > Assert XSHUTDOWN (Reset GPIO =3D 1)
>
> +5 milliseconds
>
> > Enable Regulators
> > Enable Clock
> > Wait 2ms+
> > Release XSHUTDOWN (Reset GPIO =3D 0)
> >
> > Even with this sequence, the brownout prevents detection if the
> > off-time was ~2.3s (I got this 2.3s number by conducting extensive
> > stress tests on the platform starting from 50ms to 3s. At 2.3s the
> > success rate was 100%. Anything below 2.3s, the sensor entered a
> > brownout state atleast once.)
> >
> > Thanks & Regards,
> > Saikiran
>
> ?
>
> ---
> bod

