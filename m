Return-Path: <stable+bounces-243844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEswLpmy+GkdzAIAu9opvQ
	(envelope-from <stable+bounces-243844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:52:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD55A4C01C0
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64734301A3B7
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB75A34DCE3;
	Mon,  4 May 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HL5GL0jh"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194E378812
	for <stable@vger.kernel.org>; Mon,  4 May 2026 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906281; cv=none; b=THd4cUqANIt4ynzdgvFJy0fY6UKtrzrdpi2EfVP8xj+4pNxl0JxBbZo/JJmARFUic9JnWC2eJiD0KR1wnt0K9LZ+5B0BM5D0s4psSLtNk1CbJ/aVc7EVcGte2MV3644cXgzDChoYIxnAZIUiuKzMRICIJIHnr9Yd6vhdQ+gJFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906281; c=relaxed/simple;
	bh=UEerAe/VqV266w5YzUjkWIPlVazTouTk/6bonURZdFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SvxXJamPNjc6EgZ4qoIP9yl4lHtUJ0AcTJtTMffohRYeIj9ZMOxlRy8T1BbpiMWEbbCjlS0Rp/fVidJg6B+ZhA48G1RKadmMjU4QNIt9DV0tg/3FW1MQJu2T1+AET6r4cuERnqOck2EKTCIkwWNDxi4SArukCf1v/ZPivPYOoEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HL5GL0jh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0A47B4E42AF2;
	Mon,  4 May 2026 14:51:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D090F5FD5F;
	Mon,  4 May 2026 14:51:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2E5411AD2AF0;
	Mon,  4 May 2026 16:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777906276; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=r9T7bUyGzyoRVnfKSGbxar4GZSx1vKcnwh8pHU4ippQ=;
	b=HL5GL0jhE9hANfIi6ToH9PM2OWe1L4GeEego7aeusW8VgXQdKS/1uMW7S8o8YCUkEvE8Pd
	bLdW8I9Tha4gF3TFMcTni0uKGkhImeDf2+LoA4SOUiJqYI1kZ7rBRJqtjYd1jXkXGPDZiK
	YULCIN7U/uARlCylAiBGOpealK9DaJtnjUIBfUs5eQ4TKAZNnTZ5/546ZwONu/4FAabAur
	1mki7Wbv7UEgBvd7vsC+EpK1HeQCO+AunaIohYOSz2mhzw5QpEzLetJnlE8qcP31I/5eOd
	6xtsIC5dOJLhjBTDq+sca7RENfXDxfU4PxNdOxZ7/80q9jPcJntmfPKtR3tLvQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jyri Sarha <jsarha@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>
Cc: Bajjuri Praneeth <praneeth@ti.com>, stable@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Russell King <linux@armlinux.org.uk>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
In-Reply-To: <20260428090457.121894-1-kory.maincent@bootlin.com>
References: <20260428090457.121894-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH v2] drm/bridge: tda998x: Use __be32 for audio port OF
 property pointer
Message-Id: <177790627096.423270.11432502656902185390.b4-ty@b4>
Date: Mon, 04 May 2026 16:51:10 +0200
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
X-Rspamd-Queue-Id: BD55A4C01C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243844-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ti.com,vger.kernel.org,bootlin.com,armlinux.org.uk,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


On Tue, 28 Apr 2026 11:04:56 +0200, Kory Maincent wrote:
> of_get_property() returns a pointer to big-endian (__be32) data, but
> port_data in tda998x_get_audio_ports() was declared as const u32 *,
> causing a sparse endianness type mismatch warning. Fix the declaration
> to use const __be32 *.

Applied, thanks!

[1/1] drm/bridge: tda998x: Use __be32 for audio port OF property pointer
      commit: 2a46a9356ba7b1bdd741c8b41e5374edcd960557

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


