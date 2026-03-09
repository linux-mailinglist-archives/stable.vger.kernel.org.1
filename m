Return-Path: <stable+bounces-223731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I6CO8JFr2lbTQIAu9opvQ
	(envelope-from <stable+bounces-223731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 23:12:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF5242190
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 23:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69D20303F05E
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 22:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F24425CEE;
	Mon,  9 Mar 2026 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XR8U4r0o"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637034B197
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773094302; cv=none; b=EgnO4scFQgppLkZnWNxSTJB+ndSRGOB0TWVhqKu6w192CCPvm92sYBe0l4vOwK6P9Fea9sdUSq5Opq30qFx+W0AYw/0kRrd8tnjI4tnTQDTu6QJYc8ohd6PrkCrIHI7eipuIoSHOaeVjHg+z5MNgc7CkVHZS9OwpAgBTc/j/8qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773094302; c=relaxed/simple;
	bh=7JbT6R6SIbM8amciyZsK0MMMAtBzxAh3sN/RrfOqdgI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mpUGo6/U/k/k/61I3AejPvVQK84f7IhXaakY+1Fr9+DLP1yq19+q/Y4us8KenGyWbtE6ARojqgF+YZFFqjKsZpCVWw7eaUReS3ixAO+IPBeWq137brCKpkxmH6+q6cDZPCD41MFLRq+rSioL61c514fP8LczqExVup69eKc2xPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XR8U4r0o; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 81B641A2CD6;
	Mon,  9 Mar 2026 22:11:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 44A895FFB8;
	Mon,  9 Mar 2026 22:11:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 942161036971B;
	Mon,  9 Mar 2026 23:11:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773094298; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WYlXLONy9mBlcv034goEv1OXN0BmOgEpq5aAxgqAphg=;
	b=XR8U4r0o+4rtoXQfOhCQQyzV/C/Gf1YY78if+p628DmpTwm3AMRZDVzZ8yUXzKsW8i5eVe
	aBeW8o+3ypYxYSMnloAn+DM6ygI19M6NJtH1hDkn2Zkux/EffRRxhzSxDb54vnqBWARUEt
	uxgSBZ2C4rW9Zgrrm3u4LzZfxuNdTx3L5tXma0l5R0FREQjvVgm+tWO+vmDQTWk/ihAUJT
	M3dVCLL9uJYYNgpUzIqe3nN43PXAH4sZ6r/tJPDKMAt+Vg5rJKis3puE0VE5u0FVaxRR/g
	Kj+P8dEUz58X+L/H0mu8bwOWirOWMZDFIzzikZSqpBQVAOky4AWuokll4bmusw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>, 
 Linus Walleij <linusw@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-0-2e15f5a9a6a0@bootlin.com>
References: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-0-2e15f5a9a6a0@bootlin.com>
Subject: Re: (subset) [PATCH 0/3] drm/bridge: ti-sn65dsi83: two fixes + add
 test pattern
Message-Id: <177309429437.116308.1394218325282178971.b4-ty@bootlin.com>
Date: Mon, 09 Mar 2026 23:11:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 4BCF5242190
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223731-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,kontron.de,denx.de,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action


On Thu, 26 Feb 2026 17:16:43 +0100, Luca Ceresoli wrote:
> This series fixes two bugs in the driver code and adds support for enabling
> the test pattern output from userspace.
> 
> 

Applied, thanks!

[1/3] drm/bridge: ti-sn65dsi83: fix CHA_DSI_CLK_RANGE rounding
      commit: 2f22702dc0fee06a240404e0f7ead5b789b253d8
[2/3] drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual LVDS output
      commit: d0d727746944096a6681dc6adb5f123fc5aa018d

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


