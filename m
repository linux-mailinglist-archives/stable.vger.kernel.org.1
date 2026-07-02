Return-Path: <stable+bounces-271540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Opo4B7SsRmqmbQsAu9opvQ
	(envelope-from <stable+bounces-271540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 20:23:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC576FBFD3
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 20:23:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=NfmR94Ne;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271540-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271540-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 258133028E86
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 18:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E2435677B;
	Thu,  2 Jul 2026 18:23:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C03090C6;
	Thu,  2 Jul 2026 18:23:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016625; cv=none; b=YY8lGlXfR4rPFq3E7ChOs52BL92bwtZsDwm1srHG8ntw757BVDCZrpAXKh0FjjseAF1ctkPDt+KXjbtOZMHKQYvc9s+VxkUY6DFbxdr/8y5GZNTXpInXNBp/jDtOZDZ2e9PVKns2WKysxlGmGM4ffce9nA3SSQhrbvMLlJrmv64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016625; c=relaxed/simple;
	bh=eA8Q+hA17ukWLXB1CNR+Deq0hQsIHwC+H49wxnv3eCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dswlW8F42YTODsVfRwBXcNKsUXwGJzItbptbDrHl/h/QKRHdN9zHs9tbvpQ3j3pX8ST4me3ZQ8uvbOenSA8BygxmwL/wlCu1LtWuu5BBphTNS2TIKziGGlqIyXTLQAhGSw07cT2Vrs8G3vDAiWqdXDhoFVKjnBTXHAMXSwYE4hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=NfmR94Ne; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=HMwrIHSesSwBeH6rt0sJESP8Af/ZauXLbklgi13pmLA=; b=NfmR94NelT+fa24vbw3X4cZSHb
	QvuasTkKBv7nIffde1TU80ZGRZNMujgsv/nuoVr3pIcjqDy7UPTdzPhtTHRVAuRk7JhYoTg9uHII1
	OXSywskLhP2W95jLSdoQhIR2fZTrye+LU2vzfa9Etb5OTfmJFQ6XHFQfu1sZlbRxoktutEE7P9SoB
	ArPm6ocKSke0tRI7ISqWohmMBzfpnbFQkUclzfS5GijvvmpVyKhpm6aoK5HSe/bsdsJEIDkx8WO8d
	ugD7ymSrVdM9xlSDc9/rOOCWLEx468ifdBKwzJAo50QBqnSdERWYx4IwvokZQ4i5enrACjARLo8IU
	wX/8jIZA==;
From: Heiko Stuebner <heiko@sntech.de>
To: oklopfer37@gmail.com, Oren Klopfer <oklopfer37@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org
Subject:
 Re: [PATCH] Revert "arm64: dts: rockchip: Further describe the WiFi for the
 Pinephone Pro"
Date: Thu, 02 Jul 2026 20:23:38 +0200
Message-ID: <6745357.1oUyQt6lIG@phil>
In-Reply-To: <20260615225014.219115-1-oklopfer37@gmail.com>
References: <20260615225014.219115-1-oklopfer37@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271540-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:oklopfer37@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:pbrobinson@gmail.com,m:regressions@leemhuis.info,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com,leemhuis.info];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,phil:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABC576FBFD3

Hi Oren,

Am Dienstag, 16. Juni 2026, 00:50:13 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Oren Klopfer:
> This reverts commit 096bd8c679185f898cae9933c6a68650fa26ea4f.
>=20
> Just as with the Pinebook Pro, there are multiple chipset variants for th=
e Pinephone Pro, and multiple firmware binaries for different distributions=
=2E The change causes issues with some of these combinations, and reverting=
 it resolves the issues. See the Closes below for the full report.
>=20
> Similarly with the Pinebook Pro adjustment, the original commit only indi=
cates "further description" and not indicative of fixing any existing issue=
s, so reverting should not kick any back up.

The commit message did not get any line breaks, 72 character
is the preferred line length.

Also the patch contents itself got mangled.
All the indentation is set as spaces, so that patch won't apply.

Please try using b4 or at least git send-email for sending patches.

Thanks a lot
Heiko


> Fixes: 096bd8c67918 ("arm64: dts: rockchip: Further describe the WiFi for=
 the Pinephone Pro")
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/r/20260607225901.64019-1-oklopfer37@gmail=
=2Ecom/
> Signed-off-by: Oren Klopfer <oklopfer37@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3399-pinephone-pro.dts | 18 ------------------
>  1 file changed, 18 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch=
/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index 8d26bd9b7500..d46cdfe3f784 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -734,12 +734,6 @@ light_int_l: light-int-l {
>          };
>      };
> =20
> -    wifi {
> -        wifi_host_wake_l: wifi-host-wake-l {
> -            rockchip,pins =3D <4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> -        };
> -    };
> -
>      wireless-bluetooth {
>          bt_wake_pin: bt-wake-pin {
>              rockchip,pins =3D <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> @@ -766,19 +760,7 @@ &sdio0 {
>      pinctrl-names =3D "default";
>      pinctrl-0 =3D <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
>      sd-uhs-sdr104;
> -    #address-cells =3D <1>;
> -    #size-cells =3D <0>;
>      status =3D "okay";
> -
> -    brcmf: wifi@1 {
> -        compatible =3D "brcm,bcm4329-fmac";
> -        reg =3D <1>;
> -        interrupt-parent =3D <&gpio4>;
> -        interrupts =3D <RK_PD0 IRQ_TYPE_LEVEL_HIGH>;
> -        interrupt-names =3D "host-wake";
> -        pinctrl-names =3D "default";
> -        pinctrl-0 =3D <&wifi_host_wake_l>;
> -    };
>  };
> =20
>  &pwm0 {
>=20





