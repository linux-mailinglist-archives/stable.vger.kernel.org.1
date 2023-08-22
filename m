Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AE6783C73
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 11:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjHVJFH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 05:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjHVJFG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 05:05:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE2BCE
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 02:05:03 -0700 (PDT)
Received: from [IPv6:2a00:23c8:b70a:ae01:f948:d864:621d:4c96] (unknown [IPv6:2a00:23c8:b70a:ae01:f948:d864:621d:4c96])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 48033660723E;
        Tue, 22 Aug 2023 10:05:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692695102;
        bh=3bJQrDmqmXC8YyqK341ofGRp+uMO8KhwC8wGTc0wclE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UYVP/Jm6sM7fR8HtN+NXJ4H7O91if9WculPUkFaqwK5P0FggMboxoDTKfWJAsuKNK
         1e62bodp79mlmosAB44tdw7s2m7GoHxuIva1aZ/Uufch6hsUlwDOwyzSs1p6XRC7TS
         /AjT32CYYeesvhJ8HT8lwxKKQG73eqa9jFSENiSnMVKWngT6JJJwztCwA+k5rbnDQd
         33kml1fOMEgDoEf/ys9MddDYwhcuKk75kmYLzniC8gBolXnHGpdnXJ8JxrnKmva80b
         6mDVzvAiCDn39Zx8yg5qoGulSMLFx9yjQ55hQu6CsnCjW/YIuUvNaSp0PKmLTA3VaO
         nvuSVMISeb3MQ==
Message-ID: <69bffdd6106795aae9d2278c90281e952302fe86.camel@collabora.com>
Subject: Re: FAILED: patch "[PATCH] arm64: dts: rockchip: Disable HS400 for
 eMMC on ROCK Pi 4" failed to apply to 5.4-stable tree
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     gregkh@linuxfoundation.org, dev@folker-schwesinger.de,
        heiko@sntech.de
Cc:     stable@vger.kernel.org
Date:   Tue, 22 Aug 2023 10:04:44 +0100
In-Reply-To: <2023082156-capped-subtext-c4e2@gregkh>
References: <2023082156-capped-subtext-c4e2@gregkh>
Autocrypt: addr=chris.obbard@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.49.2-3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

For reference, I don't think it's worth carrying this patch to 5.4-stable.
@Heiko, please correct me if you think I am wrong.

