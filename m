Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7697DCB87
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjJaLN0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbjJaLNZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:13:25 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE87A6
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:13:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6AA683200A58;
        Tue, 31 Oct 2023 07:13:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 31 Oct 2023 07:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1698750799; x=1698837199; bh=ZU
        vE4/OvuyJI9p7Vd2BV9UP0U4vItjSeE39R7bZC7kU=; b=aYp4OOa7x/o4qzcBME
        l8+MSYFIKxtChuV1CHgiSLwJWVCyWK21/O9Ch9GDY4LOkpSECs+CXeXen2R46qrq
        od9YVBvZzCABMcRfbPIeDeq2ZmUU6cWjBIuO2nIqLkn4tmv16sM01mbFFQO+ClgM
        gsoElk9frCTavf7I6uHH2BHEvaUR19VbYzS4xiEM+FTqfyGjBDTqH36Jj9SK/28I
        IxDd5giqw3DdSEXM10QQFR+CTM70uBqMy9xvZlhR1xeYEdTRhQ6LkioyIpHYOOZ1
        W/qBDIzjVTU6kfztZJVUP7dv4MLOdnskMHHYTZhVr4lR8Xm9ggSM1UbFhVqZmNRX
        mfKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698750799; x=1698837199; bh=ZUvE4/OvuyJI9
        p7Vd2BV9UP0U4vItjSeE39R7bZC7kU=; b=StwgIyulhPvZs6xDH4HAmH+e0uMZ8
        Z9DkKWOpiqq/yrQSARq4d/CKbDhtRitexO07T6u/x5CMW1f1eDdPl1mHur26ZOqZ
        8KvO9GY8KgfmbZIGikYuRrM6tvAU0RPsZfTKj4qIXdP86OXsnwRCRbZJtttTGaoG
        rBCOd9eWH24xEu/x0KeGVfVLeQijp0QNXbNfujhcxVkCiuQGjBbPYRZmiJY0UM+9
        NwhlOATiBJc9qG3RBm7zl8Tzgi1GnvLUI99QLGskgPRX7on4vzyBf7/D/p8bph6a
        2KKmKuS8QLmSn+mfguxLi2WOrqb0nx1q0lZ3f2F8I1ipj25FNk8TwDzsQ==
X-ME-Sender: <xms:T-FAZWOzpaWugFY0EC2Dp4RBbGNbMCxa8jP_i87JKuT9lCxcg2ckhA>
    <xme:T-FAZU9v8ud0tDPqi9W9pFmd6CM_o8ZoQxZss0aYotGbhSxgHRB0VZ6HQvrhqpbcQ
    ni16KpcIwBkCg>
X-ME-Received: <xmr:T-FAZdS2bqhpwGoomHyfLJDNB6-r1hBl16eLwYwrAI2jMSQfn1GGb-cYC3qyFYwjGs3shl4Ox9AOka4A9rXxdrPlSBvtIKh9bhwcNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtvddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepleeite
    evieefteelfeehveegvdetveehgffhvdejffdvleevhfffgeffffejlefgnecuffhomhgr
    ihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:T-FAZWu8udcEk0Mn2cZlq5BxKr-p7SvaEwhfJAKZOnKOJJObqffphQ>
    <xmx:T-FAZecfRXKUWWmb8d7s9gM0Z8sXyWWSl9vxeX3du1PZJYmYOwyacw>
    <xmx:T-FAZa278v27x4XgricXQQcGtjANQIiV2N3-pMQ_OxpulBxxcUcwZg>
    <xmx:T-FAZWS3wm6d7zjd6G7G_-jXwl13elhZhb05_eigjQzAIeZRV5Lqqw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 07:13:18 -0400 (EDT)
Date:   Tue, 31 Oct 2023 12:13:16 +0100
From:   Greg KH <greg@kroah.com>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     stable@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>,
        Manasi Navare <navaremanasi@chromium.org>
Subject: Re: [PATCH 5.4.y] drm/dp_mst: Fix NULL deref in
 get_mst_branch_device_by_guid_helper()
Message-ID: <2023103108-breeching-grumpily-302a@gregkh>
References: <2023102723-steerable-trench-2f00@gregkh>
 <20231030112904.142092-1-lma@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030112904.142092-1-lma@semihalf.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 30, 2023 at 12:29:04PM +0100, Lukasz Majczak wrote:
> As drm_dp_get_mst_branch_device_by_guid() is called from
> drm_dp_get_mst_branch_device_by_guid(), mstb parameter has to be checked,
> otherwise NULL dereference may occur in the call to
> the memcpy() and cause following:
> 
> [12579.365869] BUG: kernel NULL pointer dereference, address: 0000000000000049
> [12579.365878] #PF: supervisor read access in kernel mode
> [12579.365880] #PF: error_code(0x0000) - not-present page
> [12579.365882] PGD 0 P4D 0
> [12579.365887] Oops: 0000 [#1] PREEMPT SMP NOPTI
> ...
> [12579.365895] Workqueue: events_long drm_dp_mst_up_req_work
> [12579.365899] RIP: 0010:memcmp+0xb/0x29
> [12579.365921] Call Trace:
> [12579.365927] get_mst_branch_device_by_guid_helper+0x22/0x64
> [12579.365930] drm_dp_mst_up_req_work+0x137/0x416
> [12579.365933] process_one_work+0x1d0/0x419
> [12579.365935] worker_thread+0x11a/0x289
> [12579.365938] kthread+0x13e/0x14f
> [12579.365941] ? process_one_work+0x419/0x419
> [12579.365943] ? kthread_blkcg+0x31/0x31
> [12579.365946] ret_from_fork+0x1f/0x30
> 
> As get_mst_branch_device_by_guid_helper() is recursive, moving condition
> to the first line allow to remove a similar one for step over of NULL elements
> inside a loop.
> 
> Fixes: 5e93b8208d3c ("drm/dp/mst: move GUID storage from mgr, port to only mst branch")
> Cc: <stable@vger.kernel.org> # 4.14+
> Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> Reviewed-by: Radoslaw Biernacki <rad@chromium.org>
> Signed-off-by: Manasi Navare <navaremanasi@chromium.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20230922063410.23626-1-lma@semihalf.com
> (cherry picked from commit 3d887d512494d678b17c57b835c32f4e48d34f26)
> Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

All now queued up, thanks.

greg k-h
