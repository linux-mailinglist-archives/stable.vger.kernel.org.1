Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260BA7CDFB0
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 16:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbjJRO1b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 10:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345562AbjJRO1V (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 10:27:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D642D57
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 07:26:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c2a0725825so584898666b.2
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697639163; x=1698243963; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yz7ZSvascT2J277a7QoKDS11yhfUPVtOBgADIA7AQis=;
        b=wmq3JQ20vXZyMu83mEGpO4M+/tgOjw7Fvq3MRhcJw7KPLoHGCXyh9AQDpSWOacGHXG
         RUY4WC8/A1qwSMcOs1dawNhH0g0n/fIactHppReBRMh6yOGIYI335QZfVVyihM3eOR7Y
         VnudgIEQFx4jp+5iBO9AGbEtCx0OweB0bi6fZQ2VqfQOMEGPkhmfPh/MXazVOPQe4cuf
         6JFN5JvHdZ6xLcZSgw0lZ5sOZ+9c547/0r2qmojZqElWF2eEwYShJply2860mnrP+Dbo
         3ZrXgsyEPyNg9cPYv+fD3D17ywCv/BPYamsyUtjo5+ZwExYrSUUwBYnsPjQCPb9NuPwk
         d0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697639163; x=1698243963;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yz7ZSvascT2J277a7QoKDS11yhfUPVtOBgADIA7AQis=;
        b=uUiPDFtApy20+8i9fmoiQMtGJDHi4rvMcc/xyYjhuWUJo8o3LVlFFdh7EQ9CQ3f3Bo
         sAMCm/qLJfncc43vWnV9Uxt67Yu39p3HJnifjB2f4c9FKTPkIsaiKK989FWqJegfD5bq
         8lYixwRhwdqwiW7hoNmSDbPuNumKLCNp8SHajFkQORysruOsTqiryUCylKVRo1ZHqpNY
         dXk2eA9BRRor8O/pi1IZ67wuJEfcXWaxe/sXnNtSGNcjtNnR697UW3iwRK3sD0pakSRo
         RjxxCxnYHP5uSWzQeSl9H3JgjLoAVTT/wkEBg5qrgvbEMz2SBBwigrpaFGgDmmNz1/2p
         /QAQ==
X-Gm-Message-State: AOJu0Yz8DVGT1KCF6ciqHCf0pHma1jKq99IXvrck+y+AxOlCmz81HyAg
        5A9n+prevxQi2HKXCbIXJ/o3NQ==
X-Google-Smtp-Source: AGHT+IGXsHNg+vY54Vy7dLjS/eWTBxTI8IxUwjx0EIdkU+CBaq+/D+mx/PDV0nwXtR4BDJ5gjFnm5A==
X-Received: by 2002:a17:907:3202:b0:9a5:9038:b1e7 with SMTP id xg2-20020a170907320200b009a59038b1e7mr4375120ejb.36.1697639162665;
        Wed, 18 Oct 2023 07:26:02 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709064e4b00b0099bcf1c07c6sm1784191ejw.138.2023.10.18.07.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 07:26:02 -0700 (PDT)
Message-ID: <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set
 the FUSE_INIT_EXT"
From:   =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 18 Oct 2023 15:26:01 +0100
In-Reply-To: <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com>
References: <20230904133321.104584-1-git@andred.net>
         <20231018111508.3913860-1-git@andred.net>
         <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com>
         <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
         <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 2023-10-18 at 11:52 +0000, Bernd Schubert wrote:
> On 10/18/23 13:46, Andr=C3=A9 Draszik wrote:
> > On Wed, 2023-10-18 at 11:39 +0000, Bernd Schubert wrote:
> > > On 10/18/23 13:15, Andr=C3=A9 Draszik wrote:
> > > > From: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > > >=20
> > > > This reverts commit 3066ff93476c35679cb07a97cce37d9bb07632ff.
> > > >=20
> > > > This patch breaks all existing userspace by requiring updates
> > > > as
> > > > mentioned in the commit message, which is not allowed.
> > > >=20
> > > > Revert to restore compatibility with existing userspace
> > > > implementations.
> > >=20
> > > Which fuse file system does it exactly break? In fact there
> > > haven't
> > > been
> > > added too many flags after - what exactly is broken?
> >=20
> > The original patch broke the existing kernel <-> user ABI by now
> > requiring user space applications to pass in an extra flag.
> > There are various side-effects of this, like unbootable systems,
> > just
> > because the kernel was updated.
> > Breaking the ABI is the one thing that is not allowed. This is not
> > specific to any particular fuse file system.
>=20
> How exactly did it break it?

At least in Android, creating new files, or reading existing files
returns -EFAULT

>  These are feature flags - is there really a=20
> file system that relies on these flag to the extend that it does not=20
> work anymore?

I don't know enough about the implementation details, but even outside
Android user space had to be updated as a prerequisite for this kernel
patch:
https://lore.kernel.org/all/YmUKZQKNAGimupv7@redhat.com/
https://github.com/libfuse/libfuse/pull/662

Which means any non-Android user space predating those changes isn't
working anymore either.



Cheers,
Andre

