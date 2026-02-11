Return-Path: <stable+bounces-215790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id w0RmCgVsjGlmngAAu9opvQ
	(envelope-from <stable+bounces-215790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:46:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCF1123F15
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C09653010BB0
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB88281525;
	Wed, 11 Feb 2026 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="D6P9gLkf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u1YJ5Wap"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E28460;
	Wed, 11 Feb 2026 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810367; cv=none; b=XBBcCHIM3cTo8f4BvA6TlRQaXG2aOhZpb95ylqkc3A1VA40zNtkQWgfB6b1dyeRdfdsxf3G9mIa3zrGAsufUdhqdFIptPIyl3ijkNw7KMDcEucUuPVbKf/sPn//s1zc4PXfPJU3Ic2SQAoKjuvOVWhxEs3ILI2sHbzoViLkBa/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810367; c=relaxed/simple;
	bh=UMyxJV4svHC9C+Q/U8kxDvWW1hGYe8YJ+LZPzQW1Dn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijxlS/dCoCtDCcGa2l0kED1nIVtitW/RnbWuNJmCgjv+GVdC0sJKBJ3wCr/xn7f2/FMOHKpaVBAwP2TzY99vFUUZaloaxLBqy4iinSW5DCCIswZIBTuiuob4MDmcMG4ntfCZd/xXE1ddGY7npixKjAkhYJHXis6smpU5Q8N48VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=D6P9gLkf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u1YJ5Wap; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 21BD41D00183;
	Wed, 11 Feb 2026 06:46:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 11 Feb 2026 06:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770810363; x=1770896763; bh=ukbEN640sL
	CWjepQ3oOy/19KEzPFUeSNtmy3J6LTRuw=; b=D6P9gLkfxYzKfsUf0CAG8VmOmc
	eJbuwBPDfvJYEDMb2oulNIqbvtpsrgFFuHJ4tOfjjecFZGZ5mLbn6TBLYgV/6Sjv
	skPR67hPYHcWxpgA7VD+1o1GkWLv9GFPl2wdK24aQM6iT/87Wo7X9Xj///a6ilMH
	/6vbIRJlMOwyD8R5YRWVl8UrEp6gZMBYAYv5SHpBLm3ES210Hhv7kurNtwbW6SVW
	wmX+5N39X+0Yr4VgIUd93pZpfvCwqHNG3jsk+jviHLzlf/9Dv3mtulWr2Qd6c+V6
	wv8PgDJLaxgJKxcpWnWlrk7oWdamcch8NTV/oO/l0TAKCkXLOv+v6GbJAqtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770810363; x=1770896763; bh=ukbEN640sLCWjepQ3oOy/19KEzPFUeSNtmy
	3J6LTRuw=; b=u1YJ5WapTnOO51LbuXW87gB9hcscNuECThY7V6wxz90dm115w7c
	K7cYdhXPPy9vJGVPvZRt84jkpeR8kfnyjERL7YQxRyk8veqImnEVJ0MFkzrms8e4
	Kr4/bzXZIzG5CHId/McTed7M8gyjqid5M6L/4adY9F/m+O7gba2CLnB/L+etMiL/
	96d02g4THzrHOl/mSRH2mRvbgvOMCaFje/0t4KmE9MBcvDNK5o19TcoQJszcDmW9
	oS+/qZEbDg9DRQirz+CPrQZfWCkJjXtr1kX8tAr5Ti3c4Oz695oLjwMkHKZkIdMN
	SGMAItjkFgMhmC7n6JE3QWjG0kMUJWn9Xcw==
X-ME-Sender: <xms:-2uMaVBCbfr859cGEbq5QpG7w_o81C00UlHrFHns-aDa7_Y4aeU-CQ>
    <xme:-2uMaSkXQtqXsj36Y7Kk5Dr_7dWnVUlIF13FaOWYChiX4W9WU990fZni76g6o5ep-
    89sUhxhJDv656qa1o6RU3zUlSefJWQQoLdAHWH03KCSxoUMLiQuHWc>
X-ME-Received: <xmr:-2uMaWxwS8pLkK2QTg-yaSmu99IAdBF6VRf2r5Xj3rlnmYSVMVZ34YF8bIxnlvHpF98GHcaVFdI-sU2p3N-y7z6b7ijKT5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujggfsehttdortddtreejnecuhfhrohhmpeflrghnucfr
    rghluhhsuceojhhprghluhhssehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepvefgtdejgfeugefgffethedvueeigfegteduffeftdeihfduuefgieelteekheeg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjphgrlhhushesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhvg
    hikhhosehsnhhtvggthhdruggvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhn
    vghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqrhhotghktghhihhpsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgsrhhosghinhhsohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgvghhr
    vghsshhiohhnsheslhgvvghmhhhuihhsrdhinhhfohdprhgtphhtthhopehsthgrsghlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-2uMacQDmam6Ndluo90DoSSA864FB_o7xtOYntFtqf0478uILqnJ7A>
    <xmx:-2uMae9Ad0hpCRjGR50u68RSJo8aR50evKXYSrIMLK6rbTHJXIcwJw>
    <xmx:-2uMaatdKf6p6Cy-_xx49pF4AkcKypYFnHsTXozPWg7lht9t7SvK1Q>
    <xmx:-2uMaWPUK4iBXdUci29oRFj4fciIDYs-kLRBr_JDKASAnGUmAAdZDQ>
    <xmx:-2uMaUsoCZr9j0XuJpu1tJMAcY6fId3JDlqUQWUbeVEP8CzFyi-Z0N7R>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 06:46:02 -0500 (EST)
Date: Wed, 11 Feb 2026 12:46:01 +0100
From: Jan Palus <jpalus@fastmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peter Robinson <pbrobinson@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: dts: rockchip: Further describe the WiFi
 for the Pinebook Pro"
Message-ID: <aYxrhXSLHcAHavAd@rock.grzadka>
References: <20260210120142.698512-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260210120142.698512-1-heiko@sntech.de>
User-Agent: NeoMutt/20251211
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[fastmail.com:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com,leemhuis.info];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215790-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jpalus@fastmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sntech.de:email,messagingengine.com:dkim,leemhuis.info:email,rock.grzadka:mid]
X-Rspamd-Queue-Id: 5BCF1123F15
X-Rspamd-Action: no action

