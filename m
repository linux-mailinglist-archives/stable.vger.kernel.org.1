Return-Path: <stable+bounces-210711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLq1AcqBcGktYAAAu9opvQ
	(envelope-from <stable+bounces-210711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 08:35:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3414052E07
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 08:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A7FF4076D9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5652EBB8A;
	Wed, 21 Jan 2026 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AisaWf+e"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329C2FB622
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768980927; cv=pass; b=giaLRD6wngpl3JmB2WEVddRim2peiMQC/wYePr5RYGgOqqgFUUl6seVcJPxdIDuhzrlgoq6BnmlBYTV9mv/1z2/s9MxoUhXo7dKcosnRa50aAGoq46bMMGnwB5ZRekasG4l0XU+GtqeoUvrGa+Q/lJGmEqH1otJEPfYIyqUBQdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768980927; c=relaxed/simple;
	bh=SOUjgxYvDdnP4DlvfNWb8byF1MNVm4lzaeeu5MVLYJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Efvzcr5ZzFnAtP0jXtzOvZJt0xfcLx0iGDo27qsJwguHgRgDEufGQYQ7NYmEhx0ymZvj19ObRiEeobiMMdE3NU3gZUX7Ua1lphsT9O3EdImeprR82F+SFrZYKUtj5Bf19N4qfmgYAFE2aKb7BZ5TY82HLJyzWevFigiRWS11SoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AisaWf+e; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c5265d06c3so67216385a.1
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 23:35:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768980924; cv=none;
        d=google.com; s=arc-20240605;
        b=ET9Bsw2Wxn2fEiTl+YB3Yw5FlhEdDLg+tGs6MKRpsHUT4FtjgrdGEg91wTLHxH4Hl3
         MOt9qws9hPbnzdXlm+rN0r2+gMlKpnHBl+Z22aUlN5NTCMP1slKq9t8N3m3VHnYSyYMC
         ukhr6qWtkx1JSTHdfCuRZhZSEFrkSKy7v/OckPr0Pmt94ezNwqZOUKum3oH1+sBedFry
         U5azJ2L2UwaQlU/WJ2mjwxw44l4c3rjQ7hOnOyXNDqv4JTcingaoNWNz7uj4Sf8M/Yxr
         ovFViF5T2OfzIiQQeugvc5/HV9Rif2uznn+T3vDCqGBPeKf2bvXnDHaRZWlUA4OoQnS4
         g3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GlwN8j82SgoVOz7HHzh2bhzIqCg28sVCaQneoE9LKSM=;
        fh=4v0ADcRZzRVapW5cOEvcipT3L46uGC5SPwTjMpYU8Ec=;
        b=X1OoV3BwybsQ3bOVuCtCCAW7D//YRZB0SOX5SHqz4T7+t94vXPxYVPCIRtqCxmAGdp
         a/36+pSXfKsS+X8foy4+zEvNlJTj68Nbstuh1DIIw1ioU3F+5SB1E/tsmjBQRw7WXFd7
         8nXXw4gTjkd45zIC7PHgCeyk5zxGMZt24DUvS7kBY24UZZGISdRPlnM6eZorlUso2jEt
         zaSdeYhbyNvud38zH0R56wvHna+cBD+ydYh9iXgQUQULEvrJZOzrmprlp6krxs5Oz39r
         ZNxvGNjhhXhA1Ve5hCZzlv6nK6BZNhuBozPNby1s9dzSzKPv8vdXZKkrq/XJNCsg2q18
         9WPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768980924; x=1769585724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlwN8j82SgoVOz7HHzh2bhzIqCg28sVCaQneoE9LKSM=;
        b=AisaWf+eKhWHVg7oa91XRb1r3102BDCDmc9BboovfYpZ7QQLQsgjsygBE5+8W6C3Dw
         6Xt54Ulet4SJrwh5GbEJMlY4Hol7jLvfpgpAkhxIpSmaCf2n0Lrf59O8XgkCfRcC/jy/
         OspvrGyP5c/D8sWiKAuHIrPpBNWm9vijYKAyObnmtDI00+4XXSKXx2R1+ABA1GZn2UT4
         GhHoIIypDMrsvxll0jRQlJRMe8Qdj20U9zqq8bi3A4CfdwIdVnhSp7wBPD6R8xpdamYl
         V9kmFn8PQOTHAYWK5+Z/7vVEjwkllMLbLF+4+HG1QnMTREDqYMlNlB4gF9ntlFbpBosE
         cQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768980924; x=1769585724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GlwN8j82SgoVOz7HHzh2bhzIqCg28sVCaQneoE9LKSM=;
        b=M2ZDPtByYrWdtXmy8HmWXK9xH/I9b69IyuLdLhnhNAAcsEhSdb2UWRyw363I3eFLVd
         Xiyk7p3OsISCTLgKnZx7Ml1GewWaSTUpODwFYBkCddChO4095wzM4YIsRRlWn5zYkntn
         MPlcxsTOR5yPGVNANGlX7Q4973cAGlbDc5cbxIZpjxDiqWkfD2HVIo3DUSgUgA4GA33f
         xkCvh6svjmxFHnIPao/z9eFgQRCh/TSODG6OuW2V04LkF/Lc1V/6rmHKGVsBNFIxa2bb
         RuDGweDdo5sFXwzUOZO46u7P9OKy45rxWpvBcwLe72kiGs82Aypu2x+5aamjd4Zsh6q7
         tzPA==
X-Forwarded-Encrypted: i=1; AJvYcCVsuQauvsFHkoDGKDXbdfSupdk1WmKAPYIcGlMzbWXUkXFYR/QRhM3l5Iz9dHDxIume7NUUz1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzArODr5X3XM7TQ4AaQG/Mu00GKnEFB/trFwZ/sF9kBVsNHq2a
	fX0IiGZmkfbB8IZoBA5F08vAJsY/G7oyQC1wEfWwJUqALUMUaXkLAmLX4NqItQwQSHY/0GqFmbx
	urTi4R4wZBdKMN0/3IUzjjNpktvc1iPg=
X-Gm-Gg: AZuq6aIQym+ZF9jLDlxslCYCvUbXdpaDAxT+oMP+vyKjpEvPHDkE2U5gyef1dAmPD8X
	k56pSEMAW9aVHvy/wh8kwHHmorMTeUJWJGfFE7UUqsXOWag72VUH5mTBaOgHV6qaatl+wilb6pF
	ptKU+AH8jPXyxBCcj/9VVRTRqW2nd4U/+Ug8YFLUHTUWcdfUP777rCRpp5xjJhu5fHuoB2pjUJb
	+YW2A6dlnyeQzQRSq1tOgT1Lfbl1ueK7cuBbGFM6rC0d8ADQ1GXh3aJPki+Dj934ZV8dso4RAoD
	kP6cvwN3NR3hbksS22IVq0AvziE=
X-Received: by 2002:a05:620a:199e:b0:8c6:a5ae:e9cc with SMTP id
 af79cd13be357-8c6a5aeeb3dmr2503090885a.14.1768980924177; Tue, 20 Jan 2026
 23:35:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-ufs-rst-v2-1-b5735f1996f6@gmail.com> <176894531223.1201556.243460289333921566.robh@kernel.org>
In-Reply-To: <176894531223.1201556.243460289333921566.robh@kernel.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 21 Jan 2026 11:35:15 +0400
X-Gm-Features: AZwV_Qj7xD-HFnkapRoKPYsoUpofy6BjoS4guSoqEyGq3j-AZNfOskowc3KWMuM
Message-ID: <CABjd4YyPhHCL0TNzKG1_t4bTspfcC0bx41a8t=u+CJo6JvMC0g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Explicitly request UFS reset pin
 on RK3576
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Heiko Stuebner <heiko@sntech.de>, stable@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210711-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[stable,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,cherry.de:email,2a2d0000:email]
X-Rspamd-Queue-Id: 3414052E07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 1:45=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Tue, 20 Jan 2026 16:53:54 +0400, Alexey Charkov wrote:
> > Rockchip RK3576 UFS controller uses a dedicated pin to reset the connec=
ted
> > UFS device, which can operate either in a hardware controlled mode or a=
s a
> > GPIO pin.
> >
> > Power-on default is GPIO mode, but the boot ROM reconfigures it to a
> > hardware controlled mode if it uses UFS to load the next boot stage.
> >
> > Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
> > device reset, request the required pin config explicitly.
> >
> > This doesn't appear to affect Linux, but it does affect U-boot:
> >
> > Before:
> > =3D> md.l 0x2604b398
> > 2604b398: 00000011 00000000 00000000 00000000  ................
> > < ... snip ... >
> > =3D> ufs init
> > ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=3D[3, 3], lane[2, 2], pw=
r[FASTAUTO_MODE, FASTAUTO_MODE], rate =3D 2
> > =3D> md.l 0x2604b398
> > 2604b398: 00000011 00000000 00000000 00000000  ................
> >
> > After:
> > =3D> md.l 0x2604b398
> > 2604b398: 00000011 00000000 00000000 00000000  ................
> > < ... snip ...>
> > =3D> ufs init
> > ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=3D[3, 3], lane[2, 2], pw=
r[FASTAUTO_MODE, FASTAUTO_MODE], rate =3D 2
> > =3D> md.l 0x2604b398
> > 2604b398: 00000010 00000000 00000000 00000000  ................
> >
> > (0x2604b398 is the respective pin mux register, with its BIT0 driving t=
he
> > mode of UFS_RST: unset =3D GPIO, set =3D hardware controlled UFS_RST)
> >
> > This helps ensure that GPIO-driven device reset actually fires when the
> > system requests it, not when whatever black box magic inside the UFSHC
> > decides to reset the flash chip.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c75e5e010fef ("scsi: arm64: dts: rockchip: Add UFS support for R=
K3576 SoC")
> > Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> > This has originally surfaced during the review of UFS patches for U-boo=
t
> > at [1], where it was found that the UFS reset line is not requested to =
be
> > configured as GPIO but used as such. This leads in some cases to the UF=
S
> > driver appearing to control device resets, while in fact it is the
> > internal controller logic that drives the reset line (perhaps in
> > unexpected ways).
> >
> > Thanks Quentin Schulz for spotting this issue.
> >
> > [1] https://lore.kernel.org/u-boot/259fc358-f72b-4a24-9a71-ad90f2081335=
@cherry.de/
> > ---
> > Changes in v2:
> > - Change default pin pull to pull-down in line with the SoC power-on de=
fault
> > - Link to v1: https://lore.kernel.org/r/20260119-ufs-rst-v1-1-c8e964939=
48c@gmail.com
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi | 7 +++++++
> >  arch/arm64/boot/dts/rockchip/rk3576.dtsi         | 2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>   pip3 install dtschema --upgrade
>
>
> This patch series was applied (using b4) to base:
>  Base: 46fe65a2c28ecf5df1a7475aba1f08ccf4c0ac1b (use --merge-base to over=
ride)
>
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
>
>
> New warnings running 'make CHECK_DTBS=3Dy for arch/arm64/boot/dts/rockchi=
p/' for 20260120-ufs-rst-v2-1-b5735f1996f6@gmail.com:
>
> arch/arm64/boot/dts/rockchip/rk3576-luckfox-omni3576.dtb: ufs: ufs-rst-gp=
io: {'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 113} is not of type 'arr=
ay'
>         from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer=
.yaml
> arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dtb: ufs: ufs-rst-g=
pio: {'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 130} is not of type 'ar=
ray'
>         from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer=
.yaml
> arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dtb: ufs: ufs-rst-gpio: {=
'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 116} is not of type 'array'
>         from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer=
.yaml
> arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dtb: ufs: ufs-rst-gpio: {'rock=
chip,pins': [[4, 24, 0, 29]], 'phandle': 117} is not of type 'array'
>         from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer=
.yaml
> arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dtb: ufs: ufs-rst-gpio: {'r=
ockchip,pins': [[4, 24, 0, 29]], 'phandle': 133} is not of type 'array'
>         from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer=
.yaml
> arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dtb: ufs: ufs-rst-gpio: {'roc=
kchip,pins': [[4, 24, 0, 29]], 'phandle': 122} is not of type 'array'
>         from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer=
.yaml
> arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dtb: ufs: ufs-rst-gpio: {'ro=
ckchip,pins': [[4, 24, 0, 29]], 'phandle': 134} is not of type 'array'
>         from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer=
.yaml
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: ufs: ufs-rst-gpio: =
{'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 130} is not of type 'array'
>         from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer=
.yaml
> arch/arm64/boot/dts/rockchip/rk3576-evb1-v10-pcie1.dtb: ufs: ufs-rst-gpio=
: {'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 134} is not of type 'array=
'
>         from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer=
.yaml
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5-v1.2-wifibt.dtb: ufs: uf=
s-rst-gpio: {'rockchip,pins': [[4, 24, 0, 29]], 'phandle': 130} is not of t=
ype 'array'
>         from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer=
.yaml

Thank you bot. This wildcard for *-gpio is driving me crazy. And yes,
looks like I forgot to test against the schema - sorry for that. Will
resend a slightly adjusted version shortly
(s/ufs-rst-gpio/ufs-rstgpio/ to avoid incorrectly matching against the
GPIO schema)

Best regards,
Alexey

