Return-Path: <stable+bounces-127493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B039A79F91
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 11:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398D93B7CEF
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204021F2BAE;
	Thu,  3 Apr 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lzPGB4Nt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64111E5B8B;
	Thu,  3 Apr 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670845; cv=none; b=sGDlS4qClbGleRwaKMKY5Bf/xW60JLn2WqeLI1CElH63dVHXVulXhD7ODq3l40dSqW2/+GHh/sc6hVkiEAUL/ReXaKe6CFbvNZUiC2q2sYkBk5O4HBYOxwmBRp1sTMSI1uVDhyJNB4GNOVICRNfH4NdjQxBjTvJZLUd1Gemz6Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670845; c=relaxed/simple;
	bh=WieTwftKJ4wIoBz+4UXZMSRR5q3d/MG41Yn+IFrvBkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTORRQslPSLW9co0PdImkUThjpVg72sio52oVYk4bYzw6tc8BHSksY7CwaATt3+Hqtmwf9Ab5CzumKdNxdqWR83YbK7xfFOCFDTzrfeTpFGCMU2/Yv8mhZMf9lANaUTiAj1YXHkiR9eYhXWhldVGkIor+fnkF8B4iKGqa9GwFSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lzPGB4Nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7480C4CEE3;
	Thu,  3 Apr 2025 09:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743670844;
	bh=WieTwftKJ4wIoBz+4UXZMSRR5q3d/MG41Yn+IFrvBkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzPGB4NtmFEwOJ+8kx/WZsDtdWgn1ueihPaqCjpqdxW+zYZichIiT5lD5FonrKK9K
	 0jU69pjMuyyxdayEXay4SCYHtwrOYYKBxIGaLgY6fQZ8/UgKYR7kfs8Z4GKJgWuH56
	 75tdHMRwBtVrHROXFf7U6JB54EMmX0PeiSnRTCDw=
Date: Thu, 3 Apr 2025 09:59:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Henry Martin <bsdhenrymartin@gmail.com>, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2] serial: Fix null-ptr-deref in mlb_usio_probe()
Message-ID: <2025040310-gangway-obvious-5122@gregkh>
References: <20250403070339.64990-1-bsdhenrymartin@gmail.com>
 <970e78d3-e3bc-4a34-9ba8-40df4823726f@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <970e78d3-e3bc-4a34-9ba8-40df4823726f@web.de>

On Thu, Apr 03, 2025 at 10:50:36AM +0200, Markus Elfring wrote:
> …
> > Add NULL check after devm_ioremap() to prevent this issue.
> 
> Can a summary phrase like “Prevent null pointer dereference in mlb_usio_probe()”
> be a bit nicer?
> 
> Regards,
> Markus
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

