Return-Path: <stable+bounces-87561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4465B9A69D7
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32986B288D3
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5773B1F81A6;
	Mon, 21 Oct 2024 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSAkqZir"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F251F7092
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516088; cv=none; b=U94/BBAGtHU0+gX+RS8ypbHLNtYX1KeLhX5kkq4XWiTrGU8vWG9k8rYv5s8k2gYCdA5vgwCfob33fJAgYV+7ldmFVH5jA/hmkcRleGMiXj+5RFQgOlfEqSVvHGznFaFDvlZJXGNblzBNLRhTuuXVaBuNiPOxyskk/1XMOcPbS2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516088; c=relaxed/simple;
	bh=9RqLgA+h9hX8Mf4mFhAuHHjEmy1g2wQEgrhonrkcENw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=II8rtINHl8hBcXUs/DnOERQSJoVu+/LbgXmad/lUAU+7QR4v581lBbafNlTbMVKyC/7SDR/tbBbnqj7X3ozN8fdFsm+4cV96x/Wh6gdlMPU2P5UIFObppIcmd0jOmeybV+GPGP0J+TqQKQGYQcR5Gk/81midhcODlioXeeTlNcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QSAkqZir; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43158625112so43770295e9.3
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729516084; x=1730120884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqnULJngiAuI4PU+WENgbKZbOXrbYOY8YLdD1t2buO4=;
        b=QSAkqZirhGkLWgHFsX6Xw33D6EoduRGwUDEC7/y7HYPpt087V3LhISPGsXNrHvdfSj
         c4Z3SD+KBhzl0OuHjqSWaPKMa3JmVDcdIcYnnBA6d4XcipnqtsiYIz/uNc6mAfIXnwiO
         dXF9xELYB6QGv0Okbj8FJBJui9zCsU+06EAmK0NhZFZJUbQJZBqLmfvRrFIhVmoSRT5Z
         dPiuGE2G4R6KZBv16XACnSm4xWfL5/mAkofZIMV62xue/bo4B2pKduh8taGGkoaPUVxz
         U9LnLmX/OERaS30Xsq/eVQvk/paWNjFrPlaPOUwudTFpafhq6HOfoI10l8kewhQwwrHy
         kUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729516084; x=1730120884;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqnULJngiAuI4PU+WENgbKZbOXrbYOY8YLdD1t2buO4=;
        b=aGhBvxXbS24RAy+sXaQR04sCUf20Oo/BLEmmo6sFdSBCjKotmCA1LwWM8bcZYg4TNB
         762HUY7VU2c76/lHdLXQSelLfXEU2ScuMvaM1CcQ3l8lxzjUgcDaqWDo75PXS2T1pVEN
         3/X+F8geW4PJwfSCsaI+dP6bEpBA5q71yM50Yx+jDY61Ub57jGjQHsyejj7AQBkmRZ3X
         iCXewyvT29XHWlZAKtIBqmfxYN1BzCsSDiVi8pgiwhg+FQu5La4uR1+k6GPwRZxHkPQo
         N8Iu/P4BJulePC9JQwAhs0Gp2vrFZUGpAz3wkQG/DICrw/oGLvXneyb1mgpfVC6ysGSX
         UugA==
X-Forwarded-Encrypted: i=1; AJvYcCVi3jiTfch0Tb+LN0qFCzA+k4+l6ATjVVRd5thmm5CpnkOfFg3zyOcmzQfoULsxO7jrIze9pvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2s9cickJ1lNt/97JvGOvWTxRoLDMVDUJWxwv088oc2Jh5GgYU
	OiWCc+M0r/VOoxCK6FkJ9SD3F8ofhIg1kZ4Rw51WJ98fbcEq+0T0GnpoOPgLbUoJA4NUwSsqVhW
	hkVc=
X-Google-Smtp-Source: AGHT+IGm1/5Xh2Z81XQToS4JZjHin15PG7qBhTsyW0jnN8vOfqwSxnZN3dWJ97hienGRAVBco+uHkQ==
X-Received: by 2002:a05:6000:b45:b0:37d:54d0:1f20 with SMTP id ffacd0b85a97d-37ea218b5ecmr7255011f8f.24.1729516084157;
        Mon, 21 Oct 2024 06:08:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4864csm4327496f8f.35.2024.10.21.06.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:08:03 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
Message-Id: <172951608323.1285208.3162107667310691864.b4-ty@linaro.org>
Date: Mon, 21 Oct 2024 15:08:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Fri, 18 Oct 2024 15:49:34 +0300, Abel Vesa wrote:
> The assignment of the of_node to the aux bridge needs to mark the
> of_node as reused as well, otherwise resource providers like pinctrl will
> report a gpio as already requested by a different device when both pinconf
> and gpios property are present.
> Fix that by using the device_set_of_node_from_dev() helper instead.
> 
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/bridge: Fix assignment of the of_node of the parent to aux bridge
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/85e444a68126a631221ae32c63fce882bb18a262

-- 
Neil


