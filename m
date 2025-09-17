Return-Path: <stable+bounces-180386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33E2B7FA78
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 16:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F5B619F0
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C0132E735;
	Wed, 17 Sep 2025 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="fmGapKok"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173B32BBF9
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117249; cv=none; b=Inu90ZzrCZFPBYER+uq0PXChK7egc86RXPwmiv8MQSG1mXL2g4U4vDyHeEZW2RQzKA/Ki11E3x5viwyuAakT7x4NWwe7gLL/6z5c2UrxLHMOPGf3QqzpYFomsb8qcbV/tQoTdTG22xlwFxp1kRLnE3ku0ZG0AneJJSj2Cl5NT6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117249; c=relaxed/simple;
	bh=nV1QrshvRehJ/eXBSMMeuT6hGEcacS/VSfv5Aahy3qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYty0OYvzI4TRWLGd4C69PlcKPT8BvPAVWbjK1hvpP5Qx/CUfaGUYGXobGvtZ9wsfmKVT9j/ZdFWAsplHLS6DFhb1ef7kqNIbvFGQqoSgkF1MoULJjjA/Qi7dLBKiny/HmVESnnZW1dhJgawK8fCYC0D9yjUn7dlmHyyqZhglWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=fmGapKok; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-827ec18434aso436153985a.0
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1758117246; x=1758722046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=to4BXgFyFuRjiSPORVXGshM37diVDi0cjrsHXYAgKmw=;
        b=fmGapKokLz9Fcmrm+nnUjiBmvailZKN+eXBViNgThFZcWW19Vmx7mlOTKESzUXi37B
         bs07Bfpv0vPwxX87e0/CVX7SE+rfHLbUu5LhZfHHxpBsWZxqJzUD7T1FQKiYBcELbr/3
         tycxPy/BbxgZyi/OBh0MXs0wciy4FKRW0kBEXz6oAralAR8S31KhPOUKqNhM2flGyjZM
         mXgAR0E2WSV7g6k3isAoALB1kzYFjlEA3OCIW6LBLdyOdKzDLffiipLxAO6PbpeHufyJ
         vNbUOvar8vSc+A/xmQAycFDBypO9mTF1YRVvfp7sTLCP9qeXVh5hmitRiypaZHStkKYg
         zQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117246; x=1758722046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=to4BXgFyFuRjiSPORVXGshM37diVDi0cjrsHXYAgKmw=;
        b=lZfy3VEKjLs9jiPG8p2Elvcewi4MbsGDQLYhYcor7737QrZJC9JQI/WMlMiRAiDGKL
         mbFMy3HINEA/tDp7SnNS7EeKJhQmXIEsBKtdoJGbp4nK31c4zxIS7xlUqMwtKiYfvH5x
         qFqYZo8Wzl8mC06J8C+5kSLgE48t7ylP/KaPCfmGBAMYZIHg9RTGZFZOrf2RHBztbtEN
         kdVJ/sKJjUgyHWn4QaIxf0aBmwEqXYjhejubty4lq3SfJVc3+SJa7OfDt9FJ/70NKA0j
         GyVrSvk4nK99ZzfIypjQeLN+4wf8b+ojrB96LIWpsEbOr99p7ProX2f/TeF2hdLAeaPE
         bEJw==
X-Forwarded-Encrypted: i=1; AJvYcCW29fo1D8GVx3iJ2pfpC2xrFy7pRIlYfx+mH1hDKa+u4fpFEHxenbhcFhdS8ZYhCFnAf+eKEDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvTS8K7bmYuHvn5+vUdrUyrl8AdZjqFuXbiurC6yIAZnnlq1GP
	VfHpSRwL+KeuuoVyDaTUPVPmTUWx6RhSdIzT1TTE8Expz2t3qjCo1xJKs7nO3InvAw==
X-Gm-Gg: ASbGncu5eo5CMuu6TTLehDjpArORFVVF+aP/8LgceSmxQP88tZLJwpdFjkKqo59j/iW
	iLAfjFQrY8gEBZESOAnua7nUkhnYxYTWTIYAz7y2nFBL2HJVGrwP4EJCMlEChkCO4oZs7bktooY
	qw7G4Qd8227FWSBjYYC7Gl/65uqYdQwx0fsri58tDWypt8Nytuk5hIMzkZzFesinhcTy6MRk1fn
	ogOK5OfVnl6qxf93fTKQmG6Tu2YFno0VjJ5U6CTMmxzwybzLLOFVQM1RPxqLbJkyIOjSsqO12pW
	yCt5BGPW03ceicKArZ07+Gq3QhKQJi5sIYNLVKQppf3+7m9+8VT0+Onqn8mh0XAfjVOcBivP7cX
	UNSM0PM3UGFf0vtDQIk7wm0sLtEy+3thu8BAdMQUw9zwaMNkjQvm5c5hD
X-Google-Smtp-Source: AGHT+IGRBja0r5jLJ3qHXTLicrQ5EPV+1Dbg2srLDJPVrFlUWF3hlqL5YtcEGgwOtuhZt3aFjNDHDA==
X-Received: by 2002:a05:620a:4009:b0:817:6fe8:dabd with SMTP id af79cd13be357-8310b59ae28mr257079385a.28.1758117245776;
        Wed, 17 Sep 2025 06:54:05 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-82b15c2202dsm372471385a.55.2025.09.17.06.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:54:05 -0700 (PDT)
Date: Wed, 17 Sep 2025 09:54:01 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Russell King <linux@armlinux.org.uk>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
Message-ID: <c94af0e9-dc67-432e-a853-e41bfa59e863@rowland.harvard.edu>
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917095457.2103318-1-o.rempel@pengutronix.de>

On Wed, Sep 17, 2025 at 11:54:57AM +0200, Oleksij Rempel wrote:
> Forbid USB runtime PM (autosuspend) for AX88772* in bind.
> 
> usbnet enables runtime PM by default in probe, so disabling it via the
> usb_driver flag is ineffective. For AX88772B, autosuspend shows no
> measurable power saving in my tests (no link partner, admin up/down).
> The ~0.453 W -> ~0.248 W reduction on 6.1 comes from phylib powering
> the PHY off on admin-down, not from USB autosuspend.
> 
> With autosuspend active, resume paths may require calling phylink/phylib
> (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM
> resume can deadlock (RTNL may already be held), and MDIO can attempt a
> runtime-wake while the USB PM lock is held. Given the lack of benefit
> and poor test coverage (autosuspend is usually disabled by default in
> distros), forbid runtime PM here to avoid these hazards.
> 
> This affects only AX88772* devices (per-interface in bind). System
> sleep/resume is unchanged.

> @@ -919,6 +935,16 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
>  	if (ret)
>  		goto initphy_err;
>  
> +	/* Disable USB runtime PM (autosuspend) for this interface.
> +	 * Rationale:
> +	 * - No measurable power saving from autosuspend for this device.
> +	 * - phylink/phylib calls require caller-held RTNL and do MDIO I/O,
> +	 *   which is unsafe from USB PM resume paths (possible RTNL already
> +	 *   held, USB PM lock held).
> +	 * System suspend/resume is unaffected.
> +	 */
> +	pm_runtime_forbid(&intf->dev);

Are you aware that the action of pm_runtime_forbid() can be reversed by 
the user (by writing "auto" to the .../power/control sysfs file)?

To prevent the user from re-enabling runtime PM, you should call 
pm_runtime_get_noresume() (and then of course pm_runtime_put() or 
equivalent while unbinding).

Alan Stern

