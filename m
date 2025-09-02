Return-Path: <stable+bounces-176977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F3AB3FC68
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7381B24F85
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEB72E5415;
	Tue,  2 Sep 2025 10:28:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5EF2EC57B;
	Tue,  2 Sep 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808886; cv=none; b=g8dl/sMMLdcRfCNilaw6aUC6V7y+1OwwNxy2kIRoH+C1BOrbsBfKK0wwvvKaBDe997NdKTzJFb/VCSymma2MnyAz7qoHBP80VSGAo1HdQxGbT5FEAU7/O1AduivHcEZ4SSLfA5npnsFdtX4WzOTj9J8MZm/fTNRTPjH3K1b4uas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808886; c=relaxed/simple;
	bh=NYZ/k+QUdmExt9Cd73uifh9B1Y3UsA0bGoTxnRMsluU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuqCGFCAR/43OZeUFnJ07PiRn39ZtveZ8w4Z1W94jOnAbcHEwkfqfiIRzylYXXwZBdMmPSKpKSoPvZVW9PLbKbmTNpc+hwU1F2cSl+qftUJCIXMRrjSadofaDeILn06Ve4Qc9FHkXssh3eZAamE7rAIBatw1gC+24KQ0YZR3Anc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5571526BE;
	Tue,  2 Sep 2025 03:27:56 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F08263F6A8;
	Tue,  2 Sep 2025 03:28:02 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:28:00 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] mfd: vexpress: convert the driver to using the new
 generic GPIO chip API
Message-ID: <20250902-kind-gorgeous-armadillo-166b84@sudeepholla>
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
 <CAMRc=Md+2_3w5kdaUF9-nGdHv9C+tGRfN9TTu6E4+hSdFbwGBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md+2_3w5kdaUF9-nGdHv9C+tGRfN9TTu6E4+hSdFbwGBQ@mail.gmail.com>

On Tue, Sep 02, 2025 at 11:28:49AM +0200, Bartosz Golaszewski wrote:
> On Mon, Aug 11, 2025 at 3:36 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > This converts the vexpress-sysreg MFD driver to using the new generic
> > GPIO interface but first fixes an issue with an unchecked return value
> > of devm_gpiochio_add_data().
> >
> > Lee: Please, create an immutable branch containing these commits after
> > you pick them up, as I'd like to merge it into the GPIO tree and remove
> > the legacy interface in this cycle.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> > Bartosz Golaszewski (2):
> >       mfd: vexpress-sysreg: check the return value of devm_gpiochip_add_data()
> >       mfd: vexpress-sysreg: use new generic GPIO chip API
> >
> >  drivers/mfd/vexpress-sysreg.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> > ---
> > base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> > change-id: 20250728-gpio-mmio-mfd-conv-d27c2cfbccfe
> >
> > Best regards,
> > --
> > Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> 
> It's been almost a month, so gentle ping.
> 

Sorry for that, LGTM. FWIW:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

