Return-Path: <stable+bounces-6767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C36813A5C
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 19:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B501C20AFC
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 18:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B557F68B9B;
	Thu, 14 Dec 2023 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hWWLT2Xe"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B4310F
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:52:44 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bdec453c8so9983827e87.3
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702579962; x=1703184762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1YI7E4Yx3iebHdrqbE0xCVHhBGWXCdGqSCBozZBsUE=;
        b=hWWLT2XeGignVzPb0iJpIbuoU0A/aX1twdmJnpT8hpOvjTYPE7t/n6nXrvkfwXeT7F
         u0h4L4VwTMcmQNKRZeBjdCa+l4gm+/dqF3Qxhsf4+3qoT5oD+Qi7ueu3iAdBf8WkUgc1
         P4Uf3nIZxNBB3f/rCzLfD2AgqEEEqlWQzNwmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702579962; x=1703184762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1YI7E4Yx3iebHdrqbE0xCVHhBGWXCdGqSCBozZBsUE=;
        b=t38OfYV4ac1sVPZowLYEQueqscfx2ehwoMKC2VEPycHMf0Q+fNnRrUqD2uoIO6/aBI
         BBVrNfpKiM/DIphN1hEAJ/3okjnF/0X8EIZZG26bLDJbo3K6K+BurXVHn9/BWHNi0Zju
         C9fpW8aUadT0lXcdINWbOJE7ych6OR73SFB4MhovW4I2p8ts+S6l7GdgqCKVW/cCzjAk
         A1AH8kzs+G2wkem6O4eUWqo/hg9I0/41YX+qp8/n/Zr6tZApqK1Qr8UN42AKs7zdiXId
         7qpqFo3xHbS6KR2AEVP47bjy61jTSmHkpy3r3zE23UpQvYdHVGQLX3ljzaXXHz51UhEi
         aVog==
X-Gm-Message-State: AOJu0YwshaGEyTSVG9B7ZU+aKe52WibeYf8iAvR0CRhsuyDsCQm5qyr5
	kcOcAUcpDUL+d167Ukq9DLr6hWX6bltQDyFi4JM=
X-Google-Smtp-Source: AGHT+IFmjuTwtk4YKlDgxiYv1zZZwSoeQuF5CGg0UrWLUxYso6CB3ti4L8IXRndvInSRiCpr3ZdtYQ==
X-Received: by 2002:a05:6512:3984:b0:50b:f01d:180d with SMTP id j4-20020a056512398400b0050bf01d180dmr7062102lfu.107.1702579962024;
        Thu, 14 Dec 2023 10:52:42 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id d11-20020a170907272b00b00a1e2aa3d094sm9930361ejl.173.2023.12.14.10.52.41
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 10:52:41 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3364514fe31so957659f8f.1
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:52:41 -0800 (PST)
X-Received: by 2002:a5d:5601:0:b0:333:2fd2:51fb with SMTP id
 l1-20020a5d5601000000b003332fd251fbmr4932153wrv.116.1702579961041; Thu, 14
 Dec 2023 10:52:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208234127.2251-1-yu-hao.lin@nxp.com> <ZXpjjmD5Se7axJju@google.com>
 <PA4PR04MB96383A106724AC1CE683112BD18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZXqwP7NscRtE1uGL@francesco-nb.int.toradex.com> <PA4PR04MB96380AA7B60AFD73491FF53BD18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB96380AA7B60AFD73491FF53BD18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Brian Norris <briannorris@chromium.org>
Date: Thu, 14 Dec 2023 10:52:29 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOHQUnruWqsN0yTbKzVD8+7hcafLFhhv6jq7cdUzTY5ZA@mail.gmail.com>
Message-ID: <CA+ASDXOHQUnruWqsN0yTbKzVD8+7hcafLFhhv6jq7cdUzTY5ZA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
To: David Lin <yu-hao.lin@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 3:38=E2=80=AFAM David Lin <yu-hao.lin@nxp.com> wrot=
e:
> > From: Francesco Dolcini <francesco@dolcini.it>
> >
> > On Thu, Dec 14, 2023 at 02:22:57AM +0000, David Lin wrote:
> > > > From: Brian Norris <briannorris@chromium.org>
> > > > It probably wouldn't hurt to significantly write much of this
> > > > driver, but at a minimum, we could probably use a few checks like t=
his:
> > > >
> > > >         cmd_size +=3D sizeof(struct host_cmd_tlv_mac_addr);
> > > >         if (cmd_size > MWIFIEX_SIZE_OF_CMD_BUFFER)
> > > >                 return -1;
> > > >         // Only touch tlv *after* the bounds check.
> > > >
> > > > That doesn't need to block this patch, of course.
> > > >
> > > > Brian
> > > >
> > >
> > > I will modify the code for next patch.
> >
> > I would suggest not modify this in this patch, we should fix all the co=
de that
> > is subjected to this potential issue.
> >
> > I would personally do a follow-up patch just to add the check to avoid
> > overflowing the cmd buffer everywhere it is used.

Right, there's tons of code that could potentially be affected, and
this is definitely a separate patch. (Your feature only adds on to the
existing issue, so these are separate logical changes.)

> O.K. I will only change commit message. In fact, this TLV command is adde=
d as the first one command.

Well, it doesn't really matter than your TLV is "first" -- if there's
an overflow, there's an overflow. Maybe the 8 bytes you're adding here
are the necessary tipping point. I don't know without doing some kind
of informal mathematics/proof.

Brian

