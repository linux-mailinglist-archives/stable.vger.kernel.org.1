Return-Path: <stable+bounces-80741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C379904B9
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 15:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82FB1F228E6
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 13:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFDE2101A7;
	Fri,  4 Oct 2024 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izq+I0a5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250433D5;
	Fri,  4 Oct 2024 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049604; cv=none; b=bX/W/N6dZA/VCZjdKuhfMyrupz9p1TjDjC0sNyN2Oaego9E8Dtt7DF6Lbo8NxyzdIlriENsekfYqZ8ozbV6+rKX9C4e0d79rhvVBwtTUp26wHv2ev204s+0qmPudgEXDAoFwRRUROD1qlDqmVNnKRmPjUXONyHyXZlvJssFKTYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049604; c=relaxed/simple;
	bh=oMYr0J7vPOPRVc7QldvTZSHj9WMFS7q8Kx/H5jbYL4E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWxqSaNsTOuAiDsklIBL3LcpzWErKDmE8TBApZNk0wEbi2XeGq169CqsocYT7IqOq1HZPhFs91GbhJ2Lwl8vQEP8oXTO7+mViePQxG7KZfM5Gpz60FU0FePhYJHQxS+ob8HH5FBt/GYN+4o0GMIJ84t41Cybxe9DgDilD2MUPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izq+I0a5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so1900777f8f.1;
        Fri, 04 Oct 2024 06:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728049601; x=1728654401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xquMX47J/UTAd2fUYDr54EILmglm1WHGMz/WfdVeeI4=;
        b=izq+I0a5ohhoABNpAuNXk2EbZydo5Qbj6AOjw2QpMp5sS1uSSZTVNUkwgPTdUtD8um
         2kUMWA6CLjUyI10ARANZWQF7lfm49bbpz5Lq//MXjwVwJr2AtlA3LP0jDjrEqOhEqIsV
         CUXpZDJ5O/ciMLwHLUKtKHQ3qHvLRAFPZeh3COsElgQ6lpaZK2MPDd/+cKXMVH6wUoD6
         F07z6sL2QELAYFZLiFZL+QZgGFiDkXKHxwMTQPmjGmMi46aNSWgIrl2k1X8fv2948lYa
         Z7nAxQPo2FWk9N8dNqAKP4xBO1wh6ksBePdW9tN3u0ocKjt+MW0Ce/7qRjZKhvV6PjJ9
         2lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728049601; x=1728654401;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xquMX47J/UTAd2fUYDr54EILmglm1WHGMz/WfdVeeI4=;
        b=irlsZlfyzsB2ovTWp2jFySLd9sqyXfO/excUhBBZKTtpNDuOQ5gPg24o3Ba8OQBc0F
         9HBgGxc75rvo5zdaN/6Dr/HRQ2qZpikc/U0novOwobSkRpF8MXJcL8t5Su1rSlDzFHWl
         ksVR7tdYPVf7wsglm5JoT8oqF+Nk40n7LRqR69jzs9qbEcuN8ohCLEK9uIz3p8EYqLGR
         zn/TN6ui+Kxs8npOd6QAXzk3BRTUuMhCZv5wg89tIGnwF/yGqtK0QgDCDczmgCZNabw9
         C/D5zmaVMC/4kDsZMqN2nbjN76crAXW88Y7/jnX9NT1DXwAlhpd/Kqij7CRPr39UiRs5
         NIWw==
X-Forwarded-Encrypted: i=1; AJvYcCVG+gmHkm7di7KFrrOuwjF0E6pAk4ddfGwc+2XVen5Ei4VMtd+1lQGg8qRoLNBaZCblqYyLZS1T@vger.kernel.org, AJvYcCW+DqyrihECqrg/7TL2tOIJ5GCzDoQ7ekj25SJa5MXCB/4U+VkuIaugILGNm265YSfzFZ10t0eg@vger.kernel.org, AJvYcCWqJM/lGmzjSDw5upiWjYwFd2jPl0TB+IINjbpXAjo3UVpZuWygXaeaQGq0788TBY4Q4DEvr2kEZ2DCap4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFmFQYypOYBgnzbJKsFUgZvz1dyVM08R1r9mMFHDtsqoECpxeb
	7CbjdWhRhOZohi9p2Uee9Sp4yyc2F/BujSSulqYusvjAWdUuzQHq
X-Google-Smtp-Source: AGHT+IEn4lV83tB8+RgSLR8zaIiwUXR9TcB5oXcYr/vqVWEQ1FhRpBowNA9v0KynJqoOvieo0Uxm8w==
X-Received: by 2002:adf:fe8a:0:b0:374:c8b7:63ec with SMTP id ffacd0b85a97d-37d0e73742fmr2555611f8f.21.1728049600414;
        Fri, 04 Oct 2024 06:46:40 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d0822b94fsm3284447f8f.46.2024.10.04.06.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:46:40 -0700 (PDT)
Message-ID: <66fff1c0.050a0220.f97fa.fec2@mx.google.com>
X-Google-Original-Message-ID: <Zv_xuL7uKwjj0zk5@Ansuel-XPS.>
Date: Fri, 4 Oct 2024 15:46:32 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	stable@vger.kernel.org
Subject: Re: [net PATCH 2/2] net: phy: Skip PHY LEDs OF registration for
 Generic PHY driver
References: <20241003221006.4568-1-ansuelsmth@gmail.com>
 <20241003221006.4568-2-ansuelsmth@gmail.com>
 <2dcd127d-ab41-4bf7-aea4-91f175443e62@lunn.ch>
 <66ffb1c2.df0a0220.1b4c87.ce13@mx.google.com>
 <a463ca8c-ebd7-4fd4-98a9-bc869a92548c@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a463ca8c-ebd7-4fd4-98a9-bc869a92548c@lunn.ch>

On Fri, Oct 04, 2024 at 03:44:33PM +0200, Andrew Lunn wrote:
> > While the patch in net-next fix a broken condition (PHY driver exist but
> > doesn't have LEDs OPs), this account a much possible scenario.
> > 
> > It's totally ok if the PHY driver is not loaded and we fallback to the
> > Generic PHY and there are LEDs node.
> > 
> > This is the case with something like
> > ip link set eth0 down
> > rmmod air_en8811h
> > ip link set eth0 up
> > 
> > On this up, the Generic PHY is loaded and LEDs will wrongly be
> > registered. We should not add the LED to the phydev LEDs list.
> > 
> > Do you think this logic is wrong and we should print a warning also in
> > this case? Or should we bite it and just return 0 with no warning at
> > all? (again my concern is the additional LEDs entry in sysfs that won't
> > be actually usable as everything will be rejected)
> 
> We should not add LEDs which we cannot drive. That much is clear to
> me.
> 
> I would also agree that LEDs in DT which we cannot drive is not
> fatal. So the return value should be 0.
> 
> The only really open point is phydev_err(), phydev_warn() or
> phydev_dbg(). Since it is not fatal, phydev_err() is wrong. I would
> probably go with phydev_dbg(), to aid somebody debugging why the LEDs
> don't appear in some conditions.
>

Ok I will squash this and the net-next patch and change to dbg.

Do you think it's still "net" content? I'm more tempted to post in
net-next since I have to drop the Generic PHY condition.

-- 
	Ansuel

