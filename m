Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7C37DCB60
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbjJaLFY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjJaLFY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:05:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D26A6
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:05:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63917C433C7;
        Tue, 31 Oct 2023 11:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698750321;
        bh=LO2q8fnynVhnYCAq+Dkp2dVkYJTkgP+TsTKmiwRu1pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqxE/if+6BRCT9xfziTuD5g6p7pICUqISinwvDI2f4kRyHc4MeV0Z1co9PjVyBsJI
         6uz7I6Ulve1OPzkhNr23jgyltPXM0NTbV+xCF7vh+fbq3g0eU2Dfp8N31yXbyXIme/
         ddGxYWKGvWikZ9Yija+UnWuRd8if03CUfTfL0QYQ=
Date:   Tue, 31 Oct 2023 12:05:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     David Lazar <dlazar@gmail.com>, stable@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH 6.1.y] platform/x86: Add s2idle quirk for more Lenovo
 laptops
Message-ID: <2023103108-transpire-implosive-a7b2@gregkh>
References: <ZUAcHzdwjpXA8VSq@localhost>
 <bb006649-bdf0-4dbf-bab6-45b06ecfdb10@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb006649-bdf0-4dbf-bab6-45b06ecfdb10@amd.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 30, 2023 at 04:29:53PM -0500, Mario Limonciello wrote:
> On 10/30/2023 16:11, David Lazar wrote:
> > commit 3bde7ec13c971445faade32172cb0b4370b841d9 upstream.
> > 
> > When suspending to idle and resuming on some Lenovo laptops using the
> > Mendocino APU, multiple NVME IOMMU page faults occur, showing up in
> > dmesg as repeated errors:
> > 
> > nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000b
> > address=0xb6674000 flags=0x0000]
> > 
> > The system is unstable afterwards.
> > 
> > Applying the s2idle quirk introduced by commit 455cd867b85b ("platform/x86:
> > thinkpad_acpi: Add a s2idle resume quirk for a number of laptops")
> > allows these systems to work with the IOMMU enabled and s2idle
> > resume to work.
> > 
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218024
> > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > Signed-off-by: David Lazar <dlazar@gmail.com>
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > Link: https://lore.kernel.org/r/ZTlsyOaFucF2pWrL@localhost
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> 
> As this is changed from the original commit in 6.6, you should add what you
> changed in why below the commit.  Something like:
> 
> Moved quirks into drivers/platform/x86/thinkpad_acpi.c since kernel 6.1
> doesn't include the refactor that moved it to AMD PMC driver.

No need, I can take this as-is.

thanks,

greg k-h
