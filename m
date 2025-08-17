Return-Path: <stable+bounces-169891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FB8B29368
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 16:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481814E476B
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 14:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D1629CB24;
	Sun, 17 Aug 2025 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PcY7eKah"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD115D1
	for <stable@vger.kernel.org>; Sun, 17 Aug 2025 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755439524; cv=none; b=upJ99b5ZO9u1xHor27uigkafmVEXhY1uTcucLVDruripZWhCUvSXSC5kB8y7FjVUjphkY3KbSUx7HQuRuJ3pp8qW8W64jYZZe7lddX2M3PZpcGY7FdX1rB5G4pM0s47zcXESBltGMb+CaI3zYGdGb2VQ0gBEHVu8Z8blZeMuuA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755439524; c=relaxed/simple;
	bh=PJ17ZBM8vnBMeQbb0Ut90UvV0t+Aze88KGdtfeCQtHk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0N6auuoSM+WYjWBSc2247acTKrnrqeJkUFIzJlI/JByLaF1UgBKziZW3VDrhMnK4OTWNyurANf0L5qV2YlrVB0n+XjKoH4wWrN7ciwQelF0jHNvkuXtl8LW03F5jMPBtVH7K43mTQec84C0rHlnuXQuCA8YPqiYeQY0EhbWVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PcY7eKah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695CBC4CEEB;
	Sun, 17 Aug 2025 14:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755439523;
	bh=PJ17ZBM8vnBMeQbb0Ut90UvV0t+Aze88KGdtfeCQtHk=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=PcY7eKahOqiTYt5oPuXr/3kpH3/QJm3pg/3q4mC8MIZoWilGyW915w5Xe1H/vGmuB
	 eCcxYkYW1RRTQ7NVn1epVNZMr76KhE+pv+clS130NPPu2j5Sn7puzVDZnAP6iMk+Qc
	 /VU2EFAN13kLQUX0pG7Z+wev1YGnwodFQC7A5IJs=
Date: Sun, 17 Aug 2025 16:05:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [REGRESSION] [BISECTED] linux-6.6.y and linux-6.12.y: proc: use
 the same treatment to check proc_lseek as ones for proc_read_iter et.al
Message-ID: <2025081751-accurate-eradicate-9456@gregkh>
References: <20250815195616.64497967@chagall.paradoxon.rec>
 <2025081615-anew-willpower-adca@gregkh>
 <20250817134329.GC2771@pc21.mareichelt.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817134329.GC2771@pc21.mareichelt.com>

On Sun, Aug 17, 2025 at 03:43:29PM +0200, Markus Reichelt wrote:
> * Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > > I have bisected the issue to the commits
> > > 33c778ea0bd0fa62ff590497e72562ff90f82b13 in 6.6.102 and
> > > fc1072d934f687e1221d685cf1a49a5068318f34 in 6.12.42 which are both the
> > > same change code-wise (upstream commit
> > > ff7ec8dc1b646296f8d94c39339e8d3833d16c05).
> > > 
> > > Reverting these commits makes xosview and gkrellm "work" again as in
> > > they both show network traffic again.
> > 
> > Is this also an issue in 6.16.1 and 6.17-rc1?
> 
> I can confirm the issue with gkrellm on 6.16.1 (and 6.15.10 fwiw).
> 

Great, we are bug compatible!

Please work with the developers of those changes to resolve the
regression in Linus's tree and then we can backport the needed fixes.

thanks,

greg k-h

