Return-Path: <stable+bounces-100395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AD69EADD5
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 11:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D823A1888B78
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370519D8BE;
	Tue, 10 Dec 2024 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bqc78wMp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A3A23DEB5;
	Tue, 10 Dec 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825952; cv=none; b=D+zaR6L7RNdCNzbh7t5Hf0eYBv3BXmc8sbclKfm0vReS6Ad2UwJ+c2vM+PFeVQk+mumgiq7pZyAn5axY7S3HrvmtMOeqUW6HdU1bdbUQ5IRM1CV8Ja3pmRlNaMippkrr+eY9JgEPM7mYaIGYKPvTOlAF3dv1VCd/ooGsVrN9qHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825952; c=relaxed/simple;
	bh=vFa1uvOLC+eKcjuhtS0bQ9lL/5VAw4GivQJT1gJtRNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqgyvT7KtDae5QZmL3ERONKy131VR8To3B/uJfz/OPb/LJ0HgTxkbDcvbUXpmxGf4XshPGu/aTXOQLH9O9f9OtpZd2fYuWgJRQIVSf4ppYDfalfGRsKlzRHbrMS8Qwo4WuT+Bi9JLVq1xdaF04Rf9d3RSEvq9GMtDmVGFhHs+Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bqc78wMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFFCC4CED6;
	Tue, 10 Dec 2024 10:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733825952;
	bh=vFa1uvOLC+eKcjuhtS0bQ9lL/5VAw4GivQJT1gJtRNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqc78wMpEhXqMWil441mbdhqhEdLLteSpU7Xa70Xb2+MUBse+v7OtJgF2bOSnRIvu
	 RRefrUhLC9RNj3XYmF1z5wHyQaR3BfuMWksHdUo9KK1EMOf2uqOOHkkDR0mYpRpk+J
	 /ZmBRFwlGq+fRFYdpEgU4OmixyoQMgmWuW4945FQ=
Date: Tue, 10 Dec 2024 11:18:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: quic_jjohnson@quicinc.com, kees@kernel.org, abdul.rahim@myyahoo.com,
	m.grzeschik@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com,
	shijie.cai@samsung.com, alim.akhtar@samsung.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
Message-ID: <2024121035-manicure-defiling-e92c@gregkh>
References: <CGME20241208152338epcas5p4fde427bb4467414417083221067ac7ab@epcas5p4.samsung.com>
 <20241208152322.1653-1-selvarasu.g@samsung.com>
 <6b3b314e-20a3-4b3f-a3ab-bb2df21de4f5@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b3b314e-20a3-4b3f-a3ab-bb2df21de4f5@samsung.com>

On Tue, Dec 10, 2024 at 03:23:22PM +0530, Selvarasu Ganesan wrote:
> Hello Maintainers.
> 
> Gentle remainder for review.

You sent this 2 days ago, right?

Please take the time to review other commits on the miailing list if you
wish to see your patches get reviewed faster, to help reduce the
workload of people reviewing your changes.

Otherwise just wait for people to get to it, what is the rush here?

thanks,

greg k-h

