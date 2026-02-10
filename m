Return-Path: <stable+bounces-215652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNV9Iswhi2lyQQAAu9opvQ
	(envelope-from <stable+bounces-215652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 13:17:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD611A9CA
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 13:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED3903010636
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 12:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6F232143D;
	Tue, 10 Feb 2026 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="I5e7E/Rv"
X-Original-To: stable@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50F31984E;
	Tue, 10 Feb 2026 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770725832; cv=none; b=O8PW59ahvEzcDpO20WCJSm7YQOz7MkzuL3B21G4krUhzwy+JOxh5865SayHYSpEP9WV0FIEJ7D9W1CVYLPXHnLiPjUEpmxBEjyq5S6iupQtCnPDvH23Qbfm/YxT9q0Heuhmi0G/USYn0Q8Add++iS/zo/6imc698U143vB8pgNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770725832; c=relaxed/simple;
	bh=hW54ichh9oFMv6+QJBB1LR6ogHPIyNEHK655abqVQM0=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=fSj09Vpz9FIbL1gman1PemSCXOL9+rPl4KlRAsdAA3pTg8tC0m72242A/wktmGc2gUEwVAWQrWqQUPQs0KCDAmzEWloLzkLkBTL2UvGbrHOohMu7UIAiwzIEIdher9xg4BN1du1OmYrx9P2OqPLI74MJKmQXrGZErxR/wJREA40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=I5e7E/Rv; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id B549141D4E;
	Tue, 10 Feb 2026 13:17:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1770725822; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Kb0h3q8XigQq/XBwFpeBJIagWOtIH4mIMrOrXJzvCe0=;
	b=I5e7E/RvSurKmra/K5KTcgQ+Lr65xym40iEMwlGI61L+btlMYHr1alKvxBhItyKVX9555d
	yCBScQ1wjObpy+TSa8tUpicj0/KtBIJy4iS6kDkHuN1YriOr+SsRyaMI+Yj0KRsPkSxnEP
	9U7OxrEH5T5Mox2LTQOlNBeK8HevOy26yywGaD4VrDbRwBdvdPSK8K0T7As2GMVXUFes1j
	gKRqgr3Wd372vLCR0t0b05vKYTd7oBQ03pRWB7zmS5p54ZUGWpMd5kHFqYtgYFsgzDu8y/
	BwC9KQEDgpSX0vsybVEDGaknyXqbFsL8VJgGGeRRI0XUU2KWeqYC394nFtEzUA==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <20260210120142.698512-1-heiko@sntech.de>
Content-Type: text/plain; charset="utf-8"
References: <20260210120142.698512-1-heiko@sntech.de>
Date: Tue, 10 Feb 2026 13:17:00 +0100
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, "Jan Palus" <jpalus@fastmail.com>, "Peter Robinson" <pbrobinson@gmail.com>, "Thorsten Leemhuis" <regressions@leemhuis.info>, stable@vger.kernel.org
To: "Heiko Stuebner" <heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <f15b0ead-163b-8101-4856-160476c590b0@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] Revert =?utf-8?q?=22arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= Further describe the WiFi for the Pinebook 
 =?utf-8?q?Pro=22?=
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[manjaro.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[manjaro.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215652-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,fastmail.com,gmail.com,leemhuis.info];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[manjaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsimic@manjaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,leemhuis.info:email,fastmail.com:email]
X-Rspamd-Queue-Id: C6FD611A9CA
X-Rspamd-Action: no action

Hello Heiko,

On Tuesday, February 10, 2026 13:01 CET, Heiko Stuebner <heiko@sntech.d=
e> wrote:
> This reverts commit 6d54d935062e2d4a7d3f779ceb9eeff108d0535d.
>=20
> It seems there are different variants of the Wifi chipset in use on t=
he
> Pinebook Pro. And according to the reported regression - see Closes
> below, the reverted change causes issues with one Wifi chipset.
>=20
> The original commit message indicates a "further description" only an=
d
> does not indicate this would fix an actual problem, so a revert shoul=
d
> not cause further problems.
>=20
> Fixes: 6d54d935062e ("arm64: dts: rockchip: Further describe the WiFi=
 for the Pinebook Pro")
> Cc: Jan Palus <jpalus@fastmail.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/r/aUKOlj-RvTYlrpiS@rock.grzadka/
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../boot/dts/rockchip/rk3399-pinebook-pro.dts  | 18 ----------------=
--
>  1 file changed, 18 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/a=
rch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> index 810ab6ff4e67..7c23971920f0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> @@ -883,12 +883,6 @@ vcc5v0=5Fhost=5Fen=5Fpin: vcc5v0-host-en-pin {
>  		};
>  	};
> =20
> -	wifi {
> -		wifi=5Fhost=5Fwake=5Fl: wifi-host-wake-l {
> -			rockchip,pins =3D <0 RK=5FPA3 RK=5FFUNC=5FGPIO &pcfg=5Fpull=5Fnon=
e>;
> -		};
> -	};
> -
>  	wireless-bluetooth {
>  		bt=5Fwake=5Fpin: bt-wake-pin {
>  			rockchip,pins =3D <2 RK=5FPD3 RK=5FFUNC=5FGPIO &pcfg=5Fpull=5Fnon=
e>;
> @@ -946,19 +940,7 @@ &sdio0 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&sdio0=5Fbus4 &sdio0=5Fcmd &sdio0=5Fclk>;
>  	sd-uhs-sdr104;
> -	#address-cells =3D <1>;
> -	#size-cells =3D <0>;
>  	status =3D "okay";
> -
> -	brcmf: wifi@1 {
> -		compatible =3D "brcm,bcm4329-fmac";
> -		reg =3D <1>;
> -		interrupt-parent =3D <&gpio0>;
> -		interrupts =3D <RK=5FPA3 IRQ=5FTYPE=5FLEVEL=5FHIGH>;
> -		interrupt-names =3D "host-wake";
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&wifi=5Fhost=5Fwake=5Fl>;
> -	};
>  };
> =20
>  &sdhci {

Thanks for this revert!  Until the underlying issues are investigated
further, reverting the troublesome DT changes is pretty much the only
reasonable action, so please feel free to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>


