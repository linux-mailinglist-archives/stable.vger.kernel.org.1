Return-Path: <stable+bounces-154700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C15ADF5B4
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 20:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDCD189F18C
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 18:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315BF2F3C33;
	Wed, 18 Jun 2025 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="OWIbdG1t"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030F70830;
	Wed, 18 Jun 2025 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270809; cv=none; b=CA8rE5+BB3QkvDxE2p3EpOMywW/g9OaaWFMrE7vX2WVZ0h8c/YvNAAV4OYxYhJ1OWys+AG8/5bipaelpSEWdAkYcFpX0rH1+rmcvakRL+wdX0PAlQnLFKb1JDfSN2C7ub7A24+Id/Dyr2ixVL0r3OslPzIFNg93VaxaXlJRG9+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270809; c=relaxed/simple;
	bh=C0yjYuxk9HEfAVtDgEMUSgUUtL7qGtI5gEuB1q0IKKw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8Xit75yk8JwFKfRanwArxg1+pq5hXFGP6XcvqLcrTnrRqcEbhCM0WcOHd3MSjROOkarAz3tWnMXFwrLJw2ytMxcLfHFQYiebp00j6YpnMMeTqnZpMu5Lo27+ociKMNE7/UaLxBOwy2dqFEDCG8FntdCpqaeIbwTI19qshNb2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=OWIbdG1t; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Wed, 18 Jun 2025 20:14:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1750270442;
	bh=C0yjYuxk9HEfAVtDgEMUSgUUtL7qGtI5gEuB1q0IKKw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=OWIbdG1tNktCSFk5VeupvwznvwdaCGlMepk1tbnH2uDepAACJrKBxNcitjX/0UU60
	 ZOYX4JAU6z57aOsRiVTKBqYTDkgqJjtlrM80JSFN5iICX/FiMzwutVf8x9jupVokKu
	 DTlT3DUADEup4KGv/xfTm+Nw96B7KoLL0EbhGqMyh37A5CSD37PBcUxpmXKJwowAbj
	 CxTIHjWWZ/fEb+zkCG1fHavbVmtJbZc+biofO+rThIuXjmVstvogVW3et+6VyH81c/
	 i077fyovLIYeENqte7A1NEWAjM9j4Fa1KmJb/UvZNoXYxZ/GJ7CRjN/g8cVusrE/ih
	 6FCw04YPQe0fw==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/512] 6.12.34-rc1 review
Message-ID: <20250618181401.GB8693@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250617152419.512865572@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.34 release.
> There are 512 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Jun 2025 15:22:45 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.34-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots on x86_64 (AMD Ryzen 5 7520U, Slackware64-current),
no dmesg regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

