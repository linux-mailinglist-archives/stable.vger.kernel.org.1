Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A5E74DCF0
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjGJSBl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 14:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjGJSBh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 14:01:37 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74C5128
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 11:01:35 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-403b30c7377so4994721cf.1
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689012095; x=1691604095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2mAb04uNq1AMHQNpvPDDERYq9CZGbl5fsMiRCnuOFIc=;
        b=opD2DNKdWmu40noOfYNxRV4vxH/LowhkkIXvYL/dihAlv4F11HxG7tOWywntDBxZ51
         2HDCJpZ21XWmTjZNwugv5QczXc5JB0afrOBWEcZ/pAR8EV26t24abxWu9xZ4Jyn6jZ1x
         67hLvzElobdKg24WLx4oLO+VEWJtIqai4XBUWRcl4pq8J7KDCHrHvpfYDdEsjQ3jyIMN
         d2uCQzkX4Ymufmya/IcVahFgcem1U7DUU/JwXgzemx1FLt0BY8QMlSJeYYZqZtO6uLB/
         YdLmBZQqWf2AH/JWPSi8FMPPUJtyZEhNxkjMHxdI9UaXV4v7fj+9N1sheO9LlQb08bvV
         +/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012095; x=1691604095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mAb04uNq1AMHQNpvPDDERYq9CZGbl5fsMiRCnuOFIc=;
        b=O3AOBt8MZ45ZlbIDajkPEwz/8RDpbGLP2ibLuXJD+WS0fm4ksS6orKP6lU5MdE1n7u
         5IWg9qlmYkKuLihSPSgiAK50qkuk487JLXFJs2TOcgnIjqWgYR1vQ3RGZkJf0IS9PLPP
         w7dVoCtr+qtkR8ANG4My+9XvCFUMpUycDoNdEHKiDYFDWX7nmnbbgtnsbDpYBH8/ArRw
         OGH/36u2YnpcC6OX9K+bCkK5Ojeg3+gLgsAdcoNewJF8bonG3+90cc6kvotROAewxr2m
         PQZFdJjUNvWiX7mVERzAiInRyTLIEOZ202m4PlR7D2+3oO0/h3ltW77aya8QgLvcr5AK
         z1Xw==
X-Gm-Message-State: ABy/qLagPl3gMoIqOzosLF9ZMdlrk8vnNRL3JyqiiaV/ZZFrTYi23wQ/
        raotSvFKySmwX22Ibkd4D1OmFA==
X-Google-Smtp-Source: APBJJlFNIJ0STG/YX8tdMDnIoyf46UgtWo9nXXVxz3w2y7YTJeLvp5i08w3/IHh/aX3saMFV/M2A6A==
X-Received: by 2002:a05:622a:148b:b0:401:ec6d:3870 with SMTP id t11-20020a05622a148b00b00401ec6d3870mr15990391qtx.11.1689012095010;
        Mon, 10 Jul 2023 11:01:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id f7-20020ac84647000000b003e4d9c91106sm145530qto.57.2023.07.10.11.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:01:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qIvCX-0004TE-RP;
        Mon, 10 Jul 2023 15:01:33 -0300
Date:   Mon, 10 Jul 2023 15:01:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christian Hesse <mail@eworm.de>
Cc:     linux-integrity@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>, stable@vger.kernel.org,
        roubro1991@gmail.com
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
Message-ID: <ZKxHfTkgKHYqhBz2@ziepe.ca>
References: <20230710133836.4367-1-mail@eworm.de>
 <20230710142916.18162-1-mail@eworm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710142916.18162-1-mail@eworm.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 10, 2023 at 04:28:43PM +0200, Christian Hesse wrote:
> This device suffer an irq storm, so add it in tpm_tis_dmi_table to
> force polling.

I can't help but feel like we are doing something wrong in the Linux
driver that we keep having IRQ problems.

Surely Windows uses the IRQ on these devices? How does it work
reliably there?

Jason
