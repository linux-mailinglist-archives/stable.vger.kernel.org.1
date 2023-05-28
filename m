Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2677139C9
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 15:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjE1N7A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 09:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjE1N7A (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 09:59:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C547BD
        for <stable@vger.kernel.org>; Sun, 28 May 2023 06:58:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D519E60C47
        for <stable@vger.kernel.org>; Sun, 28 May 2023 13:58:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5B4C433D2;
        Sun, 28 May 2023 13:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685282338;
        bh=BG1qeLsBpG6FQ7/85NqOlzw7hJsRohPxu07A+rbLyXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GoNOfjZ5yUyoq7ErfmnM30yV4UQCC15Fi3m4iey24tNO5mZyDZykB0h4GTgBTDZMU
         ImSWiScliu7Yk5eGDk8aW80YYjJu/z+ArKHvTRXxwW3iBiFAiSBjFOmL7Oo/Ukqz3H
         lfVJxM+HDwDNzxSfxSJQNQBDZhVYLTLc0Qe2pksc=
Date:   Sun, 28 May 2023 14:57:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: Fix for hang with newer GPU F/W
Message-ID: <2023052839-landfall-corner-6927@gregkh>
References: <e6601f6e-82eb-c227-3e80-4f73fdf69937@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6601f6e-82eb-c227-3e80-4f73fdf69937@amd.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, May 28, 2023 at 08:52:50AM -0500, Mario Limonciello wrote:
> Hi,
> 
> Can you please add
> 
> 5ee33d905f89 ("drm/amd/amdgpu: limit one queue per gang")
> 
> To 6.1.y and later to fix a hang with Navi3x GPUs?
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2585

Now queued up, thanks.

greg k-h
