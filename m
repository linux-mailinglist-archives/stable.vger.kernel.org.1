Return-Path: <stable+bounces-60691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BC3938F42
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 14:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29ECA2814CB
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3226316CD35;
	Mon, 22 Jul 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN0fc4on"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5AC16A399;
	Mon, 22 Jul 2024 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652381; cv=none; b=RbFOApaBZWfsv1Aa68HeeO8+Y+kz7ZET0cgmDt/GV+vZ+Df6QTLKlB19y+KjLjZGteZ9kZYfe9ptVp5aPXtgu7SHi5Bbe3QqeO1uRLfjwkiQrNrhPVSvYnsUjE6N4rDrtawIbt2QIRer3+DRZgLZhsFZhHR1mTUexy68YSvo5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652381; c=relaxed/simple;
	bh=1HKmNtpBLaJ/1itDqyN89g/bbmGsW4YT3x22U21KFmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crxntCwhGE4bm7Xsa0LuDJueVQMswsd3Ch7ra5arQV5wbVzcLjajtDvxQ1Qd0wgZuF/Hr47Cwr1rh4hxe4ygy1sTINu3iM92DJspbsb1CqlSLvn/yH5C31syjWM9AQY2GvC9hrwgbfp731oULZIyOxemZdH9kqmECt9v3tPe2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN0fc4on; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FF7C116B1;
	Mon, 22 Jul 2024 12:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721652379;
	bh=1HKmNtpBLaJ/1itDqyN89g/bbmGsW4YT3x22U21KFmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PN0fc4onvI2E9OF63pGR4CC2W3tUn1cshDFhjN0l95Ijb0ETIPFwiQZU31ALXP/dn
	 jgb8La5ToaIwdgMsO959lbUc/ssc91OOIyWZYslnvoJw5Om5lKt3jRFBp2woOipX9l
	 Bax2LD7fYLZiIHGyxHgJ3uu0Due+T0kpSLomFO4OgtElSUXVafW4jU9f9ry4dJSyML
	 7F2r00YjzP2Xz60klbPFcLgt1wRZBPrxU7wCnqRbSiZ3tECx02JH2XTlic02C3i+hH
	 RDtmd36sqLtV8touE722DXW6yVWIb7J1JepEk4YBm+anOC/M6xDqxi5m9wvdttqcNg
	 C2wplJ6bk4TOQ==
Date: Mon, 22 Jul 2024 08:46:18 -0400
From: Sasha Levin <sashal@kernel.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Agathe Boutmy <agathe@boutmy.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, matan@svgalib.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 08/11] platform/x86: lg-laptop: Remove
 LGEX0815 hotkey handling
Message-ID: <Zp5Umno8LyWoP03J@sashalap>
References: <20240709162654.33343-1-sashal@kernel.org>
 <20240709162654.33343-8-sashal@kernel.org>
 <4d5e5d39-d53c-4650-8729-01cf0bf478c6@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4d5e5d39-d53c-4650-8729-01cf0bf478c6@gmx.de>

On Tue, Jul 09, 2024 at 06:35:36PM +0200, Armin Wolf wrote:
>Am 09.07.24 um 18:26 schrieb Sasha Levin:
>
>>From: Armin Wolf <W_Armin@gmx.de>
>>
>>[ Upstream commit 413c204595ca98a4f33414a948c18d7314087342 ]
>>
>>The rfkill hotkey handling is already provided by the wireless-hotkey
>>driver. Remove the now unnecessary rfkill hotkey handling to avoid
>>duplicating functionality.
>>
>>The ACPI notify handler still prints debugging information when
>>receiving ACPI notifications to aid in reverse-engineering.
>
>Hi,
>
>this depends on other patches not in kernel 5.4, please do not use this
>patch for kernel 5.4.

Ack, I'll drop the two patches you've pointed out.

-- 
Thanks,
Sasha

