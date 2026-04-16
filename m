Return-Path: <stable+bounces-238277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMIFAxOm4GkEkgAAu9opvQ
	(envelope-from <stable+bounces-238277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:04:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E0040BF98
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3BAE303FFEE
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C68393DCB;
	Thu, 16 Apr 2026 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOFGGHvV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34E38D693
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329959; cv=pass; b=By4NiEjrKSEjY5dTl66RZFJDnYG0vIIiMeNWf2Hk+fypv+bGQL0ojWJtZ8ieh9OgkT1OlQ+hBFz829HaOHmxgmL6W6bKAK5deXcKwbRiozVNP8x9WiPN8tl6gZZJBvbr5hI48y3Jj8utc1DOhUArVEWlyd2ArorTPbJGQEFtgQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329959; c=relaxed/simple;
	bh=5mBmmllB5S8fgsehiq65Oyp/IPuXw4X4HH7VTt5lbQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxS23avSoMhNc1RsJfvnNS73Ttv9NTcwE2eCuVZcPUHIONKy07yW6wUvNXIAE8Q3kgf5lrv7FTwG6HfU6peYlhVnkuq2NYYDXd9RjLvvOhafc75m7oyXBNbYQIe9/1lov6XDDglv1pCr1KCWDgoYTVWwL6cXxBHVmUTUDTU+W3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOFGGHvV; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64937edbc9eso6852121d50.2
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 01:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776329957; cv=none;
        d=google.com; s=arc-20240605;
        b=Njb+fGENDkSwRLR9pUW6XQSHKir/VkgW3ouZsOgGWJvQbOm8Wv5eZQ8co24Z2tmAro
         UEciSMnHLsSrj/FAT5SBcqp6S8gXR+cc8zjfL/+hCrNyXggvs8+Yf1eMN78r9Sj2EbOK
         qKe6VN98l6U/RFxoLI6AWwcw+XSPZD68zO9IXMGUIGmbnVJhU8zA8jGkCfqAnxG6bE2O
         met1d2v1hsI98U4v93hXEBG7cWzViGFuNjgzOTJE6j1H9+vJOFB1Yc4wdAKiFiL1QxUW
         jyXMoqmWlOtPxg2v+mT74eqjYjJMNPxBjzD7fwcr6EPYXc1Lik6z8YWb1WRn5Hw5AiX/
         Q/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rHLTvTB9rDNh9jJv6Ebk36+huSVLvHgRUe2zgyE7vag=;
        fh=NhKpJehgwnEjlaNqh/k+v7xZ+2/NiYTsDidtZ8C3liQ=;
        b=j42pFslsqQKWJM3MhFmcheM3IF6PP9WXVowg8gY68PG8DX34ApeFRTCTNzbZJPUwvb
         3EfQCeeg83eeR17d/8Nh+2pwjPXk/A9kF1O9yyCTNJ+MmJwVrv/iA/ixFUtV2R2KSZYE
         wYuNopqcw/ti8yVZiBc5bQc2f8HcCIOHI8mQV0x4FzLZvn7Qx7Dw5xGnVEPSif97DcBD
         07Eju65zvJiztasNCqygTjFKz0Cj82TVICn/iZc4Ktsh2YxgSn7+WxdZg7AvjADAS5mT
         A+pB8ldu8tcfGIlWsQHs9UO1bHEUwBhZqdg5NT0JDdr+d3jlPEz+zNPn+WuPIAdjiqfb
         2C9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776329957; x=1776934757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rHLTvTB9rDNh9jJv6Ebk36+huSVLvHgRUe2zgyE7vag=;
        b=oOFGGHvVKx9vHuDYjmfwePlvGmjRgwVMsqexZz5YV9ZRROlOIxzw5R0canE0s0ICxn
         5P3yv93cWwXI1oMxMRF5INtDNDMLSc4JrIq30Mr7Fu0EclHPw5Ykeyqa6gmWtoGE3+rx
         vEAWMbrD7EAwEPcld77v+xJM5Sk/73H9oHyrwesjVeJuGQsgwz8jd/Nz7SlgwOOsgSns
         stXo/jDaO3uQMBCwof6GM1oOLTGLqUTy2/e4ZHKUrVYuT7+moky0z+m5lu3RtZDUdWAW
         s7qrB1zhHawttew42bwM/RduSrcw8SX8aAir0HD22LYuLSlFWznCeoCOk2/CG0zmoYLX
         Ut/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776329957; x=1776934757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHLTvTB9rDNh9jJv6Ebk36+huSVLvHgRUe2zgyE7vag=;
        b=o9pGN8sNEyj+E8FkIMVZsANMaWGlBDuAUnqKER/hjE2sIBLOD8gnF0/YrHRJldaHZm
         hMG1o1XDbWzhlc5f8usGPkbGQNiZh0A9OyYA6l6Ezz9BK8pHxIDQiqxj0Vas4ZGYBsEx
         ELkJtP0SURq4JW/nx7ZraJUPtECwLjtGDe1HVhSEMDI6AVHWwmNaooCj1tnDkO9/ffre
         rGPGXsrCkRSpKv+Vmrifv3SC2J3VQ6Y83r9cYxzbqDOIezlrV8GBh/NswIcunGQGBdSP
         EbtUZw58qlZq43Fgmt8bHZE3okV3j8cbY0I57qIkxORqd9luiEg6TTmSUti/X9RZJFOh
         TTgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+WCKZFELOtZDalCMxkrCRlmgoKEV+bZomGUK/3qab3dJ+WqfqFrU7hNOwmY61f6sQG6RG9zQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy/brUzxem6Ex6V5bugAgNExcVdTg5q4iZyUPW3a7+qvftXf7o
	FMuKsHT7pgmkYkCrSvBNPwZBt7mAIAkJcHEpQa3yWTtCaBWNejWJ3/rzREigF8E/faqH9DDZV70
	FKIYbK2QadR5uYn5CLcKeRtF3UpXJ41w=
X-Gm-Gg: AeBDieu3b/DPK4vcUBRTKmIYzTxcvmU+qjjVwOn1ACU8NDUZIpU20Nfeg18ZFoS7lzs
	j3JvYa9ECmrQhatSpLMw8JtEs3vQ6QIWvvGYpFBXDiRFGq1bxzGYtTuSKANx32tEfee1vd471K/
	j8AWcT61rJL3MmA8feS6nhpkNuqmTNGMR7T4mL0OLr+0X94ItsaPx6rBLgXjKrH/YMnCd+0LM/0
	3Z34ti4CjloX6Oomy1R1oxJio6c2FFczi+hRSqN1QsDFzQLjm938vU+Qa9UZFSogK4UGv5FvTd0
	wPAEpxdROZXRRikVQGMB
X-Received: by 2002:a53:c903:0:b0:64e:a335:95cd with SMTP id
 956f58d0204a3-65198b427f8mr17307099d50.41.1776329956736; Thu, 16 Apr 2026
 01:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415174159.3625777-1-lgs201920130244@gmail.com>
 <ad_WmuauLJ3xDKqh@J2N7QTR9R3> <2026041603-guts-crested-ef76@gregkh> <aeCOdWLaVpH-5w8s@hovoldconsulting.com>
In-Reply-To: <aeCOdWLaVpH-5w8s@hovoldconsulting.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 16:59:01 +0800
X-Gm-Features: AQROBzBJInu6_sedDTufJcGH_sz0MWfYgc8C0FVsACksumcnkFd7jCyotGqllqk
Message-ID: <CANUHTR9+Z9s3thfKMC5qiLMdYJAo-1sX1g9QiU65OVCbb+mAMQ@mail.gmail.com>
Subject: Re: [PATCH] arm_pmu: acpi: fix reference leak on failed device registration
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238277-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 99E0040BF98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg, Mark, Johan,

Thanks for the further comments.

On Thu, 16 Apr 2026 at 15:23, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Apr 16, 2026 at 06:40:55AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 15, 2026 at 07:19:06PM +0100, Mark Rutland wrote:
>
> > > AFAICT you're saying that the reference was taken *within*
> > > platform_device_register(), and then platform_device_register() itself
> > > has failed. I think it's surprising that platform_device_register()
> > > doesn't clean that up itself in the case of an error.
> > >
> > > There are *tonnes* of calls to platform_device_register() throughout the
> > > kernel that don't even bother to check the return value, and many that
> > > just pass the return onto a caller that can't possibly know to call
> > > platform_device_put().
> > >
> > > Code in the same file as platform_device_register() expects it to clean up
> > > after itself, e.g.
> > >
> > > | int platform_add_devices(struct platform_device **devs, int num)
> > > | {
> > > |         int i, ret = 0;
> > > |
> > > |         for (i = 0; i < num; i++) {
> > > |                 ret = platform_device_register(devs[i]);
> > > |                 if (ret) {
> > > |                         while (--i >= 0)
> > > |                                 platform_device_unregister(devs[i]);
> > > |                         break;
> > > |                 }
> > > |         }
> > > |
> > > |         return ret;
> > > | }
> > >
> > > That's been there since the initial git commit, and back then,
> > > platform_device_register() didn't mention that callers needed to perform
> > > any cleanup.
> > >
> > > I see a comment was added to platform_device_register() in commit:
> > >
> > >   67e532a42cf4 ("driver core: platform: document registration-failure requirement")
> > >
> > > ... and that copied the commend added for device_register() in commit:
> > >
> > >   5739411acbaa ("Driver core: Clarify device cleanup.")
> > >
> > > ... but the potential brokenness is so widespread, and the behaviour is
> > > so surprising, that I'd argue the real but is that device_register()
> > > doesn't clean up in case of error. I don't think it's worth changing
> > > this single instance given the prevalance and churn fixing all of that
> > > would involve.
> > >
> > > I think it would be far better to fix the core driver API such that when
> > > those functions return an error, they've already cleaned up for
> > > themselves.
> > >
> > > Greg, am I missing some functional reason why we can't rework
> > > device_register() and friends to handle cleanup themselves? I appreciate
> > > that'll involve churn for some callers, but AFAICT the majority of
> > > callers don't have the required cleanup.
> >
> > Yes, we should fix the platform core code here, this should not be
> > required to do everywhere as obviously we all got it wrong.
>
> It's not just the platform code as this directly reflects the behaviour
> of device_register() as Mark pointed out.
>
> It is indeed an unfortunate quirk of the driver model, but one can argue
> that having a registration function that frees its argument on errors
> would be even worse. And even more so when many (or most) users get this
> right.
>
> So if we want to change this, I think we would need to deprecate
> device_register() in favour of explicit device_initialize() and
> device_add().
>
> That said, most users of platform_device_register() appear to operate
> on static platform devices which don't even have a release function and
> would trigger a WARN() if we ever drop the reference (which is arguably
> worse than leaking a tiny bit of memory).
>
> So leaving things as-is is also an option.
>
> Johan

I did some more investigation, and it looks like directly changing the
semantics of the existing API would break code that is already correct
today.

In particular, there seem to be at least two different kinds of callers:

Callers that already handle the failure path explicitly after
platform_device_register() fails. For these users, changing
platform_device_register() itself to drop the reference internally
would lead to double put / use-after-free issues.

Callers that operate on static struct platform_device objects. Many of
these do not have a release callback, so blindly dropping the
reference on failure would trigger a WARN.

Because of this, changing platform_device_register() itself to always
clean up on failure does not look safe.

One possible direction may be to leave platform_device_register()
unchanged, and instead add new helper APIs for the different cases.

For case (1), I was thinking of a helper like:

platform_device_register_and_put()

The implementation would simply call platform_device_register(), and if
that fails, call platform_device_put(). Callers converted to this helper
would then no longer perform their own put on the failure path.

For case (2), I was thinking of a helper like:

platform_device_register_static()

The implementation would first install a no-op release callback when
pdev->dev.release is not set, and then call
platform_device_register_and_put(). This would make the failure path
well-defined for static platform_device users, avoiding the reference
leak without triggering a WARN.

If this direction sounds reasonable, I would be happy to work on it and
send a patch, and I would also be very willing to help with the related
API conversion work for existing callers.

Thanks,
Guangshuo

