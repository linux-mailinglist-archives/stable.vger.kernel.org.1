Return-Path: <stable+bounces-76896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB2497EB30
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 14:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4171F21C64
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 12:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE0436AF2;
	Mon, 23 Sep 2024 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6CopgEp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DFE1F93E
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092945; cv=none; b=fHPRc9E2YKDdASC2vFO6OrSM4yDxY7GjpNqQAUy/0wvjW0khb7lHEBeSDNDzs4VBGBia72YPK4+Ga6jtkzrF+59MF+jHS4Z3IL7pOGSBTfwYmQJ9Fa+DVqsT09mZmmIIpv5wVUUkP6fWr35fGt0dFadRQ/UOLcxVqkZZoByCBss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092945; c=relaxed/simple;
	bh=TMWey0bFrVes7UY33oxB2lmVjsZfpufLQQxJp4Id8q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV8hyJj3T0oiWLcaC8f0Y5e3hpPwly2mNu1jTccb91S+CMIneHcTVHoZCsrZILLaLmBALbb45YD4RrDCxJYiTl9Ppm8Ft0C1AxJ6RIKWhFqKEB4bcHOolYuAeaHyhvRBy9IIVNQA2jbmzDUOS2RcgUxWLBES+RTC3+Z+rfo6fdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n6CopgEp; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f754d4a6e4so40307871fa.3
        for <stable@vger.kernel.org>; Mon, 23 Sep 2024 05:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727092942; x=1727697742; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QVRH50fCKozmOUshjN+dDlF47miSFCtvmdmtQcy3j1g=;
        b=n6CopgEp30jMG5HMxf44gUNv/H1Tsfo2ZUmyoXILHkqdtxk894wLlHANTKJAR1zjbb
         NacA3HGr1rb9EJUjT5CyDXUBA86sjMk4OpPTO9gFaQJjLZiguLte9YeWar1GsJXMNajA
         2DpJo+/+MpEMqkhuhMLp3XInKiFWoNs4jMTnaOA3o3Yhrkux2XSnVePdg0g421/VzHNS
         ZCj7Sx7Zba1nhH+WF2rbqw43Gy5G1OvY9vRKQJzkECxslBX6HU/ox7ny1xdQdx4f9VdA
         rH9tt1zwyeit8Zng9e5PXdVqIzEMuhyxsq/y4WRxfWbe9mO85KKVTpn1zVv/e/jvSHqB
         BIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727092942; x=1727697742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVRH50fCKozmOUshjN+dDlF47miSFCtvmdmtQcy3j1g=;
        b=YxErvlS6vas4A2wpEW4r5F8UkloQ1kKdbhwsPQ2VBEhqPXzDTsyGbwrvQbj0m5kJjG
         X+GwTvBU02Q1OHaX3t+cHgPNWD0ygR8Y0wYbytayhMUQm8hEHbOGZNdoZ7Q5oxdTiTO2
         nmHIlAvQYRxl5gA5lYnPF68nSquQrg8cQH3slqy8Cz5W66YnlKWE/xyio3w8YTuHetR/
         Jxgrcp/CUhZyw5sVOgeztc9NB0taySJty/qHKIdm0BXpO9FxtM5NgNfoARdsFvYy+KTo
         E3GC7DHxjvwgM00UfuYx/NjkmRhqUqLeGkYuD0118RD0Dq/e/MIothBAH6CGYNH/Xcgd
         FQOg==
X-Forwarded-Encrypted: i=1; AJvYcCWXeyT/5009ibC1ic1+nwhb8wszRryecYXXi4YiISAcEK/FUCkBC76DOFcPLJ7Z5HOPyQtekwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8kdo/+gxKXI3xs7dXYMPuq1tHhFJygTSPrvpJQcS9rj2ku4TB
	J0erA0xznjHP7vgFZzxhaPNjGz57Tnm/HqLHlnpyD99qwNFWcFE39GVnNmhc7xA=
X-Google-Smtp-Source: AGHT+IEEze98MhQNK9bySuiglBV8sRer7SucAOqy7IS5J0wr/mela9f4okwv0utK9Sj5XW+kWXtIjg==
X-Received: by 2002:a2e:712:0:b0:2f5:23a:106b with SMTP id 38308e7fff4ca-2f7cc5bb65bmr41075461fa.34.1727092941455;
        Mon, 23 Sep 2024 05:02:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d37fb73sm29001501fa.78.2024.09.23.05.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:02:20 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:02:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: ville.syrjala@linux.intel.com, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>, 
	Deepak Rawat <drawat@vmware.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	Thomas Hellstrom <thellstrom@vmware.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] drm: Consistently use struct drm_mode_rect for
 FB_DAMAGE_CLIPS
Message-ID: <lhm7vwyjohbnjls7kazqcdjiuurxij32j2tayldya6qldammye@n5dhn73uze3u>
References: <20240923075841.16231-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240923075841.16231-1-tzimmermann@suse.de>

On Mon, Sep 23, 2024 at 09:58:14AM GMT, Thomas Zimmermann wrote:
> FB_DAMAGE_CLIPS is a plane property for damage handling. Its UAPI
> should only use UAPI types. Hence replace struct drm_rect with
> struct drm_mode_rect in drm_atomic_plane_set_property(). Both types
> are identical in practice, so there's no change in behavior.
> 
> Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Closes: https://lore.kernel.org/dri-devel/Zu1Ke1TuThbtz15E@intel.com/
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: d3b21767821e ("drm: Add a new plane property to send damage during plane update")
> Cc: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
> Cc: Deepak Rawat <drawat@vmware.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Thomas Hellstrom <thellstrom@vmware.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.0+
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

