Return-Path: <stable+bounces-219944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IxRLMZ0oWkPtQQAu9opvQ
	(envelope-from <stable+bounces-219944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 11:41:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 328181B618F
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 11:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB9F130488D7
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3964139E192;
	Fri, 27 Feb 2026 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BjKIjHQa"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3681B6CE9;
	Fri, 27 Feb 2026 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188760; cv=none; b=d6D6qoEbBrrP5juiK4zP0HMH16HebpYfYMYEzbGI0ebCqjOFnq8BpNWWi8QRFzyLTNL9euf6pUH0hsH/IwefA0p+8ULj3NYlzrQUip0PyFLxLk8u7cUnd6kLPG+DzoV5iI22vfCepqCLPasiUE9aTQJIXH8iNLkVhK61By49ETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188760; c=relaxed/simple;
	bh=ioM8dRelJUsuhIhZUYqJWAIIL3DZuUFABGA7490lMwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mA3kUlfLaNq4PVBA2UnRo+K3+iRezyf1nCca7I30/gEP2MqOreivMIq30J+bmV1DsLNogUUsmea6WD3XpgfVgPnRE4BO7SOH+KxTAD3Qwvt4M1MM9bnWKcNMc0QBqLShjS+cvlewON7Qk4dbmQdzYJfc9YGJZTq1iJkgg/BYVfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BjKIjHQa; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fMlDr4McRz9v0X;
	Fri, 27 Feb 2026 11:39:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772188748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8w5EwMRK0R3wBg7LKfkhPQ3VrWqO75sMw6kOXuck4Q=;
	b=BjKIjHQag7RYnvy6B/2Gxbw1I639uus0ziNvLa9skUOEBGmBHIbsWl284BnuLECGOe3S//
	jgDj5RoHg+ok07IFrPzm06W4AzuX1a/6aQByDIlRGye8cb/3cOHlu3pWIKpeCk/eP6q/4W
	BbKhVR4BGXjVbtXhpvxguvux7YBOc/thQHgKJvkG3+7bU7VEjQ9gVcNIE2UC/xpIM4pngH
	Y0lAiaX75bYIYpAK21cKEIq8HmLlHSwkNJ/vS5zbmgrxb+IkaY8ojxrpFsrYi1NArivcjZ
	UOyhpkc+8+1TjPgjPmpUSgdt1xZb5w4xlwu2rJ40QcMzuBkHKf2CIpgtdAIvWw==
Message-ID: <044a03ee-3c78-4915-ae0b-3cf5045df374@mailbox.org>
Date: Fri, 27 Feb 2026 11:39:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] drm/bridge: ti-sn65dsi83: fix CHA_DSI_CLK_RANGE
 rounding
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
 <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ozhti5di6ph93sjyyaxf1hw7dg48qofu
X-MBO-RS-ID: c7d1db9bcc0e34afc1a
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219944-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:mid,mailbox.org:dkim,mailbox.org:email]
X-Rspamd-Queue-Id: 328181B618F
X-Rspamd-Action: no action

On 2/26/26 5:16 PM, Luca Ceresoli wrote:
> The DSI frequency must be in the range:
> 
>    (CHA_DSI_CLK_RANGE * 5 MHz) <= DSI freq < ((CHA_DSI_CLK_RANGE + 1) * 5 MHz)
> 
> So the register value shouldpoint to the lower range value, but

should point (missing space)

> DIV_ROUND_UP() rounds the division to the higher range value, resulting in
> an excess of 1 (unless the frequency is an exact multiple of 5 MHz).
> 
> For example for a 437100000 MHz clock CHA_DSI_CLK_RANGE should be 87 (0x57):
> 
>    (87 * 5 = 435) <= 437.1 < (88 * 5 = 440)
> 
> but current code returns 88 (0x58).
> 
> Fix the computation by removing the DIV_ROUND_UP().
> 
> Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thanks !

