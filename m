Return-Path: <stable+bounces-135237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB42FA97EE4
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 08:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3272F7AF0DF
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 06:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B71F265602;
	Wed, 23 Apr 2025 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PDfF0pV8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED04221FF20
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388711; cv=none; b=Id5ofDBjcvcNcxvEZJ5oAszAtTDYz5evYNVOHiE8gm1GZglZkPDYfOLD56+mpebwKg0vPEjmmSfLzwko4vFL4MuvuCdz5M4vFkjOeRwPf/Os0/PSt5gNDe8S1ZwvixHfHYWH9qM8yTXIstO7LCNxXT4UDU/pQsIGmPMacRH0n7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388711; c=relaxed/simple;
	bh=2DjKR6ud7hzYJiVTIULDnA5FjF0BQ7I5hc1KLhmg2eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVTmiGxamLtc2BfnXbVoGgT+I15vapxnlGky0DEK9Zz74XqyVvOpnijZ14vH1xf14iT7vEOROTWA5XWUDxy6VP4YXwC06uKj230y37WxL6cTvIX2lidUmzfs6nOmV0a3QW8rcI0Nys0rS5j7I6osW7mZrt1NuNR8BA0BQt1KXi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PDfF0pV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C895C4CEE2;
	Wed, 23 Apr 2025 06:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745388710;
	bh=2DjKR6ud7hzYJiVTIULDnA5FjF0BQ7I5hc1KLhmg2eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDfF0pV8Bz1A/XGRWWapE2Gfq5pyzHpQMHSRcKXWs7Oq4hHuXYMRfEmR6IG8v609o
	 F5L8DxA6C4lxHPfX9P+5d9dyM1K0Kp0fCV+3h//DhIzMSEgc/O2U0mbJtfpyHn3PfB
	 IUnaIvLLO2QOHBVqC+KUEj4OkF5ZYBuNNyINtffA=
Date: Wed, 23 Apr 2025 08:11:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y 4/4] mmc: sdhci-brcmstb: add cqhci suspend/resume
 to PM ops
Message-ID: <2025042330-primal-starlit-d77d@gregkh>
References: <2025032413-email-washer-d578@gregkh>
 <20250324221236.35820-1-kamal.dasu@broadcom.com>
 <20250324221236.35820-4-kamal.dasu@broadcom.com>
 <2025042202-profile-worshiper-c2b0@gregkh>
 <CAKekbevHy0v78=3QmDeOWTXCX+oj5zxixw19Wz8VKLByA+MygA@mail.gmail.com>
 <CAKekbetDRWC5FfO1KvcMrwbUwr2V3MWX6_YQHifOd+J0KWSEaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKekbetDRWC5FfO1KvcMrwbUwr2V3MWX6_YQHifOd+J0KWSEaA@mail.gmail.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Tue, Apr 22, 2025 at 12:36:42PM -0400, Kamal Dasu wrote:
> Greg,
> 
> Do you want me to resend v2 for the series or just the Patch 4/4 ?

Please resend what I have not picked up already.

thanks,

greg k-h

