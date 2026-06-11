Return-Path: <stable+bounces-262766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8QKzJebeKmoIygMAu9opvQ
	(envelope-from <stable+bounces-262766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 18:14:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0206735BA
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 18:14:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ogkbxZUc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262766-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262766-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D407B30091C9
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13253E170F;
	Thu, 11 Jun 2026 16:11:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D8395AEE;
	Thu, 11 Jun 2026 16:11:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194268; cv=none; b=uCwWtvp+WNVcAO9qa6dbqZr/RdYjsrZ5506j1G3E6THGzbKDyoShTHKOk7mJ7tgdAAaku90TZQV3sVM3TjintplHIaoVq8foJQ2MsB/CYBA8aCyt75GIuQfaUFo/vbEPqwIB/Fp2JjJTNR75YEcxwzLYY0cMCgZhF2JSO795xe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194268; c=relaxed/simple;
	bh=qnK1lIVwd9Oz6w5M1qJRb48/3Lj2RgjjxdFZqdacRhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTtLjzelN1zRwbdzd5udo7dwsfIg9C/UhMJTI8K0Ut8IImzAug8JL4F7KVANpg72yOvRazGoTK3eA0vb/1R+MSmUEMPsz5jhE1cgz55LD7VBz1HBGe7fXI00jWIJ7Ltppkeixk1PlFqrXMWSivG6JJnUoGgd9kevHMvqKJCnJgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogkbxZUc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959A81F00893;
	Thu, 11 Jun 2026 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781194267;
	bh=5Z2obxuOlT0K7zT6h2EEIhqYsBu6dly8lQ8sboW2Vpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ogkbxZUc39myVWyZO/P2nkC1S3nQ2/OgknkpsBselFFFzetmAo6fgC8uyExejtM8C
	 yPgr7v1BOMEJdWly48BpVxjszwWo4fxd6yIm/EqpR77LsI860MieNfFRosaQPmNxX2
	 h0tlcUOhDdYUg3eGorT/xVpGr0pk4MbY9RF+ZyyuRBor3CFGq7qxWQdFZCt9Nph0nb
	 wXPCfzJgATb7DrOcZyQI6vXJ+pC+QObxDEjVYao8PD4+hIij6THJIPOqdQtJT7iPUT
	 72oBGdd6O0TsKlJAI9Av0a8oC1b4el2Tu5nafhWn3HCMHdCbzThg0s1EegtUVyzdFT
	 BaI8ZDckVca9Q==
Date: Thu, 11 Jun 2026 17:11:02 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: mediatek: fix refcount leak in mtk_probe()
Message-ID: <20260611161102.GV3920875@horms.kernel.org>
References: <20260609081300.208168-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609081300.208168-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262766-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:nbd@nbd.name,m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E0206735BA

On Tue, Jun 09, 2026 at 08:13:00AM +0000, Wentao Liang wrote:
> If mtk_sgmii_init() fails after successfully creating some PCS
> instances, it returns an error without cleaning up the partially
> created ones.  mtk_pcs_lynxi_create() increments the fwnode
> refcount for each PCS it creates, but this refcount is never
> released because mtk_probe() uses a plain "return err" instead of
> a goto to the err_destroy_sgmii label.  This leaks both the PCS
> devices and their fwnode references.
> 
> Fix the leak by jumping to the existing err_destroy_sgmii path
> which calls mtk_sgmii_destroy() to safely release all allocated
> resources.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9ffee4a8276c ("net: ethernet: mediatek: Extend SGMII related functions")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

I think that a better approach would be, on error, for mtk_sgmii_init()
to release any resources it has allocated before returning.

Also, I'm not convinced this is stable material
as I'm not sure it's bothering anyone.

...

