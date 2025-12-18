Return-Path: <stable+bounces-202996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E88E5CCC547
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 15:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 812C13097CA7
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0B086323;
	Thu, 18 Dec 2025 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hNcJnGe8"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61026299;
	Thu, 18 Dec 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069184; cv=none; b=h0U4eu5/2ln7W1uRd05uNfBjGNuJPkcqhWW8QZOqvasRUUkcNEzEUbO1lLOlpTn2h827xQUsbChOXXuUCWtByqad0oZFGNSmipgZzFEYl9utwqd6jUW8cq7Lq8NpC30cjF3ChDP2tU8OBO7oYuqCFtHrEe8ucX1MGooAVKL9On0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069184; c=relaxed/simple;
	bh=LY4nFPiOTkGww0ISgcKF6HSfdVYUtoR3hd0EwFScy1k=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=qvfyjvyhHn2vsOracaf3cxVJg6+9hwqXG8VNSWSaNwJSnLTO2g/otfDSd9R/JZQjT8h1EEUV6tekz9RjYnOpLXiZramLHHzl+CE+ociU5G+dp0B1O/YGNpgDCgGTW369zaxrrDtHF29ck5n/xQcmi4AKpWTz4AS/cWRsMP1OyI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hNcJnGe8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D66181A22D1;
	Thu, 18 Dec 2025 14:46:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9E1A6606B6;
	Thu, 18 Dec 2025 14:46:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4CBF102F0B4F;
	Thu, 18 Dec 2025 15:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766069174; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LY4nFPiOTkGww0ISgcKF6HSfdVYUtoR3hd0EwFScy1k=;
	b=hNcJnGe8TulQ23mUQr3WbbFPlKC5EDvNAgRcZijZy+tyGsTWp+wRWl8E4jXM7B1IQL7cvn
	G6YZ4ZMa2l0YCwXVjKALw7u2UKOPnE1uVqdjlEDn4H2w2ZqDM/F8D8MCeWSib7ksE9j0b4
	bZ6nmrdb4QIQmbi7OuwVzvuXiLPz9/6IoIG/zI7pEJAGyVLe82j8ObP5zrfHK/7elNAL2D
	KFldh5lezJs7QtQZzT8ZPIXUxLv0FDzhFnn+rFOR4EHizyUfow1SfCCPsdOxquMAR9xxfK
	5IfXqgn9FhEGVP5ygpRd9HY7rQEnyPa0T1LWlRfGAZMKqggzG4JE3Yjt7VtTXQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Dec 2025 15:46:09 +0100
Message-Id: <DF1F9S3FL5XG.1D9IAMJ5FHV4Z@bootlin.com>
To: "Ludovic Desroches" <ludovic.desroches@microchip.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Anusha
 Srivatsa" <asrivats@redhat.com>, "Jessica Zhang"
 <jessica.zhang@oss.qualcomm.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH REGRESSION v3] drm/panel: simple: restore connector_type
 fallback
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20251218-lcd_panel_connector_type_fix-v3-1-ddcea6d8d7ef@microchip.com>
In-Reply-To: <20251218-lcd_panel_connector_type_fix-v3-1-ddcea6d8d7ef@microchip.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Dec 18, 2025 at 2:34 PM CET, Ludovic Desroches wrote:
> The switch from devm_kzalloc() + drm_panel_init() to
> devm_drm_panel_alloc() introduced a regression.
>
> Several panel descriptors do not set connector_type. For those panels,
> panel_simple_probe() used to compute a connector type (currently DPI as a
> fallback) and pass that value to drm_panel_init(). After the conversion
> to devm_drm_panel_alloc(), the call unconditionally used
> desc->connector_type instead, ignoring the computed fallback and
> potentially passing DRM_MODE_CONNECTOR_Unknown, which
> drm_panel_bridge_add() does not allow.
>
> Move the connector_type validation / fallback logic before the
> devm_drm_panel_alloc() call and pass the computed connector_type to
> devm_drm_panel_alloc(), so panels without an explicit connector_type
> once again get the DPI default.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Fixes: de04bb0089a9 ("drm/panel/panel-simple: Use the new allocation in p=
lace of devm_kzalloc()")
> Cc: stable@vger.kernel.org

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Side note: this function is very long, it would be nice e.g. to move the
big mistake-checking switch (connector_type) to a function. Of course that
would be a separate series, after this fix is done.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

