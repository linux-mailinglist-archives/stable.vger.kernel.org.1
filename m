Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7375974632B
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 21:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjGCTGb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 15:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGCTG3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 15:06:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CC2E6D
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 12:06:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51d5569e4d1so4503923a12.2
        for <stable@vger.kernel.org>; Mon, 03 Jul 2023 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688411185; x=1691003185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dit9LAm7JLSPjlhx5oaqHDTlW0MgUhpLCs0igpyOsX0=;
        b=jdY9k07LhPPH23YzgGF3C6gVLaV44MrsGpgq8bDkspNSMFZLVxGTOo1CHRSMbsxQ/M
         +pI5yHuFfp2fLzPmPCr/yuUehgONeB5DxFpkoD2+yoQ+RhAQRHsmEkIo0hDyGkY4AWmL
         Dpd6BhZhlpqiSldd21OovcLGeHJBPFU5EXUvcpqq+OemWBTSTUdpU+JrQwVbE/o2iffG
         Hkt4vWetDyKmclt9G3g+kpzAr114qm7LKqO2GxGZm7oIULfQLkH/QxNPFOXzLYdBdiio
         2LP5Ws9LB9LkN1zMnttPp+pZP4INKJqWPO97Wnv5reK+VfrZGpDR9dhq88HTIrVdhhkL
         SIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688411185; x=1691003185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dit9LAm7JLSPjlhx5oaqHDTlW0MgUhpLCs0igpyOsX0=;
        b=enrUcJ71b7xtuLMYyG/3mxJpaoBJKxWKruwY/YQA1Fq8aQ2pvAw27/kYwnB4DwpoYi
         PL0qZNzAfD0xjADZfl7ObGo9FG14q13vu+lpoQcwQwm8i23zVw+9I8oyq00+ciwhY3ed
         vO/S4BvTdcPVZoEJbqPz3pyKhpBMH4wPUX3B+7jY4IQXDTfwamsF3ykHqB1bpwHsssbp
         r5dZX792FsS/UNDENvAWHkBOhrVKmffsVjWksv8rw2VbzF5dsbPmSWWwm8MSS9RBGxdR
         XMfMjkMGJJhY8oXy2mDGxvg6fOuov64HbMyhbW1gkIeGYgkLBV+owegIeFEksXzlh3VE
         k5ng==
X-Gm-Message-State: ABy/qLagTkwtr3ua/fZuW8IBHIsfry9Vro64yPjsh4eV1Bkwlqry82jR
        t23WM9SA2rmyJnahA8hXEwI=
X-Google-Smtp-Source: APBJJlF5gxfIrEz74YxF5Ca4XYvuNGEmkhYzcX1+srADGSbEDLZQzc+bmNegoNZU2nSXWyNM/PLH8A==
X-Received: by 2002:a50:ee05:0:b0:51d:d4dd:a0e1 with SMTP id g5-20020a50ee05000000b0051dd4dda0e1mr5662279eds.15.1688411185188;
        Mon, 03 Jul 2023 12:06:25 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id g19-20020a056402115300b0051873c201a0sm10908574edw.26.2023.07.03.12.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 12:06:23 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 1C14ABE2DE0; Mon,  3 Jul 2023 21:06:23 +0200 (CEST)
Date:   Mon, 3 Jul 2023 21:06:23 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Regression in 6.1.35 / 6.3.9
Message-ID: <ZKMcL6bG4RlnvHbi@eldamar.lan>
References: <MN0PR12MB6101C52C4B7FB00702A996EBE224A@MN0PR12MB6101.namprd12.prod.outlook.com>
 <2023062808-mangy-vineyard-4f66@gregkh>
 <ZKLT2NnJu3aA0pqt@eldamar.lan>
 <4e04459c-3ff7-3945-b34f-dde687fad4be@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e04459c-3ff7-3945-b34f-dde687fad4be@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Mario,

On Mon, Jul 03, 2023 at 12:43:06PM -0500, Mario Limonciello wrote:
> On 7/3/23 08:57, Salvatore Bonaccorso wrote:
> > Hi Mario,
> > 
> > On Wed, Jun 28, 2023 at 08:16:25PM +0200, Greg KH wrote:
> > > On Wed, Jun 28, 2023 at 05:56:01PM +0000, Limonciello, Mario wrote:
> > > > [Public]
> > > > 
> > > > Hi,
> > > >   A regression was reported in 6.4-rc6 that monitor resolutions are no longer present for anything but native resolution on eDP panels.  This specific change backported into stable at 6.1.35 and 6.3.9:
> > > > e749dd10e5f29 ("drm/amd/display: edp do not add non-edid timings")
> > > > 
> > > > After discussing it with the original author, they submitted a revert commit for review:
> > > > https://patchwork.freedesktop.org/patch/544273/
> > > > 
> > > > I suggested the revert also CC stable, and I expect this will go up in 6.5-rc1, but given the timing of the merge window and the original issue hit the stable trees, can we revert it sooner in the stable
> > > > trees to avoid exposing the regression to more people?
> > > 
> > > As the submitted patch had the wrong git id, it might be good to be able
> > > to take a real one?  I can take it once it shows up in linux-next if
> > > it's really going to be going into 6.5, but I need a stable git id for
> > > it.
> > 
> > Do you know, did that felt trough the cracks or is it still planned to
> > do the revert?
> > 
> > Regards,
> > Salvatore
> 
> Hi,
> 
> It's part of the PR that was sent for 6.5-rc1 [1]. Unfortunately it's not
> yet merged AFAICT to drm-next yet nor Linus' tree.
> 
> d6149086b45e [2] is the specific commit ID.
> 
> [1] https://patchwork.freedesktop.org/patch/545125/
> [2] https://gitlab.freedesktop.org/agd5f/linux/-/commit/d6149086b45e150c170beaa4546495fd1880724c

Ack, thanks! 

Regards,
Salvatore