On 10.02.2026 13:01, Heiko Stuebner wrote:
> This reverts commit 6d54d935062e2d4a7d3f779ceb9eeff108d0535d.
> 
> It seems there are different variants of the Wifi chipset in use on the
> Pinebook Pro. And according to the reported regression - see Closes
> below, the reverted change causes issues with one Wifi chipset.
> 
> The original commit message indicates a "further description" only and
> does not indicate this would fix an actual problem, so a revert should
> not cause further problems.
> 
> Fixes: 6d54d935062e ("arm64: dts: rockchip: Further describe the WiFi for the Pinebook Pro")
> Cc: Jan Palus <jpalus@fastmail.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/r/aUKOlj-RvTYlrpiS@rock.grzadka/
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../boot/dts/rockchip/rk3399-pinebook-pro.dts  | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> index 810ab6ff4e67..7c23971920f0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> @@ -883,12 +883,6 @@ vcc5v0_host_en_pin: vcc5v0-host-en-pin {
>  		};
>  	};
>  
> -	wifi {
> -		wifi_host_wake_l: wifi-host-wake-l {
> -			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
>  	wireless-bluetooth {
>  		bt_wake_pin: bt-wake-pin {
>  			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> @@ -946,19 +940,7 @@ &sdio0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
>  	sd-uhs-sdr104;
> -	#address-cells = <1>;
> -	#size-cells = <0>;
>  	status = "okay";
> -
> -	brcmf: wifi@1 {
> -		compatible = "brcm,bcm4329-fmac";
> -		reg = <1>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "host-wake";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_host_wake_l>;
> -	};
>  };
>  
>  &sdhci {

Although it's pretty much obvious feel free to include:

Tested-by: Jan Palus <jpalus@fastmail.com>

