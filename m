Return-Path: <stable+bounces-87714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2289AA17E
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 13:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6561C224CF
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 11:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756A919DF4F;
	Tue, 22 Oct 2024 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jDNQOwz4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287D619CC00;
	Tue, 22 Oct 2024 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598062; cv=none; b=Vn0YOfAYSn+rPjeEXkD1v6o/ygQQvcJ3SgrIicbN9T5OPeXEQSgBgYKlGiJME4mpLmeVyGsd9ae0oh1r5PYGd5MbNIS0Sy/tCeGttT00L6l3L2N4eKlWKEHMYvs7t/yBWLkk8o5unj41eKEcvdJ3ZfueDG/zX9S/3zMC47ukLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598062; c=relaxed/simple;
	bh=G/kbwQLjdr9WblhnfaCAq2D6cyH7ZviTQFM+Gi3kM3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxjiLedWFYgh6xDtl29msOdcWznXRokOl2UoQra9ETkGt5F3gmn3ut/QSHnKFoke+2X+ljKhuxwA845nVvYXPcjNfVOvDCu3yS4QzjWKq89sSMesBWkCtetW9gKixp57M++4HQT607EY7VMFYEqHQwJhuXimOmUbX1ogtTq81aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jDNQOwz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C95C4CEE6;
	Tue, 22 Oct 2024 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729598061;
	bh=G/kbwQLjdr9WblhnfaCAq2D6cyH7ZviTQFM+Gi3kM3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDNQOwz4h3o7F2LuRcfSkFx4n/KBLHAEN4Z89X8ucny+gBsKvdm9GhoxFKnbqoMwd
	 i8EG9TmUmf4vF25owqjOUHh0X+HLcBlSoUsJBLtiUjeyZ4b6p/Zn5MClmvx7lmFq/K
	 5mdgSag9XegiagqlJWBsMiHvznKktSAAKOs96fsI=
Date: Tue, 22 Oct 2024 13:54:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Liao, Bard" <yung-chuan.liao@linux.intel.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	mstrozek@opensource.cirrus.com,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	bard.liao@intel.com
Subject: Re: Request to backport "ASoC: Intel: mtl-match: Add cs42l43_l0
 cs35l56_l23 for MTL"
Message-ID: <2024102229-pueblo-swell-019e@gregkh>
References: <448a5371-75d5-4016-9e6d-d54252c792b4@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448a5371-75d5-4016-9e6d-d54252c792b4@linux.intel.com>

On Tue, Oct 22, 2024 at 07:31:42PM +0800, Liao, Bard wrote:
> Hi,
> 
> commit 84b22af29ff6 ("ASoC: Intel: mtl-match: Add cs42l43_l0 cs35l56_l23
> for MTL") upstream.
> 
> The commit added cs42l43 on SoundWire link 0 and cs35l56 on SoundWire
> link 2 and 3 configuration support on Intel Meteor Lake support. Audio
> will not work without this commit if the laptop use the given audio
> configuration.
> 
> I wish this commit can be applied to kernel 6.8.

6.8.y is long long long end-of-life, so there's nothing we can do there.

Please remember you can always look at the front page of kernel.org to
see the currently active kernel versions.

thanks,

greg k-h

