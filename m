Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902AD7A7A09
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjITLHg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjITLHf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:07:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEA6CF
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:07:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C44C433C8;
        Wed, 20 Sep 2023 11:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695208049;
        bh=B5rZnsC5/y5roLTKyUT3i4ghLDLTwZv3pSus0JihLdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5djudNFH9HlHbfMTgDbo7qf//+GWrNETB9aCshw7Z8dotCim87lbkgOn7ZeK2O2Z
         tczcYK4mH2VkrDZ9q/sscj+VzOfOqKeQms1W86RUL9PaxcxsM5ZPaBMwTnQd1NM6D8
         Kc+tO6ck3cCCefY4cDHI33u6u2xTnftRxTQx5DvU=
Date:   Wed, 20 Sep 2023 13:07:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     stable@vger.kernel.org, sec@valis.email,
        Bing-Jhong Billy Jheng <billy@starlabs.sg>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Victor Nogueira <victor@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        M A Ramdhan <ramdhan@starlabs.sg>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATH 4.14.y] net/sched: cls_fw: No longer copy tcf_result on
 update to avoid use-after-free
Message-ID: <2023092017-action-sly-90dd@gregkh>
References: <20230918180859.24397-1-luizcap@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918180859.24397-1-luizcap@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 18, 2023 at 06:08:59PM +0000, Luiz Capitulino wrote:
> From: valis <sec@valis.email>
> 
> Commit 76e42ae831991c828cffa8c37736ebfb831ad5ec upstream.
> 
> [ Fixed small conflict as 'fnew->ifindex' assignment is not protected by
>   CONFIG_NET_CLS_IND on upstream since a51486266c3 ]

Now queued up, thanks.

greg k-h
