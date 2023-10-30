Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD687DB323
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 07:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjJ3GQk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 02:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjJ3GQj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 02:16:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F76A9
        for <stable@vger.kernel.org>; Sun, 29 Oct 2023 23:16:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF58C433C8;
        Mon, 30 Oct 2023 06:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698646596;
        bh=9N4Ow9AN16LvhAK4dg7DN4N94Imcak0ll712nhz3VTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rrD0/rdQdT1K0WJFc2zkmFQrwb6goBDBsDEkwEhPr/YdC6eJhq5rCUz9HU4gELuT1
         O3xcJSsAEoxLqD6HacAUegu3b4PXA/J+PDAlmts35HTo0XU/zxePvcrgMfGjNqVUXr
         uZTcAVuumYhCSmTkdFGOCtNwhxmmO2PNK+EeEpws=
Date:   Mon, 30 Oct 2023 07:16:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Lazar <dlazar@gmail.com>
Cc:     stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH] platform/x86: Add s2idle quirk for more Lenovo laptops
Message-ID: <2023103019-evict-brutishly-5c7e@gregkh>
References: <ZT6idniuWk88GxOm@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT6idniuWk88GxOm@localhost>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Oct 29, 2023 at 07:20:38PM +0100, David Lazar wrote:
> commit 3bde7ec13c971445faade32172cb0b4370b841d9 upstream.
> 
> When suspending to idle and resuming on some Lenovo laptops using the
> Mendocino APU, multiple NVME IOMMU page faults occur, showing up in
> dmesg as repeated errors:
> 
> nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000b
> address=0xb6674000 flags=0x0000]
> 
> The system is unstable afterwards.
> 
> Applying the s2idle quirk introduced by commit 455cd867b85b ("platform/x86:
> thinkpad_acpi: Add a s2idle resume quirk for a number of laptops")
> allows these systems to work with the IOMMU enabled and s2idle
> resume to work.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218024
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: David Lazar <dlazar@gmail.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Link: https://lore.kernel.org/r/ZTlsyOaFucF2pWrL@localhost
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/amd/pmc/pmc-quirks.c | 73 +++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)

What stable kernel(s) are you wanting this applied to?

thanks,

greg k-h
