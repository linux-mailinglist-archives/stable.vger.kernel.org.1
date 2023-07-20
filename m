Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0EF75B686
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 20:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGTSVI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 14:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGTSVH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 14:21:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E14E6F
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 11:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B051661BA6
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 18:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C241DC433C7;
        Thu, 20 Jul 2023 18:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689877266;
        bh=MNMqKRo+Y/GV+TSJI8Mt23DGfH6LtqdWAD4hNOiF6ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wOP283YMsRMJ5YVaeMDS6hQY3Nw9FG1qvw2UMMvkUL8mdhAKoTdhhl5VabtaWU4rP
         de2mg7ppPT+2cV5x2onO4eTM9DxuvPkBzmB5ppg39empUBl1SvbizW7gei3FNbhObK
         WYY/sP+tDrKFWXWLDq7dQW0XUicnRxtu6fzx9nSw=
Date:   Thu, 20 Jul 2023 20:21:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stefan Ghinea <stefan.ghinea@windriver.com>
Cc:     stable@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 6.3 1/1] f2fs: fix to avoid NULL pointer dereference
 f2fs_write_end_io()
Message-ID: <2023072048-unjustly-stagnate-85de@gregkh>
References: <20230719190944.15238-1-stefan.ghinea@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719190944.15238-1-stefan.ghinea@windriver.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 19, 2023 at 10:09:44PM +0300, Stefan Ghinea wrote:
> From: Chao Yu <chao@kernel.org>
> 
> commit d8189834d4348ae608083e1f1f53792cfcc2a9bc upstream

6.3.y is long end-of-life, sorry.
