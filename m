Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335D675EB7F
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 08:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjGXG3Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 02:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjGXG3Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 02:29:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541F0E3
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 23:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEBAF60F36
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 06:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B91C433C7;
        Mon, 24 Jul 2023 06:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690180162;
        bh=vrrxxiz9rWvNsJjvprmYaQ3mw0GQdLXoDFiZQGvqno4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KAyz+p2NKXtKIdiP0nczabO7P5nD25K7U587u53ORHQXmsNb2SLag8u59fixwitp5
         ZWMGq08DOmekAbjBBt/+Foxj/8GfpVVAf19qE9KTdCTYDoEmsG9V82QIl+m94T7ZtH
         tDAh2XlksiPx0ejULLh7saJBhV6OBwqzlmEmgw2M=
Date:   Mon, 24 Jul 2023 08:29:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yunxiang Li <Yunxiang.Li@amd.com>
Cc:     stable@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 6.4.y] drm/ttm: fix bulk_move corruption when adding a
 entry
Message-ID: <2023072420-dangle-liftoff-c1ce@gregkh>
References: <2023072146-sports-deluge-22a1@gregkh>
 <20230724004330.1320-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230724004330.1320-1-Yunxiang.Li@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 23, 2023 at 08:43:26PM -0400, Yunxiang Li wrote:
> When the resource is the first in the bulk_move range, adding it again
> (thus moving it to the tail) will corrupt the list since the first
> pointer is not moved. This eventually lead to null pointer deref in
> ttm_lru_bulk_move_del()
> 
> Fixes: fee2ede15542 ("drm/ttm: rework bulk move handling v5")
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> CC: stable@vger.kernel.org
> Link: https://patchwork.freedesktop.org/patch/msgid/20230622141902.28718-3-Yunxiang.Li@amd.com
> Signed-off-by: Christian König <christian.koenig@amd.com>
> (cherry picked from commit 4481913607e58196c48a4fef5e6f45350684ec3c)
> ---
>  drivers/gpu/drm/ttm/ttm_resource.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Both now queued up, thanks.

greg k-h
