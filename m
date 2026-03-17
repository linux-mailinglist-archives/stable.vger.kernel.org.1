Return-Path: <stable+bounces-226902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJeSEsi9uWnJMQIAu9opvQ
	(envelope-from <stable+bounces-226902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:47:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9E82B261C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EC92304B71E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2021238A732;
	Tue, 17 Mar 2026 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gNoejq0Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6A5346AE8
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 20:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780421; cv=pass; b=ri0LizaZu3at0gZ6c5jKCEnpdc2GSQlSoXISNjHcJ5WxPIlMNStcyjiPHXH5mT3s8RJJpYqCSV8sY8zw3r811aBvyjk4J47gWeV26Q064OvgaQolXqb1+w5OIuTy992j5DbvZCtFJwEG7c98MLJTHBdWyNd0T/Dxjf1+IZQNbX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780421; c=relaxed/simple;
	bh=1UqOfPikprRq6BleZK7camV+7IT1c8k2nbOkIlVFbsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATfZwJjGCRD9MAeN9kSQLRpcuNVlbJs15I589l3I6sMDP/yIlrfRGslvRojSBIeTd69R1BLdaH/KPFFwmc7GRLsHNQDr/RUSvKOefLxKhbHcbtEXUvF3kennrg6LfwsJqW7Sya/kZCXH7ZepTSS/FQWbIV+jdtDZKiof2b3S6RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gNoejq0Z; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-509069a7a7fso163281cf.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773780420; cv=none;
        d=google.com; s=arc-20240605;
        b=fMl7NyLP6Ruzd3lt2ebuRZQNBArm5GRF0jDw7Fbxgp+RL911VB1zdixSXtYjnE/J8Z
         SZ5vhTJPc/WtljiYTzgCOxTDfrY9eJulJmREAv0TUnWk82JYg0P+L/T2Dgs9xqHgklP6
         eCVio1zLRtuPqJA+pajGmmoz8RExxbv6CFcF6K2n9PWdRN/P/fMxaJHw6+ym+Zzwpupo
         4bV9coJTjWBdurtYFrt1HtCAebv3+SJ09hU13hazIEwBPBNcIuo8UkOLYy7XTCC87xrS
         xSPbDeo28TU+s/PcAORh+mIbaPQBK5kuOmtzZx9ZOYrraBsl/jDDyYRbuBOXjy6Q90/X
         t7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0g7Ha5KuBuAQFnpUh5T9xFIsqyLN9o7sep6G8COfJE=;
        fh=CVatutRDrtbBj1Nql4DaLaFEVW29aX+y7PHp8gKg71M=;
        b=Bz260uWs6LjTERzNz66cn+tZ4mIO9NZpmJLsbeuL9jlfPnLDvMUGti6MIQX+DL5kxN
         e4dIx1WIZIxbIybkWRDPOSouPWthOgCs1W2S405To6hmGjKcEOTIZd7F6wy2dw+CLaka
         NU7+Idl9FCwUoBE+GJHua3Yn5BLCPTFtKU5aDEz3d+6Z+gj+vImpBmRr1c89V74H3j6f
         RRWkQ6ReTvZAwKKS1h8moXPDhLAwBLYHr+RatuKPR5XcwJffs5JKc+wyZKShPlFOJjNA
         bQGFjWRzz6XA/1dOFZMJKnIu61tXsjR2rxxDRIG6EQvLftS5WTOFDck6RhVVlS3+I2Mm
         UvZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773780420; x=1774385220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0g7Ha5KuBuAQFnpUh5T9xFIsqyLN9o7sep6G8COfJE=;
        b=gNoejq0Z+ZXNvAA5pW0oniBO5yuME5HQ4XIGsvFBArbL6ePhitEA13RlgvbVHhnius
         7MHZlWHdtLf12aMb0ljZQrWB/qFRoHV2husE81T4bo0KgkKQ3wqL3yCoAcowpbfTaQ4N
         X6l7i4bnrz5MPK6jvOKNbTkxt/kvAdCEMqTS53dHJT53XtUP3ddwHX/eCDHN0u6rRiV8
         NEsLPevI2mYkTBz6ffT6IdAFpSat0CPqLogKNVOCD7WfLv+mg+DAcOsalGjeu2bspjIU
         mDISn5QbIg3L1wWUqPqQzm1N9jvUttl/zxV9RvE1+UfJgnGL6/JItzovDUcvRMpx8Qol
         RAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773780420; x=1774385220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U0g7Ha5KuBuAQFnpUh5T9xFIsqyLN9o7sep6G8COfJE=;
        b=BUZMCsPB/wwWvZwvUNqByHMKw+/SuxlBRugoBmwrdGFcWVliq4ZSjhz8SyhbPJ5YUZ
         pQTQS739aRvX0gxfuPm6On1HzEy6ICpqSjwUBEt3uYpNlC3Xh7DFHl+rAXHeuH21uEwD
         OP0FzBU8UhP8LIAV/Xy7KsPy9u3cJRCUceyAC0OUkhaJLu5RcZ4GZuoCmk7sWnUEHAvM
         Min7QNZYqIcfVt5DHu19dKFnHg0tI59AuAH6P09OPQyUuzCs5JBwBHfeRtYnx3JnibKI
         S95btqzqCaMLDdTunjSmfuNOyKPYY0AxvJoTdJXvWpFY8xJiqSFfBhhqlRs8/pECc9Iz
         x2yg==
X-Forwarded-Encrypted: i=1; AJvYcCVx/pgpYd+pqoyw1Df4KZ1c5k31Tc7+CPpmm0ntZpyVZXogx9e01+qz38sJniBTLHeYGwptHB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTP19okFggUTpNDPpmDEjT265sESAd7q9O0B6OLOUVjoK3iuA
	sFWZfNd3f/Ss8jWJVqAw8Hq603WMOzlHO4PTgCy2KHgIuYWVNNyghBYKY8oY5d1E+pwF9yvYS/2
	weLi4lzCZJNTNjVhzygNtyBQQ701VnoTheP8lHNU3
X-Gm-Gg: ATEYQzxEC40+hQzV/otxb30qsg5ttrv4TTg7u9uOWwBQC1NUnCcDTZyToZhau/22Cxs
	7dNuKbsRWGn1VQf5okv7auJFARa6N1DP8aEHNRrxfxIIv84jnDWwzTnXLL7FVn7wE46WXgocLRz
	VgC2gFI2RWds2EpOPxvGaBE7s9vHIgoT3u3WsI80oB1La6zkIhaUmoLUxlewaYIgYMsLwF8zEpt
	li1z9CErTwUZIhaJ6vtOxVwYd0K6JEN+Iq1sOBB2enBBgILD/QpgE0WZ58QB0yy2mPpsivggQTL
	pu36DQ==
X-Received: by 2002:a05:622a:452:b0:509:25d8:9991 with SMTP id
 d75a77b69052e-50b148afba4mr3544991cf.16.1773780419110; Tue, 17 Mar 2026
 13:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309022205.28136-1-guanyulin@google.com> <20260309022205.28136-3-guanyulin@google.com>
 <2026031115-unboxed-spouse-1dcd@gregkh> <CAOuDEK3k6nyiHxhcL1kv=QNQaZMF6ms=sLerSZ5JBc5WBd7nAw@mail.gmail.com>
In-Reply-To: <CAOuDEK3k6nyiHxhcL1kv=QNQaZMF6ms=sLerSZ5JBc5WBd7nAw@mail.gmail.com>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Tue, 17 Mar 2026 16:45:00 -0400
X-Gm-Features: AaiRm52oebfHWYMuJ454hQral2Qma88MIrRh798G5MT3B5G2QN7X35-2OnybgKY
Message-ID: <CAOuDEK2pyt4nKWxXXwtzgRuP6u9kvi_Joe8Ec8qDDHVzSue1rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ALSA: usb: qcom: manage offload device usage
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, perex@perex.cz, tiwai@suse.com, 
	quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de, 
	christophe.jaillet@wanadoo.fr, xiaopei01@kylinos.cn, 
	wesley.cheng@oss.qualcomm.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226902-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,perex.cz,suse.com,quicinc.com,kernel.org,arndb.de,wanadoo.fr,kylinos.cn,oss.qualcomm.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B9E82B261C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Wed, Mar 11, 2026 at 5:31=E2=80=AFAM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > You have multiple levels of locks here, which is always a sign that
> > something has gone really wrong.  This looks even more fragile and easy
> > to get wrong than before.  Are you _SURE_ this is the only way to solve
> > this?  The whole usb_offload_get() api seems more wrong to me than
> > before (and I didn't like it even then...)
> >
> > In other words, this patch set feels rough, and adds more complexity
> > overall, requiring a reviewer to "know" where locks are held and not
> > held while before they did not.  That's a lot to push onto us for
> > something that feels like is due to a broken hardware design?
> >
> > thanks,
> >
> > greg k-h
>

Hi Greg,

Thank you for the feedback. I understand the concern regarding locking
complexity and the reviewer burden. The usb_offload_get/put functions
track sideband activity that runtime PM cannot reflect. This is
necessary to prevent the USB stack from suspending the device while a
sideband stream is active. Ensuring atomicity requires orchestrating
three asynchronous subsystems: System PM, Runtime PM, and USB Core.

To address the concerns effectively in the next iteration, I would
appreciate clarification on your primary concern:
1. Preference for fine-grained locking:
Using USB device lock ensures atomicity across these subsystems, which
is inherently a device-wide requirement. A fine-grained approach risks
races during concurrent software events, such as a reset occurring
during a runtime suspend transition.
2. Preference for improved transparency:
If the coarse lock is acceptable but the implementation is too opaque,
I will refactor the next version to be more explicit. I plan to
include device_lock_assert() calls, __must_hold() macros, and add a
"Locking Hierarchy" comment block documenting the vendor-mutex and
USB-core lock interactions.

To clarify the "broken hardware" point: this isn't a hardware bug.
These races are triggered by standard software events, such as a reset
occurring while a sideband stream is active. Please let me know which
direction you think is more appropriate for the kernel, and I will
refactor the next version accordingly.

Regards,
Guan-Yu

