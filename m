Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC6A745E03
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 15:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjGCN5u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 09:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGCN5t (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 09:57:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036C4E51
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 06:57:48 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b699a2fe86so74198471fa.3
        for <stable@vger.kernel.org>; Mon, 03 Jul 2023 06:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688392666; x=1690984666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKlR/17zBBOm87/ERZ/UgMSxJea1HiQOEOXEkvHkmd8=;
        b=PaExsTHmnVLcUii2/kshU7xQ7UsndZVhnIf4YWBJMUlmMnAEL2Fa8rBV/5nVsXPLtp
         /ArWTI0tFnVgmYQ/O7G+guYMgEKb4wXHlx8QJAM1jpdxYQvhiDH41YSwbyXWX0DDFkc5
         1DMSb77BmfjXRpU+AXOgAKOVwusQEFdsAP6I+giQt0vNi+Ayq/hfdO3eJTa2t6MnptCp
         e9VyGgsOiC8hDRJ4EezCq4yXDDvb5LnGVuTygKkUXzilIlJnulMhqti040vNxjAlrov9
         gfiAG2VQQVKmgf6RvwI4w9CJhRm231tDS+F2At6Ao6RtOuXnheMwkslDSQY813G5a6uL
         lEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688392666; x=1690984666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKlR/17zBBOm87/ERZ/UgMSxJea1HiQOEOXEkvHkmd8=;
        b=S91M486hQV0kwEhil/0R97N0dgZXrOPGK1hnGyoMOCqvg1hCTtUhRyh7ouxQiHGcQ1
         qlX0vg5b2FjBa/z828F7SYicmFOBYdEkRaaQVDamkvoXj1EX5Bb9M9yOU+9gfLNlrYsN
         2ak2mqAqyZ0MzNAMwQwFz8Z0McN9tEDLLfnG0UJQUBK3Z2C/M0acDLn1ULVl4lwGAKwG
         AviofUqkNw8smTUZzHdD+FI4xSCZ2cVhoWwNV9LLpUlv2qbrcIvsIVd0rvgF6vV4HcOl
         DmjXCtjJSYtq4ug+0tvNMD0AAWu0I0xaIjQstB9GQph1IPv/1VrvKEcd7Q6NIVuw36yu
         MNnQ==
X-Gm-Message-State: ABy/qLbNPyJMphI84nHfdDwV+aUuhqcrWyXYBXWAB7iREnDUzAVqmFGD
        z8YFrAyutCOJ9P3OGY5khuU=
X-Google-Smtp-Source: APBJJlEjtAu6fwqxU8bio+kqvjipP02DjJCXlp59Cuax6A+JXSJcUNt07ThdpT2s05dON86kjoSnZg==
X-Received: by 2002:a2e:3507:0:b0:2b6:eee2:99b0 with SMTP id z7-20020a2e3507000000b002b6eee299b0mr656660ljz.37.1688392665935;
        Mon, 03 Jul 2023 06:57:45 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id kt19-20020a170906aad300b009894b476310sm12090368ejb.163.2023.07.03.06.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 06:57:45 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 75AB5BE2DE0; Mon,  3 Jul 2023 15:57:44 +0200 (CEST)
Date:   Mon, 3 Jul 2023 15:57:44 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Regression in 6.1.35 / 6.3.9
Message-ID: <ZKLT2NnJu3aA0pqt@eldamar.lan>
References: <MN0PR12MB6101C52C4B7FB00702A996EBE224A@MN0PR12MB6101.namprd12.prod.outlook.com>
 <2023062808-mangy-vineyard-4f66@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062808-mangy-vineyard-4f66@gregkh>
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

On Wed, Jun 28, 2023 at 08:16:25PM +0200, Greg KH wrote:
> On Wed, Jun 28, 2023 at 05:56:01PM +0000, Limonciello, Mario wrote:
> > [Public]
> > 
> > Hi,
> >  A regression was reported in 6.4-rc6 that monitor resolutions are no longer present for anything but native resolution on eDP panels.  This specific change backported into stable at 6.1.35 and 6.3.9:
> > e749dd10e5f29 ("drm/amd/display: edp do not add non-edid timings")
> > 
> > After discussing it with the original author, they submitted a revert commit for review:
> > https://patchwork.freedesktop.org/patch/544273/
> > 
> > I suggested the revert also CC stable, and I expect this will go up in 6.5-rc1, but given the timing of the merge window and the original issue hit the stable trees, can we revert it sooner in the stable
> > trees to avoid exposing the regression to more people?
> 
> As the submitted patch had the wrong git id, it might be good to be able
> to take a real one?  I can take it once it shows up in linux-next if
> it's really going to be going into 6.5, but I need a stable git id for
> it.

Do you know, did that felt trough the cracks or is it still planned to
do the revert?

Regards,
Salvatore
