Return-Path: <stable+bounces-92030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDA09C2FD4
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 23:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C8EB20F42
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 22:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A801A304A;
	Sat,  9 Nov 2024 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wmCH83XV"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D01A3029
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731192746; cv=none; b=Xy3dn6SB/AmwHCE9wU1L6fOwkKRx0pKK5Ov93FgK3n1nFL1tyOcvbzIm0WJlK22Kp5e3AZHyuBRWSDIQHoab6duCZbsV1OdxTuhuUR8/5aXQrZsOYQWcboPlPGoE//bb7+Hj5XKZpRwBU8w6k+flq0ahFUnnHNyllvfVQgekm2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731192746; c=relaxed/simple;
	bh=mJBTuqirzz69BmXD/kpAAPw6FsO5yoS/nGUBBLTl7Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShQJv3NYjlMCwRiDjnTc+LF16DjTuBde6uGyNvZac1eDz/Mr5eyv5aftM2t0EFO7slpBSY88x4svqS8Xrk+SN1pF0D0uI+ETEDwqNITnSRoGJDvzA60ZttJIyAmC3f3/kkblK+etaoAwfs38sBEOpRNugrzjPTqERwhkJM7bZMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wmCH83XV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w8gBGyPTDJo8Wblkn6DK9LVzHMsd9X3M336TYhnbuuI=; b=wmCH83XV6CawKCBG+wBFbmq4qJ
	U+tEpY8FgwvM9/lF+DEae3CbhHS1ANMEGtDfnxsAgUk8XV0poeQzYLbRpGzQeT2gwLizmjSAwObte
	J+xi/zFNarxQae70PAfKGE8VqX/frWY/0TDgYDAwizyltIzH8YvAciiOetgodJDTekUqN9dkoCftY
	bO/mbg/agRoMdWtEL0VNkNuO3dH7o24rjOfJKxZMOuQmSVukUScXqaOYSqgBsubcqPqh6YwCpQslU
	60n8tX4dZsbrUdXK/DlQDgz8VHecI194PvUnj1fE9VK81QAKhv8tBMw6utWI/s+G+y4OBzaXHLvIM
	4XRiNUGQ==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9uJP-0000NE-3s; Sat, 09 Nov 2024 23:52:11 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	mripard@kernel.org,
	zyw@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	Thomas Zimmermann <tzimmermann@suse.de>,
	airlied@gmail.com,
	groeck@chromium.org,
	simona@ffwll.ch
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: cdn-dp: Use drm_connector_helper_hpd_irq_event()
Date: Sat,  9 Nov 2024 23:51:58 +0100
Message-ID: <173119266840.1201296.18042535241169632590.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105133848.480407-1-tzimmermann@suse.de>
References: <20241105133848.480407-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 5 Nov 2024 14:38:16 +0100, Thomas Zimmermann wrote:
> The code for detecting and updating the connector status in
> cdn_dp_pd_event_work() has a number of problems.
> 
> - It does not aquire the locks to call the detect helper and update
> the connector status. These are struct drm_mode_config.connection_mutex
> and struct drm_mode_config.mutex.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: cdn-dp: Use drm_connector_helper_hpd_irq_event()
      commit: 666e1960464140cc4bc9203c203097e70b54c95a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

