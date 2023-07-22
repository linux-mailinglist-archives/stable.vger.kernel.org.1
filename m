Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7CA75DBFE
	for <lists+stable@lfdr.de>; Sat, 22 Jul 2023 13:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjGVLs5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 22 Jul 2023 07:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVLs4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 22 Jul 2023 07:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0512D45
        for <stable@vger.kernel.org>; Sat, 22 Jul 2023 04:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8A1660909
        for <stable@vger.kernel.org>; Sat, 22 Jul 2023 11:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4556C433C8;
        Sat, 22 Jul 2023 11:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690026535;
        bh=gJqemBGWK0BoAX8LvLIei9JR3+tPS1LiLG2EAd+C4Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTjSph3JdBK/BV+k7S2fAgIIHVVDpiFVnllXTVPTlXj/a6zPOQ5Utj5VcO75b3PYA
         wo+VMRDUpLyYL2fqUUGFORW4A5NNJ0rtOg8T7djmXYNt8OULanwTk2in+/+xNJE7Bu
         FThbUKm/qPxmv4xRDrgfk/GWYrUSrhr/iJiduuIE=
Date:   Sat, 22 Jul 2023 13:48:52 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: FAILED: patch "[PATCH] drm/ttm: fix bulk_move corruption when
 adding a entry" failed to apply to 6.4-stable tree
Message-ID: <2023072217-unplanted-disburse-9999@gregkh>
References: <2023072146-sports-deluge-22a1@gregkh>
 <BL0PR12MB2532C071AA71F63C61113B42ED3FA@BL0PR12MB2532.namprd12.prod.outlook.com>
 <2023072136-laurel-tightwad-9492@gregkh>
 <BL0PR12MB253239BEB59D9B2DBB6B47B1ED3FA@BL0PR12MB2532.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR12MB253239BEB59D9B2DBB6B47B1ED3FA@BL0PR12MB2532.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 21, 2023 at 08:01:23PM +0000, Li, Yunxiang (Teddy) wrote:
> [Public]
> 
> Found the issue, this commit is also needed, commit 0c3855ba8dad41c4113e73f77eb926e44577e4af ("drm/ttm: fix warning that we shouldn't mix && and ||")

I have no reference as to what you are talking about here, sorry.

Please submit the needed commits for us to apply to stable trees in full
detail, otherwise we just get confused.

thanks,

greg k-h
