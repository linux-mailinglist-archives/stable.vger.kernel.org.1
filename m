Return-Path: <stable+bounces-196500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE272C7A77A
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40FA23439C2
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2472DBF7C;
	Fri, 21 Nov 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITZhY9Cw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BAD2C08D0;
	Fri, 21 Nov 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737965; cv=none; b=Z9W2e+oapR/1J/8Qqfs5lNnoB791zZI3G54ywzC4BDdsE/M3sVVSWmP1HflUtGvaBQXG80/s2kqfNoe15cQjpJlDZG6Ddvesn9jMrmbg7Wu8gF3zOHMbSZhjsDniUsmE1YextdJfPI9XjGJ1o54N1sTStH8hph/LDW0Is0+hkXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737965; c=relaxed/simple;
	bh=0pQsw6YqEHyPK56ix6znWLkOdaepGxe12FjZqbBnn+M=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=i4dYFF8+eD6FExoQu1m9sUe1A9V1mdrff19zJYiHl7+iOX1IPLRqVbh21p7KTSa0uThXo1WQ//+9aqTLZD5Mw3Z9aKp8O4OvPnEVDtFqOOe57gryIJVs90NFv3Oa6if5W0WSE6Txee48BVRj/sUrOvtf5IGXCaq2OCDAaHY+lI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITZhY9Cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1421C4CEF1;
	Fri, 21 Nov 2025 15:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763737965;
	bh=0pQsw6YqEHyPK56ix6znWLkOdaepGxe12FjZqbBnn+M=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=ITZhY9CwXeZWdnyczZwovFe/mqvGe8EkH6IQ2ROQc7b5tz5OxNVn9iFCNQtOTmEwS
	 vipr2dlB0oGwZhOoajEhPQtLVCFJkDMnJ6nLEuXS9mWmwcEIH6Op4zUnwnDBuPECA9
	 8sXKSbycj+j+0fUDSgVr5pdUMAlA8AiNjeyMVa9VLgVb0XiEwyVZ5HWojcWmBdYbiG
	 4z0mcf5XcKSuqjwY+SNdSOfLdu7XoK43KIPtLcQWPUi08tGaDYIEs31iun7yyMpT3U
	 Hb/8obwoWfaCg4xkcFR05R/oF5mt4cGNV+6Rh/F5PWXFNY9XhuePiUhQWFfqKNVPZt
	 OzM5BYUk4Akbw==
Message-ID: <165d97e3434aa8dd46508da3450b59e5@kernel.org>
Date: Fri, 21 Nov 2025 15:12:42 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Ludovic Desroches" <ludovic.desroches@microchip.com>
Subject: Re: [PATCH REGRESSION] drm/panel: simple: restore connector_type
 fallback
In-Reply-To: <20251121-lcd_panel_connector_type_fix-v1-1-fdbbef34a1a4@microchip.com>
References: <20251121-lcd_panel_connector_type_fix-v1-1-fdbbef34a1a4@microchip.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "Anusha
 Srivatsa" <asrivats@redhat.com>, "David Airlie" <airlied@gmail.com>, "Jessica
 Zhang" <jesszhan0024@gmail.com>, LucaCeresoli <luca.ceresoli@bootlin.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On Fri, 21 Nov 2025 14:20:48 +0100, Ludovic Desroches wrote:
> The switch from devm_kzalloc() + drm_panel_init() to
> devm_drm_panel_alloc() introduced a regression.
>=20
> Several panel descriptors do not set connector_type. For those panels,
> panel_simple_probe() used to compute a connector type (currently DPI as a
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

