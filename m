Return-Path: <stable+bounces-188383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A9BF7CF2
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BF9A4EE3C4
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F1E245010;
	Tue, 21 Oct 2025 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="mwlRwnKK"
X-Original-To: stable@vger.kernel.org
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB9A231836;
	Tue, 21 Oct 2025 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066183; cv=pass; b=LsyElFyCjX8IxY+rDaLU0csGAm01pi2gxXTiRZR7TDcDO+MfqzrZs+Uvw4hVHkjMAXCH6WEgvbzw7A++6H0c7dnVqna4r+d1ms9FAUpjIjnBbwUp1D+vr3aUrZTI7kg/rY2x/fhqGKr5G1rJ8SUP6/4EwWu+rXcqATM2x+GZE7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066183; c=relaxed/simple;
	bh=8oaAN5ILJ5mMnbm08raXrGbj91i5i/wpOE8fO77jvJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyaOTw2LlQf9DlYAlLxbupFkasxVWRDm7uEp9WjOuOBAfLW7kTg2dVM5u787ZVbfe8Ys84aB0iC29ndWagundMikhO02MUxl08RPXNi0AZ3Z5HOwMFv+sH2H4hXsllA3OunicHUgA7uYggSA0R0Tl0Sy8C6Gy00b9SYN3u35vSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=mwlRwnKK; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from chcpu18 (191host009.mobilenet.cse.ust.hk [143.89.191.9])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 59LH2V42779999
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 01:02:37 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1761066158; cv=none;
	b=T/+4lEACQsGHm9udGaaM8aihrcqTVOZWFMG5F6JFTX6O29X4zQZJiKQrzOHaxLRU+TYJsGkQRHU3tjXryqiqgGc7KJk2elxnVrcyA/Mvoeibz+Pzj33l0AGvdmVwNOYeUAo+cwO8r6eqmBR6wuzCErqMQUWX8CAoTbSlOoiytpg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1761066158; c=relaxed/relaxed;
	bh=FRVfiD6X5NXLrHjgmPEma2QRAwCTtDTlCJMspqk53gA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=raDpEqVXBRFjJ+wUSmpp+P5YZX13JFY763EFGLojsAm+RjHi87pcnobAFrsD0vwZkLzLTY9hubuslyhvuNW5z01X8BeF0ajY4UpCh0pSIIVj2fi22fA913vR9n9oweBRKicWL+VqmC7A9gTlrtAnKEldHMr8xkv4tp+EMdPi+Do=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1761066158;
	bh=FRVfiD6X5NXLrHjgmPEma2QRAwCTtDTlCJMspqk53gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwlRwnKKPlBkjp3sWnD8EgVcbM/N++9LiW8IlROkRqjbjbzRlLTmg7lQJHzbrG2qW
	 aIDSzRBg1+MM2UqOgD5pJyEa7zPj1JEgLuPN7A15TuOAsATKh1i4izXe+Qm8kqJVOe
	 s2FCrgZbTxk+vgaMx9KSo5SixHbjlgQ3wOXoZzLY=
Date: Tue, 21 Oct 2025 17:02:26 +0000
From: Shuhao Fu <sfual@cse.ust.hk>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/nouveau: Fix refcount leak in
 nouveau_connector_detect
Message-ID: <aPe8optzxlZ8Rwf5@chcpu18>
References: <aOPy5aCiRTqb9kjR@homelab>
 <aOXYV5pgilTvqMxR@osx.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOXYV5pgilTvqMxR@osx.local>
X-Env-From: sfual

Hi, this is a friendly reminder of this patch. Please do let me know if
it needs any rework.

On Wed, Oct 08, 2025 at 11:20:15AM +0800, Shuhao Fu wrote:
> A possible inconsistent refcount update has been identified in function
> `nouveau_connector_detect`, which may cause a resource leak.
> 
> After calling `pm_runtime_get_*(dev->dev)`, the usage counter of `dev->dev`
> gets increased. In case function `nvif_outp_edid_get` returns negative,
> function `nouveau_connector_detect` returns without decreasing the usage
> counter of `dev->dev`, causing a refcount inconsistency.
> 
> Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/450
> Fixes: 0cd7e0718139 ("drm/nouveau/disp: add output method to fetch edid")
> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
> Cc: stable@vger.kernel.org
> 
> Change in v3:
> - Cc stable
> Change in v2:
> - Add "Fixes" and "Cc" tags
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 63621b151..45caccade 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -600,8 +600,10 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
>                                 new_edid = drm_get_edid(connector, nv_encoder->i2c);
>                 } else {
>                         ret = nvif_outp_edid_get(&nv_encoder->outp, (u8 **)&new_edid);
> -                       if (ret < 0)
> -                               return connector_status_disconnected;
> +                       if (ret < 0) {
> +                               conn_status = connector_status_disconnected;
> +                               goto out;
> +                       }
>                 }
> 
>                 nouveau_connector_set_edid(nv_connector, new_edid);
> --
> 2.39.5
> 

