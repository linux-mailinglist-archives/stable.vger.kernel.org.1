Return-Path: <stable+bounces-196974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C754C886C1
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 08:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB436353F40
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 07:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A9128852B;
	Wed, 26 Nov 2025 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1fQ2MTE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C51722AE7A;
	Wed, 26 Nov 2025 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764142134; cv=none; b=To0W1mPyaxtfKM5jasfd2sAY8+Cazl5rC1zQFWJaqdURdbHOlYtgJWeaZXs1CIrmDrReYZKp7Pb25vRVeOscWOMY4rlpQrOl/SsuEBRpm6IsN2/5gnVGwSAsoRbTPv51QEDeXzaMGiFQ0FI5efsfm8N+/udtoUxbjzMKtSGMf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764142134; c=relaxed/simple;
	bh=i1KFnd6WpCX0JiCZFUcGVDGKHATmpq7NgEA6yxC9yrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aafhan5PmDUnqsjTS3gPr0T6jcnN57B2B9ulbp34yWvZdQTO27VHM1jZlOZXn7L3C9DKU/sqlSKf7hY6Ojafzs91afzlgtZm+vmaXEG8QT8Dzj4nJK+S0dGauoQDxYH911YQ55axTL17clMJNwUyy3A84uRskW0NknXonTGysB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1fQ2MTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7419C113D0;
	Wed, 26 Nov 2025 07:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764142134;
	bh=i1KFnd6WpCX0JiCZFUcGVDGKHATmpq7NgEA6yxC9yrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1fQ2MTEcy1aLHYWWLsUG2RyJl6xBdIdWFsmQyvfcCjzehpcYNJ5FhUD/SNihN+ki
	 NqFTexGmxM3iIYwoBD5r4UjHfgirFuwVOgQShp8cdV0h+3QHBiuKcKAcFAz6vH9jnK
	 UKhGKdjqVGiauxb2kymRux4aBNzkIzqCk6Jdnq84=
Date: Wed, 26 Nov 2025 08:28:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15.y 2/2] Revert "block: don't add or resize partition
 on the disk with GENHD_FL_NO_PART"
Message-ID: <2025112630-washhouse-jolly-9689@gregkh>
References: <20251126065901.243156-1-gulam.mohamed@oracle.com>
 <20251126065901.243156-2-gulam.mohamed@oracle.com>
 <2025112659-oxidize-turkey-c005@gregkh>
 <IA1PR10MB7240FF5F015F21FDDC8E591898DEA@IA1PR10MB7240.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR10MB7240FF5F015F21FDDC8E591898DEA@IA1PR10MB7240.namprd10.prod.outlook.com>

On Wed, Nov 26, 2025 at 07:25:08AM +0000, Gulam Mohamed wrote:
> Confidential- Oracle Internal

This not confidental, nor "oracle internal".

> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Wednesday, November 26, 2025 12:47 PM
> > To: Gulam Mohamed <gulam.mohamed@oracle.com>
> > Cc: linux-kernel@vger.kernel.org; hch@lst.de; stable@vger.kernel.org
> > Subject: Re: [PATCH 5.15.y 2/2] Revert "block: don't add or resize partition on

Please fix your email client to quote properly.

> > the disk with GENHD_FL_NO_PART"
> >
> > On Wed, Nov 26, 2025 at 06:59:01AM +0000, Gulam Mohamed wrote:
> > > This reverts commit 1a721de8489fa559ff4471f73c58bb74ac5580d3.
> > >
> >
> > No reason is given, which is not ok :(
> Greg, Thanks for your review.
> Actually, as I said earlier, the reason was mentioned in the first patch. But I have included the same reason in the second patch also and resent it again.

I don't remember "earlier" as I get 1000+ emails a day to do something
with.

Also, patches need to be "stand-alone", with full information as to why
they are should be accepted.

This is not a new requirement, you know this :(

thanks,

greg k-h

