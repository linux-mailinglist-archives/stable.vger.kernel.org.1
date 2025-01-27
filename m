Return-Path: <stable+bounces-110895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5703DA1DC7B
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 20:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A111628F0
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 19:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886B6190664;
	Mon, 27 Jan 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSO0ocrl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FEE15B10D;
	Mon, 27 Jan 2025 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738005014; cv=none; b=fAlc1C6xlBASy7ttDxXZgrx3FwL6JhjVWabdoB/PvwRVF/esZE7fhudw+AQ+A1nKWvmB0T3PhnBii+zgezh3JAhCgXch2QA3r2dI/IJBZgwSzg5v7vapNFoFjSMyDhtNN9JeyqPlDJgBYTNZodzbShED/cH/MOSU2hPod6er+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738005014; c=relaxed/simple;
	bh=lTeFCil2l/UIXzU38ggGuLU1j/fB7hbnVd9CIRfIvuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXdchQcEmfHKIqOBJuQFa54iY7DJE/t9e0V+okOYeJecpkUTEHyXfYiWX341fOiJkWBe4Qt3qKa2HP9NxVX0RMp371xh+uBrS4Ttsgwoetkzf/V0es4szgFFo5DPOggkc0ht2vpf/F2sI4nURrIVcB2CMouZY0+RvPUR6xPg9CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSO0ocrl; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30613802a04so49956301fa.2;
        Mon, 27 Jan 2025 11:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738005010; x=1738609810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bGwrXPOvo05x7dKLdltIQ3oHgnPqyjh5wBEm2GWPthM=;
        b=WSO0ocrle/1a95VdmtJtadGf3H1JoXY1rrAgKSbA8wK/fTCEo8M7dLJ2B6+unN5QzO
         5AEOlivQaPvyipC/AaqC1XcRd/77au3mG7vexTnTbp7xWFeIB/30f7Kk7W/9CFBzaC8o
         arfEcU34hp9CpJ2b/VJczA6jdLsLpjEpiQ8GYlhgGW3JmdljnQJ8H5DpBfLeIjZZjRfB
         7kBkUl4oJqYL2UYD5kFoLe7gFHJJz5a2X5DjpYpofFf26k3AIyLV3pwVPWVs/pKu5rss
         yUEZJdDvO6ydll2aQtIPqcQHvL9Tr7TxAg/M1v+Mv0EhUp8ZryMkNA+T97ZcHNlywfhj
         sYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738005010; x=1738609810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGwrXPOvo05x7dKLdltIQ3oHgnPqyjh5wBEm2GWPthM=;
        b=JOwiZJZmgOnauEzB6ETYSpoTib3AQXrSi7d+rDj8bEjSkzvLhlmMWPW675F+u0qkzk
         K3me6R0EvvBpfsXDWE/B+DAjPr4FB7yEEZ9K094VH1pnaAXDPs5SMHJZ8fzNrpv/pS26
         vJESj7pAgLT+rLw2qUyAA8fg5XnwW9ukXCbBWvG0ABFmZmfEI7wuaKGY8HqhtKJAupWK
         NrFJzC8IoIQ6DQQZhUOywmI3I7yW0FLgDybXC/eg9VyLt9jA9cSEYdahrF5oFvQMa7//
         80CLv+sZOQUQlPujw/kTdgQ+KmyAGXahen6EhNK+w6FckFWtQzDDjTsL+OuARb7WOT2K
         IBpA==
X-Forwarded-Encrypted: i=1; AJvYcCUiA5TgdeU/FEox43BdFSg5Q/8ZU98L6+FkTuOazxfWatDEQQRMmM8b+ZRxkORi04AXl+Doqan98OY/yRbE@vger.kernel.org, AJvYcCVyC1P2CDjUQfQzG/9suS8cbYSLaglpDJ0kd4G9EpDGmtdR1NeTIM4SxNPxgsTj5yRCa8DZHanI@vger.kernel.org, AJvYcCVzSJn9e/x5CMOuTc7mvotx60/TzJ4kfkrTSeV/yNdxl6mLK9TmhFg8xjpMyoTh0JcdC3RxmqiFRO5aXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1gh2gg8ea3okBit661/9VMzne6WCx2lYU91G2BpaQzAqzO/G8
	tRSiNbV4bCLD2YIp5A75hH+PXkmhgQR/kWf18MsdvcFuOHeChVqU
X-Gm-Gg: ASbGncu02/+f1k4Fd8WFkaLK+oS/WuA2T23qLVW/5ht6PinLKGNg4mxsiGQDRsBICuN
	iHiAw5rvBOmQNgUrIrSZf5nzS7p1gXI5rZXWAxaWoT8xFWCFpncS6CSlkmqelY1FTF5M7NJh2SS
	UG38SfHr46S88FCzs7cMbWNUq1Ujhynrjlzgf9gH5yjGvIy+M2Ej7eTjJbAv2i57ZH91vcBSXtn
	jHT9xNsdj8v17jOf1Drs2IE625IMXKEu5jNBHyg8xoJa0+mw7sKIlm/ystC8i+bw0jeO/tWD9GK
	CTyYWNI4N4RycktOe/0=
X-Google-Smtp-Source: AGHT+IGcyGJAafbq2BnEAcDVUomhfJ6yZ8JXnr9Oo1BWvohJt8PKPBt3ZNFrQEx4CVCXKFZ8BeCIuQ==
X-Received: by 2002:a2e:b555:0:b0:302:22e6:5f8 with SMTP id 38308e7fff4ca-3072ca9a6f7mr122102721fa.22.1738005010251;
        Mon, 27 Jan 2025 11:10:10 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076bc49806sm15422331fa.91.2025.01.27.11.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:10:09 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 50RJA5QR002808;
	Mon, 27 Jan 2025 22:10:06 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 50RJA3D2002807;
	Mon, 27 Jan 2025 22:10:03 +0300
Date: Mon, 27 Jan 2025 22:10:03 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Winiarska, Iwona" <iwona.winiarska@intel.com>,
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
Message-ID: <Z5faC6M2MUj8KYoB@home.paul.comp>
References: <20250123122003.6010-1-fercerpav@gmail.com>
 <71b63aa1646af4ae30b59f6d70f3daaeb983b6f8.camel@intel.com>
 <7ee2f237-2c41-4857-838b-12152bc226a9@roeck-us.net>
 <Z5fQqxmlr09M8wr8@home.paul.comp>
 <1dc793cd-d11d-441a-a734-465eb4872b2a@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dc793cd-d11d-441a-a734-465eb4872b2a@roeck-us.net>

On Mon, Jan 27, 2025 at 10:39:44AM -0800, Guenter Roeck wrote:
> On 1/27/25 10:30, Paul Fertser wrote:
> > Hi Guenter,
> > 
> > On Mon, Jan 27, 2025 at 09:29:39AM -0800, Guenter Roeck wrote:
> > > On 1/27/25 08:40, Winiarska, Iwona wrote:
> > > > On Thu, 2025-01-23 at 15:20 +0300, Paul Fertser wrote:
> > > > > When an Icelake or Sapphire Rapids CPU isn't providing the maximum and
> > > > > critical thresholds for particular DIMM the driver should return an
> > > > > error to the userspace instead of giving it stale (best case) or wrong
> > > > > (the structure contains all zeros after kzalloc() call) data.
> > > > > 
> > > > > The issue can be reproduced by binding the peci driver while the host is
> > > > > fully booted and idle, this makes PECI interaction unreliable enough.
> > > > > 
> > > > > Fixes: 73bc1b885dae ("hwmon: peci: Add dimmtemp driver")
> > > > > Fixes: 621995b6d795 ("hwmon: (peci/dimmtemp) Add Sapphire Rapids support")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> > > > 
> > > > Hi!
> > > > 
> > > > Thank you for the patch.
> > > > Did you have a chance to test it with OpenBMC dbus-sensors?
> > > > In general, the change looks okay to me, but since it modifies the behavior
> > > > (applications will need to handle this, and returning an error will happen more
> > > > often) we need to confirm that it does not cause any regressions for userspace.
> > > > 
> > > 
> > > I would also like to understand if the error is temporary or permanent.
> > > If it is permanent, the attributes should not be created in the first
> > > place. It does not make sense to have limit attributes which always report
> > > -ENODATA.
> > 
> > The error is temporary. The underlying reason is that when host CPUs
> > go to deep enough idle sleep state (probably C6) they stop responding
> > to PECI requests from BMC. Once something starts running the CPU
> > leaves C6 and starts responding and all the temperature data
> > (including the thresholds) becomes available again.
> > 
> 
> Thanks.
> 
> Next question: Is there evidence that the thresholds change while the CPU
> is in a deep sleep state (or, in other words, that they are indeed stale) ?
> Because if not it would be (much) better to only report -ENODATA if the
> thresholds are uninitialized, and it would be even better than that if the
> limits are read during initialization (and not updated at all) if they do
> not change dynamically.

From BMC point of view when getting a timeout there is little
difference between the host not answering being in idle deep sleep
state and between host being completely powered off. Now I can imagine
a server system where BMC keeps running and the server has its DIMMs
physically changed to a different model with different threshold.

Whether it's realistic scenario and whether it's worth caching the
thresholds in the kernel I hope Iwona can clarify. In my current
opinion the added complexity isn't worth it, the PECI operation needs
to be reliable enough anyway for BMC to monitor at least the CPU
temperatures once a second to feed this essential data to the cooling
fans control loop. And if we can read CPU temperatures we can also
read DIMM thresholds when we need them and worse case retry a few
times while starting up the daemon.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com

