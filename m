Return-Path: <stable+bounces-139703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40328AA959C
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 16:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0743A7277
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24F4259C85;
	Mon,  5 May 2025 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vBHvnNG8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA7846C;
	Mon,  5 May 2025 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454984; cv=none; b=WZKqBAZWCJGTpwq0Z9LsEvfIa6/3jFA4DV24j38u86cttvwNfA30snSPS+nNwlR4wVy9suPXO6PeryfF/Q1f9TB2kCw3tfvwzhkHJqUwL1rZm2X0eKgUEGN7qCep+AaRPWTgR1zodhQdNDTuqw/a6TjVJyElkBezZvFtPqq8i2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454984; c=relaxed/simple;
	bh=3dTkU/7lC44YMbIkb0IBuu22iBQwpntrjLelWWH2HaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4wNIx0SzYlIpVYM3Xpa8ZP6MIZXUWKp3iJXvn9/w3mi8MewOedycjBJritoVbrTGOR9PPDC9hABiS+L46wsMVbyUfgRtn2gJSbPiFsGfKpwNCuAiKYKnkxDoLmIKOtDXg5D9dKugAfYvEM+kmzl3T+pFHNIHwCJ++wuT3vSHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vBHvnNG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E58C4CEE4;
	Mon,  5 May 2025 14:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746454983;
	bh=3dTkU/7lC44YMbIkb0IBuu22iBQwpntrjLelWWH2HaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vBHvnNG8BqPqODc8WHTFGYCabDiU2fvxZkVzZG49Oyv4lDZCnBVLVO2/oGfyP3ic+
	 YdRIPmZ90ERSTUdYRhvCTKgyeS8V/inJI+PmeBe0/+a0u1bmg2bNq5pZQNOdp4UbXy
	 84Bmnbop4rqNcGAwJXcdikq/TkacFhu04Y2qsD/4=
Date: Mon, 5 May 2025 16:23:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: Please apply to v6.14.x commit 6eab70345799 ("ASoC: soc-core:
 Stop using of_property_read_bool() for non-boolean properties")
Message-ID: <2025050550-clause-macaw-771a@gregkh>
References: <7fb43b27-8e61-4f87-b28b-8c8c24eb7f75@cs-soprasteria.com>
 <2025050556-blurred-graves-b443@gregkh>
 <8e6c91c0-6780-414e-9cf6-1cc2a058be0b@csgroup.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e6c91c0-6780-414e-9cf6-1cc2a058be0b@csgroup.eu>

On Mon, May 05, 2025 at 03:27:18PM +0200, Christophe Leroy wrote:
> 
> 
> Le 05/05/2025 à 15:10, Greg Kroah-Hartman a écrit :
> > On Mon, May 05, 2025 at 11:48:45AM +0000, LEROY Christophe wrote:
> > > Hi,
> > > 
> > > Could you please apply commit 6eab70345799 ("ASoC: soc-core: Stop using
> > > of_property_read_bool() for non-boolean properties") to v6.14.x in order
> > > to silence warnings introduced in v6.14 by commit c141ecc3cecd ("of:
> > > Warn when of_property_read_bool() is used on non-boolean properties")
> > 
> > What about 6.12.y and 6.6.y as well?  It's in the following released
> > kernels:
> > 	6.6.84 6.12.20 6.13.8 6.14
> > 
> 
> Ah ! it has been applied to stable versions allthough it doesn't carry a
> Fixes: tag.
> 
> So yes the 'fix' to ASoC should then be applied as well to stable versions
> to avoid the warning.
> 
> Note that it doesn't cherry-pick cleanly to 6.6.84, you'll first need commit
> 69dd15a8ef0a ("ASoC: Use of_property_read_bool()")


Now queued up, thanks!

greg k-h

