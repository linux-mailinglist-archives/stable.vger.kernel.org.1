Return-Path: <stable+bounces-213357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP1oAp4Gg2lLgwMAu9opvQ
	(envelope-from <stable+bounces-213357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 09:43:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68785E3499
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 09:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51BED30BA79C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D0394490;
	Wed,  4 Feb 2026 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmyYo5Yc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56731394480
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770194276; cv=none; b=QSZvL8O/3LPS3C+k8XOTingx8q3HsuZp74FwEaS+eVy1OvyEA5RufuKlYBbfHSfK+Qeafp82GE32F5AiOGCPd1bjrEt+hK9D0xzwIoavKvFm/PGMWMws9dO8yTXYEVDegdI/gACFiOl7KmsX+gX+D3tTSmufxDvXLB81eJMiBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770194276; c=relaxed/simple;
	bh=YdGqnKEXZqPfejPy+MWDZJlt5n9n5NEiIZZsEFwyGbI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h6Dq0/w0Rae2+RuRStpHMXUA2rRv+8S10vSbxlAR2QTgbeYUI/vuFYExLoQXU4pn7mo/PxxW/UHVoOgTv/Bb1aFoyhfH1A9bAYzLbSU1oX+QF6uF2W7JxRkZEhehbGLM9QR3wxiOhKS4HCJBy68Spf7D+m3E+9OaSpL4TT0EUpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmyYo5Yc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43590777e22so4041284f8f.3
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 00:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770194275; x=1770799075; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YdGqnKEXZqPfejPy+MWDZJlt5n9n5NEiIZZsEFwyGbI=;
        b=BmyYo5Yc+5frcx3oQ8iRzs7iSTpsXLh3VAmvVJf6i6XsSgQYrkNjrgtkkMoYpSP/HI
         FnHpHuSxoM7qexfaew2PxolAsGWMSVft7hG1BrF9tkkHubIAuijpD95UOMeETLMir3ZL
         5tjxePJimm8JTGZOcYiRAvGKCOUFgJciqumH8CaZLf+s5YOJ9AsFTgfgQmZqRCPf69xf
         TrPw7uEz525z5ySMLttoESHqeUnQw09eaCUUrQifgWhioU47YoXlT5jb/nQuKOsmKKle
         x6ETjMfPJRMKeKZjlb2CkFKJZO3mEnyBBqVOcr3iju16J4x4f7ZZgudvfzcbVyDdZtLw
         KYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770194275; x=1770799075;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdGqnKEXZqPfejPy+MWDZJlt5n9n5NEiIZZsEFwyGbI=;
        b=t7/FDhaGYFOnSkkfGVkdRswOrqmKcookZe5pV9g9A4aQ1zcjtpWiSQrr5V75kbw5Nr
         Niw53Mwkj/d/MfHlqnACe+Pz/hKaHr+CpjCQf8PCiCiqaHROQq1hHfj4f/R1KAFMOu4x
         r7oGKjmNxqGmI5TW4wpXEw+FwDaYtpvTHITH+P/SP7NArzP0+n/lsjshie8FtT3nKdw0
         XA1o/KrQaCceOTgVtyRDwDcNsAcIt5z8J9/QG7IhYn1jDMOydynqsKWoxWMLJ9PBw319
         7yS62kjTyVCVhjFZyumX9FHhrh+SGA+YCsWAyJcYJgcRjUAcrNeq1/BqXfxLTzdU+q1L
         BQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWdYrfjAsD+8ETjcrmTOoig7cD4oaea8GrKdxjMdm7BwXA5LVJOyqCVgQzn/P6hN/T/Dv4sTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwINwXh128fvPmJFjnEWnScMcmYPHHES5jJ6aic/9p5GWT4+fru
	mWYd/9ridTLOcnlOa482Bxb2F3wBKBbfcamC2PQynznLqN+uv2mna3ph
X-Gm-Gg: AZuq6aK6Kr/EdxOD0d/zO/nF5tp9i/KHUDRHVf+zxhtahELMTT1qJVTb33CRx2vL3DU
	Vtuhr1MRQJ8NRO1c8sEqPzOnjoBlxwdYQrTDPsONkamc2MLDcKhgXBWl0DANYkk5nCSjEELfNzu
	6m6Q2O0ZjO5GZUrD4MGd4uUOju3AEGhoLJ3wMjPjT8j3XR+0DSU8GdvR6XeFheC5tVezXtE9IN2
	taLJFlgvS76rZxvzcvCYNEwnshNZAszqzwZH7niloKmDWwP3hc6vnuZpQL5oCJsN4uipeTUuy0H
	VuXf7gf1ui/HWJLjM8cci2gJLCm1XbOq5kHrgKX7drg2Au9BoBldz3MS77RFBiOu/X3Y9mvNth0
	gUI0NSlALR+hv9l+98oGVfVKv8gosY0vU0M34vtc9VRDzOsXYGh8n3Sdo3pAirwtqIz8o8uxyO4
	/L1Wkj4KZmDBexpw==
X-Received: by 2002:a05:6000:1885:b0:425:769e:515a with SMTP id ffacd0b85a97d-4361805c0famr3038165f8f.42.1770194274302;
        Wed, 04 Feb 2026 00:37:54 -0800 (PST)
Received: from [10.176.235.211] ([137.201.254.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e38e38sm4832086f8f.11.2026.02.04.00.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 00:37:53 -0800 (PST)
Message-ID: <a729a7d1b63d0b7e78806bfec238d8db2705c693.camel@gmail.com>
Subject: Re: [PATCH] scsi: ufs: core: Fix RPMB region size detection for UFS
 2.2
From: Bean Huo <huobean@gmail.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman
 <avri.altman@wdc.com>,  Bart Van Assche <bvanassche@acm.org>, "James E.J.
 Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Bean Huo <beanhuo@micron.com>, Can Guo
 <can.guo@oss.qualcomm.com>,  linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 04 Feb 2026 09:37:51 +0100
In-Reply-To: <CAKTNdwG_RycHp++Z++D5HzcybSyQwvKbb++AhtXhNgE6sOoThQ@mail.gmail.com>
References: <20260129-ufs-rpmb-v1-1-691534ab723f@flipper.net>
	 <8149b8cb5a7b36a1543ca05666f33a6373674e0e.camel@gmail.com>
	 <CAKTNdwG=He3iJ8cPo4fFbcEwQQRrt_SGzoviMhi2a3kMXAO8hA@mail.gmail.com>
	 <ad7e2d0e5b219b4b2ef2aa7ab342513a2c66171f.camel@gmail.com>
	 <CAKTNdwG_RycHp++Z++D5HzcybSyQwvKbb++AhtXhNgE6sOoThQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-213357-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huobean@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68785E3499
X-Rspamd-Action: no action

On Fri, 2026-01-30 at 18:49 +0400, Alexey Charkov wrote:
> > > The spec says it can only be up to 16MB maximum (see section 12.4.3.1
> > > RPMB Resources), so it should always fit. Happy to add a comment abou=
t
> > > that.
> > >=20
> > > Best regards,
> > > Alexey
> >=20
> > Hi Alexey,
> >=20
> > Thanks for the clarification on the 16MB RPMB limit - that addresses th=
e
> > overflow concern.
> >=20
> >=20
> > In your above operation, why not use SZ_128K to avoid the magic number?
> > BTW, please update your comment.
>=20
> Good point, thanks Bean! Will amend in v2.
>=20
> Best regards,
> Alexey

Alexey,=20

did you send your new version patch?

Kind regards,
Bean


