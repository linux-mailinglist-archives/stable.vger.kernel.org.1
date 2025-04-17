Return-Path: <stable+bounces-133101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2179A91D80
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EFE462F3E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37032472B9;
	Thu, 17 Apr 2025 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoqO9GdX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7E64A98;
	Thu, 17 Apr 2025 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895562; cv=none; b=VXh+l0eDHZCy4OV/4ILe8SznfSl2TbxI1D3ywll24Auw1h/LnIv4TfRO2N1yKOKT6uVnX+03eXPEd6khaSESww3eb9ziMfA9ncDkuzSY0SUI9Vsrzab9qZA1Zcx7Q5Ntu8aLBupQyCGBqVIQG5kkdSfAOKuk3W+LHbld9vGBh24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895562; c=relaxed/simple;
	bh=vMhvBBkKElMyIh7A9PoUjyUtyXpKUsIiYLmszT6LqGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSh3pKFFtsK174HGY4hGcz18TvTCk3Otf9jU+VEpWpM/3L5TqiZeHP7ZxaG4YRhsdB+Q1/Ym7V7Xgi3gdJX+onlgPIsXjRR+9fm5QJtjySRsgF96Fug5tXu0j/14lVVhvzXiboOBK1OwAIKMatmgnR0Ry02pSz/WTsoSQczBv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoqO9GdX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so4084885e9.2;
        Thu, 17 Apr 2025 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744895559; x=1745500359; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=04TfvKNzSnzlvKlxW6Gwj4q+0nDZMEDnwoinbXJa+Pc=;
        b=SoqO9GdX1AbQI8RwzrJ86m4XZjPlljgY8bcw8R5iGgRd0XlUUB7k+o8sK8v67/PBY8
         UQyJIXbqPyipIFzuVRjI0c8KvBQcKzDAkTQOZQ4GPUNkN7MjrJYE2pa6mPKVeNf47ihY
         9nj65BGL3vumXs90Se1AneZ8hPV2L1AywZ8oUx9QZVrfWdpPq1k7uRdb+dsT6mAO9Lhw
         Dvl82taR9HrCnHtLaQg+FvnldrTYRMilxmahhQH7droushL9EeJRpyN3XAcRQfYL5Gp3
         azkbOnsdL0l40Swd6m8h7IRSrGSuOOEmohQzh5LKeKZaSmiXy399zgDfrAtOfIR6mcUU
         rbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744895559; x=1745500359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04TfvKNzSnzlvKlxW6Gwj4q+0nDZMEDnwoinbXJa+Pc=;
        b=U4pYWQJlRm6jVp0SmS7vhd9Jzk0Po6ZFZRI5o4UuMxLRIo9yf/TLWLT4EHBu43Kp3g
         oE5a7DclB2IZcyvi6e1zMzRfArGvlHmWkeaq02M/NaVh8M/dbNitQekeaJAPHl+fzrmg
         DXm+aXQcG25PmHaiw0yIkG6TiU9gyvG6fzhMtrB0H6NUz1zCXDUEFRWSw3x1TH0+m46V
         jqEz15C9fFkanht0/m7JPFF+WwE56ZRJ9NGDWjT6f+pN+NCniI8IbNijRBg0vJ+4X/jK
         ca63p5tRDIZG0z7Y8Lk3CgqSd5kOApTUggdaH6G+s3sG9nyxS5mNL18ULDBnF9alBMwA
         oyuA==
X-Forwarded-Encrypted: i=1; AJvYcCUVb49t7JXEbajWTByYUECdfNRchS+/gJWoapXAwzQ5NAwkEZ8QhX4XZcHqFtsXhS4V2vDu/sBC@vger.kernel.org, AJvYcCUnnabczafcX1qtuAQdJmthoT4IPIRxIVTSm7ZB9Wkqoo3QeCEMSNOu5UBxSbFmQHJYPfFHFexf@vger.kernel.org, AJvYcCWSRUf2b1e+gKI4TIpBT+5yqwwk0Ke1nW7DvxXKPszeKu4CH/ojW9+vdfxmD+WjXPc+bRvuEvF4pLfk@vger.kernel.org, AJvYcCXhHw0cy/es0DRcmS5A+yFgZxhzhSJguWAydkMcm36wuP7CcxMq2Z4VDLMgsCqsI9DNO+7lKKpdJftRkUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1GYjBV+J/DtfbEAo9qE77NtCvxG3agINM/Xh7PJzQE+L+Qz6
	ROkSvawZnW2tOTL8tJPVPttw8c06TcaY2GI4AgB0lsw/rRn9Dg0c
