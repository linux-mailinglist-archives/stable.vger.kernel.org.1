Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081637905C7
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 09:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjIBHaJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 03:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242831AbjIBHaI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 03:30:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878681709
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 00:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25293B8275D
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 07:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E078C433C8;
        Sat,  2 Sep 2023 07:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693639801;
        bh=M7Mg6dQQESUu3rXdE1alsQpkTDe58Vz2TM0UK3q4X+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVQVqJTQRoh4Osw/cGtNJEzcpZYY5QWuSrjC16G90dQYQHJtnUOP47RpFNO1PJoMr
         StE509RpScGWwFZ8APJ7eqe9tW22cN7ipvsSaNi340ARYtobbZpPWH9KzLnyD5UouQ
         I8XQnL8fRUfEglidbe1or0kXRrUZi4Iv6knaiEGw=
Date:   Sat, 2 Sep 2023 09:29:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: amdgpu segfault on 6.5 while playing VP9
Message-ID: <2023090250-tinker-quirk-c904@gregkh>
References: <c7953970-6faf-4bd5-88f1-13d545a0e905@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7953970-6faf-4bd5-88f1-13d545a0e905@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 31, 2023 at 01:57:56PM -0500, Mario Limonciello wrote:
> Hi,
> 
> A segfault is reported while using hardware offload for playing VP9 videos
> on kernel 6.5.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2822
> 
> This is fixed by this commit:
> 
> 6f38bdb86a05 ("drm/amdgpu: correct vmhub index in GMC v10/11")
> 
> Can you please backport it to 6.5.y?

Now queued up, thanks.

greg k-h
