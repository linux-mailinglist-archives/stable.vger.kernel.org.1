Return-Path: <stable+bounces-108596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C867A10828
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 14:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DF8166D9F
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF4222F19;
	Tue, 14 Jan 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="bEFXh/PO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C64E17557
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736862642; cv=none; b=RSep7xLV36czMGq0jxM3gxO85Q+ZoJnVn32ntKAEFr3ggZtb3F2mRyHyy7zNygu1tm9Z7mKYJDlWAzE9MOQkd28qFL8AcoLQ4LygBTwdSPwGRX7vLzYh7ZmYc0aUZZDlsax3JXXEzEcYCgaZBU7dciy5vH7YDhC5LJRbidyQ3p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736862642; c=relaxed/simple;
	bh=MK2AphVmYBUjHm1HCF0DhkauVUycpjqvY/5QFbqNgB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjV7ahE0ssufPbHFtfu4/qhFUDH4YYXoezpqSnFkLudqsehxRNPZgwtZX3yWallJCGYuLT35CVrbaLWvFeWjM5JZ0nXNpE/Qo8G+zu3bUTjhaK9pznUBk0dJ9a8cS7LwvSYzUcaZwFL+6s2JGUJJQmw5QlnVHiotPoZptA3MtrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=bEFXh/PO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so9502549a12.2
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 05:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1736862639; x=1737467439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qK8eJ72oUfZkFBOw+tTcLnGpMzZXzfZ2mLBjQdYOmks=;
        b=bEFXh/POozmDGCRznXWNSkQrNAb4Gv7QjPzIcp1Hb7amkblZBooQDnqgd/ldb1uU2P
         fVgCtEyXsQZ7k8CZrE01/riIWUCdrsuQv0XXR0X5LTilImVzvL9xsB3rdw9tE+Qwd7ai
         n4cuXs2hYyL6Mm1R9O+ugzsJf5X3M5KZKU9dTNkuagm+ZHJe80mGmjUW1U51cXVWFzKc
         hx7nphzBMKxuJNEyJKdX2evsjOgs/LxOOO+BkM54xJRJOI/I1pljYd2l41/rVpYH/QWL
         na9xmzonwRxJKtchTi8Vcar7yZoOcwM0fakqs0Guc7FXQAr0DkyBlJgFC+dLuh7CzLfr
         c7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736862639; x=1737467439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qK8eJ72oUfZkFBOw+tTcLnGpMzZXzfZ2mLBjQdYOmks=;
        b=j9qlHV0xgD4K9QKq8iT4Y7ST34Q6t1W/kCOBoswN05HXxpw/zVu7hT8RoUAtPaQCTE
         oC37NjkdcJSr/UkE7ixhJeY1W1V01KHPI24t0WPTh1M3nSuQ0hirUVMJkx3E0FQHH//Z
         iomnOiGg8X9dEsDuzW5SliZG9XzMZKwmC1WYut6kbWtuurEh9RS6D0Djb5YuqA2R/ekK
         VRUXzfZqlHYIJ/ZXft5tz1XcX4b60UT+MD4EiPzirhjDbHvRmxq6VUjuDoRFw17u4Z+h
         ziIW2+8h2vYKeaeoJ8vctyzKAYde17SJVOufkaSojmpycxCee8b8nDOO/5qLbiJP+1Hm
         t+QA==
X-Forwarded-Encrypted: i=1; AJvYcCXhfR4Qr6RiHp0q3utRGd/98vK01j0w0+tOlI//wy81L0zbfoo4ZCAFQU+AY3FfF2b7l6tdJH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTEZr8qdgSO6f3tDjDo/E73ZRfYxHh0wHedjwT/5ByzZPE3sLH
	bU/+UavKtp8WrVX5kkLwAogcnB38hTUoYnlUnxjJWz8wbT225CDBjzepWJ5/Z9VA9zE+eO/fbVQ
	Nm64KvgtjBFf4MDLFrePWPHWZbc/k8FdN3Sx+DJpx35JNPBRh
X-Gm-Gg: ASbGnctdFdtGNkMqsokGo4xVl8oB+PB/8mryIdQM0/rwxRLGGU7uTZsEhFvqEje2fo7
	PDkiXcO7ZFEn9paidtJ2rOV5HILg1+sX8GjlBxjc9MHE5lFQ4+mc86qdV92Z95QoocMFNDlo=
X-Google-Smtp-Source: AGHT+IF46TQhtbMMZMIZCKwTcvvfKRkqdMf4+iusbVX+iTYMmw+SknyG/9KNTOsKRbNl7xnQQq1VrKvxMWJ1gHVadbI=
X-Received: by 2002:a17:907:3d89:b0:aac:1ff1:d33d with SMTP id
 a640c23a62f3a-ab2ab740dd9mr2228481666b.30.1736862639349; Tue, 14 Jan 2025
 05:50:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121071325.2148854-1-iwamatsu@nigauri.org>
In-Reply-To: <20241121071325.2148854-1-iwamatsu@nigauri.org>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Tue, 14 Jan 2025 22:50:13 +0900
X-Gm-Features: AbW1kvYfwvDX59DGr73TkVKQWrZUOAfV-Cykp2gPV41y5Dp3jhO_fwHVhjZEQuo
Message-ID: <CABMQnVJVTmnsx3RNYK01ikZ-jnn_y4pbrNAeZaKPzz0N_YFz5g@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY address
To: dinguyen@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dinh,

Could you check and apply this patch?

Thanks,
  Nobuhiro

2024=E5=B9=B411=E6=9C=8821=E6=97=A5(=E6=9C=A8) 16:13 Nobuhiro Iwamatsu <iwa=
matsu@nigauri.org>:
>
> On SoCFPGA/Sodia board, mdio bus cannot be probed, so the PHY cannot be
> found and the network device does not work.
>
> ```
> stmmaceth ff702000.ethernet eth0: __stmmac_open: Cannot attach to PHY (er=
ror: -19)
> ```
>
> To probe the mdio bus, add "snps,dwmac-mdio" as compatible string of the
> mdio bus. Also the PHY address connected to this board is 4. Therefore,
> change to 4.
>
> Cc: stable@vger.kernel.org # 6.3+
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  v2: Update commit message from 'ID' to 'address'.
>      Drop Fixes tag, because that commit is not the cause.
>
>  arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts b=
/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
> index ce0d6514eeb571..e4794ccb8e413f 100644
> --- a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
> +++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
> @@ -66,8 +66,10 @@ &gmac1 {
>         mdio0 {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
> -               phy0: ethernet-phy@0 {
> -                       reg =3D <0>;
> +               compatible =3D "snps,dwmac-mdio";
> +
> +               phy0: ethernet-phy@4 {
> +                       reg =3D <4>;
>                         rxd0-skew-ps =3D <0>;
>                         rxd1-skew-ps =3D <0>;
>                         rxd2-skew-ps =3D <0>;
> --
> 2.45.2
>


--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 32247FBB40AD1FA6

