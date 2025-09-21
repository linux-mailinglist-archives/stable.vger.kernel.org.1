Return-Path: <stable+bounces-180822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAF4B8DFF5
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 18:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B7D178D18
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25724C077;
	Sun, 21 Sep 2025 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="WnxYzB18"
X-Original-To: stable@vger.kernel.org
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748C1BBBE5
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473024; cv=none; b=InUD1rq/iP5+TLNEKa0/a2dBMHIKfHihnrUXSc8JvNgj0iGzXXHYGh/CB9pqNOg+TfVhZyIcUzXLXOYTBBm2jHQxJtotJ2hGS2Fg/xmInqSMe3OHzxHCVR1ZoT53Z2uGAeLe5LlGaYqhhrElwlEXnsQc7muOsON7I+D/Puwo+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473024; c=relaxed/simple;
	bh=JCZBbIRGk8mlF/ttSypbCIGUJh5UrAb6g374xCcPmHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dzi3eox7ByeYuxyjLKcXi1F+SfzFpnGmc/Gbqa1nST17ryXLBwhrtfHJSw3b0cmj2NNMfeKd9FQF5/mGLQ8fpp20zi8YwLfn1YlMR95xev68KDRvVOAeX9gHU7Zcn334GEfrr3itrDrmZVh2y9YIaTmAoAodyUnsDt3bbo/an24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=WnxYzB18; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id A0220464CB
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 19:34:41 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id A9AE1464C2
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 19:34:40 +0300 (EEST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id AAA5D1FFE53
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 19:34:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1758472479;
	bh=JCZBbIRGk8mlF/ttSypbCIGUJh5UrAb6g374xCcPmHE=;
	h=Received:From:Subject:To;
	b=WnxYzB18KihvNxEd+v5k6BP/dthhQOHKwu1T+MxWBtMYRrbCNXgqQCvsVwcnoE3uO
	 NDAefPbXk42sEGgWFkQSERBfAt7USiWzidkEHU9sZBg36JjUZw/yhiFa5TMHKutUGu
	 YO40g1ku5IMHkfsP5iR5WNzxMJA9hFAJ5hFcsYJjglLrP6nohAv7xm7um7uvgPk9XM
	 U1+dy3X1LXxduAKwQ3GF9FW77Jnv1mQsUk2hgdKCdUs6q8RNseOeqwz8J1+wpMItlt
	 OjCPSpfYxEvEDgrUmNqqog4vcXr7HcQj1d84UrDaw9tmlDWr6156a4GzOuOzGxefBu
	 zHuIFsNxVLrzw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f176.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-3515a0bca13so47295301fa.1
        for <stable@vger.kernel.org>; Sun, 21 Sep 2025 09:34:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXGM9CI3pZ5E6xa3h3J1aq+UCE1vHI6MnZ9Bez2xgQ146D0wqfv4RA/GhlKXwI0ftlb/+cnAFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymaTzaVRp85ul7CLY5Tks+HYLNaODhSlcKe9v3OpIXpC0+XWJn
	M9xkA4Obv5RrfNHRBWoCwbZDWEQp36hMbb778M2R/W5slG+PHhueYGm2GWciT5Ur0nWjDyanfXf
	nlcBHz7w85mESenPariylLTQo+rdiX44=
X-Google-Smtp-Source: 
 AGHT+IE9o0QolNDrKBYDLL7Lj8Otr6WYMQZVA8zGEljN08JK5V/WBVAY0g4oAk9hgOCgdiQifUB/yLJrblPH4YTKh+I=
X-Received: by 2002:a05:651c:438e:20b0:336:83d3:9210 with SMTP id
 38308e7fff4ca-3640ccc20b0mr27613771fa.22.1758472479156; Sun, 21 Sep 2025
 09:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025092126-upstream-favorite-2f89@gregkh>
 <CAGwozwE-wBt2fiDyFPjX2tR9VySQJyXn1zLtEQFCRHnxNS=fWw@mail.gmail.com>
 <2025092134-snazzy-saved-1ef4@gregkh>
In-Reply-To: <2025092134-snazzy-saved-1ef4@gregkh>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 21 Sep 2025 18:34:27 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwF3SgRG7ZYSj629NOJx0dWSBYH67v_wwQ7WdKOU9cGxow@mail.gmail.com>
X-Gm-Features: AS18NWDq-M4xF2KtccqokjPv5lL-LYtt51wH5AH7EzZWTkrVriydHNqLJpcUpIs
Message-ID: 
 <CAGwozwF3SgRG7ZYSj629NOJx0dWSBYH67v_wwQ7WdKOU9cGxow@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] platform/x86: asus-wmi: Re-add extra keys
 to ignore_key_wlan" failed to apply to 6.12-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ilpo.jarvinen@linux.intel.com, rahul@chandra.net, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175847247990.4161114.15994662743197372745@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 21 Sept 2025 at 18:29, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Sep 21, 2025 at 03:57:25PM +0200, Antheas Kapenekakis wrote:
> > On Sun, 21 Sept 2025 at 14:34, <gregkh@linuxfoundation.org> wrote:
> > >
> > >
> > > The patch below does not apply to the 6.12-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > >
> > > To reproduce the conflict and resubmit, you may use the following commands:
> > >
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 225d1ee0f5ba3218d1814d36564fdb5f37b50474
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092126-upstream-favorite-2f89@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> > >
> > > Possible dependencies:
> > >
> >
> > Is commit 1c1d0401d1b8 ("platform/x86: asus-wmi: Fix ROG button
> > mapping, tablet mode on ASUS ROG Z13") eligible for backport to
> > stable? If yes it fixes the apply conflict. Z13 users would appreciate
> > in any case.
>
> I don't see that git commit in Linus's tree, are you sure it is correct?

Sorry, I picked a hash from my own tree by mistake, it is commit
132bfcd24925 ("platform/x86: asus-wmi: Fix ROG button mapping, tablet
mode on ASUS ROG Z13") in v6.17-rc5.

Antheas

> thanks,
>
> greg k-h
>


