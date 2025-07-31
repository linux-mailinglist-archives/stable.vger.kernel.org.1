Return-Path: <stable+bounces-165608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 559A5B16A4F
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 04:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2332C6206D0
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 02:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB4B1A01C6;
	Thu, 31 Jul 2025 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YExX0o6u"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5021C1DED5D;
	Thu, 31 Jul 2025 02:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753927698; cv=none; b=uNDJHgLe0XOY9NLvVBD3/J4rk2voL98e5bssiDVepp7rMmta9jnsd05kKWqJmg8lt1QQ5HJkvurqIduXWzB+XHswslC+7wuSvXFwD0VWsbdehHzUMdBAH87Mh23q3krO3NR5tRlGS8o1kk2/2jFOY0oMJ9GeAy64WhQIHIwrrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753927698; c=relaxed/simple;
	bh=jYjmmUbhAo5Rx12q31rCMDi0MJPFmBegHSkQ5/vkesA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z6/fALs3mWdhY1hELT2p0Vc8DOrCeVLOWvXdZ2z8+kkr1Op9Sfz8QCz/9Z6AGO+wmkXEVxD3LK26kDkiu0apxCTD2lGNpkadJmho9l18+Y/z97k9+HUWylvgk+B3uLFYrrOz8T4Z4gCkJHT4eILyY25sjEnK41oFAl8gaxMz+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YExX0o6u; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45629702e52so1485395e9.2;
        Wed, 30 Jul 2025 19:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753927694; x=1754532494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttbMdEkxoTUOprk+YRVdSAOn6EZRYe2hYPzeU8X5k20=;
        b=YExX0o6uGhpDg8P6to+jWGY8mqmJ7GBLtUPzyJALeSlsow5EzSSiSJzSZexO3PkmTh
         k0ixiFnIHoi2SpzUhqZSb79RJeK7s+AA2r8u7A6kWDdF/WhaQzHRdiqfomzX8xsejoxr
         65Lkwfpe85bQVuy5s3D1hN/ZJkFTkuIgG6m6t8367RNHJillYizWUuCxN3Gdks3OLnZ9
         J701P9+BdvePT28h1rklEFHwgbHj3X0NzQs+2bilTgJINFCMwsO+r7shaTU201+OY4/C
         MdHY3NDxmCAJPNb71YT579HnMGhx0O9RUJzCLywLOvAykh8Bn4vy/Obgy5vm5BJW5hdG
         F3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753927694; x=1754532494;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttbMdEkxoTUOprk+YRVdSAOn6EZRYe2hYPzeU8X5k20=;
        b=tTuY47GOldmLL9Seive35c8A2otdF5TJTBhXz+EnxAUcMzsLhYjkgXC4QNqrJMIlmN
         7NqfP0OX6uY/ckfjgtS4TKXUsf15j8JDyoVrGQHWmn95XBHZE9YqYa16XbS2zZAkemoz
         KflQGwvSzrf+ZVncOGOioP8QslIw+3ciyZrzKYpR7TnJt4cLF0mEaJMH9jdTVAk9uqAI
         olulsiJCQLsdrXbqRT+u6w5SEfs9VrBNvk8Lp49sOHmlbK5cGE5ud9um59Uw8sk9REgN
         g1Ph1SEkg0DBJ9OwcsdU0WzjeRQ333G0kFVGOwHIkq+PtT9hxd1kx+dOC9PM7RiyZT8v
         N4Ww==
X-Forwarded-Encrypted: i=1; AJvYcCU7jf3igBf826PUqwFBAOtn5NYe6CDh529UdFgpvNl53oQhNnc1WzC63DKUvwSYcWrkt2Z6Xr+cZrmQrlU=@vger.kernel.org, AJvYcCVxOi7UBHXxF/jv0ANJeMkTcdyaP//BU2BMnZfhySc6EYP1CW9//Y/bLxH4LgdtYx9z2kp+paF4@vger.kernel.org
X-Gm-Message-State: AOJu0YylZSiG/VmUN1e5pcdUFJXDY5OqJ9aedrjDCWqTO0XhAuDlxloq
	cZrs8WJIJxCsheuR74LvF2b4pFN3g0nswf6JDKBs6isjjxPSMVFXihvQ
X-Gm-Gg: ASbGncuQAXpJR02jUFqEN39QfZM1VjDrxloMNbdzjQvscnElL5xkNc2xlicBwZj3z74
	yMDD1YpIiSvcczauYs3uFVueUqRNWvDnswG2x9Gtmyab8n7xmCkZNwIPOudCUDzZu0/MQDyeSlH
	IccTdoYiATgwTPafYzVSi3iXrHUxDloZNwW49Oimj62GSPdhSJPA8cNMkRVCmZIhl/VeNrnQQjb
	TzZNRGIvgf0R92GJ6L8kunDaFg2AXwm1IDIM4KC2wLaws/wqIXZV+uQ7BidOCxgtRQejUjaT3om
	7zmivdColZevG/tHwB5Up34WWM9MdoOOLbq6D8u8jkwWUSWxYpyz6voo5wbQcA9v4TyKpK6OftC
	dNfVKdw81xu+lozwuMJ1wgg==
X-Google-Smtp-Source: AGHT+IHsylB7+NHRuBW9mU53rbrnh3rovtARDLzE2S2cbV7OlcCzjAu5Wxz6+1u5fMJj5KOTcLkQ5g==
X-Received: by 2002:a05:600d:108:20b0:456:26ad:46d2 with SMTP id 5b1f17b1804b1-45893943cefmr25724855e9.6.1753927694491;
        Wed, 30 Jul 2025 19:08:14 -0700 (PDT)
Received: from pc ([165.51.119.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee4f239sm7657055e9.21.2025.07.30.19.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 19:08:14 -0700 (PDT)
Date: Thu, 31 Jul 2025 03:08:11 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH V2] drm/amdgpu: check return value of xa_store()
Message-ID: <aIrQC78VWg17Iqhf@pc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The `xa_store()` function can fail due to memory allocation issues or other
internal errors. Currently, the return value of `xa_store()` is not
checked, which can lead to a memory leak if it fails to store `numa_info`.

This patch checks the return value of `xa_store()`. If an error is
detected, the allocated `numa_info` is freed, and NULL is returned to
indicate the failure, preventing a memory leak and ensuring proper error
handling.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
Fixes: 1cc823011a23f ("drm/amdgpu: Store additional numa node information")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
Changes in v2:
    - Improve description
    - Add tags Fixes and Cc

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index f5466c592d94..b4a3e4d3e957 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -876,7 +876,7 @@ static inline uint64_t amdgpu_acpi_get_numa_size(int nid)
 
 static struct amdgpu_numa_info *amdgpu_acpi_get_numa_info(uint32_t pxm)
 {
-	struct amdgpu_numa_info *numa_info;
+	struct amdgpu_numa_info *numa_info, *old;
 	int nid;
 
 	numa_info = xa_load(&numa_info_xa, pxm);
@@ -898,7 +898,11 @@ static struct amdgpu_numa_info *amdgpu_acpi_get_numa_info(uint32_t pxm)
 		} else {
 			numa_info->size = amdgpu_acpi_get_numa_size(nid);
 		}
-		xa_store(&numa_info_xa, numa_info->pxm, numa_info, GFP_KERNEL);
+		old = xa_store(&numa_info_xa, numa_info->pxm, numa_info, GFP_KERNEL);
+		if (xa_is_err(old)) {
+			kfree(numa_info);
+			return NULL;
+		}
 	}
 
 	return numa_info;
-- 
2.43.0


