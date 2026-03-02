Return-Path: <stable+bounces-222625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLpcDparpWmpDgAAu9opvQ
	(envelope-from <stable+bounces-222625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 16:24:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC63B1DBC1D
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 16:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95521301C554
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE83240F8E6;
	Mon,  2 Mar 2026 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sp1XOY7M"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D6C38F62E;
	Mon,  2 Mar 2026 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464922; cv=none; b=qfyCqv/xQQDJ0PXpfcR8r2y4l7CXMWs5nbYzqjj18pEVhu0MwExawMv5dzfDUV80mMD8sRc0r/vtOBEBldc5Hz4T6i33mLQ44ZeE8uHuAEPBB4w6fBvoFzskMmv1RdeBqGxPo0Wog24DuIWtyNpmNj/W3nW/EcS6creLA2CHstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464922; c=relaxed/simple;
	bh=thvntZTQipQ90OEnlP5d4+3JWJJD2y/hGnLtVDAEoFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ii+hi5Ldjj5rFUWa1t+W+ovkhsuRIRbDBc0HMCYAgQeaJAdhwv/M20kl6kzDgXh80OYdfnYMvQUw4T7Ug49VnqTvOIKr6vQMlhyalMcgTRdxtoz1Iqkmdq335SfhQ0vFCcH7eqyftA8TW2BXBjUbcS4gIVLvvg9zPPtge5Frym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sp1XOY7M; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3DD7EC40F86;
	Mon,  2 Mar 2026 15:22:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DCE165FE89;
	Mon,  2 Mar 2026 15:21:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4EF7A10369578;
	Mon,  2 Mar 2026 16:21:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772464917; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KX8LyfkGSnwWJK3wQK4qJ9fwSRGCapjjd7Xu/oRsfOY=;
	b=Sp1XOY7MQ1zk8WE2oJ+NgQVnj6orYIwfCpXq7fcStXzRAPTbHwZTbSH8QtKq1g+tMuTPoR
	Mjg6O+5U53e/cPQwYf9mVbpUvimmSclHJv5EjRqr936QS6GKL9dG6JD9zX4kt7VSstXWlL
	8yNbfNU1k6OVyVzbK6SdVdXFOilEsc5yJFHuNiIdzwcvds9f+oJe57k/PXR+VfjUsEGYOQ
	hHRsQOmWmNsRfznGmfO+FL+gPnYuZdvwnqXlcXl9XE9coe9XrTJlX+WX4sbycwRLCKLiG9
	IlqwafFJsvgP7m40PNNPE8vIGi8n77wA76IfYR7VLEstJIWCYy+Zswr53wtmDg==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Robert Marko <robert.marko@sartura.hr>, andrew@lunn.ch,
 sebastian.hesselbarth@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Robert Marko <robert.marko@sartura.hr>, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: uDPU: add ethernet aliases
In-Reply-To: <20260127123250.527714-1-robert.marko@sartura.hr>
References: <20260127123250.527714-1-robert.marko@sartura.hr>
Date: Mon, 02 Mar 2026 16:21:54 +0100
Message-ID: <87v7fefe99.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: CC63B1DBC1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222625-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[sartura.hr,lunn.ch,gmail.com,kernel.org,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregory.clement@bootlin.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:url]
X-Rspamd-Action: no action

Robert Marko <robert.marko@sartura.hr> writes:

> On eDPU plus, which is an updated revision of eDPU which uses an external
> MV88E6361 switch we are relying on U-Boot to detect the board, and then
> enable and disable the required nodes for that revision.
>
> However, it seems that I missed adding the required aliases for ethernet
> controllers, and this worked as in OpenWrt we had added those locally.
>
> Cc: stable@vger.kernel.org
> Fixes: 660b8b2f3944 ("arm64: dts: marvell: eDPU: add support for version =
with external switch")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi b/arch/arm=
64/boot/dts/marvell/armada-3720-uDPU.dtsi
> index 242820845707..cd856c0aba71 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
> @@ -15,6 +15,11 @@
>  #include "armada-372x.dtsi"
>=20=20
>  / {
> +	aliases {
> +		ethernet0 =3D &eth0;
> +		ethernet1 =3D &eth1;
> +	};
> +
>  	chosen {
>  		stdout-path =3D "serial0:115200n8";
>  	};
> --=20
> 2.52.0
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

