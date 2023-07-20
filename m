Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656B475B04B
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 15:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGTNnj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 09:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjGTNnh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 09:43:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41373198D
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB07761AF8
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 13:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB368C433C7
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689860615;
        bh=qFTIlNRQeD8IFZaxJlnWydEilGmNQeUdwZWlC1cmnlc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=aQ/2M4w6rPEtyCO1OsZRi65YrCEJiroomacDuR2o4Eg2gRmhZSd8cX5fpWvJhnbMq
         RWGqiZbGtGQ2Qevv/Rj4CNBPGlqMhgjpUeGviTVX8Am6Yz8FQd1dF5Wxu1kxCxPiAi
         D91BlDkLaRFF/e5/iD4S+C1/JuWY8S6ISWf+3F7IbTuym0XtnDAtbex4WVU7dBE1Iu
         RabLIJwOp709j+YSSOiIPv4xFfSlWEb6cfdshmM+9kFK4iCe2w2llZaoqgJWiV5PxA
         pT81wZwJz53+AhjirGg6VGpQyaWaXonLw6s/xtHoYr3RmLXZQwEwZsVtjtiMAb4EsD
         lni3NMBaF5grA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5661eb57452so520183eaf.2
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:43:34 -0700 (PDT)
X-Gm-Message-State: ABy/qLY/jX/zOrnUEkoKBFQ4k9u5s27Iv1QyK68G14Kj+qLSSERU+IaR
        hHomZkBk7Bmi6i296ahR9ucS25+v43hsySsPhkM=
X-Google-Smtp-Source: APBJJlEpv6AUnTPkhPZSsa2pzncVNJXiXjc7ybQJHbrQOeTez08LaUSbTCybtZdyxZYtEy5RloKUuxDzZDfbiDJJO6U=
X-Received: by 2002:a4a:3712:0:b0:566:f3f1:5f5c with SMTP id
 r18-20020a4a3712000000b00566f3f15f5cmr2162489oor.9.1689860613935; Thu, 20 Jul
 2023 06:43:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:53c4:0:b0:4e8:f6ff:2aab with HTTP; Thu, 20 Jul 2023
 06:43:33 -0700 (PDT)
In-Reply-To: <20230720132336.7614-6-linkinjeon@kernel.org>
References: <20230720132336.7614-1-linkinjeon@kernel.org> <20230720132336.7614-6-linkinjeon@kernel.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 20 Jul 2023 22:43:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_kL8H4JF=cALcGcZvEuYH3V6ehvXLHWyoQNMGwzLwy3A@mail.gmail.com>
Message-ID: <CAKYAXd_kL8H4JF=cALcGcZvEuYH3V6ehvXLHWyoQNMGwzLwy3A@mail.gmail.com>
Subject: Re: [5.15.y PATCH 0/4] ksmbd: ZDI Vulnerability patches for 5.15.y
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stfrench@microsoft.com,
        smfrench@gmail.com, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

2023-07-20 22:23 GMT+09:00, Namjae Jeon <linkinjeon@kernel.org>:
> These are ZDI Vulnerability patches that was not applied in linux 5.15
> stable kernel.
Note that same patch sent twice...
>
> Namjae Jeon (4):
>   ksmbd: use ksmbd_req_buf_next() in ksmbd_smb2_check_message()
>   ksmbd: validate command payload size
>   ksmbd: fix out-of-bound read in smb2_write
>   ksmbd: validate session id and tree id in the compound request
>
>  fs/ksmbd/server.c   | 33 ++++++++++++++++++++-------------
>  fs/ksmbd/smb2misc.c | 38 ++++++++++++++++++++------------------
>  fs/ksmbd/smb2pdu.c  | 44 +++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 79 insertions(+), 36 deletions(-)
>
> --
> 2.25.1
>
>
