Return-Path: <stable+bounces-89584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FBA9BA568
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 13:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9A4B2126B
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 12:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427BE167D80;
	Sun,  3 Nov 2024 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRiQ51mk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5915C13E;
	Sun,  3 Nov 2024 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730636815; cv=none; b=HmZSAOSq1HGR8EaSGJrpODyutRrKhn8hAV7cS3aEibeiYIiXndDtSCUIcEFZvQWjwm5l/1cwwNtEJ4v0+oGtH0veDj0uV5/XG/yuj55hVPuka/soIZUy0Lkqt1ijnROfIBz6L8js/00pC4+maZHljMHREkLLzdUvpcGwMo72+Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730636815; c=relaxed/simple;
	bh=CFu8EXuLeAPBM1k/RypaGR9NzCkA0Ja3O9xlJ7YHyvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mp5DMde/ZgqYruwhNyYvICU0b+RBPqLwYhwLeIaFHTwwXFo8HdPhdHGUqrgZUslDupSxwwlRmq1DjHUCA/6Dt5ZCoWZBGuPkGxeRsM3tCD4uilM0Alyth0gIAZUpUoyu9OSfE+0cu/Pyf74wI9xa0umvIbH1KIAoqWw8x8M6bxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRiQ51mk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F14CC4CECD;
	Sun,  3 Nov 2024 12:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730636814;
	bh=CFu8EXuLeAPBM1k/RypaGR9NzCkA0Ja3O9xlJ7YHyvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRiQ51mkXxWXH284sUByo+95QkTDyW11VXe3jniA3KlZHBt2p2CjSIpcEaY+R6NFD
	 l3tbDaeRMxhHnqIPqish1golipszPo+eKGATkcjZeB8xqnDu1SirTUYuc7z5B+EsnB
	 P4nwwGJhONy4QwhZK5VcZ4Fy4RMeXVTblzoYyLUVgtsI6KDcQgiKgt/rFUFo0SRoOF
	 guJ7uBmM1pZd9CsYR2vFCYxjR9Io4n9a/TuHxv+eydOxKbFRYthkSqaGEJxTJ9+6Rj
	 CeZhLYfyBfT0mIpvybag3C0VUddwnZ/EXJyDP+JYIzVQNn1qiothy3Th6z9TCmpS2P
	 2jBanTn4dhZyQ==
Date: Sun, 3 Nov 2024 07:26:52 -0500
From: Sasha Levin <sashal@kernel.org>
To: Conor Dooley <mail@conchuod.ie>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	m.falkowski@samsung.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Inki Dae <inki.dae@samsung.com>
Subject: Re: Patch "dt-bindings: gpu: Convert Samsung Image Rotator to
 dt-schema" has been added to the 5.4-stable tree
Message-ID: <ZydsDGB12rGQVB4r@sashalap>
References: <20241101192914.3854744-1-sashal@kernel.org>
 <61548681-29c3-4348-a048-658747c0212a@conchuod.ie>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <61548681-29c3-4348-a048-658747c0212a@conchuod.ie>

On Sat, Nov 02, 2024 at 01:42:51PM +0000, Conor Dooley wrote:
>On 01/11/2024 19:29, Sasha Levin wrote:
>>This is a note to let you know that I've just added the patch titled
>>
>>     dt-bindings: gpu: Convert Samsung Image Rotator to dt-schema
>>
>>to the 5.4-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>>The filename of the patch is:
>>      dt-bindings-gpu-convert-samsung-image-rotator-to-dt-.patch
>>and it can be found in the queue-5.4 subdirectory.
>>
>>If you, or anyone else, feels it should not be added to the stable tree,
>>please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>>commit 25cb1f1f53fe137aefdc5e54bb1392098c4200ed
>>Author: Maciej Falkowski <m.falkowski@samsung.com>
>>Date:   Tue Sep 17 12:37:27 2019 +0200
>>
>>     dt-bindings: gpu: Convert Samsung Image Rotator to dt-schema
>>     [ Upstream commit 6e3ffcd592060403ee2d956c9b1704775898db79 ]
>>     Convert Samsung Image Rotator to newer dt-schema format.
>>     Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
>>     Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>     Signed-off-by: Rob Herring <robh@kernel.org>
>>     Stable-dep-of: 338c4d3902fe ("igb: Disable threaded IRQ for igb_msix_other")
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>How is a binding conversion a dep for a one line driver patch that
>doesn't parse any new properties?

As a follow-up: this happened due to a toolchain upgrade to GCC 14.2.0,
I'm looking into fixing it...

-- 
Thanks,
Sasha

