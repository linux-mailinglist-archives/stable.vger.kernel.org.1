Return-Path: <stable+bounces-45423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12798C9403
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 10:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F1A1C20BDD
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 08:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCFB224FD;
	Sun, 19 May 2024 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="hne29QXt"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9628C168DC
	for <stable@vger.kernel.org>; Sun, 19 May 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716107929; cv=none; b=RjU8pT7JuNcQmJJY7mTYANvXd9vkeMpD2mSM//IQdCshqY8skP4AqAduKjpPD3c9EhCsAdydyNDwz8El5FWDPSBaRHDJdEX3wZOe01TRBUctWf4BoUMzGMcLxxFnKBIJgT8XQzBLxkY93qe4ojMF2Z8OX/aQF8pXUANuh1t1cUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716107929; c=relaxed/simple;
	bh=Du2Y8Pm+BeB5GJi1zAHRHyRdw3R5kZCONZrNl7nimOQ=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUEU/ZH+m40XbcMt5YaNz2253/h16KDq9YxrVseWe+P65ofOgGmHHHW6vn8xu0dp8ThNkIEoC6tJ8tULWqslsracdNPQsEIQogaeu62OD18r5EAjXukDTu3I3UlfHKTFeK0uUFNv1Oq9m9aM4Z6fQLnqu064hPJtjZvP6Y368Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=hne29QXt; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Envelope-To: gregkh@linuxfoundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1716107925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ALhTuFCl+xDBBgYqvj724VRdAi7vbLj/mUFJEgqiVPo=;
	b=hne29QXtJjrcxaLyWq1GR5KjdvtslyKJAfsNe/lY52p7fljYwGRk2yJQSvw2+4TJUjZuZC
	enLq5HCIP1mhgjZXZEqvNf5kw8YhiUeWvEt1s2Wyje0Qzf7qJ0SajsGqPgS5qHlKPI0VbU
	DIumx6DmLmU0Ij7OZ7j6zgTZpygCQLf1OeCda+Db3aLESnBvgbHO1iqYCVqKdltOx6XLR1
	hQC7AlulUSDLwynPy0+5rSDzm8mJT4fBFnGqA8pIAaXIzJjyB+gnafmbLaP9N+Rfn9WnYo
	uq99QKgWzqITqZ4l7euj2Y6otWcpvD+ri9wpNlbeL4PoZ8pRU3XXAOgomi+toA==
X-Envelope-To: stable@vger.kernel.org
X-Envelope-To: hjc@rock-chips.com
X-Envelope-To: heiko@sntech.de
X-Envelope-To: andy.yan@rock-chips.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Sun, 19 May 2024 05:38:24 -0300
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
Subject: Re: [PATCH 1/2] drm/rockchip: vop: clear DMA stop bit on flush on
 RK3066
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>, Andy Yan
	<andy.yan@rock-chips.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Message-Id: <0C5QDS.UDESKUXHKPET1@packett.cool>
In-Reply-To: <2024051936-cosmetics-seismic-9fea@gregkh>
References: <20240519074019.10424-1-val@packett.cool>
	<2024051936-cosmetics-seismic-9fea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Migadu-Flow: FLOW_OUT



On Sun, May 19 2024 at 09:59:47 +02:00:00, Greg KH 
<gregkh@linuxfoundation.org> wrote:
> On Sun, May 19, 2024 at 04:31:31AM -0300, Val Packett wrote:
>>  On the RK3066, there is a bit that must be cleared on flush, 
>> otherwise
>>  we do not get display output (at least for RGB).
> 
> What commit id does this fix?

I guess: f4a6de855e "drm: rockchip: vop: add rk3066 vop definitions" ?

But similar changes like:
742203cd "drm: rockchip: add missing registers for RK3066"
8d544233 "drm/rockchip: vop: Add directly output rgb feature for px30"
did not have any "Fixes" reference.

~val



