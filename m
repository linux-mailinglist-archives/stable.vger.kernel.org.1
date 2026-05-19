Return-Path: <stable+bounces-249496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGRJAaQlDGoIXQUAu9opvQ
	(envelope-from <stable+bounces-249496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:56:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9594E57A9D2
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75FDE303B25B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A623EFD14;
	Tue, 19 May 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e/9BRLYo"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC7E3EFD34;
	Tue, 19 May 2026 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180925; cv=none; b=hHqOLHGQib0XquaKJ5BVOL7x8UxgCDYlryZNjYjweQyfsZQD6Gt3kJSRjYJz6H/kbelnhdqpo1wNhdQWifbyNo26uMp9MFEWp86OCm3wpT3uewrZ80/Ar7Ni8XFcsiwDEh9/nDK3bozP7j65625wC2GHUxxYB12sXAVpamIUOHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180925; c=relaxed/simple;
	bh=znQq4i5KuSgP06BUFtHOTw5c//xJBhQmYgIuDIYDcNc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gs97+5UOA59/U95SfcOnRZYJMk5U1ZP2e1vz8eCIxK7Hq4kPXU/Avrduhc9I450BsUMHlBIuEVONXxWBJvoRbJlFQTORSV4ro0GDAPcqTjj99khFdYlWbLGWBvFZT9cE8t1+HHiRaacbydX4RmWgbqWeo900IOso6cBczRF11Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e/9BRLYo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9FECA4E42CF0;
	Tue, 19 May 2026 08:55:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 66119606E9;
	Tue, 19 May 2026 08:55:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0AD6B11AF8B8F;
	Tue, 19 May 2026 10:55:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779180920; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XXqocNQlMTY8aRunaEJUBXO8xIg0vOs7JDa287pGveE=;
	b=e/9BRLYoYMCFKJvDfiotI+g3jFSa/st4jOph+GdrryiYfogmJzsSk97q/Y2p0B1Q/3s20q
	/68UrIZX5aqAbIewOuaD/8mh6i7LBS8m9+7PYR9K6pBs+Q4SPJn7jCouZnrjTPrC6/9nh9
	ijFvJ4Q+uY7o/UH9VKtwITvQ5ZfBvgj5+J4J/cMvv2C9PiYUgBa9itCAKYQluGYmjCkjVF
	OA4LF/6IxxwsbCtJGpuoXdddkXHcLB9/J+yBVzN/6Y6R7ohTIDh/ARw54K1YOC5PqcBgDy
	Gs+j3NzVj+ofdJLUaGypzFQgrU3IgRlaNoRQweMbTSiSrmYmOslBs2fyTnmNxA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Peter Senna Tschudin <peter.senna@gmail.com>, Ian Ray <ian.ray@ge.com>, 
 Martyn Welch <martyn.welch@collabora.co.uk>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Archit Taneja <architt@codeaurora.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260430195700.80317-1-osama.abdelkader@gmail.com>
References: <20260430195700.80317-1-osama.abdelkader@gmail.com>
Subject: Re: [PATCH v4 3/3] drm/bridge: megachips: remove bridge when irq
 request fails
Message-Id: <177918091379.250715.361254713159943739.b4-ty@b4>
Date: Tue, 19 May 2026 10:55:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ge.com,collabora.co.uk,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,linux.intel.com,suse.de,ffwll.ch,codeaurora.org,lists.freedesktop.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249496-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:url,bootlin.com:dkim]
X-Rspamd-Queue-Id: 9594E57A9D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 30 Apr 2026 21:56:59 +0200, Osama Abdelkader wrote:
> If devm_request_threaded_irq() fails after drm_bridge_add(), remove the
> bridge before returning.
> 
> Keep drm_bridge_add() rather than devm_drm_bridge_add(): registration is
> tied to the STDP4028 device while ge_b850v3_register() may complete from
> either I2C probe; devm would not unwind the bridge if the other client's
> probe fails.
> 
> [...]

Applied, thanks!

[3/3] drm/bridge: megachips: remove bridge when irq request fails
      commit: d45d5c819f2cd0b6b5d76a194a537a5f4aeefecb

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



