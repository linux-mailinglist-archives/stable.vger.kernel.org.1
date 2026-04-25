Return-Path: <stable+bounces-241135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JD5NZ4D7WlNeQAAu9opvQ
	(envelope-from <stable+bounces-241135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 20:10:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D95646738A
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 20:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35676300463E
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744B1367F2A;
	Sat, 25 Apr 2026 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="souE4j29"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BCB364942;
	Sat, 25 Apr 2026 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140630; cv=none; b=pW45uHrY2nCoFO4CzSdFs91Ip8dG7DXkL7uOgWsXjr6TihhAtZQ8IFo47B+kndQBnTU2S7vKkVCug/nzL07ZtZNAA9XFJKDUn/ElYtKCO6wwNjYovdugV8IATygUAfZeLqCt0R64Z5udlth81UH+uzKCLT3/7vu2VFQ0kM+o4hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140630; c=relaxed/simple;
	bh=4UseIi6/4cEexD8PoYw5ApPhHH+2eEMqOMHJSU0aqFU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=OlLlXHxWow665DuluesQxS/FHt5nH2Z2Hua7iXer4nblW3PJO1wusaXbqep1rKp/a85vM+ij3ugTsTfeyafZcDwBJLloIUeVRXiCNolR3/ivxD8le1zlbFfT+9OvPL/4BuCJdfZe0pRWwRb9qhu0JTnPmrCTDY/6xnGdcrnh6Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=souE4j29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49EEC2BCB3;
	Sat, 25 Apr 2026 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140629;
	bh=4UseIi6/4cEexD8PoYw5ApPhHH+2eEMqOMHJSU0aqFU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=souE4j29xsJM1GgWAVqf9q8SvLPYZrgzqOXQOdTymqn7x1J6t4b5ZAbPpzsy3e8Op
	 G2F/V8PFjbYeDqDb8pnDID9ayl99idnpdRZT7Gk5AM0fBF5k+SB66KorlG7jLsfrZd
	 /Wwl1Gh+k7i7Sezv8xxRhvUb7cAhbH/czeZ6umaqKXqqoIk9C2OyKLPqn1JABiWlvN
	 D2WSkdb9Z0prqwfIvvxw2uxP6iPYjkilxehiUC4fFBmT+5E6I3cNOI0acqZdvdR+w+
	 n+tIwJe5G16aJaJuPWoAJYodqG9p0sLbZdWGxUJTOtRt00XkJg9DrkpmfXUxcTjwOs
	 ZsCvIC0R/CGRQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260407095027.2625516-1-johan@kernel.org>
References: <20260407095027.2625516-1-johan@kernel.org>
Subject: Re: [PATCH] clk: rk808: fix OF node reference imbalance
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
To: Johan Hovold <johan@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Date: Sat, 25 Apr 2026 11:10:27 -0700
Message-ID: <177714062701.5403.1177541832751457755@lazor>
User-Agent: alot/0.12
X-Rspamd-Queue-Id: 7D95646738A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241135-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sboyd@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email]

Quoting Johan Hovold (2026-04-07 02:50:27)
> The driver reuses the OF node of the parent multi-function device but
> fails to take another reference to balance the one dropped by the
> platform bus code when unbinding the MFD and deregistering the child
> devices.
>=20
> Fix this by using the intended helper for reusing OF nodes.
>=20
> Fixes: 2dc51ca822e4 ("clk: RK808: Reduce 'struct rk808' usage")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

+Heiko

>  drivers/clk/clk-rk808.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
> index f7412b137e5e..5a75b5c91555 100644
> --- a/drivers/clk/clk-rk808.c
> +++ b/drivers/clk/clk-rk808.c
> @@ -153,7 +153,7 @@ static int rk808_clkout_probe(struct platform_device =
*pdev)
>         struct rk808_clkout *rk808_clkout;
>         int ret;
> =20
> -       dev->of_node =3D pdev->dev.parent->of_node;
> +       device_set_of_node_from_dev(dev, dev->parent);
> =20
>         rk808_clkout =3D devm_kzalloc(dev,
>                                     sizeof(*rk808_clkout), GFP_KERNEL);
> --=20
> 2.52.0
>

