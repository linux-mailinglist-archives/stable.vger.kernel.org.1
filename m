Return-Path: <stable+bounces-210609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDO2JnX9b2mUUgAAu9opvQ
	(envelope-from <stable+bounces-210609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 23:11:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B14384CC92
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 23:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A605C92D05D
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95963D3CF6;
	Tue, 20 Jan 2026 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOWXQOxH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562963D3CEB;
	Tue, 20 Jan 2026 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945523; cv=none; b=RAxF9l730RfNs6SQUuQWufNcJGA64sFgujLia6MXNgT2ejh7OfPdQJ4E/Gkr3nffwwLx1IZbmK1pl+XmAIRIAwKLzM2HAirqNofGGpy5m/JRJUkk/3xf/OLJbqRdv3Py4dGVWk7OkdkzMm15IJsYFZovImdHAZQD0Pcw/+6BI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945523; c=relaxed/simple;
	bh=iGmQTrcxjtgfmMDdD54wE5OCeQ2v++Q+BpE3G+cHjVo=;
	h=From:Date:Content-Type:MIME-Version:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=P/WwQeXncEnvycZ+sEVfPtNR59z3XpHb5XpzeEHiBPPqlQe0wBXcSEfDqZAHnkuOHn+xsJpcu2GrQ37l8I7zrmdqT9Xboy+akQKa+4BY5EENYkG/5jChMn9xX6kvr/bUolQJGWOOyaOT2OP1DMMMgHhYpTkndz3a6EdQbiJdhBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOWXQOxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806E8C16AAE;
	Tue, 20 Jan 2026 21:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768945521;
	bh=iGmQTrcxjtgfmMDdD54wE5OCeQ2v++Q+BpE3G+cHjVo=;
	h=From:Date:Cc:To:In-Reply-To:References:Subject:From;
	b=rOWXQOxHQszpyhaIrGB3VjPh14nhOZrx73IUhV7HSwSXqaI0Eh/kaSt/S8v+wtEzY
	 pJV5DZpDpV2ekat1rC3GcyHWhK7OjurBKMMqaUuk1dmFJIrBy1tYbaU5a8rcq+b0Gk
	 hQ92Fhi8lf6SbSSpnyTZZYuy2LYGmQLkbsSgPcDbO4Cby4B/x4uJU7xkwYhNuObMDl
	 YTwJ8rUtwsEMM1xJoLC8a0RUJqlDvSbHwAdA47XUS6AlYSIUdlQPCQlShBzOBpTKnc
	 WTAR7f9EefWdSztnrYPEOE13ZLC6s+yk9fW/5dOZt3KZE9XNMLlr9zPSV7TBlgFJFC
	 XG+dbVBrKnIrg==
From: Rob Herring <robh@kernel.org>
Date: Tue, 20 Jan 2026 15:45:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Heiko Stuebner <heiko@sntech.de>, stable@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, linux-rockchip@lists.infradead.org
To: Alexey Charkov <alchark@gmail.com>
In-Reply-To: <20260120-ufs-rst-v2-1-b5735f1996f6@gmail.com>
References: <20260120-ufs-rst-v2-1-b5735f1996f6@gmail.com>
Message-Id: <176894531223.1201556.243460289333921566.robh@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Explicitly request UFS reset
 pin on RK3576
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210609-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B14384CC92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 20 Jan 2026 16:53:54 +0400, Alexey Charkov wrote:
> Rockchip RK3576 UFS controller uses a dedicated pin to reset the connected
> UFS device, which can operate either in a hardware controlled mode or as a
> GPIO pin.
> 
> Power-on default is GPIO mode, but the boot ROM reconfigures it to a
> hardware controlled mode if it uses UFS to load the next boot stage.
> 
> Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
> device reset, request the required pin config explicitly.
> 
> This doesn't appear to affect Linux, but it does affect U-boot:
> 
> Before:
> => md.l 0x2604b398
> 2604b398: 00000011 00000000 00000000 00000000  ................
> < ... snip ... >
> => ufs init
> ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
> => md.l 0x2604b398
> 2604b398: 00000011 00000000 00000000 00000000  ................
> 
> After:
> => md.l 0x2604b398
> 2604b398: 00000011 00000000 00000000 00000000  ................
> < ... snip ...>
> => ufs init
> ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
> => md.l 0x2604b398
> 2604b398: 00000010 00000000 00000000 00000000  ................
> 
> (0x2604b398 is the respective pin mux register, with its BIT0 driving the
> mode of UFS_RST: unset = GPIO, set = hardware controlled UFS_RST)
> 
> This helps ensure that GPIO-driven device reset actually fires when the
> system requests it, not when whatever black box magic inside the UFSHC
> decides to reset the flash chip.
> 
> Cc: stable@vger.kernel.org
> Fixes: c75e5e010fef ("scsi: arm64: dts: rockchip: Add UFS support for RK3576 SoC")
> Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> This has originally surfaced during the review of UFS patches for U-boot
> at [1], where it was found that the UFS reset line is not requested to be
> configured as GPIO but used as such. This leads in some cases to the UFS
> driver appearing to control device resets, while in fact it is the
> internal controller logic that drives the reset line (perhaps in
> unexpected ways).
> 
> Thanks Quentin Schulz for spotting this issue.
> 
> [1] https://lore.kernel.org/u-boot/259fc358-f72b-4a24-9a71-ad90f2081335@cherry.de/
> ---
> Changes in v2:
> - Change default pin pull to pull-down in line with the SoC power-on default
> - Link to v1: https://lore.kernel.org/r/20260119-ufs-rst-v1-1-c8e96493948c@gmail.com
> ---
>  arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi | 7 +++++++
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi         | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: 46fe65a2c28ecf5df1a7475aba1f08ccf4c0ac1b (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20260120-ufs-rst-v2-1-b5735f1996f6@gmail.com:

arch/arm64/boot/dts/rockchip/rk3576-luckfox-omni3576.dtb: ufs: ufs-rst-gpio: {'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 113} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml
arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dtb: ufs: ufs-rst-gpio: {'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 130} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml
arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dtb: ufs: ufs-rst-gpio: {'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 116} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml
arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dtb: ufs: ufs-rst-gpio: {'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 117} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml
arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dtb: ufs: ufs-rst-gpio: {'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 133} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml
arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dtb: ufs: ufs-rst-gpio: {'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 122} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml
arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dtb: ufs: ufs-rst-gpio: {'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 134} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: ufs: ufs-rst-gpio: {'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 130} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml
arch/arm64/boot/dts/rockchip/rk3576-evb1-v10-pcie1.dtb: ufs: ufs-rst-gpio: {'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 134} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5-v1.2-wifibt.dtb: ufs: ufs-rst-gpio: {'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 130} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml






