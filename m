Return-Path: <stable+bounces-165574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DB1B16512
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6FD7A1A56
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5862DC339;
	Wed, 30 Jul 2025 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TCrF+Ppe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76622DCF74
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894751; cv=none; b=IY+THi9vOEluAdKnpVDeA0YPQHSiovFDsTPpnaq6WaswxhmnJD9MTx9x1j+9FCCQ/hDZfxvZlqRVShp8D0uQB6q+2P+vZN77kKFcxO9Jxb/6M1L2AjsJJAnoeXCw8BOq8QZ4uDTHs4xAnB5UYrkro35rzagtXeT0ancsDW36XnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894751; c=relaxed/simple;
	bh=hsfldSqyZtkGuHCXurYFqBQI2ocyjzcqOynFnNS3wzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G75/jYVsW+f0pR+gPQcS4Gu9sG8Q5C9zUnmGg+MVdjgFd2b9zIraHY64WZ7s7w1N+/MBtNqfKBynMyi/V9q7FonsNIpdmzOAQi+xNsoo9ZfPpwnC+OsjgiWmzAjEZMohuzNeE9g+uDaHbN3+3Zj/FeEIvcRIAxvFXlSGn7oUois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TCrF+Ppe; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bc61152d8so19388b3a.2
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 09:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753894749; x=1754499549; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EH5JD90Tl1qo9n7g3lAqoBlVtBBqqC64veRIJI/XJDo=;
        b=TCrF+PpeOD70Fu91PbxSyDfXMKsO7ZEIidcBh0eqHHwjjGbVKbZIXRnr6U0MQrf5Ai
         9v/LxalWX7O0EyIzfGliTxEZ79KKVnsfma60pluIYUKSppMEG9crRQpGpde7FIupQgjM
         TT+yjHHIo5UPhRg+cjzvIR70/UFp3rE+8Ug9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753894749; x=1754499549;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EH5JD90Tl1qo9n7g3lAqoBlVtBBqqC64veRIJI/XJDo=;
        b=gBfRQS/gaIc8PrX0cYfhcbtAJS2HGhfZfRa3Ril5K9jy1z+3drW5JWgVtmuKEG+nrf
         TMp2o4zaNh6usMTrkt5vqZcVeFsIIZTjtAINyEHZOafH3pmDMzEYOp3pA1+RwxE6aBcV
         8L3Zlw37CcFU0vMNUF9JwV5DT5VDEol9yNCbayFnJpmd+2EPYBzrbwvKTlOEAeejhxhD
         dh08X01HKoQ61pPfBO38l16aojJ+RM1ChA9S3EyfAj2XW6SFjYtrgMFrxg2PEQ4a1Xi0
         EQ1Rk/4c1LbJE2lPairB3Wwancxm9FEAefAGmX5iz/CkruAkwcSleH5owqP7OgZp3tMf
         vqtw==
X-Forwarded-Encrypted: i=1; AJvYcCXp7TXIFgWkmrZyJw5rdB3Fbl6nrQK6CZblf+I+sE62Kv9IMejY6jPbCIEqVtpZC9IBNkEl4Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiRhP7HeIqtZwU2lfBS6wkCZo1HdrXEnmlQ9Y6q7OrRjUraAic
	IiJByluuT9nGjlRAOOiPxT8fetDP1hRBiN0aCAKLk1bRJVs8X+DPRXG3KoOaQWD0W/MXT9OS05w
	SjfE=
X-Gm-Gg: ASbGnctk0so1e7sQAoqHvCQj9ClBBjg8l+OkXu2TVc96cBgxY4BPsawXqOLmNn/x8Lw
	Y0VzpYh8ih3iU1EIZf6bqU56cMLSjXhGJGzLuVnLL2byS54Eoq7dQtum4UycU5/+57K9mjyqkPO
	KrpkX3PYm8LGrjkMLvkVq2dW7CAnpokMeQpELNuzgqpWBkcGqXXtT56xzj3Z4W3uzZv3MI5Ul40
	WRpLuxpFZYh4bfX9Q3iWf4oYmFMxHJvj9LREnXdv1+aXuKkn8ZQgWTtbOI/pzOA9ibdZnKuzBS2
	HLeKHLUJ1HoV+EP6YWXSapkowpTgZ7nqNpNW4+6Le+vqpvqFI1Oa6eVvdY5eznkopj9jVflEt5x
	elcviL0VxiY17TnhIsR7e69JPiSDHXZVy/AoVuWiD2fxDaRXA2xc8I5XAXUKy
X-Google-Smtp-Source: AGHT+IH/DTINiXieBBCB6fXZn+swcx1FlwUGHkVf5c1lHKa2RVoj/xxnUF7G+HQ0O61TY1fWCWlm0w==
X-Received: by 2002:a05:6a00:2d15:b0:742:3fb4:f992 with SMTP id d2e1a72fcca58-76ab121fc50mr5625376b3a.10.1753894748872;
        Wed, 30 Jul 2025 09:59:08 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9b65:b0d6:4d11:d33b])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76a00902a50sm4485424b3a.79.2025.07.30.09.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 09:59:07 -0700 (PDT)
Date: Wed, 30 Jul 2025 09:59:05 -0700
From: Brian Norris <briannorris@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, Jian-Hong Pan <jhp@endlessos.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 6.13 445/623] PCI/ASPM: Save parent L1SS config in
 pci_save_aspm_l1ss_state()
Message-ID: <aIpPWZ5eS1gEeAwm@google.com>
References: <20250205134456.221272033@linuxfoundation.org>
 <20250205134513.241757556@linuxfoundation.org>
 <7a41907d-14d0-a1a4-47d6-90ff572d5af9@linux.intel.com>
 <2025020621-remindful-occultist-b433@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025020621-remindful-occultist-b433@gregkh>

Hello,

On Thu, Feb 06, 2025 at 03:29:35PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 06, 2025 at 11:00:18AM +0200, Ilpo J�rvinen wrote:
> > On Wed, 5 Feb 2025, Greg Kroah-Hartman wrote:
> > 
> > > 6.13-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Jian-Hong Pan <jhp@endlessos.org>
> > > 
> > > [ Upstream commit 1db806ec06b7c6e08e8af57088da067963ddf117 ]
> > > 
> > > After 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
> > > suspend/resume"), pci_save_aspm_l1ss_state(dev) saves the L1SS state for
> > > "dev", and pci_restore_aspm_l1ss_state(dev) restores the state for both
> > > "dev" and its parent.
[...]
> > Please withhold this commit from stable until its fix ("PCI/ASPM: Fix L1SS 
> > saving") can be pushed at the same as having this commit alone can causes 
> > PCIe devices to becomes unavailable and hang the system during PM 
> > transitions.
> > 
> > The fix is currently in pci/for-linus as the commit c312f005dedc, but 
> > Bjorn might add more reported-by/tested-by tags if more people hit it 
> > before the commit makes into Linus' tree so don't expect that commit id to 
> > be stable just yet.
> 
> Ok, now dropped from all stable queues, thanks for letting us know.

Any chance these can be re-included? That's:

1db806ec06b7 ("PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()")
7507eb3e7bfa ("PCI/ASPM: Fix L1SS saving")

We've independently backported them into kernels we're using, but it
seems wise to get 6.12.y, etc., back up to date.

Brian

