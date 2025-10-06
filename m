Return-Path: <stable+bounces-183423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09185BBD994
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 12:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 234C44EC3E6
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 10:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB62E22F383;
	Mon,  6 Oct 2025 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B6mPGJEU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0B722DF95
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745051; cv=none; b=rcb6bOg8t3zrzxbKpuNR9d5CgvdsOSgtZ5C78oCYBH4/7kawoV7SUjeSiIHq7r5shCL+lQAvHpdmNZA5aoR39BvQI7n1t9CmlRK6uunimaZBHdJsvrXWfFhZPb7V7Mq7z/3iccTKcL+H+yYIO8Roo8MJKijVgDcHRXb+je0Vxvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745051; c=relaxed/simple;
	bh=ZodNcP9XZMFAlZIEv94Epv7oy+W/iw/ONeixjaqxH8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErcBVBBN3JBdYbX9+IIdFBcmSzoJApkoyaD7ywvzalj1AWO0kBECDmXO4/Le6EmLPvElXUBm/8O8CWnT3OeQC8gEFXPorqNmVJigCm7fQB+sweksChSvIte9S2UdffRtGrh2J10xY34X+O8BacqjURr4yUlYfrVuUlis7Y00CzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B6mPGJEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB003C4CEF5;
	Mon,  6 Oct 2025 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759745051;
	bh=ZodNcP9XZMFAlZIEv94Epv7oy+W/iw/ONeixjaqxH8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6mPGJEUEc2nKdkbmFd+kDIXBm4pRkZP4JNzy5jkYsuGEfu06y9xvsXXKIPs2DNAq
	 Br/MUk3d6ODWv27Lu9jZ/oLCtUUSJt14nAL1p8rxBfzmOGlVDp31gY9QU9fx5TuSDM
	 mK+9i3aCV2d+33YujaPVSpitWHAkgmaTD5AuUj4E=
Date: Mon, 6 Oct 2025 12:04:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: stable@vger.kernel.org
Subject: Re: 71d2893a235bf3b95baccead27b3d47f2f2cdc4c
Message-ID: <2025100600-repose-extended-6758@gregkh>
References: <c3e98ccee91993c1d0c3df4556ac172ae04234aa.camel@irl.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e98ccee91993c1d0c3df4556ac172ae04234aa.camel@irl.hu>

On Sat, Oct 04, 2025 at 10:47:47PM +0200, Gergo Koteles wrote:
> Hey Greg,
> 
> I think this commit should be applied to v6.16 stable, because without
> it some speakers may be damaged.

Now queued up, thanks.

greg k-h

