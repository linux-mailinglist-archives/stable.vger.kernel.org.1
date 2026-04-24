Return-Path: <stable+bounces-240568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFf1AZUe62mRIgAAu9opvQ
	(envelope-from <stable+bounces-240568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:41:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6203E45ACAC
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60D133014C0A
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 07:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DF3332913;
	Fri, 24 Apr 2026 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4vQcc1/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2FE2DF138
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777016463; cv=pass; b=GzkxRovFaqZqPIS47751UD/5AjPIGBjK1r+w2k60Q8td2lkMBnIF4n/kEqkOPppvGNYL4PsUIKT+HyhTJGflwDeo+y8gi6wGluoLC+86Sx5PyDqLocsSwVHiLaQwAO6Wi4JnoZa+LfLmol4v2/S6ptVgBoxQXo1/tyXXeRRCUfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777016463; c=relaxed/simple;
	bh=1rwbJM462mkcs2a4PZtcLRIS3iii9rEHHa3eCFevBXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8D3GSZic9LIsrsLzh0u5+fRjE20wWuPRHpS1OUyTv+0br0wb1y2Lu2CrwCicdU1+uES7cYwta0u6rJunhIDOqUtMF7hy+HvWsYljiOcy2uEecoYthk8GXaqntpThcEEmLBMmugws78MW8ljEfjbQuJEBPpGYWQUFx4djCusNS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4vQcc1/; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-651b4d09141so10170076d50.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 00:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777016461; cv=none;
        d=google.com; s=arc-20240605;
        b=hINie5vVCfAkBm3YQBNeGnYqo+vJC1s6utSW51DAsUZKwBUdx54Jn/0Yy/Q5B9napk
         9cXXT3M+sVmNnuY7zuMjmPa9NSZJEdUy2q2lOTqunEqXvMUYlw0cr1gsa0JmHn2uQyjH
         W8elv9FIyj2miEDo9TOdgoYmztmy+eGwtyn67qsWh3tbAS/Bbw7BvjS0jm0UQpUQK1Lp
         UvApPuXfvJGUIQo7Zzymsf54Kt5xAxZndQx1kokP8icBtKiIQp+Gr06/LiP4cT8cN4JF
         eik6F8DjqxPlc6Qn/hHda2e17+lrIYWSVpB2OkpeaIVmR0RpCpILgl0jsAA6diIVwkTy
         MZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1rwbJM462mkcs2a4PZtcLRIS3iii9rEHHa3eCFevBXM=;
        fh=H5di6mawoscuKC3SHtcyBh/mOBMLLWEXGWh/uqO7Qcg=;
        b=Soqg49JZFQ7rc+LzCwcBuRQ3smcBcX4SPM/yVSEIMoZGLVseskt7Qny8D7MSMO7F/j
         UIYRn5sfKG633v1z4f+IEJFMfy6Qm9T4yglecB8hX5ewr/iHYWNBwR1EoLv1TTxGu2k5
         Mey5T57xSZTjoc/4n0bS2J38UvLGOoeJNp9DWxuIvyGagKKDJJalB6WzoElcyDsv7enl
         6u2nfL3H0aCKym+hBqoMxR32K1Gw+KAkcM6tpivU+5DLqJ54QZoRd7u9nid2R0PFB7RJ
         Fcrduf0Ox6F9ElGZ9O4cmZBGplD3C9/6h53G8leaJC5OE+9wvuJEnWgu965NosO99pzt
         UMPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777016461; x=1777621261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1rwbJM462mkcs2a4PZtcLRIS3iii9rEHHa3eCFevBXM=;
        b=d4vQcc1/uuAq0HuzOYiCC6ADh5RnLzKSe8EYVhn1CQ2Qq6rZGXQk2RrEqDmJyLR7Rg
         5DwQOnOK/OnpIQj21ar01SF1V8gQtmWzzW1TWNHBANCwjUuMfdbB6A9KdTUUXQAedL5c
         BodLu9Wll8nh68u6NqUfDNx62TmKR4kB2yXf0NAu2EgWznfuCWM8fdtg+SYaxM5hjSGi
         PbIAAUKEeZg+7EVl0oFPSsdSAvso8VGyHqaHjtVD4VGatea0srhtIDsUb9cQtyE40CEH
         jd5AMTa+ByHa+wSM2Wz0p8BFjPIvG39kAfiSlBYxhQfIfF8bYCxyKZ1FLubmkAKoXre1
         F4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777016461; x=1777621261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rwbJM462mkcs2a4PZtcLRIS3iii9rEHHa3eCFevBXM=;
        b=aHh+B/XJBAJtzKXlnnm2jY1Q7v/H4/3goKEsygf7XUTUh8UBya+2G/FQKAisM85U9k
         fyjK6zZOr31ua2dm6PM+knOw7XPWO20C72q3Zpb5qfuP9jn1xRFMzKzdHHzDeD4FGkt0
         spradCHNmd2eU6oYALCEr5+RKtGEjLeIZowJjUUe3107evEUsaMN3mqdNqmBqEyJZvwu
         NH58KiPAcHQB1nuivC50Rb+0SO4/5l/E/xPa2LqmVRto2XFLNq2kHWe0h6kFun5EjGUS
         hrjwIrPQ2zxPT4XK4q3RvmAwnQE0HCdHq/02XyH71RofsDSCZKkhjv5MJGXIRxjUhSzX
         rGXA==
X-Forwarded-Encrypted: i=1; AFNElJ9vdoG6Q8H9wZxQyhCzFbln2Vf4e99Tu0pKKmVUY0+6qDflGXRZx0UiDLW14GOuxz/Qy9Wbv0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya966r1uVKkTFQm0iDEFJ5kuo2mcAWYagN8AP5R9BzmjB3pxty
	VVlwQa0DVd118G6GA8xb2IMi9a+nAYj9TFp/40CMuNkdTiJL4c2iCRuNGT/LSYk4dvIWXuugSZN
	TfmbhNRDSGZ1fA+WOm6LMNougABsRdtI=
X-Gm-Gg: AeBDievIbSGuTAUYHbqKsO4lCmUIf3OyZMa1r0oPU6QjO/Dos/YiJdWeshJhUn4L62n
	4p8InzEK06jKfEanm1E0luFuR0nCXJd2I0wwH+9/wWyLsUdd/Keqg062ZIq3Hb3LYdUjgT/Zmyn
	v84uUrfVz3iCwhH6rDkoPrzUb+sSMfZIzUJTdk4mWG18HUtX/HP+5m4bg8s6z/FyMa61Q7G6Aoh
	oNCcEJ0bzji+jvjfALMXpZbSZFWgelzah3U6fJ7Rv+RBSghs2CRcs4CTUwZBZXaMJG8KWXW5Np4
	MxaPCpguW1nyg32IfLfj
X-Received: by 2002:a53:ac93:0:b0:651:bd7e:c04c with SMTP id
 956f58d0204a3-653119c494cmr20614638d50.21.1777016461293; Fri, 24 Apr 2026
 00:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415145708.3331818-1-lgs201920130244@gmail.com>
 <177645836617.906013.5675762942401997007.b4-ty@b4> <897f442d-4e04-4b70-b716-38fd10b8af36@kernel.org>
 <f661cf47-18bb-44f2-8764-c9f0b4fb68b1@kernel.dk> <CANUHTR8W7tz0me90GDci97ee6N+3MpB7uVYYFN0dtTf9u_Ui2g@mail.gmail.com>
 <2026042411-repressed-manliness-4ee9@gregkh>
In-Reply-To: <2026042411-repressed-manliness-4ee9@gregkh>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 15:40:46 +0800
X-Gm-Features: AQROBzD7oP01iGJO03f9pinRfdfCsBQH9AjYJ8PiauZIUw4gABPVYWeiSnqKu4A
Message-ID: <CANUHTR_JwTXpmE_Y6FbDfgqbJgBOjJyjR75ycW7WfLDuTbEdQw@mail.gmail.com>
Subject: Re: [PATCH v2] floppy: fix reference leak on platform_device_register()
 failure
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jiri Slaby <jirislaby@kernel.org>, 
	Denis Efremov <efremov@linux.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6203E45ACAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240568-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Greg,

Thanks for reviewing and pointing this out.

On Fri, 24 Apr 2026 at 12:15, Greg KH <gregkh@linuxfoundation.org> wrote:
>
>
> Can you go back and verify that all of the other patches you sent out
> for this same pattern are also either ignored, or reverted?
>
> thanks,
>
> greg k-h

Yes, I will go back and check all the other patches I sent for this same
pattern. For any cases involving static platform devices or similar static
objects where this fix is not appropriate, I will follow up by email to
make sure they are either ignored or reverted as needed.

Thanks again for the guidance.

Best regards,
Guangshuo Li

