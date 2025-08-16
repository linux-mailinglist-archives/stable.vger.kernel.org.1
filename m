Return-Path: <stable+bounces-169845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1137DB28AB5
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 07:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1473C568CC7
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 05:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5311E260A;
	Sat, 16 Aug 2025 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RiO2lhSE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED11E49F
	for <stable@vger.kernel.org>; Sat, 16 Aug 2025 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755322736; cv=none; b=H4cxjj4pp0ptVndP6QRFx5HizTOWtvdMa9NieGlSKoJtNqUZKbLy9niJcvYI+00Gh/Kwmw/Z4H1bb4oHmml8W0gSxQkwix8RgzPJswI41uoFsYxi/MjyUbnZ31br0KMu7obXcUUUDTpo13blOKsyx5kWuiWYDLzqKz69pn6yba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755322736; c=relaxed/simple;
	bh=i7wcWMPt0X7YEXQEDrciFWFnVh42YUQ/gRUW++NLfh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9eR1wYZIf9yFIV9dCG7B2K4PjF3ai19FphM8PZhMOSfqTGmHIr4LxWPBSoQzYqjg+HEfjyR3SFcRFR8hemEDPGofaz7EplOEGsmAr0Igc4zaP1N0vP2l6sG3oNUJ3Ecu7xetIFOubw6OBNNeRfVXR0BgYcD8p2HlAoAHYKOjEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RiO2lhSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0925C4CEEF;
	Sat, 16 Aug 2025 05:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755322736;
	bh=i7wcWMPt0X7YEXQEDrciFWFnVh42YUQ/gRUW++NLfh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RiO2lhSEWSwUJ8OfYkS5Pfjnl21ISv6/WY30C5qTGnZjc6SVGK6PDAqSbPBCdmkP3
	 j0REd6/2fhpnFq14JcXDtXBw3fen82HDgClahwCwVjN6g9iTvQ2VbdNTTfzxMvqeI3
	 bhBUs0Um0mROsJSR11sCa0GTu+Ju/jnWJctcDkzo=
Date: Sat, 16 Aug 2025 07:38:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: stable@vger.kernel.org
Subject: Re: [BACKPORT REQUEST] mfd: cros_ec: Separate charge-control probing
 from USB-PD
Message-ID: <2025081644-diabetic-frolic-ea3b@gregkh>
References: <27b5275e-ee5d-4059-9886-0dc3a868b905@t-8ch.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27b5275e-ee5d-4059-9886-0dc3a868b905@t-8ch.de>

On Fri, Aug 15, 2025 at 08:08:14PM +0200, Thomas Weißschuh wrote:
> Dear stable team,
> 
> I'd like to have the following commit backported to v6.16 and v6.15:
> 
> e40fc1160d49 ("mfd: cros_ec: Separate charge-control probing from USB-PD")
> 
> It fixes probing issues for the cros-charge-control driver, for details
> see the commit message.
> As far as I can see, the commit also was marked for -stable backporting
> from the beginning. Somehow this doesn't seem to have worked.

Now queued up, thanks.

greg k-h

