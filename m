Return-Path: <stable+bounces-266681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 66bLGcFlMmrJzQUAu9opvQ
	(envelope-from <stable+bounces-266681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 11:15:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA648697D04
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 11:15:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CNWs3zZj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266681-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266681-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9283E3081287
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 09:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A5739E197;
	Wed, 17 Jun 2026 09:10:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9025938C437;
	Wed, 17 Jun 2026 09:10:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687413; cv=none; b=i5WtSPQy0LzDnU6kPsxjwM+x+3rg154dJ7PjvPUmuHRwa+HeUmEV3Jj9Wprdaxn/S5MHX4p7AWSm4kPfDVWGYCYm2qI1izG22K4bxYdyiuR9xnb/KoMK0DEhA0Hyhf1XbvtojcdH7mANwT/s1jrcFRzTZGIX4G9/HWURE5kGNzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687413; c=relaxed/simple;
	bh=/5iYwfX/ztPp/qB5wcHpeFho909r7yqJNThsch1wIuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei6o2y4OREy6TcGjB/dm9VaeR2xfOXG4TTI/BqsiQGibmxD8opUMAF/KX23hem807kp2HCDOWIpFh/h1vQvpnCmEHZ3R+Nyle68jUhWoYWz6IEO4RM3XUjhq9VZ8/ehbEAiWeXeEfEgJ9Ci7Oi/yXgDFPevVo4WQOA3gNIFfnPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNWs3zZj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A941F000E9;
	Wed, 17 Jun 2026 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781687412;
	bh=cZeY91bsLZ6XcUtAEW8LR2FhjQcmo4GITFYewTgQyTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CNWs3zZjlcA1gaAwoIQDc6sIc4rHPrYCKFvz7Um7OaHbuzS+Y4+tufkSTTKo9VznT
	 AmtO+GEq/K5WbBGhV+xtrE3dbM4Yoa+QO5NCpaOYX28GKwBkVJWtTGab6YKgEA5ZFw
	 Pg+o2jnNE5W/vOrhkQc9TBjJeYb47U6KT82pxmY5fVmi2NKDY0cONakXjsCwVrVzE+
	 dgdg54ax9/H6QMlpJFrkjcwcFpnmQ1ymNfj1xtaMoQHZCgozdo+Adu/tFmtisgZRbl
	 0ixZcaweD0r2hNv0fkXjzvZucg0Z+U4s5/qy6fyo4ejUZpggvV7TPsXvMikUjhtCCa
	 tHUzFSzxOuLBg==
Date: Wed, 17 Jun 2026 11:10:07 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: aisheng.dong@nxp.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com, 
	linux-i2c@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] i2c: imx-lpi2c: mark I2C adapter when hardware is
 powered down
Message-ID: <ajJkQIUD0gu9nlf3@zenone.zhora.eu>
References: <20260525031450.3183421-1-carlos.song@oss.nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525031450.3183421-1-carlos.song@oss.nxp.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:carlos.song@oss.nxp.com,m:aisheng.dong@nxp.com,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:carlos.song@nxp.com,m:linux-i2c@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-266681-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[i.mx:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA648697D04

Hi Carlos,

On Mon, May 25, 2026 at 11:14:50AM +0800, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> On some i.MX platforms, certain I2C client drivers keep a periodic
> workqueue which continues to trigger I2C transfers.
> 
> During system suspend/resume, there exists a time window between:
>   - suspend_noirq and the system entering suspend
>   - the system starting to resume and resume_noirq
> 
> In this window, the I2C controller resources such as clock and pinctrl
> may already be disabled or not yet restored.
> 
> If a workqueue triggers an I2C transfer in this period, the driver
> attempts to access I2C registers while the hardware resources are
> unavailable, which may lead to system hang.
> 
> Mark the I2C adapter as suspended during noirq suspend and block new
> transfers until resume, ensuring that I2C transfers are only issued
> when hardware resources are available.
> 
> Fixes: 1ee867e465c1 ("i2c: imx-lpi2c: add target mode support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>

merged to i2c/i2c-host.

Slowly I will check more carefully all your fixes. I'm sorry for
the delay in this period.

Thanks,
Andi

