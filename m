Return-Path: <stable+bounces-127282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6238CA772D2
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 04:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDBC4188E0D1
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 02:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E0B1A3150;
	Tue,  1 Apr 2025 02:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b="eYyVXqjc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47C18C004
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743475460; cv=none; b=rg/cfKqSokPm9x2sPYnur83g9Z4PS6AsRlgdRQS3+zTwKgBOBZavX6L4TIZQea+M4XeDwPkZzS5W5JOoJ4RudPGnS5J/lDXnPzk6MrU7CIOuvlo1qx1Cg7qIaxRPBpv+IWEsuGku1K9WPjPsU9EV7lTVxT92+m5cnvtqzAB1rG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743475460; c=relaxed/simple;
	bh=HkxGjWUqTJOgqG7g3+8MzEadXEObhK4uaNG+f+mMpaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIoTy1ZnjpWweamQqvRJ/gzs/KyLmcD9CXqju0SiNa2CN7MkDj5hLIx5MtbxH20nQXoKWNuhgh8AHUcjMDT6M/VPK1SqZKf6Zsh792DsMn+8S6hN0i0lRCtwcGodhZBva6CwZKgNaVPfvfemJyRKZ+iVOC8/b3UuasBskqvs7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com; spf=pass smtp.mailfrom=lessconfused.com; dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b=eYyVXqjc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lessconfused.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-303a66af07eso6966062a91.2
        for <stable@vger.kernel.org>; Mon, 31 Mar 2025 19:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lessconfused.com; s=lessconfused; t=1743475458; x=1744080258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkxGjWUqTJOgqG7g3+8MzEadXEObhK4uaNG+f+mMpaA=;
        b=eYyVXqjc96cYAL7J5II6yGzorQAT7ybIEzwi28gXkn6HiURBAmrIv3U6wXYUhgKesU
         gtTRYfrbtzJRp3pJlejjL88m0se4Z5/BJH+G7jJ4760gZ2Lf9rjx6JJeLBIxsfp0hDVu
         wO9dAaNxhUjcjPYNh3wWxKVWDmTb3PZuZuV1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743475458; x=1744080258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkxGjWUqTJOgqG7g3+8MzEadXEObhK4uaNG+f+mMpaA=;
        b=L595lIJsQm6O9/EwuaypcVaahtVaBXN32ZZgE45ARn43loxvLMtKNL0J9De4dQMcpp
         4Ub802kzUb4mov0U9JNHR0yca8iEOjPBSK8hnxWE9jmqTOfOLI17LsYsx8M504L8ihZl
         4my8pDIycNe/7YEAxnJBHr1y2MFKEaCJNhOtcGc4ZJRLTVoBBJiIykIe7thve1+oGVib
         S/qeREn+q7k0LQN1oTXOUlj7NPt9rgbo6oPo5R/CVE4T3WFKNGfmsAdQRAgPei9C7odu
         ns+mrE0v/MzH+uroKARQhmb/AP2e+9YJfEM9+ssWWfzth+3DRj/k296Q4Bdp37jgtIgD
         T74A==
X-Forwarded-Encrypted: i=1; AJvYcCXeKRVZwbNKVQHY/3LqU7KyIhMp8gl14j2ZBqKspYwca4BbUbpUMWUqlRoNsujJQsr8QAuLdYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxMvUeeB0BPTAsEs+y5uhfrxdeemfY3DiWYWzVeKvIjz7IUUDT
	A1nmpuEyZ06qzRb5P8P/fnBQINjpTMuwclxGacxD5aisqoc8nR+8byb3SgrDIhBlYF5V/WI5teV
	v1dUygiWtMsktF+jroJmNSmbOU+3xYVBQyw864A==
X-Gm-Gg: ASbGncsX3aDg2uAZ7uga9DgKOqJLeRtEcX/2xqohL/17QzDmPNLnCtkwN+sY1bE36by
	odljpjPWErBQe+V+wc6JvhZvNhRrhK/0fxrhnDOs6DaeC63Oya9gKAxqIY0/Q3vahVedH7j6SnP
	48KsJ3I0T1dOR3dvA65z7po84=
X-Google-Smtp-Source: AGHT+IEpFvhBi+lUM5E7CGqIh8SlOtzaJBvCk79aI8LiSy+0QDNR3/3AA4vdH3Sbx11mdSvsVtvYulswYGsuHxWrLD0=
X-Received: by 2002:a17:90b:1f91:b0:305:2d68:8d39 with SMTP id
 98e67ed59e1d1-30531f9475fmr21374158a91.12.1743475457642; Mon, 31 Mar 2025
 19:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331074420.3443748-1-christianshewitt@gmail.com>
 <17cfc9e2-5920-42e9-b934-036351c5d8d2@lunn.ch> <Z-qeXK2BlCAR1M0F@shell.armlinux.org.uk>
 <CACdvmAijY=ovZBgwBFDBne5dJPHrReLTV6+1rJZRxxGm42fcMA@mail.gmail.com>
 <Z-r7c1bAHJK48xhD@shell.armlinux.org.uk> <CACdvmAhvh-+-yiATTqnzJCLthtr8uNpJqUrXQGs5MFJSHafkSQ@mail.gmail.com>
 <Z-ssXdmRLYqKbyn6@shell.armlinux.org.uk>
In-Reply-To: <Z-ssXdmRLYqKbyn6@shell.armlinux.org.uk>
From: Da Xue <da@lessconfused.com>
Date: Mon, 31 Mar 2025 22:44:05 -0400
X-Gm-Features: AQ5f1JqL8hh66tVHnQp1H53_t8VYOq9ejOXVjyop1xdABti6QeP9kvlxkmw2sn8
Message-ID: <CACdvmAgP8iftcUumv9RrHBLLHFtQtPeRVgDVp7YkWuPsW6Ybmg@mail.gmail.com>
Subject: Re: [PATCH v2] net: mdio: mux-meson-gxl: set 28th bit in eth_reg2
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Kevin Hilman <khilman@baylibre.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Da Xue <da@libre.computer>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Jerome Brunet <jbrunet@baylibre.com>, Jakub Kicinski <kuba@kernel.org>, 
	linux-amlogic@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, 
	Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 7:59=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Mar 31, 2025 at 05:21:08PM -0400, Da Xue wrote:
> > I found this on the zircon kernel:
> >
> > #define REG2_ETH_REG2_REVERSED (1 << 28)
> >
> > pregs->Write32(REG2_ETH_REG2_REVERSED | REG2_INTERNAL_PHY_ID, PER_ETH_R=
EG2);
> >
> > I can respin and call it that.
>
> Which interface mode is being used, and what is the MAC connected to?
>
> "Reversed" seems to imply that _this_ end is acting as a PHY rather
> than the MAC in the link, so I think a bit more information (the above)
> is needed to ensure that this is the correct solution.

The SoC can be connected to an external PHY or use the internal PHY.
In this gxl_enable_internal_mdio case, we are using the internal PHY.

Sorry about leaving this out in the last email and causing another RT.
I'm not very familiar with ethernet underpinnings so I don't want to
use the wrong terms.


>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

