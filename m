Return-Path: <stable+bounces-249493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOcqCr8jDGpqXAUAu9opvQ
	(envelope-from <stable+bounces-249493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:47:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CB857A748
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EBE4304BD45
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC283E0C5A;
	Tue, 19 May 2026 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pccyd7ig"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FF53E0C61
	for <stable@vger.kernel.org>; Tue, 19 May 2026 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179575; cv=none; b=dxIw6NktFZhuV7ooTr9lvD30bMNeVxdt6pQvCUnzzaRgl47n8j9pviW5yH0DEeFPLjCMk/u7hRMGDSEm4EY1dBMpdr6A34oB6Y5QHGrlxJb6hVYoewZ6HqRkMBPGTgHtXjuLTzYEeht+fNCWWGTPAAhaZzlX5G+6MGSMI8r3nXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179575; c=relaxed/simple;
	bh=wnrS4dcVqmKW4AB86g4pJmocMvF9ZK6MkX8Xv5p8yF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JEL2UnEbdZXEzwL3+4cqkuQpXgPV/wuGXhcdT7Pubc2xCpw0/o0UWlvMzOwAeUmsjOLvF5yJYXylxELm0/dpW3XX9x9NgAogc7UZMsGrTkTIalVmUNGdKYJshsNfHabBEORnz9caaM2CL+nWqareiwePNy5JAqiGy8y2jS23dzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pccyd7ig; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DA0F71A3621;
	Tue, 19 May 2026 08:32:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA6E5606E9;
	Tue, 19 May 2026 08:32:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E83A11AF8B81;
	Tue, 19 May 2026 10:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779179570; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VlqOUs/HlxKHLGHUE043tCFwBQNWXwKu63vYHdIURK8=;
	b=pccyd7igbtHf6/xloNwwoUnJHRjSHf7XHOburEAzTu/CG4FaFGuZ7RhzXaNC6tSn+tO9YO
	rah5eg1k9zTVvxmv5+71dTeR0ky4PY4VZuIe4VfEX3gunRiKpkY9MLj9Vf0cEg5m4E0DTe
	2CNL89hvU+mz6m08r/oUgE3jHlVU8qjzxHeFf0R05H/uRb9nsK/exUl8AkI7AFHVvmXtNt
	FCbOdHS+VEh3NvEkGGeHNFeBRCUCc/Bg/A1prjtU4aTvV/fkchLe7msklZx+NGLjMv/ucD
	at4uzn9D5D7veKTVDm2KGOgzOpc9tS545rcLTKKS5xc7D/2NeIwn2YUgcqnECw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260430194944.78119-1-osama.abdelkader@gmail.com>
References: <20260430194944.78119-1-osama.abdelkader@gmail.com>
Subject: Re: (subset) [PATCH v4 1/2] drm/bridge: chipone-icn6211: use
 devm_drm_bridge_add in i2c probe
Message-Id: <177917956604.84587.1196053606706642578.b4-ty@b4>
Date: Tue, 19 May 2026 10:32:46 +0200
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,denx.de,lists.freedesktop.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249493-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,bootlin.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 35CB857A748
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 30 Apr 2026 21:49:42 +0200, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe
> fails after registration, and drop drm_bridge_remove() in chipone_i2c_probe.

Applied, thanks!

[1/2] drm/bridge: chipone-icn6211: use devm_drm_bridge_add in i2c probe
      commit: 73d01051e8040c0b1de7fd26b3b8d0c2ffa6895c

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



