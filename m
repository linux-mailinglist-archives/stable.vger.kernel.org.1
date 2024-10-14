Return-Path: <stable+bounces-83744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC0F99C376
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13B11C2212A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 08:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0663114F12D;
	Mon, 14 Oct 2024 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kAMz9tF6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9779A14EC47;
	Mon, 14 Oct 2024 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894787; cv=none; b=VZajQXhwgFtNK1OKQEnQGhJbq5lhppJ5QRyDqOEhw8f0rFYW8p4rdOROYRkuIjnqrlbRKJUjNz5LhIui0fJ+aARX/gCvYxJz180XLqnuCPaDvaZi2adqQ/xKEPtsCnb89PH7ArradTz9EiaD4ZCf3a9VnU53wT599V6klDL2r1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894787; c=relaxed/simple;
	bh=Zf7UK2yauZJWjmc17nFTJZP1zHvDjY0aFx1QwCppRco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaNsL3JKCTDJWDvDFEnU4VBMjfFvc36/sIy+pUiapJ56q0onaYRn0reRKtmoPQLnP/AKsa1KPpkaH78CVvMBKAJQmiW4IO1DxGk6KGyNQC9JktoJ1ubPStGJh/67/ULInDiNIZYdFrI+Ffbd+b4lkn1jMQMTulwvjPNnwMLHA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kAMz9tF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A11C4CEC7;
	Mon, 14 Oct 2024 08:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728894787;
	bh=Zf7UK2yauZJWjmc17nFTJZP1zHvDjY0aFx1QwCppRco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kAMz9tF6M5yaerilpGdbHVgh2Ye9hberlEHT1lvUwL4aY2lU2sP42Xe3/2K9YXNnz
	 gNBfkmQfOCFyFKaOIZn26rGAQyVMWX7T7oXAntAkQbcf45U3ivqybbouiW//ru4AdN
	 KaSfcxO0fDRg8a1/H/hfxShb8fsOCtanA4AIm5kk=
Date: Mon, 14 Oct 2024 10:33:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq_arm: Fix missing refcount decrement in
 error path for fw_node
Message-ID: <2024101442-earthling-maverick-f591@gregkh>
References: <20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com>
 <a4283afc-f869-4048-90b4-1775acb9adda@stanley.mountain>
 <47c7694c-25e1-4fe1-ae3c-855178d3d065@gmail.com>
 <767f08b7-be82-4b5e-bf82-3aa012a2ca5a@stanley.mountain>
 <8c0bbde9-aba9-433f-b36b-2d467f6a1b66@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0bbde9-aba9-433f-b36b-2d467f6a1b66@gmail.com>

On Mon, Oct 14, 2024 at 10:15:25AM +0200, Javier Carrasco wrote:
> On 14/10/2024 10:12, Dan Carpenter wrote:
> > On Mon, Oct 14, 2024 at 09:59:49AM +0200, Javier Carrasco wrote:
> >> This approach is great as long as the maintainer accepts mid-scope
> >> variable declaration and the goto instructions get refactored, as stated
> >> in cleanup.h.
> >>
> >> The first point is not being that problematic so far, but the second one
> >> is trickier, and we all have to take special care to avoid such issues,
> >> even if they don't look dangerous in the current code, because adding a
> >> goto where there cleanup attribute is already used can be overlooked as
> >> well.
> >>
> > 
> > To be honest, I don't really understand this paragraph.  I think maybe you're
> > talking about if we declare the variable at the top and forget to initialize it
> > to NULL?  It leads to an uninitialized variable if we exit the function before
> > it is initialized.
> > 
> 
> No, I am talking about declaring the variable mid-scope, and later on
> adding a goto before that declaration in a different patch, let's say
> far above the variable declaration. As soon as a goto is added, care
> must be taken to make sure that we don't have variables with the cleanup
> attribute in the scope. Just something to take into account.

For this simple probe function, it's not an issue, please just make it
as simple and clean as possible.

thanks,

greg k-h

