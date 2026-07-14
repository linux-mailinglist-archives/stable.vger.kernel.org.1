Return-Path: <stable+bounces-274590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 67vIF4K4Vmo6AgEAu9opvQ
	(envelope-from <stable+bounces-274590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:30:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A23527593CF
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:30:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=N98NbSqp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274590-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274590-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D30C30247D2
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CF2418A47;
	Tue, 14 Jul 2026 22:25:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A7B377AB4;
	Tue, 14 Jul 2026 22:25:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784067957; cv=none; b=MI1KQ4TIEqdY+f3CjN+dt7hBuekf1iWRrfVrDRPbiXN5ScATo898+pOjNPRVJJuu6H2XbTGVjOWhtcmvJn7qIdhQH03nbgL01bjnV64fTIO2NYhOpoNXXEfngk19p9xfgX008S9w1tA7G0kryKxLO2artoeSM3wPJ55692CNy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784067957; c=relaxed/simple;
	bh=S7eAX6LeH8Zsdt9Sg2EvYAKXA2oU0yPKhN5cDf7rbYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWneHqnxZ+pRnkosMdshUlR6HNJNNT21Cn4H2Vk+vD36c2PxDN8NpWT018UlZn7S35N55L58S75Q6JFMcfjcrBP1K+Kjs98fRoZfNonoRkhRFydglzdTUQ4mQMik7bP4fHSTkJOnhmYkCm0nqzE3KNppmuUTug/h1I0imXpUZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N98NbSqp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F831F000E9;
	Tue, 14 Jul 2026 22:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784067955;
	bh=FnY3zyFinC3+lm72vnzw/gDx1kFOPSh6nzQxKUrgSKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N98NbSqpiwClF1AgURNZpLcV2roeim3qj6ofCisOzrlaFw2JSk5FNtXl6hVOyIrpk
	 uN5nJInB316XY56tbnTv0qZIdDtETMWtXsxiDrGANR3eETeX5R/R666jWhgkf+XJa8
	 pkQ+JS1G7lcRGalcFWyN3OJ3Xs1xcgf0tCzTcFO332gW65eSVlptxeSmo8wME+curv
	 A1JJZuDNOVVkUBZTUVDKkKa620F4Mya3ECF7JSiyM8AhOGRx8EsJMLPHr131yrqG/h
	 67+L/NdfLDGvUvoDJUXg5+H1k6LilDwJTMK3V+EMOZ/GxiKrlXKBd942W+EtvH2nmK
	 k4IoUrixnUi3Q==
Date: Wed, 15 Jul 2026 00:25:52 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: rva333@protonmail.com
Cc: Qii Wang <qii.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: mediatek: fix WRRD for SoCs without auto_restart
 option
Message-ID: <ala3XZ1Jw_M8sZlt@zenone.zhora.eu>
References: <20260709-6572-6595-i2c-v2-1-b2fb8510d1d3@protonmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-6572-6595-i2c-v2-1-b2fb8510d1d3@protonmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274590-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rva333@protonmail.com,m:qii.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:stable@vger.kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[protonmail.com];
	FORGED_SENDER(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,collabora.com:email,zenone.zhora.eu:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A23527593CF

Hi Roman,

On Thu, Jul 09, 2026 at 04:31:29PM +0300, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
> 
> MediaTek mt65xx family SoCs have no auto restart, however, they still
> support the WRRD mode in the hardware. Because auto_restart is set to 0,
> the WRRD mode will be never enabled, leading to read errors.
> 
> Fix this by removing auto_restart check from the WRRD enable path.
> 
> Fixes: b49218365280 ("i2c: mediatek: fix potential incorrect use of I2C_MASTER_WRRD")
> Cc: stable@vger.kernel.org
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

merged to i2c/i2c-fixes.

Thanks,
Andi

