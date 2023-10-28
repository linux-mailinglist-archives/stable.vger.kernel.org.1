Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3201B7DA7B7
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 17:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjJ1PR4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 28 Oct 2023 11:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1PRz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 28 Oct 2023 11:17:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07984C0
        for <stable@vger.kernel.org>; Sat, 28 Oct 2023 08:17:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4F8C433C8;
        Sat, 28 Oct 2023 15:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698506273;
        bh=Mq2VerxFhJkRrFwBZBtCI/dBUvnwNl8iuUPDdwxZDJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VLW34GsNcojQtx8Q5mNPx3sVfNe0YlOcQqVdHfJvXAbZonrLcQWqFkjc6VGOHxlMW
         YLe2f+QA+sObWByIDxHjRxFId2OhygPavLVDzxRCdyOuO43aMPIlQW1OaaDHnHsj/i
         A6DlAHm05dJHRoaM83p3DsdPWz8husEwsBYdAvwnw1JrRjRLGO7Ux9bKtRus4aeRma
         Q0U9m2RcFJXBEba+Ua61xvI2L0vB37Us52vuuwitEnQv0/xBLnrF9+6UpJE2+AeElp
         SI7dL/UgYZ597dnAL4SMyFPK63ODIU8RyS3H9UU33z1PBYI+w2S0izEqsPtyFgIbbm
         WpYhDMcT5rl1w==
Date:   Sat, 28 Oct 2023 11:17:52 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     gregkh@linuxfoundation.org, krisman@suse.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/fdinfo: lock SQ thread while
 retrieving thread" failed to apply to 6.1-stable tree
Message-ID: <ZT0mIG77a3389A6C@sashalap>
References: <2023102835-margarine-credibly-e8ca@gregkh>
 <5223b572-03a1-4e04-93ea-da4c2ed4d597@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5223b572-03a1-4e04-93ea-da4c2ed4d597@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Oct 28, 2023 at 07:32:30AM -0600, Jens Axboe wrote:
>On 10/28/23 1:27 AM, gregkh@linuxfoundation.org wrote:
>>
>> The patch below does not apply to the 6.1-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>
>This one applies to both 6.1 and 6.5-stable.

Queued up, thanks!

-- 
Thanks,
Sasha
