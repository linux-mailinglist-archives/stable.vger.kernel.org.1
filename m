Return-Path: <stable+bounces-73143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2478E96D09D
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85084B24CF5
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 07:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1C3192D73;
	Thu,  5 Sep 2024 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wY1BaZq7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26218A94F;
	Thu,  5 Sep 2024 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522033; cv=none; b=EFyKcsi2Yj1j0d7K1vE1Zh0bdMWji/8Db+QA59pa+agH4/9HH4MGeJUQX4DIBF3D0MV+Fnb5YhIr9z9IXrIgEWiujvRe0pJyBHX4LStLx2j1aFTQ2CO/ezn03tTb3IItsxPt762nWB7ycSVPhi2myHjlQXycyX3E/D/55st/A/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522033; c=relaxed/simple;
	bh=PZJmqlHpJ1uU+ASFJIpncqC9uV3uvVokLmZ+DOZ31vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odtJp9TU5gKFXwiK+TIW3lrDxWSGesJpRlJiCDd+uDRqXTScvrwXFpGOpFnQ0tksAnH5XrHjxLyDKAdJIekCOraRKMIyS2qcaOVgBjOyFfJxTkNv28d5sdsv38juHdgDOVzM1utuCH1BX0AuUPJy8U9UBtx2sAzMdVJ/0Zk75Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wY1BaZq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C745C4CEC4;
	Thu,  5 Sep 2024 07:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725522033;
	bh=PZJmqlHpJ1uU+ASFJIpncqC9uV3uvVokLmZ+DOZ31vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wY1BaZq7EaV2nxp/Ky4u1EjnAofwymLmYwxfNFMzbKe0jbHCKfdS8gsQnzSNvxLBw
	 PumHeZzyspeIqGIDgjb4BCQ/0o2i9Hx1hQmo8m8P4UXCskEjO3NFFDypxbP6bOCSaO
	 tx5sTpSbitonzYibe/kA3nVEGUcVkW8snJjYW0Ms=
Date: Thu, 5 Sep 2024 09:40:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: sikkamukul <mukul.sikka@broadcom.com>
Cc: stable@vger.kernel.org, evan.quan@amd.com, alexander.deucher@amd.com,
	christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
	Jun.Ma2@amd.com, kevinyang.wang@amd.com, sashal@kernel.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Bob Zhou <bob.zhou@amd.com>, Tim Huang <Tim.Huang@amd.com>
Subject: Re: [PATCH v5.15-v5.10] drm/amd/pm: Fix the null pointer dereference
 for vega10_hwmgr
Message-ID: <2024090523-collide-colonize-d914@gregkh>
References: <20240903045809.5025-1-mukul.sikka@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903045809.5025-1-mukul.sikka@broadcom.com>

On Tue, Sep 03, 2024 at 04:58:09AM +0000, sikkamukul wrote:
> From: Bob Zhou <bob.zhou@amd.com>
> 
> [ Upstream commit 50151b7f1c79a09117837eb95b76c2de76841dab ]
> 
> Check return value and conduct null pointer handling to avoid null pointer dereference.
> 
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> Reviewed-by: Tim Huang <Tim.Huang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Mukul Sikka <mukul.sikka@broadcom.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 30 ++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)

Now queued up, thanks.

greg k-h

