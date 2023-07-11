Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B757374FABF
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 00:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGKWL5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 18:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGKWL4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 18:11:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078B11BD9
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 15:11:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b9ed206018so29695ad.1
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 15:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689113487; x=1691705487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHo0qMf4X1AE4fyMbmdJ4zDFrUO5AckTUAmIVNX3n3g=;
        b=bfZUezdR6ChxnnxVGsBAilrCjBS5n76CuxktV8rcb2pcv/iqsYDm1kigi7cfmzReQu
         MxKM6KU1x8k4rBHgYTBBVeVR/EaKKBZUZU+WrKJJuXjUPV8GWe3fqdc4HEC57iefR5nV
         1BXmo2dcwW2j9jvDj0AA+XRR/ODoei+4k0Mx8x1HAlYvjL3raftlIctYj/zuqocHBJ6D
         Hp5TlpKTG6IENYTKIjvWdg49gnzvpFgJyEdWba08B6bgvMft4nNuoV0VZtcZNfXRj0Gm
         1ME2PQgm9azlZEx1S8PBu1N27cajbrj9BrAbWY05Nk5N22GGa1PfG7dn4emM4gT6UBi5
         bwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689113487; x=1691705487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHo0qMf4X1AE4fyMbmdJ4zDFrUO5AckTUAmIVNX3n3g=;
        b=FpacFOnmAXNmhRzTdkoR6YHRLVh2WyWSaD1eMsYe0VRcP3Nb4GPvUmXTeToyn9qTRF
         AEeKD89agbUHuQFFBVKc89RV4GzZSAuhl+M/BMS5G6y0jRdfJOKiHV+rX/dsr3Z/Lo+o
         dOTQaYQ2SqCyJkWFcsP+IdrF/2XNiiYlojpBHqnAEMBc9vE6k55oVpUrCzEoV//BrtZP
         T8obxNVeKWbldunQPEgFhI5cjvFD5tQFDVKK90lothY1B3l2my7GQSkshXsQXdOfd3wH
         86HxlMLGzI8FijsJFBZeW3QbFi2G2vSqlyW+kAVaP0ZbHGwX+RbETYnSzR2ehAi/tVai
         68Ag==
X-Gm-Message-State: ABy/qLYmlCJACEhJYdlrhtK8A2YQpqwWUM/ylwWDZRF5/qTiQkvmFdDa
        TEPiXSSe4sdQA2CX3GGpiLbmSw==
X-Google-Smtp-Source: APBJJlHqZ0qfiC4zcfhS1XF3OMF9UVOH+LxsU51wscEEc3H0iT4AUmhd8wDhsXS45SiLuMmywDpiFQ==
X-Received: by 2002:a17:902:f688:b0:1b8:c666:1fc1 with SMTP id l8-20020a170902f68800b001b8c6661fc1mr88703plg.20.1689113487138;
        Tue, 11 Jul 2023 15:11:27 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:8944:7c0b:5d4e:f65b])
        by smtp.gmail.com with ESMTPSA id x22-20020aa79196000000b00682a839d0aesm2181015pfa.112.2023.07.11.15.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 15:11:26 -0700 (PDT)
Date:   Tue, 11 Jul 2023 15:11:22 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <jstultz@google.com>, stable@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] regmap-irq: Fix out-of-bounds access when allocating
 config buffers
Message-ID: <ZK3TiuPZr0A8iaNN@google.com>
References: <20230711193059.2480971-1-isaacmanjarres@google.com>
 <8e5fba54-9ec7-45a7-8dd6-6ea63d853907@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e5fba54-9ec7-45a7-8dd6-6ea63d853907@sirena.org.uk>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 11, 2023 at 08:50:08PM +0100, Mark Brown wrote:
> On Tue, Jul 11, 2023 at 12:30:58PM -0700, Isaac J. Manjarres wrote:
> 
> > [   14.033877][    T1] ==================================================================
> > [   14.042507][    T1] BUG: KASAN: invalid-access in regmap_add_irq_chip_fwnode+0x594/0x1364
> > [   14.050796][    T1] Write of size 8 at addr 06ffff8081021850 by task init/1
> > [   14.057841][    T1] Pointer tag: [06], memory tag: [fe]
> > [   14.063124][    T1]
> > [   14.065349][    T1] CPU: 2 PID: 1 Comm: init Tainted: G        W   E      6.4.0-mainline-g6a4b67fef3e2 #1
> > [   14.075014][    T1] Hardware name: Thundercomm Dragonboard 845c (DT)
> > [   14.081432][    T1] Call trace:
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.

Hi Mark,

Thanks for your feedback. I'll go ahead and send out a new version of
the patch with a trimmed down commit message.

Thanks,
Isaac
