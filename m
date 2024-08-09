Return-Path: <stable+bounces-66281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A155D94D34E
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 17:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58ABD1F21E7E
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEB3198E79;
	Fri,  9 Aug 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKnN2ail"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB43198E6D;
	Fri,  9 Aug 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216886; cv=none; b=f44ZW+QvgCfxeIHU3PdbPEwUbqO64wS77lnFwVoPqnuC3uwowP3dsmMMgqcLR1EoSmei9jhjDU5QWHJjs0+2nBIG5ePi+QTlGr9ViQZZorYvuDJm3bOvGMGrm66zaP8ajXGNKlA4nOhQmDsuWQ9w6MYTLw6dzOmSA10kqgZI4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216886; c=relaxed/simple;
	bh=2D0UJ9CPvkXheq8AuRIAqUI7JO96fv77PhT9a5EEqBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mgl4+NuMcMlavWkooTIMGaVOXDgmm2vRfHF183Yd4xwLTOLrJFcgVgNLEI1qoyp1VduWuRBDFgKP1y11ndoFnw7DTxdnbKnruzerU72nmz1U1IbZueW7Ow3xBI4KDAsicpxU3MxGF5x0AcomcpegdiXxCl1n0iyAiHxBBTw17+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKnN2ail; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C83C32782;
	Fri,  9 Aug 2024 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723216886;
	bh=2D0UJ9CPvkXheq8AuRIAqUI7JO96fv77PhT9a5EEqBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NKnN2ailXGRJUG8fDp3X703mPXgBpsdt4BPIhOoq6utEKFmD6oJY7wtTN7yaVui27
	 9z9SRQaKHEz5OW50JA7cxUYFWDv1IiroibC30XgUzTbgchFqTse0d9x6MqNiUbskfI
	 dI2m0SxpRnLanXnoMwBTuRnsV8oCJu6zE6J8LB3sOQKEgwvvM1DDSX8DoWpvj0T6Ct
	 D6neMHdrKRYiptjowBe+Q+geho0y3xY2GuZwJE5V1m9sFzTuoM5AZez6zxaARflhyw
	 27qmLth4ZkAALz7M/uN3S8PFXBhp5/X6GrXaDWuY0fS9KBHZhAupvAdANqJSUFKdg1
	 vuEdmJRdNhB3Q==
Message-ID: <c2334dc1-d036-434f-8632-6583138f9176@kernel.org>
Date: Fri, 9 Aug 2024 08:21:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED][STABLE] hdparm errors since 28ab9769117c
To: Niklas Cassel <cassel@kernel.org>
Cc: Christian Heusel <christian@heusel.eu>, Igor Pylypiv
 <ipylypiv@google.com>, linux-ide@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, regressions@lists.linux.dev,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu>
 <45cdf1c2-9056-4ac2-8e4d-4f07996a9267@kernel.org>
 <ZrPw5m9LwMH5NQYy@x1-carbon.lan> <ZrYn9CL1uLJEwpdT@ryzen.lan>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZrYn9CL1uLJEwpdT@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/08/09 7:30, Niklas Cassel wrote:
> Hello Damien,
> 
> If we want to no longer respect the D_SENSE bit for successful ATA-passthrough
> commands, e.g. by replacing the ata_scsi_set_sense() call with a
> scsi_build_sense() call in the else clause:
> https://github.com/torvalds/linux/blob/v6.11-rc2/drivers/ata/libata-scsi.c#L955
> 
> ...then I think that we should also replace the ata_scsi_set_sense() call with
> a scsi_build_sense() call for failed ATA-passthrough commands too
> (in the non-else clause):
> https://github.com/torvalds/linux/blob/v6.11-rc2/drivers/ata/libata-scsi.c#L952
> 
> ..however, that does not sound like a very nice solution IMO.
> 
> 
> Another option, if there are a lot of user space programs that incorrectly
> assume that the sense data (for both successful and failed commands) is in
> descriptor format, without bothering to check the sense data type, one option
> might be to change the default value of D_SENSE in the control mode page to 1
> in libata's SATL, i.e. set ATA_DFLAG_D_SENSE in dev->flags by default.
> 
> That way, we will still respect D_SENSE while generating the sense data
> (in case the user issues a mode select to modify the bit), and the default
> will be to generate the sense data in descriptor format, as it has been
> since 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through sense").

That indeed should be acceptable. And we should also patch hdparm to properly
look at the sense format and not assume descriptor format by default.


-- 
Damien Le Moal
Western Digital Research


