Return-Path: <stable+bounces-201157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E9FCC1F61
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDFC4305F0E6
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECBA32C944;
	Tue, 16 Dec 2025 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ANYBJXNa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F99337117;
	Tue, 16 Dec 2025 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765880602; cv=none; b=A1y2KlFKhceWtR4MPDLcMXJgH7JqxMeBiJvCmTi8XlgpzUmG50xqfPb0T9UvbUr6fFyf6MZCm+aTwLDxNnppCWft5YDzUIEwMLxYhtYFQl6a3dcDrMFY0HHAcnRjfw4c8jUV8hOalV+obJ7hBBNKAvT10HaTP3Ag0+qcuSsgoZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765880602; c=relaxed/simple;
	bh=ckQRhVB2xur896X0WHoIxMHQY+we+Eu9B1EGGC5lK0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiyDvH7FvrFPNmbmuiNSEKpffIMiXnNLNpdF7eXtRQ6HJWRNP09dTggySRomV/SsZPJ80anEeIJweSnpvwMYnROeGKkHXd/n4ESe94qo8mvLUsldlCK0OgZdfxOoZYkcwaIetNkOzeoWEvipIt+fK221Xh3O+EfjoRSA+WlsRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ANYBJXNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942A4C4CEFB;
	Tue, 16 Dec 2025 10:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765880602;
	bh=ckQRhVB2xur896X0WHoIxMHQY+we+Eu9B1EGGC5lK0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANYBJXNa94IyzkHFr16KOL3n9WOwqj/yXil5XYWP/WuzgNL3es1VKOR4foUS5V/l3
	 SaeWttXL/wQ7Hcdmkkw+GirABSzZEOzBLSupv5stELpZBRMfOQiZlnS1No5vTAenOQ
	 ZClInt9ciuOK5laxbou2KyMrzERzjkCQ0qp34FFY=
Date: Tue, 16 Dec 2025 11:23:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hans de Goede <hansg@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, sre@kernel.org,
	Bryan O'Donoghue <bod@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: Patch "media: ov02c10: Fix default vertical flip" has been added
 to the 6.18-stable tree
Message-ID: <2025121606-commence-grating-01b5@gregkh>
References: <20251213093506.4122377-1-sashal@kernel.org>
 <bc08a3fe-5b1c-4f19-b1df-fe1b1d5b23e2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc08a3fe-5b1c-4f19-b1df-fe1b1d5b23e2@kernel.org>

On Sat, Dec 13, 2025 at 12:52:07PM +0100, Hans de Goede wrote:
> Hi Sasha,
> 
> On 13-Dec-25 10:35, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     media: ov02c10: Fix default vertical flip
> 
> This fix is incomplete, leading to wrong colors and it causes
> the image to be upside down on some Dell XPS models where it
> currently is the right way up.
> 
> There is a series of fixes which applies on top of this to
> fix both issues:
> 
> https://lore.kernel.org/linux-media/20251210112436.167212-1-johannes.goede@oss.qualcomm.com/
> 
> For now (without the fixes on top) we are better of not adding
> this patch to the stable series. Can you drop this patch
> please?

Now dropped from both queues, thanks.

greg k-h

