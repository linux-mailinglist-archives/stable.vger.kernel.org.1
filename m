Return-Path: <stable+bounces-50472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126AD9066F9
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC3E1C22494
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8C113D8A4;
	Thu, 13 Jun 2024 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RmUUNPxE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4813D88D;
	Thu, 13 Jun 2024 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267736; cv=none; b=PtmelGW/rY/2pLUbZrZKyKR6bnC9wWkk+c3/Mhm8EIBT7wmTgmHztKyHoh2R2y2LzizIRzTNAt323ESTO+34MWhYuxO0uBpy+ppzHqJndxx8cQogpRWS964O+40pDPXYgBJYrOGqoxina14DcUZsc6mfL7Da3IB18zJrDuGbUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267736; c=relaxed/simple;
	bh=N5DdWMPrASkdOuejzNT9p5ae0XXAvRm5RgjLS6GQ1/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtbqSd07cy7IAY94H76KTdofcu17KnROvT5eScQN08xgR2FcLx8AXmSWVnQ+FNa00tBzhSIMUonzsL/MbFqAq0P26czPnFYPxGARws6ehPsFzqO9nPsjtO69fvMKmyMouYEM0VyfFz7aiQHjh0CzShh4uPR+F29LOqR3eUVGhAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RmUUNPxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E9CC2BBFC;
	Thu, 13 Jun 2024 08:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718267735;
	bh=N5DdWMPrASkdOuejzNT9p5ae0XXAvRm5RgjLS6GQ1/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RmUUNPxEkfMAMxFwjy0Y6fXcIbGtO92rxcHlhVIAunOykVeMfVPwqXfnNCA6XVSe4
	 25ssDEZnPmkcejrd0VmfoKvrtvVEcm6e3zWC/87cy2pJFii4LmURm3ak0J5xtwBQTc
	 YTeR9feZSVNmG2MfQSsV1tuSOHop9NmwKvyYJy0w=
Date: Thu, 13 Jun 2024 10:35:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ismael Luceno <ismael@iodev.co.uk>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Intel e1000e driver bug on stable (6.9.x)
Message-ID: <2024061323-unhappily-mauve-b7ea@gregkh>
References: <ZmfcJsyCB6M3wr84@pirotess>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmfcJsyCB6M3wr84@pirotess>

On Wed, Jun 12, 2024 at 10:33:19PM +0200, Ismael Luceno wrote:
> Hi,
> 
> I noticed that the NIC started to fail on a couple of notebooks [0]
> [1] after upgrading to 6.9.1.
> 
> I tracked down the problem to commit 861e8086029e ("e1000e: move force
> SMBUS from enable ulp function to avoid PHY loss issue", 2024-03-03),
> included in all 6.9.x releases.
> 
> The fix is in commit bfd546a552e1 ("e1000e: move force SMBUS near
> the end of enable_ulp function", 2024-05-28) from mainline.
> 
> The NIC fails right after boot on both systems I tried; I mention
> because the description is a bit unclear about that on the fix, maybe
> other systems are affected differently.
> 
> Best regards.
> 
> 
> [0] HP ZBook 17 Gen 1 (D5D93AV) [8086:153a (rev 04)]
> [1] Lenovo Thinkpad P15 Gen 1 [8086:0d4c]
> 

Now queued up, thanks.

greg k-h

