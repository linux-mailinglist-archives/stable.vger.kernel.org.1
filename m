Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6013775E4D7
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 22:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjGWUbQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 16:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWUbP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 16:31:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F22A1B8
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 13:31:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B130C60E98
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 20:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED24C433C7;
        Sun, 23 Jul 2023 20:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690144274;
        bh=f8J/0MeEhg+4cJj4yCTE+9u19EgyTbNq8rUsvnrBboM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADJMaBKAHuwjbWfeFsuDIhGhoob5ECYxLOALVoxZfUcKOTsbnNv05uEINAf5eQxuJ
         0y+0JUJBP1TGyXp5ZCYGMzjfRV56tH6b/5NMYX7iHoQOJ0LEHzIfVPqP6dQ2ulE1KI
         mXSaBurONMFvFYIt4+ESn9Cc0+DdbTIYPdEQYkOc=
Date:   Sun, 23 Jul 2023 22:31:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: Build error in v5.4.y-queue
Message-ID: <2023072359-bovine-serve-097d@gregkh>
References: <b54030b3-9cb2-5c31-cc3f-45a4ac8f41f9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b54030b3-9cb2-5c31-cc3f-45a4ac8f41f9@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jul 22, 2023 at 08:35:23AM -0700, Guenter Roeck wrote:
> Seen in arm:allmodconfig and arm64:allmodconfig builds with v5.4.249-278-g78f9a3d1c959.
> 
> sound/soc/mediatek/mt8173/mt8173-afe-pcm.c: In function 'mt8173_afe_pcm_dev_probe':
> sound/soc/mediatek/mt8173/mt8173-afe-pcm.c:1159:17: error: label 'err_cleanup_components' used but not defined

Thanks for letting me know, the offending patch is now dropped.

greg k-h
