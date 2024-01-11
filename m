Return-Path: <stable+bounces-10512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6854282B065
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 15:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC0FBB21735
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D633C46F;
	Thu, 11 Jan 2024 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvyeJTOF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38753D96C
	for <stable@vger.kernel.org>; Thu, 11 Jan 2024 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5edfcba97e3so56818497b3.2
        for <stable@vger.kernel.org>; Thu, 11 Jan 2024 06:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704982444; x=1705587244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQY9zGPEtO1QF2ljEldwAIEPyis1kLrWBuBbYuv032U=;
        b=PvyeJTOFNL31cKfs/kuPxMmgiXyCOXgLpJjHNXh1+RlK1DYfdCbn1HkuTt0wn5XmWG
         Ii98COGRSpv6K4u6lJ1XXj1+N0vFOONpfwH5duiE2vWilmRIM9A48+Vi/e6KyjwiBiNx
         2srrdZmaBrQDCVWrRBaTStYlhU+f+oiy6rwVgSqXfJJee2EoccnIItF7j5hL27ZnC+Me
         beKz84KQbEkw/9/MYd4nmBlVebeQEPwTjqmZ3QVEr4Vyy/tTM3H3iDNtjyBJi+/8B+Aa
         Q5V4vtLL+4LzEXD6M6fQx/3zNVHJG1vAeC5Glo1AmihdxjLxMAY5sfp1ktE42yXfD2PD
         HHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704982444; x=1705587244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQY9zGPEtO1QF2ljEldwAIEPyis1kLrWBuBbYuv032U=;
        b=OIC7cFDf820IQFcBofYpd+ZSx3IUZcdt45BP6UNduxdEZkUOwISSCLVtYUwodrUmj5
         b2WEz659b+4LPMLyAYQTfKBjxsLLYc9HKmdARMK5o4moZUPi44kRQY1pDbEMYGsiQT1U
         isSvLEWQSYBRU5xNnE42CR7BsJQvkxB+D21G7YloLnooxVi3G7aDuhymJ96i3FGwO6Du
         qiazDP0gIuhwkNHTJ0G3Y7kbcb/jzSYyiq+b5CRV+wl7eJ9eKfnkH9KsXw03ov7n4/wi
         /0EVKXZqlb5XaKUlI37KabiMMKYNF5kkmT4uIPu9wZ/2BEzUnT079e3MVJtdM7WBLnaO
         jryg==
X-Gm-Message-State: AOJu0YyHRCLDsdunY99x2p2InTaisdPtw952W27EP6iAs7yPv9HDBOAq
	CYD5ECEwSikmd4lI1yxDq8Z/odUoKBiCNG+F9GSsYaqFVW/PFg==
X-Google-Smtp-Source: AGHT+IHbjb9WBJNb7mg6Cf0OKedEBHnlOsptBA2sTAMDxR21dqAolwUjCQy13ZKdOjJSxqEUmo0hzT35aqUzxhvj6QM=
X-Received: by 2002:a81:c60b:0:b0:5d8:5727:80fb with SMTP id
 l11-20020a81c60b000000b005d8572780fbmr537921ywi.84.1704982443677; Thu, 11 Jan
 2024 06:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109-prevent_dsa_tags-v4-1-f888771fa2f6@bootlin.com>
In-Reply-To: <20240109-prevent_dsa_tags-v4-1-f888771fa2f6@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 11 Jan 2024 15:13:52 +0100
Message-ID: <CACRpkdYPFBugiM5-TsB0SJ=zE4yvjqCX0XLXE5axxeTp0wVcRQ@mail.gmail.com>
Subject: Re: [PATCH v4] net: stmmac: Prevent DSA tags from breaking COE
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Sylvain Girard <sylvain.girard@se.com>, 
	Pascal EBERHARD <pascal.eberhard@se.com>, Richard Tresidder <rtresidd@electromag.com.au>, 
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 3:42=E2=80=AFPM Romain Gantois
<romain.gantois@bootlin.com> wrote:

> Some DSA tagging protocols change the EtherType field in the MAC header
> e.g.  DSA_TAG_PROTO_(DSA/EDSA/BRCM/MTK/RTL4C_A/SJA1105). On TX these tagg=
ed
> frames are ignored by the checksum offload engine and IP header checker o=
f
> some stmmac cores.
>
> On RX, the stmmac driver wrongly assumes that checksums have been compute=
d
> for these tagged packets, and sets CHECKSUM_UNNECESSARY.
>
> Add an additional check in the stmmac TX and RX hotpaths so that COE is
> deactivated for packets with ethertypes that will not trigger the COE and
> IP header checks.
>
> Fixes: 6b2c6e4a938f ("net: stmmac: propagate feature flags to vlan")
> Cc:  <stable@vger.kernel.org>
> Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
> Link: https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2=
@electromag.com.au/
> Reported-by: Romain Gantois <romain.gantois@bootlin.com>
> Link: https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495=
@bootlin.com/
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

