Return-Path: <stable+bounces-92210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3124C9C50A3
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 09:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2791F213D9
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 08:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DF420C002;
	Tue, 12 Nov 2024 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GcwqxcaN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1292920B7F6;
	Tue, 12 Nov 2024 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400232; cv=none; b=dyd4qwPQsNV3GhddeWB5UEK+onpvou1wSXtdBKwkilVJk3TJYBFGjpVEB9nxj35BxL4ltHV3PEhSoK0t/g3IeAoNfLrZPocRiLkw7gx+GwE7yB2i6A47iXGqtnaPygIOzT3jn4hrBOIdEjPcH74nJe3AgZctOpfKsRktpDoDNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400232; c=relaxed/simple;
	bh=qJGjeqrO3MOifyflIBZ0HVysY2YzY/j6eCF9sYrgS5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ec2LQ4xC81ojXGfWo+oIa+vVIcGieW6I6WqoL/k9aRjcYH3FG7Zu37k/Dpr7x38vAxTItO5Zdnvx2Y5JnjqxFRbvtvmJTOsQAO7zqhn90BU/oEx14QTqpl9q0XdT0jTyW8LnFhOQ3vBjKTpanWRJGmONFs7ZfeN3UmimWR5uV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GcwqxcaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DBFC4CECD;
	Tue, 12 Nov 2024 08:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731400231;
	bh=qJGjeqrO3MOifyflIBZ0HVysY2YzY/j6eCF9sYrgS5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GcwqxcaNduEPK/K2fYAs0FORz7sRZtaot2h80t/HUQ6u78ZtkjV3dZeZ10yiXI1l9
	 3qe+FYXNRb35xz7YSLEP8NsXGCgNk1HCke1X0YsQF3L9/Ku1aWBQjQorQtVCVciNUz
	 Y0jPUKDoCHULzs5J6dND3HWQFC75xrn/6KYZkfkY=
Date: Tue, 12 Nov 2024 09:30:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, jeffbai@aosc.io,
	broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, mario.limonciello@amd.com, me@jwang.link,
	end.to.start@mail.ru, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1+] ASoC: amd: yc: fix internal mic on Xiaomi Book Pro
 14 2022
Message-ID: <2024111221-brittle-mumbo-d475@gregkh>
References: <2948220EEF71E78E+20241111070804.979792-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2948220EEF71E78E+20241111070804.979792-1-wangyuli@uniontech.com>

On Mon, Nov 11, 2024 at 03:08:04PM +0800, WangYuli wrote:
> From: Mingcong Bai <jeffbai@aosc.io>
> 
> [ Upstream commit de156f3cf70e17dc6ff4c3c364bb97a6db961ffd ]
> 
> Xiaomi Book Pro 14 2022 (MIA2210-AD) requires a quirk entry for its
> internal microphone to be enabled.
> 
> This is likely due to similar reasons as seen previously on Redmi Book
> 14/15 Pro 2022 models (since they likely came with similar firmware):
> 
> - commit dcff8b7ca92d ("ASoC: amd: yc: Add Xiaomi Redmi Book Pro 15 2022
>   into DMI table")
> - commit c1dd6bf61997 ("ASoC: amd: yc: Add Xiaomi Redmi Book Pro 14 2022
>   into DMI table")
> 
> A quirk would likely be needed for Xiaomi Book Pro 15 2022 models, too.
> However, I do not have such device on hand so I will leave it for now.
> 
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> Link: https://patch.msgid.link/20241106024052.15748-1-jeffbai@aosc.io
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Now queued up, thanks.

greg k-h

