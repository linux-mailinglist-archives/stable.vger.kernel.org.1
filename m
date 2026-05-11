Return-Path: <stable+bounces-245251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHNACjLtAWpHmQEAu9opvQ
	(envelope-from <stable+bounces-245251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:52:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 912F95109A5
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F17F93051BCE
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F48D3FFAA0;
	Mon, 11 May 2026 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VWaqAKoL"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C03E63B8;
	Mon, 11 May 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510824; cv=none; b=j6VIa1NZmU4EJcSz1nn0lw4MBfrNeJSVSHZXO9qHpUnLAbl1RLcZd5F0oWUhmvXL5/44pnSSUDOKpq7TK+5zB2pHz3qlWhwamKrCVG0Qq+y/WXs6V6cA68V3/h8G1C/l/q0T+TAMCinpWBTYIyW+JRvfyP8GzPW45C46Q+LPTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510824; c=relaxed/simple;
	bh=RYmIXowrr7pr3gorZbTZ3rhHQYY3hTTTsYnjsPi+7WU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=psE3fMvKGk+MlElOW15fRZsuk3AkHx1bBfHU+cbtVK4Bs+z6FseZHJkIpUH2z+nKwgmHwFCyFHgxnZ70c/nakmzJ5bakjYbk1mb9Ge3U2blMzlFpbWoVmst2CNBo+vuGZ7OYpYqV+VstwEpOe9weaj7bM/oLsRz4UfgBGC3NoVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VWaqAKoL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CE44C1A3507;
	Mon, 11 May 2026 14:47:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9157960646;
	Mon, 11 May 2026 14:47:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8FBE11AF9E71;
	Mon, 11 May 2026 16:46:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778510819; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=G1i5mz2DWzKBNwv2Sy64RuYnaQuN20oFQ0vjUn6j8Ek=;
	b=VWaqAKoLo7iSnjsWK23N+ph9jQaUME0KChbqVzf9tLYzeheWPidalhUTSaFTbWgUYaqKfK
	+71228TfaAxz53t4iMjAN3Tfme0JSBzuk3pimeLjg7G+bdTfkj/Pyo+61OWsradBAROdDc
	xURMoZn124wkB8c7Wkuul1VsopF9s9IF+rsMmFQsIMagw+x0kNr3NX3ETrQYM/d9c1OZAY
	GROGkbhxhFOWlQYueuoJO3BB/55AwaM/Rt2JfCTj8QOCJrPJ2DUY9Bh0DZWjsV5JOAe4Z2
	oyIR4V5RpC3Wy75+yhvuI8IuBsY21haBe0MwpkUV7vrvLNZAuvY97uMbDIsZSw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/2] drm/bridge: chipone-icn6211: use
 devm_drm_bridge_add in i2c probe
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: luca.ceresoli@bootlin.com, Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260430194944.78119-1-osama.abdelkader@gmail.com>
References: <20260430194944.78119-1-osama.abdelkader@gmail.com>
Date: Mon, 11 May 2026 16:46:43 +0200
Message-Id: <177851080324.59556.13424478378599102713.b4-review@b4>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 912F95109A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245251-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[bootlin.com,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,denx.de,lists.freedesktop.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:url,bootlin.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 30 Apr 2026 21:49:42 +0200, Osama Abdelkader <osama.abdelkader@gmail.com> wrote:
> drm/bridge: chipone-icn6211: use devm_drm_bridge_add in i2c probe

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


