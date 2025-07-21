Return-Path: <stable+bounces-163576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C506B0C444
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 14:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9CB07ABAF4
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598712D46A6;
	Mon, 21 Jul 2025 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kajyNd4c"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F32D3EEA
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101715; cv=none; b=t0VzcKc6Kp6sIDaSjWqXL7vZK8ZUinqvgvUrUGkU+kFmTHXzTmgwd6ywwL9aLi67eNzj/A5ioYzggzWgjz0KXpMy0BDg29eci7SUro/6Du7KgFdkOSluIdrshraZ33bAJ6ZK6bliB5/EHgL+dgUIbwedf18zajwXGq6W+AHwSts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101715; c=relaxed/simple;
	bh=ulH9bDWp4GfSG32fGIA9w6glDVnfajU/Y26juhsaelM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QV3y3zgq+ShcPT6SrkqwAMWBEZZBnH6iGvgxKZDkjZR7ereIYt7VyikF5JrgaSK1J8+RRP8s1ltUB7kPlrMeK8Xo84u0sgyC1f1eE/UkkeuAN3MRwpEqiIuG+KiStSWdfxFVOBGZ/N5sKSoqHcKn1qCltezLd5WhRgZ7ac4PSB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kajyNd4c; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45619d70c72so40245185e9.0
        for <stable@vger.kernel.org>; Mon, 21 Jul 2025 05:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753101712; x=1753706512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aa3jFlo8PFVRMavweJwveRRo4CK12LF4HIyOo2NB0w8=;
        b=kajyNd4cSk6q1l2eAqnKyQd73ipb1Tbr0DPF1nPGP8iJKhfznyZJOg07Re9adL/z9P
         AET402mmMwjRvT5hFvYCXEbLiuhQ40orx9Xre3eNG+roEgXQKKu2oibw1x3lhJtGp1Nb
         ui95ZIWoU8Upww6XWF5F7mHets77+UiamNFSUDG/0oIc7PmHE3htwAO0aejCWjLHoUNs
         T7T3TyYKo+L9xV+HkCfYhA3C4o2WD18ADMvHi2aGGXo61TiJ0zcxkiEpmHXnxQy5yuMW
         Ylrgl1GnmZmWPk1SoA/oNshNIS/4/80YUkjEDcPSpVLrDnQLopvx78WaPM5FjgmyDWhs
         dWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753101712; x=1753706512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aa3jFlo8PFVRMavweJwveRRo4CK12LF4HIyOo2NB0w8=;
        b=uJYp9Br1FzWH1VLivW+KwdG5wAAzceNlWp6WndS9N5UpFElPf+0Mh52FgB6zzMTdOA
         erB3qyq8ySP5m55HUJ+KmMOJbTw0epkPzixqsqLG13uK9TwAH5DyAJU1+Xm0KWFOJNJ5
         RMnVFP5f8i8iQoPbD9BPejIINPQsn3mgz+DzPBBdEj0Bw0vh1v44e7QtTD20Ul1DihWO
         pfQ42xjkRMLWznxxAuMEGD2IAuAU6stKbR3cNOrmQ8YXILVwNIxOGazuxKUd1/MwOiSB
         smthdtHXv3JcyAZIvnynfBp5X3ghVXxFiqn3dvZGYX1gaFlVw8FpPXsc6V7fRQSzDsAz
         OnbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa7a1Mc7ifY3R9v99ElBS4aGqaAdLV2exow6xY+0MVPB/vqFnEd6hKHM2acaiW98xdZBKsQJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzURoqQyOYfFsIOkovYZ0F07T7vIbjqHUHMSPdiKCgN8r72ykex
	W9ZKCSyibAfNg5/Auif7YkAaHXMQEKahuwTFRdYT7HpELUtKe4vnecgN
X-Gm-Gg: ASbGnctgpuT52ioEfXMbrz9QYd8Ev8ZfpYLI6wB7eDm4xv8RoMrthKtQLQIIHlwUlvt
	gXksSXd0xDCnje95JteWCzS/Lky4eaHBTQ11OjyDXEOH3phuEdCrThDBkyP6q7AhxLpWEaXx1aD
	2QjCAO2w8LWGpyj+Oi4mAbVuAycVbUfXTfc8IEoGJlaVmzS1ztMQqx7bss2HsuJydXj2SgJeQeM
	RePHla9jMFQquqW06u33Fvw2xTVftD/IwrTcXNxtYJcUrpzwBJYVGCNoffoicwxJ5kkSkqt3DJ7
	6QmeAVDE6DXSfGTkmaVE9AWuh1/mXDNbsRZaEEdODT+HQvvpvF7C9gKM9s2g6NAoeumWV9Jbnwi
	9K1U3WIQDyStn+hU=
X-Google-Smtp-Source: AGHT+IG1b8hC+1YQxb5V0u+zObEptBvU348K/44WqmTt9qRLezN7t4AOQXAZeybS6Kxsi+SP3QtKXg==
X-Received: by 2002:a05:600c:5299:b0:456:1a79:49a0 with SMTP id 5b1f17b1804b1-456347a8188mr152146485e9.8.1753101711288;
        Mon, 21 Jul 2025 05:41:51 -0700 (PDT)
Received: from egonzo ([2a01:e0a:9ad:d3b0:ec4c:9f30:1dfe:440a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-456485798fcsm44648895e9.24.2025.07.21.05.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:41:50 -0700 (PDT)
Date: Mon, 21 Jul 2025 14:41:48 +0200
From: Dave Penkler <dpenkler@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guido Kiener <Guido.Kiener@rohde-schwarz.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	Jian-Wei Wu <jian-wei_wu@keysight.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 022/208] USB: usbtmc: Add USBTMC_IOCTL_GET_STB
Message-ID: <aH41jDLB0iSFf4lB@egonzo>
References: <20250715130810.830580412@linuxfoundation.org>
 <20250715130811.725344645@linuxfoundation.org>
 <b7899ee9fddb4a39bce1349d7d1224ad@rohde-schwarz.com>
 <2025071536-rummage-unlit-70d4@gregkh>
 <faf41397ab4b4344af294bbb8c2e6030@rohde-schwarz.com>
 <a35a4e1b6cd6484d893b71da487dd8b0@rohde-schwarz.com>
 <2025071640-booting-kettle-7062@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025071640-booting-kettle-7062@gregkh>

On Wed, Jul 16, 2025 at 04:10:49PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 16, 2025 at 09:59:08AM +0000, Guido Kiener wrote:
> > Update see below:
> > 
> > > > I got the series
> > > > [PATCH 5.4 015/148] USB: usbtmc: Fix reading stale status byte 
> > > > [PATCH
> > > > 5.4 016/148] USB: usbtmc: Add USBTMC_IOCTL_GET_STB
> > > 
> > > Odd, that second one shoudn't be there, right?
> > 
> > Yes, there is no need to add both patches.
> > 5.4.295 is ok and uses old implementation of usbtmc488_ioctl_read_stb I assume, there is no need to add [PATCH 5.4 015/148] and [PATCH 5.4 016/148]
> 
> Ok, will drop all of these, thanks.
>
Yes, this is OK.
-dave

