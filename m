Return-Path: <stable+bounces-244107-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ4yLRLV+Wk1EgMAu9opvQ
	(envelope-from <stable+bounces-244107-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:31:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B80F4CCAD0
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D618C318DEA4
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BC5386C39;
	Tue,  5 May 2026 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="r5Gx+ozA"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BBB3822B5;
	Tue,  5 May 2026 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979317; cv=none; b=WqtfM7uVLEgCWsTH9IGWACDqmZGC61fpZGxBJTtSyvIfasGqpbad0e+eE/n2dfHkSCPO8/cPeBFxj1hmtcQISg/ZjuK9yvIK448GKkpOYWzLCiSXJBMS9h0gawCo25hUig3AwZ2ZNP/BEFQ1tbWmm0ytXY0f5MsDDR4RphRHgrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979317; c=relaxed/simple;
	bh=6YltjFb8ryVl8ePz86lgYMUPTTWpCMis9oxbYfoqJSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFEYQo9XNIDlqhefQtvkPbUN3R22MNupjKUiKruLpsfXYe12v8+qdnLUfKgw72WWwuZQJXE3gxTN6YMCp5UkMnCsXi4hRJ8yaY3dJYsQm0K6R7XWlcdV0gAx/vPsHh6EjqTkaL3G61ugUWmVUe3wqocO5HZr066R5XdlJlWgni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=r5Gx+ozA; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 4BA2D1FC1A;
	Tue,  5 May 2026 13:08:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1777979310;
	bh=HbcTkEPCAgd6R4MFZQ+L2NjbJTyupiBIV3wUCIEbFv4=; h=From:To:Subject;
	b=r5Gx+ozA/g/XpULNnrqSG0AN0IiIp2qSeRKjZJvtfERzakuX1fLcenY6HdByg+Qae
	 81OsHgf9EBxhM4jhFFHxzMVEc4/OK5vgouGu8LI0YrEKWw+1diTEka/5S0UwSHYXSw
	 Wl9QlRTbcZDjwlWSX4Bd2Q2go7rRt/q0BkEYvgO2ZWyx9EvCsxjwe+FlhQ6GrByBhY
	 9BNZgVxuy6RtMO0ptleOwatK2nCzHgIoEGpHPiZe8JEFlj5XiNiB77cv1I1PiqkjTj
	 FK/9RKzg8xmSc5qWPeqksTWI+96u6z0QlKZVSU6EB7VP9qecse+aWtiNPDU8ubHkoe
	 JnNeKMj2wTKlA==
Date: Tue, 5 May 2026 13:08:25 +0200
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
Subject: Re: [PATCH 07/13] arm64: dts: ti: k3-am69-aquila: fix USB clocking
 for compliance
Message-ID: <20260505110825.GA69476@francesco-nb>
References: <20260505110631.1144200-1-s-vadapalli@ti.com>
 <20260505110631.1144200-8-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505110631.1144200-8-s-vadapalli@ti.com>
X-Rspamd-Queue-Id: 5B80F4CCAD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244107-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.3:email,dolcini.it:dkim]

Hi Siddharth,

On Tue, May 05, 2026 at 04:36:08PM +0530, Siddharth Vadapalli wrote:
> According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
> the USB 3.2 Specification, SSC should be enabled by default. This protects
> against EMI violations. Hence, enable internal SSC for USB SuperSpeed.
> 
> Fixes: 39ac6623b1d8 ("arm64: dts: ti: Add Aquila AM69 Support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi b/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
> index 5119baf62a4c..7c98ee81ccb5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
> @@ -1423,6 +1423,7 @@ serdes0_usb0_ss_link: phy@3 {
>  		resets = <&serdes_wiz0 4>;
>  		cdns,num-lanes = <1>;
>  		cdns,phy-type = <PHY_TYPE_USB3>;
> +		cdns,ssc-mode = <2>; /* 2 for internal SSC */
>  	};
>  };
>  
> @@ -1502,6 +1503,11 @@ &serdes_ln_ctrl {
>  
>  &serdes_wiz0 {
>  	status = "okay";
> +	ti,core-clk-sel = <1>;  /* Select internal reference clock */
> +	ti,ssc-enable; /* Enable SSC */
> +	ti,ssc-type = <1>; /* 1 for Downspread */
> +	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
> +	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */

These properties must go before status. Please see the coding guideline.

Francesco

