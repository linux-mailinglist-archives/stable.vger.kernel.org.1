Return-Path: <stable+bounces-244108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFvjBN7S+WlHEQMAu9opvQ
	(envelope-from <stable+bounces-244108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:22:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6470A4CC802
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DE1F3290609
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1F638AC8E;
	Tue,  5 May 2026 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ahuSEwFq"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B383446C4;
	Tue,  5 May 2026 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979368; cv=none; b=WIVgIsdtJvbwgOb5a2a/w6bKD4vojHXCyQzlGj+kX2o0bqE387hdtizyVhfxzykgCoRC+QAmnSpG7+BIWKnqV+q1Gy4M6Tp33wCycwv8Jh4BPTp4fazpMFV/U7PGAf2D2H1L0nOJtQt87Dnx+9I/v050fEXAK9Eg1u68D016v8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979368; c=relaxed/simple;
	bh=4i14OH/AGTZ3Xez8hQqKkmlkTRotJdH0t0791P79zuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvMBnrkRrnooWf5Li61J4qizxZgo5GEKfkm3QgGsEBYF6rbxKfy41wKGkHfl6b1tw6kbtG6ciaZ0v9NeyonlyNtupttxgoAYSVV5ABfttfraWGPUYHtxo8FOu+HW569RqlVpUGT/6940avwB4PqllBzQ1q0JWwaeBcc3QFqsZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ahuSEwFq; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 354AC1FCE7;
	Tue,  5 May 2026 13:09:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1777979365;
	bh=IVJfobToIIbQS+LK3dO6loNuJTGbzehi/g6dvyC5Lo8=; h=From:To:Subject;
	b=ahuSEwFqljaHr1P6lJsEoyZmO0bWCVLmwjY4uM/I1oxqM1w5hl+bm3Kq/pfYrqkf8
	 2wZKUOIGPUMteNwkiITvj+0Vcfqmo0ovLNnReEgh2+8lpQJZ7gxsAPYhAJjMMy51Gx
	 Zoz5CKDpTU+gF8YQdYvt3eF6sC4RoerU41r5zEb/XfDI1b9zuw4fXJ+gkB1tcOWHXY
	 zZThRIdhGwwhYfMY15YVyr85Nrh6MgTUMK7/kHJmm0/XhPa/SuocPCCsk6l3pmmIDQ
	 FMSZn1qJP0BmTP/gVTFfwuw4arUtzilATcAGoa6EJtwWmvFlsqOambbUhgdOO0ZD/0
	 /nzVsil2cGSjA==
Date: Tue, 5 May 2026 13:09:22 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, josua@solid-run.com,
	w.egorov@phytec.de, matthias.schiffer@ew.tq-group.com,
	d.haller@phytec.de, francesco.dolcini@toradex.com,
	joao.goncalves@toradex.com, emanuele.ghidoli@toradex.com,
	ernest.vanhoecke@toradex.com, rogerq@kernel.org,
	eballetb@redhat.com, robertcnelson@gmail.com, afd@ti.com,
	u-kumar1@ti.com, stable@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	luis.parga@ti.com, srk@ti.com
Subject: Re: [PATCH 12/13] arm64: dts: ti: k3-j722s-evm: fix USB clocking for
 compliance
Message-ID: <20260505110922.GB69476@francesco-nb>
References: <20260505110631.1144200-1-s-vadapalli@ti.com>
 <20260505110631.1144200-13-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505110631.1144200-13-s-vadapalli@ti.com>
X-Rspamd-Queue-Id: 6470A4CC802
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244108-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,solid-run.com,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dolcini.it:dkim,ti.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 04:36:13PM +0530, Siddharth Vadapalli wrote:
> From: Luis Parga <luis.parga@ti.com>
> 
> According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
> the USB 3.2 Specification, SSC should be enabled by default. This protects
> against EMI violations. Hence, enable internal SSC for USB SuperSpeed.
> 
> Fixes: 485705df5d5f ("arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Luis Parga <luis.parga@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index e66330c71593..de62b7e135c6 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -746,6 +746,11 @@ &serdes_ln_ctrl {
>  
>  &serdes_wiz0 {
>  	status = "okay";
> +	ti,core-clk-sel = <1>;  /* Select internal reference clock */
> +	ti,ssc-enable; /* Enable SSC */
> +	ti,ssc-type = <1>; /* 1 for Downspread */
> +	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
> +	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */

before status


