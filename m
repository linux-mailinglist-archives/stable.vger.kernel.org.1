Return-Path: <stable+bounces-89583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693B89BA562
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 13:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA1B1C20E90
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 12:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7803916FF3B;
	Sun,  3 Nov 2024 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdItWd2e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321521632F8;
	Sun,  3 Nov 2024 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730635392; cv=none; b=f0l+T3ebkA4285wI5T56+qm2BAtn3uCFKETQD/EU5EVxJixrw47kKH/zKvbam7BGMMgyQvvzln8mE2lsY51/5ecUhY8nevc9aepnJaAQ3+0VZMbi0giZKhA2jlbBH069q+CsSnj5A8df8sJvUajUBEKHZ+8TyqOcY/xQ3PW7jj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730635392; c=relaxed/simple;
	bh=7DNL/zqt6rswpcsypF29HfVyVB/m/i17V8Atc8eSREo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDpotKFt9j9wE/Sb95m6ByVqZiJ27zkTIOJWGqgh3QF8HN1oarUA/TXesVbHhBTaGLd+XViLm7qZC+Xx6ZeLp/mHvWcvLDlhYM9qWILRgtZIjQ/bBgXXWoBcYaDvtB7t7nabj9vP9huVFvKXbGfmmrR+029Ed6WZ8WrCXh+t8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdItWd2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23535C4CECD;
	Sun,  3 Nov 2024 12:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730635391;
	bh=7DNL/zqt6rswpcsypF29HfVyVB/m/i17V8Atc8eSREo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdItWd2e69lfEZB6nG1wrltD2FleqDLQVXTrQ9ktTZVphYA4rv2eYcwAtqR23L7ub
	 +LXmO4OzJESZuPK33zZ2xfZ4eDTPlezxFMoFShdKlWqmHsY0fBGLxxf0od17ho/xJf
	 PysgFlB/EDL5Py5YoPwbNC0LIlvuXlnlVZCKSEBju2wbxcBkaOEWFYoSj7wVTN/+/O
	 SoEiF48JYp/fTOcmnNarUociVyJ4ICu6RdubTEGCIlSwB+QP22GsYMcIcmHazIyt/4
	 /rsoeb39dCTn0boAJniV1TW+Ahla1cAGYbixT5uJA0l6MRhzoRbXru2o3D1hmcDxeG
	 5WOK3zai+2BBw==
Date: Sun, 3 Nov 2024 07:03:09 -0500
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
Message-ID: <ZydmfW54l53nDdgl@sashalap>
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

It looks like a bug in my scripts! Thanks for pointing this out!

-- 
Thanks,
Sasha

