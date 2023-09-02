Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D808B7905B6
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 09:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjIBH1G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 03:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIBH1F (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 03:27:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC62710F6
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 00:26:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 772F160F0C
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 07:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80680C433C8;
        Sat,  2 Sep 2023 07:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693639618;
        bh=9YxqPB+zA7T5LiVh19ui6shMCjU9lXTi42EmQRID5so=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeNE9RUScMZ8h/Ho2K0zdduaM0iKANUfp9x0SKI83jLl5GRwneBlKxD5MW30vljml
         qM89iW/MTCxd35cEY3jb6YYQf1PN4xhW3O/bUxnEgmKV0+ryfZbHWjaG7C2uJeqw8n
         NOMCR5GcYkexmByqAueas9Qg+KZT+WGn5vqJ0Ovk=
Date:   Sat, 2 Sep 2023 09:26:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     stable@vger.kernel.org, sashal@kernel.org,
        Lang Yu <Lang.Yu@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: correct vmhub index in GMC v10/11
Message-ID: <2023090249-lethargic-passerby-b529@gregkh>
References: <20230901193835.3846059-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901193835.3846059-1-alexander.deucher@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 01, 2023 at 03:38:35PM -0400, Alex Deucher wrote:
> From: Lang Yu <Lang.Yu@amd.com>
> 
> Align with new vmhub definition.
> 
> v2: use client_id == VMC to decide vmhub(Hawking)
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2822
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 6f38bdb86a056707b9ecb09e3b44adedc8e8d8a0)
> Cc: stable@vger.kernel.org # 6.5.x
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 

Now queued up, thanks.

greg k-h