On Mon, 2023-08-21 at 19:09 +0200, gregkh@linuxfoundation.org wrote:
>=20
> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/=C2=A0linux-5.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x cee572756aa2cb46e959e9797ad4b730b78a050b
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082156-=
capped-subtext-c4e2@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..
>=20
> Possible dependencies:
>=20
> cee572756aa2 ("arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4"=
)
> 06c5b5690a57 ("arm64: dts: rockchip: sort nodes/properties on rk3399-rock=
-4")
> 69448624b770 ("arm64: dts: rockchip: fix regulator name on rk3399-rock-4"=
)
> 8240e87f16d1 ("arm64: dts: rockchip: fix audio-supply for Rock Pi 4")
> 697dd494cb1c ("arm64: dts: rockchip: add SPDIF node for ROCK Pi 4")
> 65bd2b8bdb3b ("arm64: dts: rockchip: add ES8316 codec for ROCK Pi 4")
> 328c6112787b ("arm64: dts: rockchip: fix supplies on rk3399-rock-pi-4")
> b5edb0467370 ("arm64: dts: rockchip: Mark rock-pi-4 as rock-pi-4a dts")
> 2bc65fef4fe4 ("arm64: dts: rockchip: rename label and nodename pinctrl su=
bnodes that end with gpio")
> 7a87adbc4afe ("arm64: dts: rockchip: enable DC charger detection pullup o=
n Pinebook Pro")
> 40df91a894e9 ("arm64: dts: rockchip: fix inverted headphone detection on =
Pinebook Pro")
> 5a65505a6988 ("arm64: dts: rockchip: Add initial support for Pinebook Pro=
")
> c2753d15d2b3 ("arm64: dts: rockchip: split rk3399-rockpro64 for v2 and v2=
.1 boards")
> cfd66c682e8b ("arm64: dts: rockchip: Add regulators for PCIe for Radxa Ro=
ck Pi 4 board")
> 023115cdea26 ("arm64: dts: rockchip: add thermal infrastructure to px30")
> 526ba2e2cf61 ("arm64: dts: rockchip: Enable PCIe for Radxa Rock Pi 4 boar=
d")
> eb275167d186 ("Merge tag 'armsoc-dt' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/soc/soc")
>=20
> thanks,
>=20
> greg k-h
>=20
> ------------------ original commit in Linus's tree ------------------
>=20
> From cee572756aa2cb46e959e9797ad4b730b78a050b Mon Sep 17 00:00:00 2001
> From: Christopher Obbard <chris.obbard@collabora.com>
> Date: Wed, 5 Jul 2023 15:42:54 +0100
> Subject: [PATCH] arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi =
4
>=20
> There is some instablity with some eMMC modules on ROCK Pi 4 SBCs running
> in HS400 mode. This ends up resulting in some block errors after a while
> or after a "heavy" operation utilising the eMMC (e.g. resizing a
> filesystem). An example of these errors is as follows:
>=20
> =C2=A0=C2=A0=C2=A0 [=C2=A0 289.171014] mmc1: running CQE recovery
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.048972] mmc1: running CQE recovery
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.054834] mmc1: running CQE recovery
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.060817] mmc1: running CQE recovery
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.061337] blk_update_request: I/O error, dev=
 mmcblk1, sector 1411072 op 0x1:(WRITE) flags 0x800 phys_seg 36 prio class =
0
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.061370] EXT4-fs warning (device mmcblk1p1)=
: ext4_end_bio:348: I/O error 10 writing to inode 29547 starting block 1764=
66)
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.061484] Buffer I/O error on device mmcblk1=
p1, logical block 172288
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.061531] Buffer I/O error on device mmcblk1=
p1, logical block 172289
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.061551] Buffer I/O error on device mmcblk1=
p1, logical block 172290
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.061574] Buffer I/O error on device mmcblk1=
p1, logical block 172291
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.061592] Buffer I/O error on device mmcblk1=
p1, logical block 172292
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.061615] Buffer I/O error on device mmcblk1=
p1, logical block 172293
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.061632] Buffer I/O error on device mmcblk1=
p1, logical block 172294
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.061654] Buffer I/O error on device mmcblk1=
p1, logical block 172295
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.061673] Buffer I/O error on device mmcblk1=
p1, logical block 172296
> =C2=A0=C2=A0=C2=A0 [=C2=A0 290.061695] Buffer I/O error on device mmcblk1=
p1, logical block 172297
>=20
> Disabling the Command Queue seems to stop the CQE recovery from running,
> but doesn't seem to improve the I/O errors. Until this can be investigate=
d
> further, disable HS400 mode on the ROCK Pi 4 SBCs to at least stop I/O
> errors from occurring.
>=20
> While we are here, set the eMMC maximum clock frequency to 1.5MHz to
> follow the ROCK 4C+.
>=20
> Fixes: 1b5715c602fd ("arm64: dts: rockchip: add ROCK Pi 4 DTS support")
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> Tested-By: Folker Schwesinger <dev@folker-schwesinger.de>
> Link: https://lore.kernel.org/r/20230705144255.115299-2-chris.obbard@coll=
abora.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> index 907071d4fe80..95efee311ece 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> @@ -645,9 +645,9 @@ &saradc {
> =C2=A0};
> =C2=A0
> =C2=A0&sdhci {
> +	max-frequency =3D <150000000>;
> =C2=A0	bus-width =3D <8>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> +	mmc-hs200-1_8v;
> =C2=A0	non-removable;
> =C2=A0	status =3D "okay";
> =C2=A0};
>=20
