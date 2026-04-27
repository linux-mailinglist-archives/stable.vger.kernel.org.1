Return-Path: <stable+bounces-241304-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L/jJvNY72n5AQEAu9opvQ
	(envelope-from <stable+bounces-241304-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:39:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA1D4729DC
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A73B3067FD7
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CFC3B8BBF;
	Mon, 27 Apr 2026 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="r8ETKXg9"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CDA3B8BCB;
	Mon, 27 Apr 2026 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293284; cv=none; b=cor52NGUcQjBIiT5/k86zO1FWSYZaXc8K4MsJLVzOOJjTX05mm9uIDmTlFZGspZOUFuq/bHskgg23yn93z8Mx0gyyzshk3vqtaKzhITxC1VGX9GwAmzU0wq69B2n2CuCTrd4mGCIVGNAJJjUlTR+tYK0op85YMRiiHrTkT8R54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293284; c=relaxed/simple;
	bh=sOz8A9YPihzEd99kRu8ucJArY5Hj2NaBY/3RDQjotVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRVpxM6rgwYGGdsyELA5N51tvASTzSIMloUpn4EKXDk8LStK418d+4ETpIRocbi1jNXHRW/JO/ofd98eYHo9XpRs6u0pvYyIfXzcL/Q1UfzxZWN/NwHEYiV/7vaK1qXqUoIBZ21TwHxdd4luRifxnhVWF5GTRUO1zFN5XkxkP2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=r8ETKXg9; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=h7oEJShaFloAJ3rLxurIsdLzrXqr4IFYv+DPlRiRe2g=; b=r8ETKXg9r3VtVQBW+/XwowA8Sl
	J4rYTq+XAvlLPnexbb37uxHWyetQAE9qyMveyF8rzTHUlZVkBm7IJ0K8YrKRweiu/X5Rb5Qne1PDE
	k4Cn/A9dRbyQ1axlXa7ly1c8nzuR929l2MCtTt41bOGrVDFTJGBXymhpSIJj6ndPvGlMBaXwEVERZ
	PNy9DGQ/bW59Qf8DqRqVe6tnEaYzXpHt6ylH2twL7udJsO2/FyZuOHOVHC/sAaitEG46cHnEiPaGE
	HLdM/GwKfFty/gp2kQezySTd1rwrS5AYxvZt8KCTOiCbHo9bKuem2s/R6saCYAv1QNNp7PQxeNQW8
	LJujnduw==;
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Hovold <johan@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] clk: rk808: fix OF node reference imbalance
Date: Mon, 27 Apr 2026 14:34:38 +0200
Message-ID: <4062384.Icojqenx9y@phil>
In-Reply-To: <ae9QiGGPB9gJ0HhG@hovoldconsulting.com>
References:
 <20260407095027.2625516-1-johan@kernel.org> <10504733.NyiUUSuA9g@phil>
 <ae9QiGGPB9gJ0HhG@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 3EA1D4729DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241304-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sntech.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sntech.de:dkim,sntech.de:email]

Am Montag, 27. April 2026, 14:03:20 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Johan Hovold:
> On Mon, Apr 27, 2026 at 01:17:39PM +0200, Heiko Stuebner wrote:
>=20
> > Looking at the device_set_of_node_from_dev() function, this is the
> > right move, so
> >=20
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>=20
> Thanks for reviewing.
>=20
> > It also seems the rk808-regulator.c might be another candidate for
> > this, as it also takes the node without of_node_get and manually
> > setting the of_node_reused flag.
>=20
> That's fixed in 7.1-rc1:
>=20
> 	65290b24d8a5 ("regulator: rk808: fix OF node reference imbalance")

nice ... should've looked there, instead of v7.0 :-)


Heiko



