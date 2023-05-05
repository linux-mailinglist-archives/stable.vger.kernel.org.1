Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB08D6F7ABE
	for <lists+stable@lfdr.de>; Fri,  5 May 2023 03:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjEEBni (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 4 May 2023 21:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjEEBng (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 4 May 2023 21:43:36 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98805A26B
        for <stable@vger.kernel.org>; Thu,  4 May 2023 18:43:35 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24decf5cc03so906199a91.0
        for <stable@vger.kernel.org>; Thu, 04 May 2023 18:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683251015; x=1685843015;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H7hypnUIygICP+cjWknZimHYa1WmNJLmE2RPntTriZE=;
        b=SRSJR08bxAHAMdoZW4MZSe7iK6mrvIUWXj+xImkjInDeC+BKT5rulIeJRpprEA2A/P
         2wR4vDTEY/NcegpyBO388QGVn2G8aPEfOqdRijuytR9ctglQYCNn0SxDqGCGopDqqSXo
         hfW1BrVWN7aLwmkQjg9Vv+Tp0SFiGAK5EPSCjILMU2AHJqn8YB3qQm+FD1ZoLeQxImCB
         5V+YFmLL1Zs79Wm3ey664ZAd32AgVN8nXQQnXHNM889C0okh23bmeP5qaqOwv5wr/Vo9
         zDPRyCTYFG0G6WXU5KpHLb3XUMOXw4NjQHDNmXaZB0BALFk/ywV9inewGSuuLCDq2tQH
         erqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683251015; x=1685843015;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7hypnUIygICP+cjWknZimHYa1WmNJLmE2RPntTriZE=;
        b=SeeQ1FkQgQiNSbycwHPBRwoncHrJmxievCdklxUGjrcb53qJpaLCygxnsvQRlRIDYc
         wG6nAHsLba8GQsYOUwT4eE4R2KzlJMNUIRlajFYC4uQuCIqou0LDsVAlZRa3k1V1bFLO
         lK+TIlsAH6QagKKwsZufnnig4FqevyciDgNV5KKJV63PxiouQ294cVOhwLb27JHnJxfE
         EagAEbat3aOwATdl7SOFnvXtN6GqnZ+MgijwDg/pzun/xHn659jgVs+CcueX/vIYrDzI
         WZAoz0nIB1WyM0A7Ma4+W8n9gKvDKnkCV1/bBtZM508IlFBaJlMWffmJ7fzoc79FaeDJ
         Cq4g==
X-Gm-Message-State: AC+VfDyLaaG/uVk1HNq4YEMfPsnik7v+YHsZAlMApYSOFRdsfnMLtepP
        uePRyB6HJq+OWhG1aAZrRpO7PEtoH2v6wgDQyZLjYw==
X-Google-Smtp-Source: ACHHUZ4nn6CR7WvpwK2l3gX182OnFajAMv+Tvqu7NWUIZsz4N5QzlPEFmq4YJyzU6CckTRIsxWKcgbDLhrRwAXYlJiI=
X-Received: by 2002:a17:90b:380e:b0:249:748b:a232 with SMTP id
 mq14-20020a17090b380e00b00249748ba232mr3836196pjb.25.1683251014942; Thu, 04
 May 2023 18:43:34 -0700 (PDT)
MIME-Version: 1.0
From:   Jon Pan-Doh <pandoh@google.com>
Date:   Thu, 4 May 2023 18:43:24 -0700
Message-ID: <CAMC_AXUHD=-zRxL-AogoDQTSz31SfmQ7u_eX3J5PVbXy4P86GA@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
To:     Jon Pan-Doh <pandoh@google.com>
Cc:     Sudheer Dantuluri <dantuluris@google.com>,
        Gary Zibrat <gzibrat@google.com>, iommu@lists.linux.dev,
        joro@8bytes.org, linux-kernel@vger.kernel.org, namit@vmware.com,
        robin.murphy@arm.com,
        "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
        will@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Cc'ing stable@vger.kernel.org per Nadav's suggestion.
