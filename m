Return-Path: <stable+bounces-127305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C3EA77798
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8825C3AD4C7
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 09:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F481EE02F;
	Tue,  1 Apr 2025 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RWr7Iu41"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920F1EE007
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499119; cv=none; b=trFdgIsC0Rs/pm+VKsrXrbL/ZMdMRFPqdglb7qBPcqGFEkhYetrcBgSCgYu1NUt2ak24TaUNqAHuE8zIkdoa/a5G+IIAgiEe5XMqUALio9elUEkZZgqIXRvfDY12vM7B3LG6ewjH9uWY/71g7v8aCYrnJYC5R7hf8ooO/aFAn5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499119; c=relaxed/simple;
	bh=63gzgVHfMTEcRWWIBWDGc7brFPxWTCw3fA5FNOsAJ4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMJNzHoieMMUFfzCaYyLJWGs/11TSNXquSNvRL4CcCqACIEISciC4BCHAQMpvKSChGZ8mE3KkJf16Mrc9YbZ6rrZPWYjThRX0cm40AGgtB0qn6ye1kkgaIdkBnSk4SrZ1luQZ54ZSu5RyX0Wyo1ci6pMbmCMXpPxh1iqN8Zh/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RWr7Iu41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7374BC4CEE4;
	Tue,  1 Apr 2025 09:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743499118;
	bh=63gzgVHfMTEcRWWIBWDGc7brFPxWTCw3fA5FNOsAJ4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWr7Iu41AVHLmtfPPDcCl7Eiuu66lnSF1r63f+A2A9sQfBuxMnEFGEmoNydLLQ77P
	 6SozwwfJlk4k+QmGDYxnZSTO8Xw14PpThNtw2pXzOWMvtohrLY1SLFcp2vqjo5Yjwd
	 kL8iKXm8PlzPdIlwDtthzHOe/qyYJ5toq0OHpotw=
Date: Tue, 1 Apr 2025 10:17:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: Laura Nao <laura.nao@collabora.com>, stable@vger.kernel.org,
	Uday M Bhat <uday.m.bhat@intel.com>
Subject: Re: 5.10 kernel series fails to build on newer toolchain: FAILED
 unresolved symbol filp_close
Message-ID: <2025040121-strongbox-sculptor-15a1@gregkh>
References: <34d5cd2e-1a9e-4898-8528-9e8c2e32b2a4@manjaro.org>
 <20250320112806.332385-1-laura.nao@collabora.com>
 <0e228177-991c-4637-9f06-267f5d4c0382@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e228177-991c-4637-9f06-267f5d4c0382@manjaro.org>

On Fri, Mar 28, 2025 at 07:06:10AM -0400, Philip Müller wrote:
> Yes, I can confirm that with the current stable-queue patches on top of
> 5.10.235 it compiles. I only had to not apply the following patch
> 
> ASoC: Intel: sof_sdw: Add support for Fatcat board with BT offload enabled
> in PTL platform

I've dropped this commit from the queue now, thanks.

greg k-h

