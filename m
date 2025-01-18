Return-Path: <stable+bounces-109453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB96A15E11
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 17:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414391662AB
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA03190676;
	Sat, 18 Jan 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="KEAUK8Ir";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="aYwLtQyG"
X-Original-To: stable@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DEC15CD78;
	Sat, 18 Jan 2025 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737217992; cv=pass; b=faoUO/0Zu3Y/Oz5VRUS04CeT5/4dKVyLcACQp1vReylDbZ1h+F8gp7B4xX+d+EcXenVm8dDfiqqXCuyPxzfSb0kToZilJCBSdw93pOjzvgbvprepP1+rtvI5yfhsLjCJCyQ/q4NmvWp35mPB6D/dV/Sk/UQ318wtmr7vMbPnmwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737217992; c=relaxed/simple;
	bh=uFsfTpxGEn1lVhnjt1CAR4ichEAp+mIw7RnDnlMCtBE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Pp14Qc690dTrEkXQ2omTIosPIz+ZgpBuq8jYXkELM+RoloBzQaCdtXfe/OQJy0Tmf86TTvnraD+poDGy9YkSBKbLNMlE2D4MPQgmXdQwFUvWVjkaO8Y84LRv5T+wdl+K3d8MyOSpQSModqPX7jC6sXbP9t3jA0upfT9BqcoJM8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=KEAUK8Ir; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=aYwLtQyG; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1737217623; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NY4AIQ/wtNjraEUDag5uwJ2U/6R3D8psZ85/PGRDgff86rwFeQKrg+OdZ0dQZ27Lyu
    2Va/Uz1Kfi5igGOXBQ9mxi/VGf8+lKplR1UCQgE7QfLh/sqxaz+4Cz+89OnC6GLss2Mx
    nh8ZZtNdpdbFsqaRnRSElFfTXZ8G1ISNcrAl2KdRr7T7Ju6ZTYt/R3lWcJQNSVgm8Bib
    qeqzq6rx/dlM65kXm+/iqZZD5JUrzFQmrI715sjH+ytYirEn0ZPnCJetWk4MZA8EfNhQ
    tKpfcClYjX4w8CadMQs7Ws5pkNm/uIuvYxueVjQqGQbIGv8+BZR3Jfgagjy190RHl1pc
    zTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1737217623;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=dQEpm5ns2TQ7rlS0g7Ym5uTTHeLyx+ADIRrl+6ESxGE=;
    b=KY+Dbs2IFR1IYgeU8EO9BJ1fKfXzjnpGnoHvzzbI6h7KKtHD5Yww1rIKF4ME2HiBUp
    mn+12Naj0JQjJKGM0nGTK+1OrXPeAGZ9OqXARwTpQRPZSbejS8614Fa66LmkKWQDvD7A
    0Fk1pUGJNAXMKbd1EnXfyTkCAURgYNxYkv33PxnwONgLphssLllkKBTPRfFVsmevzSCt
    B2W6sp66S5PewTLnvXNnhHs66UV/P0ahy4wPkIAFECqsJUu+zAnSAGMu/DsFTexGR4Ds
    /8UDiZS81Dz7ogD3+3+mqh3QeorBobk1TWsSFzVRq7R/7gZ31hbqwwN48qym8IBqv/wo
    whYw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1737217623;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=dQEpm5ns2TQ7rlS0g7Ym5uTTHeLyx+ADIRrl+6ESxGE=;
    b=KEAUK8IrBfCLFV08QsiCGyNjn3bd1vvUsI2tjIHr4TFJ6GCPaSmKNKu+gNLGo+zLbx
    37hmyCDKcyDSSm8VYJZGFCLobLZH6TC/4rfnpzbccuxL5SBBLd5l9rGHFg69t7UwfzMR
    xOD7vLXcusZSiu2b7emTHS7CrSC5F1hv9BR3S5ty92FUo9lAroMp9yONHhsYLDq5ViC4
    uVkWumsRHB/HGAtyzl9TnA0n8suk5WQGXomlpctqsGrI7K44+5p6Nl/ylPRLMdALcMYt
    tCU8xye2jizw+gRglrHRC6RTp8d2/r9JYN2ptvHen4pAQq4TAjl2aaOF4OFAYzkkvCMK
    vZ+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1737217623;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=dQEpm5ns2TQ7rlS0g7Ym5uTTHeLyx+ADIRrl+6ESxGE=;
    b=aYwLtQyGE3O9yyVzSTd8Cu2BZgyf5zf5v3x8ase8KFUTIQKWGLQYf/VND3Dny/oOLE
    iq6DvpILPNcrAwq0ApCw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeTwZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 51.2.21 DYNA|AUTH)
    with ESMTPSA id Qeb5b110IGR3RLU
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sat, 18 Jan 2025 17:27:03 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [Letux-kernel] [PATCH] Revert v6.2-rc1 and later "ARM: dts:
 bcm2835-rpi: Use firmware clocks for display"
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <2025011803-tactical-strangle-f6a5@gregkh>
Date: Sat, 18 Jan 2025 17:26:52 +0100
Cc: devicetree <devicetree@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>,
 Ray Jui <rjui@broadcom.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 arm-soc <linux-arm-kernel@lists.infradead.org>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: 7bit
Message-Id: <756F508D-8728-4D1B-B8E7-7D15312FED28@goldelico.com>
References: <7ba92b281cea785358551c8de99845c6345a2391.1737214993.git.hns@goldelico.com>
 <2025011803-tactical-strangle-f6a5@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

Hi Greg,

> Am 18.01.2025 um 17:04 schrieb Greg KH <gregkh@linuxfoundation.org>:
> 
> On Sat, Jan 18, 2025 at 04:43:14PM +0100, H. Nikolaus Schaller wrote:
>> This reverts commit d02f02c28f5561cf5b2345f8b4c910bd98d18553.

Sorry for the noise. It was reverted from a locally rebased but
otherwise identical copy of

commit 27ab05e1b7e5c5ec9b4f658e1b2464c0908298a6

> 
> I don't see this git id anywhere in Linus's tree, where did it come
> from?  It's also not in linux-next.

I'll send a v2 patch with corrected references.

BR and thanks,
Nikolaus

