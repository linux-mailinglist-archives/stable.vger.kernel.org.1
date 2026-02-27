Return-Path: <stable+bounces-219945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAuIHQx1oWkPtQQAu9opvQ
	(envelope-from <stable+bounces-219945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 11:42:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEBC1B61CC
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 11:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D4943047E6B
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC3B3A1E6C;
	Fri, 27 Feb 2026 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hiX3S0gD"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7B3A0B2C;
	Fri, 27 Feb 2026 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188881; cv=none; b=bJiIP9KOp8zVXoDo2nIcgMjVzuzAfhkxiHjmJy0fGMhnh+HiSf7piOVacXG6PtQ6GlCR3N+6edvKJsfrfKUc2Ah1JthwnSuDnRqJ+vvQMHM/9WToAMSCOIPYRGF5Ao9cBjLz2l8bh3ZTT0LFaA+TlSPjaMJtD9Gc5O0yyAmHCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188881; c=relaxed/simple;
	bh=hA6BDFZd6MrTqTGLDzBaPrfAhnfCTTQ+7BKj1oIHx4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r36coEtkBcirLJQ4+oU9SSkpx7vPyOSF0SmzC+1uK7RN451C3aYL74OW//9Nhvjb1ejV5L3wAUztZ3yA8tsB3Zrjic4HZ5F6GtVzJEaIHpjMSp8AQP0BlG8UCVjGhN/QkwYdWWcgKQ5XNmYmSh0PJUq44B7jkcAlD54hArPSc9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hiX3S0gD; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fMlHH73q0z9sZZ;
	Fri, 27 Feb 2026 11:41:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772188876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8yNHrrv8hSbIol16MyTEr4gp82KA1j7w7oSm0UgB4U=;
	b=hiX3S0gD7vIoc4g2amN34KUBr/5pehQhklGW8kRGIc/fmgEwPBDYzNOFwjY1iXF5ultF2K
	eOnxr4WSwbotJ5DQI+g+VUeH+5TgK/J+t7nO0erjf7VAeMGPvcpr9vKQxI3lZJxnLiE7ri
	PLjjZe9+yXiFHUeyvB7fs68OaOaqkt51G4zBDoxLmO3WxzGPeMqSVra4N2eMLF2jWrz60i
	dGq/WMv7TUKtcEdgodDdG3XkkVZrifQngq6k43rzwVG5JVa250UQDB7IDmb2frjg4f4xXU
	bdRW2LTA6aujo3dmf82hpg3vp38iFh0xrZN/jqgmgHrsXDwcaEtzvu9CyvdwwQ==
Message-ID: <4b796cc7-bf3d-4eb1-8e29-33e90851c34d@mailbox.org>
Date: Fri, 27 Feb 2026 11:41:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] drm/bridge: ti-sn65dsi83: halve horizontal syncs for
 dual LVDS output
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Linus Walleij <linusw@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-0-2e15f5a9a6a0@bootlin.com>
 <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cba5140bc5ed835239e
X-MBO-RS-META: rinne88hpm9po5saewn6i3bhefqz3wx7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219945-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,kontron.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:mid,mailbox.org:dkim,mailbox.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBEBC1B61CC
X-Rspamd-Action: no action

On 2/26/26 5:16 PM, Luca Ceresoli wrote:
> Dual LVDS output (available on the SN65DSI84) requires HSYNC_PULSE_WIDTH
> and HORIZONTAL_BACK_PORCH to be divided by two with respect to the values
> used for single LVDS output.
> 
> While not clearly stated in the datasheet, this is needed according to the
> DSI Tuner [0] output. It also makes sense intuitively because in dual LVDS
> output two pixels at a time are output and so the output clock is half of
> the pixel clock.
> 
> Some dual-LVDS panels refuse to show any picture without this fix.
> 
> Divide by two HORIZONTAL_FRONT_PORCH too, even though this register is used
> only for test pattern generation which is not currently implemented by this
> driver.

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thanks !

