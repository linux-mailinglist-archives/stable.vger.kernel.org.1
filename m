Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA49377FB76
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 18:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346695AbjHQQGt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 12:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353466AbjHQQGV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 12:06:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6BB3598
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 09:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9E38646D7
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 16:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA41BC433C8;
        Thu, 17 Aug 2023 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692288373;
        bh=EU02RGNDiz3LcwWOBJtwRGvFH/kW5Pm24riFUd/WV18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIZCIMBzWUQEQxVaQUQsNpmqD48LN0TRIUZ8YAqlte5c/2hbS7oBrWj87n8n/NSzX
         z+Q0zDvVtXH8d/2jw4lh0XRIRTjv6y1PwdTKq2f7DMo+0HObWeCqiIgT30TbmBmnyS
         U1Qo4gvkci/lxawFKMQI3DKPl2BJetmqJtXNMiZQ=
Date:   Thu, 17 Aug 2023 18:06:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Ofitserov <oficerovas@altlinux.org>
Cc:     stable@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RESEND 0/3] Add support for Intel Alder Lake PCH
Message-ID: <2023081713-galvanize-enroll-39eb@gregkh>
References: <20230817134336.965020-1-oficerovas@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817134336.965020-1-oficerovas@altlinux.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 17, 2023 at 04:43:33PM +0300, Alexander Ofitserov wrote:
> This patch series enables support of i2c bus for Intel Alder Lake PCH-P and PCH-M
> on kernel version 5.10. These patches add ID's of Alder lake platform in these
> drivers: i801, intel-lpss, pinctrl. ID's were taken from linux kernel version 5.15.
> 
> Alexander Ofitserov (3):
>   i2c: i801: Add support for Intel Alder Lake PCH
>   mfd: intel-lpss: Add Alder Lake's PCI devices IDs
>   pinctrl: tigerlake: Add Alder Lake-P ACPI ID
> 
>  drivers/i2c/busses/i2c-i801.c             |  8 +++++
>  drivers/mfd/intel-lpss-pci.c              | 41 +++++++++++++++++++++++
>  drivers/pinctrl/intel/pinctrl-tigerlake.c |  1 +
>  3 files changed, 50 insertions(+)
> 
> -- 
> 2.33.8
> 

Have you read the kernel documentation for how to submit patches here?

I thought my bot sent this in the past, if not, here it is again:

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

Is there something in that document that describes the format of what
you submitted here?

thanks,

greg k-h
