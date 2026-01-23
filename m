Return-Path: <stable+bounces-211322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PY9OD3ScmnKpgAAu9opvQ
	(envelope-from <stable+bounces-211322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 02:43:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C28866F3E4
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 02:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A4C530039AA
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 01:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DED337E311;
	Fri, 23 Jan 2026 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLcTcLra"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286A2165EA;
	Fri, 23 Jan 2026 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132599; cv=none; b=kdmg56TTpmGxWRIbNX65jelLWhPy0vzhEsqwQ1OJaTlI2g7+yG0pPim5MtCnRncBquoBEqjIOEidJRikl7X0OBvYkIXoMZtf7SjVOyeiQ6T0gjkuCAj43062aaKFCjMv8E8Qw96q6nb0joDlji9cbup2AoUdJ7qvc9vmq/uhcIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132599; c=relaxed/simple;
	bh=tkthldLffXYVms3wxAD2lbP6j9gBgsHsKO89SXCZQ54=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=d+M6B2L3+IAtIqZa3WZhJi+igyGbgws16l7Y0g1i7A1GwI435iwg1mL4C/aBtYSJeSHnEYEUY/JrzS6q8+C04UM3pxqDeTLQ3xpZM45sUTAnKYmDIFW8mJycrv4pfIMj9oXrcnkMVpujyLMzWEMavOjw+wdBzQTho9aO7MxHRWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLcTcLra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFEDC116C6;
	Fri, 23 Jan 2026 01:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769132598;
	bh=tkthldLffXYVms3wxAD2lbP6j9gBgsHsKO89SXCZQ54=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=uLcTcLran58oZgank16uYJiybGF0GSvNw1wlsmWRmd2bHG458ZEJRs/yn95lUTUKG
	 jEgHvG9TzAM/JYI0kmiLz15iIoqy0S6sZ9z/ThLHQv7bczkT6fKcfvUI3QsbORTAb9
	 A0Dk2RUgIfp49c65Fm9UqVoQ6Fv1uZeLhZUmXyRdVELn9iBbrRIwONnxLVpv5m1tRw
	 GZMADfi3KLM8zVKcPRtppjOtsOluIS++kqv3uyPT2iqth1PCHtmU/u3H1QVBOXCHl2
	 wfSLYrMb7yh+PQ5uKc7HTb7EC9qzbyDuHVlL54NKF6YfziHvdQy6oC8Lm2sKIEe+MH
	 nUY4sL2MTrtWw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251223-mtk-gate-v1-1-e4a489ab33de@collabora.com>
References: <20251223-mtk-gate-v1-1-e4a489ab33de@collabora.com>
Subject: Re: [PATCH] clk: mediatek: Drop __initconst from gates
From: Stephen Boyd <sboyd@kernel.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org, Sjoerd Simons <sjoerd@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Laura Nao <laura.nao@collabora.com>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Sjoerd Simons <sjoerd@collabora.com>
Date: Thu, 22 Jan 2026 18:43:16 -0700
Message-ID: <176913259630.4027.12058255654210765589@lazor>
User-Agent: alot/0.11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[collabora.com,chromium.org,gmail.com,baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211322-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sboyd@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Queue-Id: C28866F3E4
X-Rspamd-Action: no action

Quoting Sjoerd Simons (2025-12-23 04:05:17)
> Since commit 8ceff24a754a ("clk: mediatek: clk-gate: Refactor
> mtk_clk_register_gate to use mtk_gate struct") the mtk_gate structs
> are no longer just used for initialization/registration, but also at
> runtime. So drop __initconst annotations.
>=20
> Fixes: 8ceff24a754a ("clk: mediatek: clk-gate: Refactor mtk_clk_register_=
gate to use mtk_gate struct")
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> ---

Applied to clk-next

