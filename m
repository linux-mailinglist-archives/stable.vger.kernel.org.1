Return-Path: <stable+bounces-267081-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uMBZAnq/M2rmFgYAu9opvQ
	(envelope-from <stable+bounces-267081-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 11:50:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AC669EFDD
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 11:50:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267081-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267081-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5833301889A
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 09:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10573DF009;
	Thu, 18 Jun 2026 09:49:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33433DFC6B;
	Thu, 18 Jun 2026 09:49:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776199; cv=none; b=chQFFI32xGCAEkUJMcmXBU6gs/AWozIVNsRuQ1nYn1RAMyRqMF+NkaXe4AI1xpVL7FGO2L1b+LyldD/WLD3cW6Hs5z9F/K1O5oiqq3LHPYE5FmCPSWtwbbSPHJQFtNGyb3bnPPnLYwmBdAKoU8Jxr8KZ6tWeOHFR7BOa0rfT/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776199; c=relaxed/simple;
	bh=1j6nLnLOVBePWf0/aAALwVLmoB3ZSMnuH+q4qiF6yGg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qykrRz05RQtOaCETGV0V+GAswuxXg23qYEhvJj6Y//9fDh0E8LT9cSSEAMSDQJ40L+oGnjglMe3+jNEC5eg1uXxTm1IDYYQcz+3PeUzTh4GUAgiiXQq/EM0yIj5YCxweAgWN47e5X29qtnpEci6l6vFg1AqidQUXMgG+ooBhVM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EF99F2002AA;
	Thu, 18 Jun 2026 11:49:55 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wa9Nj-003Psb-2o;
	Thu, 18 Jun 2026 11:49:55 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wa9Nj-000000005Vo-3N6X;
	Thu, 18 Jun 2026 11:49:55 +0200
Message-ID: <bda9fbc282d9be7d07605684c12447877663754a.camel@pengutronix.de>
Subject: Re: [PATCH] reset: sunxi: fix memory region leak on ioremap failure
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Zhao Dongdong <winter91@foxmail.com>, wens@kernel.org, 
	jernej.skrabec@gmail.com
Cc: linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, Zhao Dongdong
	 <zhaodongdong@kylinos.cn>, stable@vger.kernel.org
Date: Thu, 18 Jun 2026 11:49:55 +0200
In-Reply-To: <tencent_2C7697B076D53BBE62D99B7CD15E77A20C07@qq.com>
References: <tencent_2C7697B076D53BBE62D99B7CD15E77A20C07@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267081-lists,stable=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS(0.00)[m:winter91@foxmail.com,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:zhaodongdong@kylinos.cn,m:stable@vger.kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[foxmail.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[p.zabel@pengutronix.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p.zabel@pengutronix.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:mid,pengutronix.de:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94AC669EFDD

On Mi, 2026-06-17 at 11:16 +0800, Zhao Dongdong wrote:
> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
>=20
> In sunxi_reset_init(), when ioremap() fails, the memory region obtained
> via request_mem_region() is not released, leading to a resource leak.
>=20
> Add an err_mem_region label to properly release the memory region before
> freeing the data structure.
>=20
> Fixes: 8f1ae77f4666 ("reset: Add Allwinner SoCs Reset Controller Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

