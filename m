Return-Path: <stable+bounces-244203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGleCAkP+mntIgMAu9opvQ
	(envelope-from <stable+bounces-244203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:38:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB7F4D050B
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58EF2303CE04
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFDA481259;
	Tue,  5 May 2026 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MUGBWgbz"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8B480950
	for <stable@vger.kernel.org>; Tue,  5 May 2026 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995475; cv=none; b=tA9aeBYsHq2jb6A4zJ8upB+TR+7HWThncYFL30jHiABQUoQeEIteio1NHfCK2vDBdJAdvUIZWBQARrOHAc7UM6lmsGJXDhh4grfGTcpWTpCKKxlMi95z/0Ut4xs+WpJIZx3xcYRs+PcTAjvK7Cye+Dg6VWZtSxZgRs9KCB4jCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995475; c=relaxed/simple;
	bh=HZmLA+Ej807XLHgfevQTbDYX5T8/bO5w2qryqZwTK88=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=cEpBZGHfBL3MAi6ahLsEtTrR9eFiV+N13Q9ndZX//Lyr91d+l4j+z/cw0E0IWkerFiQ2JfEn/N6Whs7xida/K30bMPNMcz6ovsCsAEB2wbQcbAK5TMhmRMLeZybKT9igsWR0AQzuD3GbEL3H3SgXWTT/9ZFFXK10KSjKegBIMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MUGBWgbz; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 000EDC5D73D;
	Tue,  5 May 2026 15:38:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0F80B6053C;
	Tue,  5 May 2026 15:37:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AAF4E11AD022F;
	Tue,  5 May 2026 17:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777995471; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HZmLA+Ej807XLHgfevQTbDYX5T8/bO5w2qryqZwTK88=;
	b=MUGBWgbzvubrNlMlIq554ytIMiO1qucps4MH4Mkk9B4b2BeeQhHaJ6e66akXUQgGozfyz5
	1Wg8RfSAM715trTjptDPGDDhG1p5FEp3Hh6whmNnwOIcKbWaRcg/a0l9Ax9RFUwDJptzut
	Mm0Dxxx8LaYFQHrgmzCn3XbCkjtQfd4aLWjg1LfpsHYQldMN242ADBh64WAFRV4bPXy2dd
	fAu82mal1ZTtrHcZTrA2EAFelMWIPtI3RJhaLlyzmDtIvDz1LNIPIMD1hKN8OGg16os2G3
	V8wNYHLVa7/Up28SJV/H6qVupM9yTfKtG3w+dnei3WXM6IlMRmYLLPY63LEwNQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 May 2026 17:37:42 +0200
Message-Id: <DIAUSFCMDQEJ.37TV8SIXF9OTP@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v4 3/3] drm/bridge: megachips: remove bridge when irq
 request fails
Cc: <stable@vger.kernel.org>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Peter Senna Tschudin"
 <peter.senna@gmail.com>, "Ian Ray" <ian.ray@ge.com>, "Martyn Welch"
 <martyn.welch@collabora.co.uk>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Archit Taneja"
 <architt@codeaurora.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260430195700.80317-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260430195700.80317-1-osama.abdelkader@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 6EB7F4D050B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244203-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,ge.com,collabora.co.uk,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,linux.intel.com,suse.de,ffwll.ch,codeaurora.org,lists.freedesktop.org,vger.kernel.org];
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
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:email,bootlin.com:dkim,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu Apr 30, 2026 at 9:56 PM CEST, Osama Abdelkader wrote:
> If devm_request_threaded_irq() fails after drm_bridge_add(), remove the
> bridge before returning.
>
> Keep drm_bridge_add() rather than devm_drm_bridge_add(): registration is
> tied to the STDP4028 device while ge_b850v3_register() may complete from
> either I2C probe; devm would not unwind the bridge if the other client's
> probe fails.

I had a hard time in getting what you mean, until I noticed the global
(ugh) ge_b850v3_lvds_ptr and the two "Only register after both bridges are
probed" checks. Pretty hacky, but definitely for the sake of the fix you're
introducing your patch will be OK.

> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Fixes: fcfa0ddc18ed ("drm/bridge: Drivers for megachips-stdpxxxx-ge-b850v=
3-fw (LVDS-DP++)")
> Cc: stable@vger.kernel.org

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

