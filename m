Return-Path: <stable+bounces-110894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B318A1DC47
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 19:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7E11657FF
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 18:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5CC18D649;
	Mon, 27 Jan 2025 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAFN4ZNX"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A51607AA;
	Mon, 27 Jan 2025 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004072; cv=none; b=lx/UDA2JwXNFqtzp0fPSpIDi0evOSqHDDSlWwp/R3/Ut3x1Y618pDmA+N8I3LHuQqrmbAEW/YhkfFcQMGF3P8YsdVQkGfG4N8WZJnhclboepaV+wL2i+iWPyzKTt3ttC/cwGrA7tbeHC2sVYbGon/rvp17XRZIWIZvBt4gZISb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004072; c=relaxed/simple;
	bh=SBnA42QZmVjeBYGqPuEolb6C0in4hQm6tEkwb746KWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3Xoz9jzdeTGXrBKASTu/m7QkiHWUkzJLpkVcGe1eJHo3v6yt7qvjKy2n05Yes8coBA7dvB6wN/QHxIRenu3QNgG+awJ9hc+yJzSIiQpDA30VZar4DjbnWqHOf1IHGrHgkQ75yCNCW4jQOxefJjSOIkBxn8ttUFGFtN9p4jd6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAFN4ZNX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e3778bffdso5469418e87.0;
        Mon, 27 Jan 2025 10:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738004068; x=1738608868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4DwBtqJe2G7SgnACIilduClbZR5mLhGNGSesirB98sg=;
        b=mAFN4ZNX3Ak8DpCnBz4PxIiQUURLAB0gMwCF4r7U4jQlTu5EUiukunR3GtcPiNcMFg
         gyT1d4+m15irzqSE4RmU+sZNGoKP8SQMp+Ms8f7B87ci3pd9rxDAjUF3EdpLSnyjuoRt
         Rfu7CsLBzMNomCFME5+tIx8QzIMoCwD0AAP+MGbHvwPAvH5nZjFoe9YfNzZISI9Ychb5
         VWZhJaqb2fcm1+kQ7KfEm5OFIDE/avDfXdvWpXseIcdTmaGj5zPQgA2mdxQ3p+78FZEj
         wMgd3NAeG/nGuOIikuIkVhYUXhkbymFL+ydLds/t4e/AkTfmVObSQgPj6wxuE3EQGycs
         P60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004068; x=1738608868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DwBtqJe2G7SgnACIilduClbZR5mLhGNGSesirB98sg=;
        b=hZMNHpGD8uDqA8jOo0s0NJbFVl7nL1STmx1Iag7mC41XkRdRFcmoW8YwAvQ4EK2kbE
         b9bspdX9F2MDh9182rV0m6kqWW93pn3kdxqRUeSoHvgCPiSjwkFSZebcavQn1Deg+031
         JRaYVCPxfA6bLtdCeq8sBhBJX+Vupf0QmfCpfVc+gRfilKTIIcwC8r+IhNn2GJw9VEfa
         a7DqX/LcPl9Nu1PQxvqdhSAVUFewJZq+rJd+uyNU6UN2FiU8gRH61VNGSF+tqRDdDJU0
         EtrndkilObeHaM42icbn7P8PnkLzcbMkAUDuxV8CVFEwx4YrBBikLXcdorYP2U6ByUT8
         8SyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmdp+R58Z5u+qe/OSLFOIsAh5ouJodbwFXp9IFjxAfPSChmkxDPKkAEWHS553lCEUJE83YbAUjF8jfSQ==@vger.kernel.org, AJvYcCWzIDE+Ud6W5fL6ScLHwtKmsgwT2xx99y6quPnEZ0mSQ/dsl9R5MAibNJgK4qZW84L9HaA71fUN@vger.kernel.org, AJvYcCXSKFpC7WkCWqLIAcfFAD843rJ4bBqgx0iFMkrtklIaKHjxn6GL8llfZmzdnGxgpu9a9yqwMeihyBKeB1Ar@vger.kernel.org
X-Gm-Message-State: AOJu0YwdWCtQAjjvIG2HtB6Km+o6/dGgKr/7mFY4qw1Ch2MaOOgXZhXP
	Rcv5vplkwwl/KWljs0WdLJBgWNNpdDblU2He9q6EC4uQyHfR/VPx
