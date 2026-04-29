Return-Path: <stable+bounces-241872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBsdBzDv8WmulgEAu9opvQ
	(envelope-from <stable+bounces-241872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:44:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897E3493B27
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D0923050A24
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 11:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ACC3EF66B;
	Wed, 29 Apr 2026 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cvcX78xV"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AD13F0A98;
	Wed, 29 Apr 2026 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777463028; cv=none; b=kyRESelmfO3Wr4uc++2Pww2BbhhfUS8ppLp7TvByabjwOsMhC9FzqLsWhzKSX1VEiK6CpqntI/pNCql/N0TJ1tP8W4QObUjSs+IlEDyzl84Rr958bN9nbmcwQYDEC45EnvO/2+TOpW6S3qIq6zV3o+w2GTW5bfTH6o+Lckx0uw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777463028; c=relaxed/simple;
	bh=5C5WjMDCk4kbiTHj64gwZ34T6TJ7DSCuppc2MhbBVao=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=rkb8CCglNGyi+PXwa4MGISASgZshFr3v24Rs9tHcYSBJv2o4PiEM33js+YhQw5JXSh9j6jDPRwFOGyFIzihRqIQE/8FedfXflaM3H0UQ+ZIy/7ao88cS99fM4HnVNh/KeU2qbeiLPcoQLd6BbTDQDM4r/src3H5q9NoCMY59pKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cvcX78xV; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7EAF0C5EF22;
	Wed, 29 Apr 2026 11:44:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 67BF6601DF;
	Wed, 29 Apr 2026 11:43:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 338701072818D;
	Wed, 29 Apr 2026 13:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777463024; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5C5WjMDCk4kbiTHj64gwZ34T6TJ7DSCuppc2MhbBVao=;
	b=cvcX78xVFs+rZdgta+uYUEgQ/SAm/sIgoeTFarUqiBRML5ZY/9UiWUx7+q+JQeBF8vWK+P
	Wdgz8vkjIaJCxLrbMnVNSC5QEcjF9CPznrQytjqO+77z5lRXw+3zTar8BcBL+nV0oa3JqN
	QxK20Tuix558dogywl6fJlAAfr099sNplQZMsVeDE8dj17uY/vSXvbe+TtGl0Nsz7Qsgqs
	PE8WgLi0UXWMVC5q2p6MuSu/2U6DuAQs2g8cftVQU5Oohwqg9jFZD1FSi1e9nAREZ0TuHl
	TjkLJMZcZTF+Sh/huni6gXY3usH9ZYfg+K9VsxZt4NzDZLY0eF7/WnYKcODcjw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 13:43:38 +0200
Message-Id: <DI5M1Y2NCMPO.1YJOI1CRHENOC@bootlin.com>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Inki Dae"
 <inki.dae@samsung.com>, "Seung-Woo Kim" <sw0312.kim@samsung.com>, "Kyungmin
 Park" <kyungmin.park@samsung.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Hoegeun Kwon" <hoegeun.kwon@samsung.com>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 2/3] drm/exynos: remove bridge when component_add
 fails
Cc: <stable@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
 <20260423200622.325076-2-osama.abdelkader@gmail.com>
In-Reply-To: <20260423200622.325076-2-osama.abdelkader@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 897E3493B27
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
	TAGGED_FROM(0.00)[bounces-241872-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,samsung.com,ffwll.ch,kernel.org,intel.com,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:email,bootlin.com:dkim,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu Apr 23, 2026 at 10:06 PM CEST, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop the manual drm_bridge_remove() in remove().
>
> Check the return value of devm_drm_bridge_add().
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Fixes: 576d72fbfb45 ("drm/exynos: mic: add a bridge at probe")
> Cc: stable@vger.kernel.org

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