X-Gm-Gg: ASbGncvC4XLAwMCjk6WCJ3lVqiNameGjpRzg7DZ96UPQGZCrBmVgcpee0IZZ3BG4ipB
	r+Iq+Dya96FxAtF/myzLVE/qRpeUXb81q2Kuf+HNtW6KyzURTsIaapTwUfuJc3wu93NJjOFBYgi
	FiMSGfhKSNKdToDXKl1L6QfRvbJfioP8PxOmRWIR6ht1T3LEdv3aaiB3mu94r9ER/hQMWcjRMwO
	xAUEqD8OJgR77NNKr0+1B98V1hYCqBC3anAwJOrcO7R6ckKw7E6dmCyL5tBbgp+HzXlsfRbCDn5
	bjvRoxKT6ru5SqMjyPJFap4R/pehd5nI9afOR24=
X-Google-Smtp-Source: AGHT+IH0JrGfVzwDr9zTnRtEYBBNuX4yDnsqZwL6HLBEocbCMqO/cqA4N513NL/eSr8dmGL7xM6HIA==
X-Received: by 2002:a05:600c:384b:b0:43c:e7ae:4bcf with SMTP id 5b1f17b1804b1-4405d5bdb1cmr66066095e9.0.1744895558817;
        Thu, 17 Apr 2025 06:12:38 -0700 (PDT)
Received: from gmail.com ([2a02:c7c:6696:8300:30d6:b851:2d62:d3f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445737sm19774698f8f.88.2025.04.17.06.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 06:12:38 -0700 (PDT)
Date: Thu, 17 Apr 2025 14:12:36 +0100
From: Qasim Ijaz <qasdev00@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] net: ch9200: avoid triggering NWay restart on
 non-zero PHY ID
Message-ID: <aAD-RDUdJaL_sIqQ@gmail.com>
References: <20250412183829.41342-1-qasdev00@gmail.com>
 <20250412183829.41342-6-qasdev00@gmail.com>
 <b49e6c21-8e0a-4e54-86eb-c18f1446c430@lunn.ch>
 <20250415205230.01f56679@kernel.org>
 <20250415205648.4aa937c9@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415205648.4aa937c9@kernel.org>

On Tue, Apr 15, 2025 at 08:56:48PM -0700, Jakub Kicinski wrote:
> On Tue, 15 Apr 2025 20:52:30 -0700 Jakub Kicinski wrote:
> > On Tue, 15 Apr 2025 03:35:07 +0200 Andrew Lunn wrote:
> > > > @@ -182,7 +182,7 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
> > > >  		   __func__, phy_id, loc);
> > > >  
> > > >  	if (phy_id != 0)
> > > > -		return -ENODEV;
> > > > +		return 0;    
> > > 
> > > An actually MDIO bus would return 0xffff is asked to read from a PHY
> > > which is not on the bus. But i've no idea how the ancient mii code
> > > handles this.
> > > 
> > > If this code every gets updated to using phylib, many of the changes
> > > you are making will need reverting because phylib actually wants to
> > > see the errors. So i'm somewhat reluctant to make changes like this.  
> > 
> > Right.
> > 
> > I mean most of the patches seem to be adding error checking, unlike
> > this one, but since Qasim doesn't have access to this HW they are
> > more likely to break stuff than fix. I'm going to apply the first
> > patch, Qasim if you'd like to clean up the rest I think it should
> > be done separately without the Fixes tags, if at all.
> 
> Ah, no, patch 1 also does return 0. Hm. Maybe let's propagate the real
> error to silence the syzbot error and if someone with access to the HW

Hi Andrew and Jakub

Since there is uncertainty on whether these patches would break things 
how about I refactor the patches to instead return what the function 
already returns, this way we include error handling but maintain consistency 
with what the function already returns and does so there is no chance of 
breaking stuff. I think including the error handling would be a good idea
overall because we have already seen 1 bug where the root cause is insufficient 
error handling right? Furthermore this driver has not been updated in 4 years, 
so for the near‑term surely improving these aspects can only be a good thing.

So now going into the changes:

Patch 1: So patch 1 changes mdio_read, we can see that on failure mdio_read 
already returns a negative of -ENODEV, so for the patch 1 change we can simply 
just error check control_read by "if (ret < 0) return ret;" This matches 
the fact that mdio_read already returns a negative so no chance of breaking anything.

Patch 2: For patch 2 I will add Cc stable to this patch since kernel test robot 
flagged it, I assume backporting it would be the right thing to do since the 
return statement here stops error propagation. Would you like me to add it to the other patches?

Patch 3: For patch 3 the get_mac_address and ch9200_bind function already returns a
negative on error so my changes don't change what is returned, so this should be fine i think.

Patch 4: For patch 4 it already returns a negative on error via usbnet_get_endpoints() 
so i hope it is fine as is? Jakub commented on the changed usbnet_get_endpoints() 
error check, if you want me to revert it back I can do that.

Patch 5: We can drop this.

Andrew and Jakub if you’re happy with this should I resend with these changes?

> comes along they can try to move this driver to more modern infra?

