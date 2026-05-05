Return-Path: <stable+bounces-244109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wByaOPrV+WlsEgMAu9opvQ
	(envelope-from <stable+bounces-244109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:35:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4854A4CCBBD
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7E91329147D
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A056E41B361;
	Tue,  5 May 2026 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="K2SVKeSc"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0430216D;
	Tue,  5 May 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979382; cv=none; b=sxEbtYliZpJ57N9SLFvDoU3aUmmnVg1vK4pUBy4na5wJEEVRF7ea2NxLQVH69n20TWMkv0BqLIJm2MDwHwI6vvGE3pEYBR/jeQLBiHxLg8dVPi3LvZVvuHtZixCyZ2mkvF1XiC+S4aXetUmUkVt42ulOsihclZMED98CywymGAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979382; c=relaxed/simple;
	bh=euTUOMCmD0FyWp5ATznm6uqzyFQkIfxhkjn9/Ba8Qw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1lKNF+7hpEerBCnqWUoUEsRm6rau3q6XaxBX8NVolIZnaLTveTqtT8pPkOr7McrVINDiCCHtCuwiqt2/uVW8zztpxKaBVpVjc/Niew5U5fCDkFO4tfvcEMh4McAjcI1EZsSvbAfrnjHnJBdbXhKPpQKq87DVnuF/dzXiotmzsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=K2SVKeSc; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 574F81FD00;
	Tue,  5 May 2026 13:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1777979379;
	bh=3DS+neLfgYJvNoWvrI31OahgxQCII44SXZ6kBTdc/S4=; h=From:To:Subject;
	b=K2SVKeSciQubWujhQ6z+Cya8PHpiiAK77j1jNWAUh4s0cgu1OAB2Gr0zqPHOxMAw9
	 s4OsY759mEmmCGZl+V8YcDQUs7F9gBhNtAIDb4NIDfRS66t7qqLhWYrgD1Wl8r9qRz
	 TR43ZKyhLS6HIey0iK06ep1fFdn3VgHM9q0IVoHloiXgZab613IlMJ+fdtKuCFzGWJ
	 OAYs9udWaXqadc5oKYXYvE0qi6hm+gjF/sA8LgfD3goAMPocaMeL6Sf/jknaS1+YzD
	 XNd/PHmghCYZbQ9kYTae5V4IsXBtCj2TDYUrJbkiGXwEU73PrxpQEodY8J5oYcMM/Z
	 CHLyO70rDJEgA==
Date: Tue, 5 May 2026 13:09:37 +0200
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
Subject: Re: [PATCH 13/13] arm64: dts: ti: k3-j784s4-j742s2-evm-common: fix
 USB clocking for compliance
Message-ID: <20260505110937.GC69476@francesco-nb>
References: <20260505110631.1144200-1-s-vadapalli@ti.com>
 <20260505110631.1144200-14-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505110631.1144200-14-s-vadapalli@ti.com>
X-Rspamd-Queue-Id: 4854A4CCBBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244109-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.3:email,dolcini.it:dkim,ti.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 04:36:14PM +0530, Siddharth Vadapalli wrote:
> According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
> the USB 3.2 Specification, SSC should be enabled by default. This protects
> against EMI violations. Hence, enable internal SSC for USB SuperSpeed.
> 
> Fixes: 39b623c05c46 ("arm64: dts: ti: Refactor J784s4-evm to a common file")
> Fixes: bed97e94ee2d ("arm64: dts: ti: k3-j784s4-evm: Enable USB3 support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
> index ff3a85cbc524..0884773ad230 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
> @@ -1010,12 +1010,18 @@ serdes0_usb_link: phy@3 {
>  		cdns,num-lanes = <1>;
>  		#phy-cells = <0>;
>  		cdns,phy-type = <PHY_TYPE_USB3>;
> +		cdns,ssc-mode = <2>; /* 2 for internal SSC */
>  		resets = <&serdes_wiz0 4>;
>  	};
>  };
>  
>  &serdes_wiz0 {
>  	status = "okay";
> +	ti,core-clk-sel = <1>;  /* Select internal reference clock */
> +	ti,ssc-enable; /* Enable SSC */
> +	ti,ssc-type = <1>; /* 1 for Downspread */
> +	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
> +	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */

before status


