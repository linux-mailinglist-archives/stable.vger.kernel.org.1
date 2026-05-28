Return-Path: <stable+bounces-255075-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE1tBJiAGGpPkggAu9opvQ
	(envelope-from <stable+bounces-255075-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:51:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6645F5E85
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BF5C3028C81
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91D3400DF7;
	Thu, 28 May 2026 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HrnYdSnX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF13FF89E
	for <stable@vger.kernel.org>; Thu, 28 May 2026 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990462; cv=pass; b=kWNPV+Sg/srX9FbYxiQbNE/BjopVF6+NdDIojjZMn/andSqV9HEvG/WKofX7EF/AaYRFHIZ3Dh8WQD7/cefhMqt26aN0VQtvr646SLOPAJrztwCajrjEFl1o8rkHkwSmMmKaO8Rf+XtixAxMbkmFgr9wgYmOg+cKNXykKo/0YgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990462; c=relaxed/simple;
	bh=QWHLfs/Eq9tDeq2hRYOytIYbdk/RxDqBU7SICM+C9U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO54qAdttkulmF4mSQm2Ga7S3nn3pjP0hAI3Xwlom9j4XyrtIW3ZKqPgGPk7GxW5h6EZL8L3dXJW9Xzvt0baRO0j+yVPssFiMg29nXw5CA7Ip7pR1QFpPQCdylsICeJPhlBO88yTvTyskoU6Yazu6Z86QRYHxKvE8nT7fPGD7iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HrnYdSnX; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso350a12.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 10:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779990457; cv=none;
        d=google.com; s=arc-20240605;
        b=iW1IQyVk56XOMfxGhWx0SSI0ArRRyOVe7ABkDjo5MHnjBa3aMUH3bP9OZigRukiaax
         Cly6R/MtaDWzudW6OWUci+8Q59Fh2U3FCb5aE883kZV2aFgomIIL6mXLX+Fp2jlTJ3gi
         wdMnKwh+OefU0Oi8nn3+JpsOy+Np6I4gAKhWByeKIkL2fb+lsE0kqhu/LnqqL+Asq+f0
         SUWT8rGESBuej52p9bdvUbM2Y8xJSsscSrRYG3YdAD0SDzIoXjD6Uq3sX4Ot7mKY/t6p
         RW9o7oNXADFaOs9JDpIub4KWXQZT7ZAdIeMgvW10PpBWtdhWIRxzIqX9M4weLmDGgj9L
         +r0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=321AUgJV4TFOEKqtHN6Q4iDV/CmVBNSkyJCx3erVaFI=;
        fh=r5fts1a4Gpr84PMM9dA0mCYQXybGgN42jjiVcxhUQP0=;
        b=QU4SYSpQKX8IrBUnFFPLIvHrhGRRV3vYIq9vGMIVkJaLO1OoaJu/ooGIekwgGUDEpC
         XtBbKSlX0GAH7Jk1iq3Q45wpbO470pwGCX4A56Y/tXgREwRVVykpVSi4X5cN/U/8fVzr
         AdAn9WvW8NZ7ZG6jOKKIoS3DML+XyCN440tdxCtZqi4O8XqL0ZsInkV3fV61JMSFc7FW
         SMU+sUJAGwJfWR5kWeNtgh4e5YFBUTb2cgB1rAKa8vjsj76Vs+K9a2gnP41sBFgI9qVb
         EzNZFtwTVngmFGpzXwklAQ2BMo3csh4z8A64jFwhqMF2sSXVzEF54tX/DKFPf0SpzzdQ
         qioQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779990457; x=1780595257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=321AUgJV4TFOEKqtHN6Q4iDV/CmVBNSkyJCx3erVaFI=;
        b=HrnYdSnXri30EaBI4RbH+FYpZKHqcVTM8pcG36BjeAt+P6U59Bm0kc+6fg5HNz6rug
         sUJNKyiZOmqj3TrF/IIcHeEj1yxYlb+vunPocySVK3zEKVTSscp9lbfnGI63H27UyRUx
         V17VmS/ntNieYK69PsY4SqPabUYTkKDX6rOgWxOCS0KeMPj3pMra8rNKACHaAc9HT3VK
         xWXYEkHlwFANX53TLvpWplKP68fEQGhsZnByfBBf0agfNg6AiSdPpM4rHExZMvmHqSWy
         KZgcQv9F6uawyJwQ5N0E88oi+S6acgTpJa9hWyjc2S/KseDu4n0zl9+RMEay9j/fXH72
         Phfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990457; x=1780595257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=321AUgJV4TFOEKqtHN6Q4iDV/CmVBNSkyJCx3erVaFI=;
        b=BPEY3Q5VvhGdn19KOlDPp2PPiT/lXIChaQoizHgUea1GZ/Ad9oLciqtrwXdPwPkjK3
         RLR2Om4X1LtHeUs7glpdPMehUx9BuHZS0ZroJVtpmIvIzKCPPTX3iaEZUnCF+ybM3ra5
         sqtxFVB8vv4KDzQt4RwOecqjHkOLyuqD1HFmX7eeRq1GL08lhFltlq2IEvWB1qOPP2+/
         Vdllkt517KvR2l2DZ+IRdrHVjKzymfsK5jKhwmylYuH55RAMYQ1JtWfXDi1ec3ZDTCPW
         Ybx4nvgyIKRY83fTbTjeNAepYgsG6mIvE3TY5HuNNyLkC27V6t4eIkiaXT+yBsNyb4TU
         uLiw==
X-Forwarded-Encrypted: i=1; AFNElJ/KoWKju5xIVlurwy0xy2gjj7SZfSmNh4myZFKrqmOAgfektK6GUVwDh4TFNQ9yS4Tx4W2qby0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9OyH79cHj2LCamqXHiD+JSkAeHYOdxh2GOr1eHHAJOSjg3Knr
	DMzPMwJVRFMyNk11XTZ5LSC7Tj+WffitD4oqpx9JfL2KfAMI8AmK52rUN5bbg1W72f0KWiqchjf
	4XYdmUR5GqcCRXd5fp4fS5kpDsip4wCiQquNUflZJ
X-Gm-Gg: Acq92OEwrIS/PeTj7SotimVHH4PZkJQKE/hSRDtOya9iDRpHzocnSbbIbaGtNx0AYbm
	aUUgMEl3NJ64Rl86lte6z59/l5xZyoXTwm5Qshe2sp9ZefWPTaUJaAo1kJXoiypiT6g1oumJHDC
	GKmOzXJiPVRRCFJiiu1Lhe6NS6c+87y0wNAZYqRvBpNBvXhnL5XTZL7GyssLjnDmJlyg+u9+WoU
	I7YqU4TiK7oEstlRSmw5qxVNxc1Z025Wi9+qX3oqNI05psLdIQQO1Ap5tf/4AanGy3pv/yIWU47
	eSoGBxcmt2VlYQ2YkA==
X-Received: by 2002:a05:6402:887:b0:67b:7d05:60b8 with SMTP id
 4fb4d7f45d1cf-68be8477892mr1550a12.10.1779990456748; Thu, 28 May 2026
 10:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421192205.7CC1A7D9@davehans-spike.ostc.intel.com>
 <20260528030604.2669758-1-jmattson@google.com> <089e8bae-73c6-47a1-a046-6ddd8610d21b@intel.com>
 <5b53ec55-67dc-45f7-b960-69bab3d38750@citrix.com>
In-Reply-To: <5b53ec55-67dc-45f7-b960-69bab3d38750@citrix.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 28 May 2026 10:47:24 -0700
X-Gm-Features: AVHnY4KNnwTlO8P-LCG991jWtE6nTq-blTF7Z93wX6YuBsZpRw4Ez6GDbXZo1As
Message-ID: <CALMp9eRpFOtFtp7fp7PC1+gUgx2GyRCRx51gS+ScNvcW1uifHw@mail.gmail.com>
Subject: Re: [PATCH] Handle Ice Lake MONITOR erratum
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Dave Hansen <dave.hansen@intel.com>, dave.hansen@linux.intel.com, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, 
	rafael.j.wysocki@intel.com, srinivas.pandruvada@linux.intel.com, 
	stable@vger.kernel.org, x86@kernel.org, meenashanmugam@google.com, 
	eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255075-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmattson@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:url,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7E6645F5E85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 9:03=E2=80=AFAM Andrew Cooper <andrew.cooper3@citri=
x.com> wrote:
>
> On 28/05/2026 4:36 am, Dave Hansen wrote:
> > On 5/27/26 20:06, Jim Mattson wrote:
> >>> The erratum is called ICX143 in the "3rd Gen Intel Xeon Scalable
> >>> Processors, Codename Ice Lake Specification Update". It is Intel
> >>> document 637780, currently available here:
> >>>
> >>>     https://cdrdv2.intel.com/v1/dl/getContent/637780
> >> The erratum says, "Due to this erratum, the processor may hang."
> >>
> >> We are seeing some Ice Lake Xeon E5 machines panic due to hard lockups=
, and
> >> then the kdump kernel dies with "Fatal machine check from unknown sour=
ce."
> >> Is this behavior consistent with this erratum?
> > That sounds like something different to me. I don't remember machine
> > checks being implicated for this erratum at all.
> >
> > My usual rule of thumb is that machine checks mean bad hardware unless
> > there's a specific and compelling reason otherwise.
>
> I agree.
>
> The symptoms we found were a hang on boot while bringing up APs, and
> there were no machine checks in sight.

Thanks for the confirmation!

