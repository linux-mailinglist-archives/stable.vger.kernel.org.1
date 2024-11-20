Return-Path: <stable+bounces-94102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 056189D35A4
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 09:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E33B2248B
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 08:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C886C175D5A;
	Wed, 20 Nov 2024 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXV7Z/pm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7D916DEB5;
	Wed, 20 Nov 2024 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091978; cv=none; b=Eyp48xyKphVF4hfFJjoHchSef9UBRUApLZ33AuvjQbwpIQ16Q48rPz8ubwOSkRM6rMTnvfYVFIn+4/FbSDLB7t3cmhdsLiXPDvjpo+7stB3ZwkgeBxbYLcQPAzEC70gpjwUpZ8b5oojEoxmdxV3zKvZOUHp1VBedpSfonLkS2xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091978; c=relaxed/simple;
	bh=uCabY3aXdU8knrzyUvKDoBC/ts+x8ZTTZaaPEX0zYC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUyiA3qGWTHdM2E9I6JQLwChaa5pZk2D3K7RduXEzAbdzPwV/Gpi9jKi4iyI5sFnf8XYjKSdUkTo+OsUeNdNut9HzD758SZHz/hcbQUG7N6Bl1OYA0rn93CRoBOvN/+5WLaIWAsdm3LvzUas0XZI817LbizpfyJkKCEuZrVRCEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXV7Z/pm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A8EC4CECD;
	Wed, 20 Nov 2024 08:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732091978;
	bh=uCabY3aXdU8knrzyUvKDoBC/ts+x8ZTTZaaPEX0zYC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXV7Z/pm3H/r3AO4Tq9FfR6TpXz+12dGVNcVBe4YnWLALAydN5KQPUMUuyqP+lzGc
	 6pS5yeOLEaQCj9p+3eAP2Up0tsIR/2X3YGP8WwavkFt/ebx2YOXWau1ZoMNTzhIL0J
	 CSS/EhklqMdNOKXRwDg1CR+A8/3cumO0ZcW5fBY/G24NJgjXhbmXVSnrCvD/LQIf6f
	 pDcGUqoBhfz9LqAWWJnalmmhYtPVxk/ZNYl7W1+c3Cmop1xfglJ4rRo9Wv+fNQYlV6
	 uki1XOe5gh/lex7JBneDXof+3DxhhFljG2uhkIMBoMeaw88+NpD7XSILNWFkP9TYsK
	 1xlZ63Jhz8Izg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tDgFD-000000007wu-3WTl;
	Wed, 20 Nov 2024 09:39:27 +0100
Date: Wed, 20 Nov 2024 09:39:27 +0100
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Jeykumar Sankaran <jsanka@codeaurora.org>, stable@vger.kernel.org,
	Leonard Lausen <leonard@lausen.nl>
Subject: Re: [PATCH v2 1/2] drm/msm/dpu1: don't choke on disabling the
 writeback connector
Message-ID: <Zz2gP5jDr4Jq1OyP@hovoldconsulting.com>
References: <20240802-dpu-fix-wb-v2-0-7eac9eb8e895@linaro.org>
 <20240802-dpu-fix-wb-v2-1-7eac9eb8e895@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240802-dpu-fix-wb-v2-1-7eac9eb8e895@linaro.org>

On Fri, Aug 02, 2024 at 10:47:33PM +0300, Dmitry Baryshkov wrote:
> During suspend/resume process all connectors are explicitly disabled and
> then reenabled. However resume fails because of the connector_status check:
> 
> [ 1185.831970] [dpu error]connector not connected 3

Please also include the follow-on resume error. I'm seeing:

	[dpu error]connector not connected 3
	[drm:drm_mode_config_helper_resume [drm_kms_helper]] *ERROR* Failed to resume (-22)

and say something about that this can prevent displays from being
enabled on resume in some setups (preferably with an explanation why if
you have one).

> It doesn't make sense to check for the Writeback connected status (and
> other drivers don't perform such check), so drop the check.
> 
> Fixes: 71174f362d67 ("drm/msm/dpu: move writeback's atomic_check to dpu_writeback.c")

I noticed that the implementation had this status check also before
71174f362d67 ("drm/msm/dpu: move writeback's atomic_check to
dpu_writeback.c").

Why did this not cause any trouble back then? Or is this not the right
Fixes tag?

> Cc: stable@vger.kernel.org
> Reported-by: Leonard Lausen <leonard@lausen.nl>
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/57

Perhaps you can include mine an György's reports here too.

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

With the above addressed:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan

