Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F528750F2B
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 19:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjGLRCN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 13:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjGLRCI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 13:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFC1121
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689181271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V34PBFVRSyPmXY6TnLemmwcb7RItdmjHqC9gKS1fTBo=;
        b=NnanpdSBUh1mtat2L7ppYBdEye5ecCqd9kBB3W67szFh+17WynQeBVeKR+bGfp5PKvy8T+
        3Z7avzta/P2FhMQmlM5oK/JJmxi9bhSZSIcohfMzf1gBgzSAzgo0HOBPBtfmQ31PN8bXN1
        BSeyARncNnpEnlL/PdU4VbTYV79WqlI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-WmT8Mv_IMLSmHE9d3-o1nQ-1; Wed, 12 Jul 2023 13:00:11 -0400
X-MC-Unique: WmT8Mv_IMLSmHE9d3-o1nQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7623a751435so690374385a.2
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 10:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181208; x=1691773208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V34PBFVRSyPmXY6TnLemmwcb7RItdmjHqC9gKS1fTBo=;
        b=cgGBHXjy76hQp9dqR9vO9gcoD9e+kJ3OB+/SOoELpgfRJFZORPPqfDKAjpo8sFgxBc
         eduVzk4MTf/04akud8XefeyuhseB4MZJPFUFH4E1iutWuE0tF5rHyt2Idj+B3AEmIXex
         N9W8yYFRUzIAs1lbKQp2Kl9m0UN2q02rPj25TC3PHyDQeyCxuM31CRqQyWrMBrVdXWtp
         qkb+xwJAKghAAkO0d0oUlvGLNRs9V0mhHGs4/ttHx40IactxYQrywr4zR5coKvcLuo+L
         gwcR/UPeL+g8vvrfMnq1Xd7YrjX1njFdw38q22Y227aLkDBGuIgGXHYeLcpXY+5c3G9V
         Xuqg==
X-Gm-Message-State: ABy/qLaP6cv0cB3+GkAQS9WyyKS1k651cretXeP4NMQL55Dz3QbMDEGw
        Zk6zVfAbr2HVb1ZA4Uw/xRSeNuP4zGjAx5zLFEh90036yAlDkEnrC/Kl7x+oE1SQpu5krV3nJF5
        Pn6PUFhiwC/zODlvH
X-Received: by 2002:a05:620a:318f:b0:765:4418:cac7 with SMTP id bi15-20020a05620a318f00b007654418cac7mr18968023qkb.73.1689181208072;
        Wed, 12 Jul 2023 10:00:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGfbsBm1Dqr0aQLF1S4fgHLvR9TbsCSLLXCvHTFTZHyd5eS5VdOP6vDZI4492sbHtDleRsIrg==
X-Received: by 2002:a05:620a:318f:b0:765:4418:cac7 with SMTP id bi15-20020a05620a318f00b007654418cac7mr18967998qkb.73.1689181207795;
        Wed, 12 Jul 2023 10:00:07 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id w18-20020a0cb552000000b0063004b5482csm2342328qvd.92.2023.07.12.10.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 10:00:07 -0700 (PDT)
Date:   Wed, 12 Jul 2023 10:00:05 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christian Hesse <mail@eworm.de>, linux-integrity@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>, stable@vger.kernel.org,
        roubro1991@gmail.com
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
Message-ID: <qvt4ndqc23ftspjtpljyv45yfhtxi6oomjios2nuk34bs7n5fi@2ye4znwhgn4a>
References: <20230710133836.4367-1-mail@eworm.de>
 <20230710142916.18162-1-mail@eworm.de>
 <ZKxHfTkgKHYqhBz2@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKxHfTkgKHYqhBz2@ziepe.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 10, 2023 at 03:01:33PM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 10, 2023 at 04:28:43PM +0200, Christian Hesse wrote:
> > This device suffer an irq storm, so add it in tpm_tis_dmi_table to
> > force polling.
> 
> I can't help but feel like we are doing something wrong in the Linux
> driver that we keep having IRQ problems.
> 
> Surely Windows uses the IRQ on these devices? How does it work
> reliably there?
> 
> Jason

I worry about it as well, especially as more vendors get added to the
list. On the other hand it seems like every 6-12 months I am
interacting with vendors that repeatedly forget to have reserved
memory regions added to IVRS and DMAR tables for devices that need
them. So I guess it is possible for the problem to be on their end as
well. For at least one case that someone looked at back in May, it
looked like he could see the issue looking at a schematic for the
system.

Regards,
Jerry

