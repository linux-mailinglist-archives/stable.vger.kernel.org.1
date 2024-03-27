Return-Path: <stable+bounces-33019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3125B88EDF0
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 19:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41A61F3B985
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 18:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C084F15538A;
	Wed, 27 Mar 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gzKAwXym"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2F1552E8;
	Wed, 27 Mar 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562972; cv=none; b=MbP1+O1nM4Bu9oLnKU87yv0cZvYibIP6zRKBk8EvtZsc+VPOn6GPWBnt/ur/mi7UOjWegso2LFRuztCqBXCo6dE0/ymi8d5L3+/7IPu6hQDn697Vxc2X6A5j1ns8qP76TR7wuN1+RQh8Skp5FSJG1pJdRquHV9VwsyqiTjDBw2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562972; c=relaxed/simple;
	bh=qtWZgi5QBm0SCbto8hi6UhEJ03WzPF1KliPiVyW63FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jibs0wS3gkTzp2JkihjvZXN3oIv2SCe17mXq/mw3x8B4paTN3RBCAFP/q5PkCqJti9hC2btmbYVkpHg9GCCddbESa/4IrVJO+DMCKfRKsK7cUa0C7nNE/jYNRxVPwoZmq+oQxd0WEkffthnkHaUOmFAW4SW5qFEzvqYcZ8MOJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gzKAwXym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1BAC433F1;
	Wed, 27 Mar 2024 18:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711562971;
	bh=qtWZgi5QBm0SCbto8hi6UhEJ03WzPF1KliPiVyW63FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzKAwXym7gt5z+7+LKhsmQinPNmuUC4V2spV5WOqnqTI3Ckeb6QOJo99vCknWixAv
	 wI8P11ukL399l1taJy/yHEeJD0zIQedgShTO9CNNm8jJVNUdlCGUjFi/vd/v618XpX
	 x8RcX/WWzebi02chokjOAg+YY70ywYmkPxIOrb1U=
Date: Wed, 27 Mar 2024 19:09:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Jiawei Wang <me@jwang.link>, Mark Brown <broonie@kernel.org>,
	Mukunda Vijendar <vijendar.mukunda@amd.com>,
	Sasha Levin <sashal@kernel.org>, linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] Revert "ASoC: amd: yc: add new YC platform variant
 (0x63) support"
Message-ID: <2024032722-transpose-unable-65d0@gregkh>
References: <20240312023326.224504-1-me@jwang.link>
 <bc0c1a15-ba31-44ba-85be-273147472240@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc0c1a15-ba31-44ba-85be-273147472240@gmail.com>

On Wed, Mar 27, 2024 at 06:56:18PM +0100, Luca Stefani wrote:
> Hello everyone,
> 
> Can those changes be pulled in stable? They're currently breaking mic input
> on my 21K9CTO1WW, ThinkPad P16s Gen 2, and probably more devices in the
> wild.


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