X-Gm-Gg: ASbGncuYLsROckR05jdtc6Y6hpRGxgjddDBEuZ1aZvQSSn3h8MNjsm3dJm+Zj37qIeO
	iqGANP+Xxwy/4dnkKd18JO6gjSKeUzb1xZdSoRT/b6F713CZ799J7/8XBqDdv7rJuFTXZiMcHUf
	YbJlpHu6i21n0dKGBblCxnLPagisq8VrFApDvo1+ADhtCy1fiIlNSsrr0OopcuCxRB0gFubIvSD
	NW9h38H5TDrWmyDL6Jz56QFDkx7I+3m0OAQvHu9RvFFFEjLhL1dXMsI4vI/vl8lopkOIYH3CeEw
	CSjDsTM3lRIfR98SiOA=
X-Google-Smtp-Source: AGHT+IH8UG7CJrTEaL66OM3T+KUSNCmOyng98VM7AApMTqZPYEjOJxePtiyDsiY7rxZfij2AuDFnXA==
X-Received: by 2002:ac2:51b7:0:b0:53f:231e:6f92 with SMTP id 2adb3069b0e04-5439c28570bmr12742475e87.34.1738004068126;
        Mon, 27 Jan 2025 10:54:28 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8237459sm1395598e87.106.2025.01.27.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 10:54:27 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 50RIsNYo002766;
	Mon, 27 Jan 2025 21:54:24 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 50RIsLrO002765;
	Mon, 27 Jan 2025 21:54:21 +0300
Date: Mon, 27 Jan 2025 21:54:21 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc: "linux@roeck-us.net" <linux@roeck-us.net>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
        "Rudolph, Patrick" <patrick.rudolph@9elements.com>,
        "pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>,
        "Solanki, Naresh" <naresh.solanki@9elements.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "fr0st61te@gmail.com" <fr0st61te@gmail.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "joel@jms.id.au" <joel@jms.id.au>
Subject: Re: [PATCH] hwmon: (peci/dimmtemp) Do not provide fake thresholds
 data
Message-ID: <Z5fWXfm+bDhGlFIi@home.paul.comp>
References: <20250123122003.6010-1-fercerpav@gmail.com>
 <71b63aa1646af4ae30b59f6d70f3daaeb983b6f8.camel@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71b63aa1646af4ae30b59f6d70f3daaeb983b6f8.camel@intel.com>

Hi Iwona,

Thank you for the review. Please see inline.

On Mon, Jan 27, 2025 at 04:40:52PM +0000, Winiarska, Iwona wrote:
> On Thu, 2025-01-23 at 15:20 +0300, Paul Fertser wrote:
> > When an Icelake or Sapphire Rapids CPU isn't providing the maximum and
> > critical thresholds for particular DIMM the driver should return an
> > error to the userspace instead of giving it stale (best case) or wrong
> > (the structure contains all zeros after kzalloc() call) data.
> > 
> > The issue can be reproduced by binding the peci driver while the host is
> > fully booted and idle, this makes PECI interaction unreliable enough.
> > 
> > Fixes: 73bc1b885dae ("hwmon: peci: Add dimmtemp driver")
> > Fixes: 621995b6d795 ("hwmon: (peci/dimmtemp) Add Sapphire Rapids support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> 
> Did you have a chance to test it with OpenBMC dbus-sensors?

Using OpenBMC dbus-sensors is exactly the reason why I'm sending this
patch, so yes, I tested it before and after the change.

> In general, the change looks okay to me, but since it modifies the behavior
> (applications will need to handle this, and returning an error will happen more
> often) we need to confirm that it does not cause any regressions for userspace.

The change is prompted by the current behaviour which is unacceptably
bad: every now and then while powering on the host for the first time
BMC happens to request one of the memory thresholds at a wrong time
(e.g. when UEFI is busy doing something which prevents normal PECI
operation); this leads to the unfixed kernel code returning zero and
dbus-sensors happily using that as a threshold value which later
results in bogus critical over temperature events for the affected
DIMM (as their normal temperatures are always above zero). It was
relatively easy to reproduce on an IceLake-based system.

I consider the current behaviour (in case of PECI timeouts when
requesting DIMM temperature thresholds) to be so broken that changing
it to do the right thing can only do good. The non-failure case is not
affected by this patch.

That said, for sensible operation a dbus-sensors change is indeed
needed and I now have a patch pending upstream review[0] to handle
those errors by retrying until success. Without the patch the daemon
would just load with those thresholds missing but it's better to have
thresholds missing than to have them at zero producing a critical error
right away I think.

[0] https://gerrit.openbmc.org/c/openbmc/dbus-sensors/+/77500/

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com

