Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB0C74BD53
	for <lists+stable@lfdr.de>; Sat,  8 Jul 2023 13:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGHLMg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 8 Jul 2023 07:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjGHLMf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 8 Jul 2023 07:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3FF1992
        for <stable@vger.kernel.org>; Sat,  8 Jul 2023 04:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE9B60B72
        for <stable@vger.kernel.org>; Sat,  8 Jul 2023 11:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26183C433C8;
        Sat,  8 Jul 2023 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688814753;
        bh=M5/LEqXA/TazMDVdyWGnW22VUojdRm4jP29vfqwqPHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xEXxnCi52YP4Nz6otLiS3NKVP8UZp1hxeeUTs8fRvXrJLW8IYZ4LWMI/7YErGBdXU
         5AxEpId7o6Ibq8D+Y9ujvyC2MGkohhUb72rqb7ZV3mPR0AVBQEhOsg9o7Q4hYIMhdE
         MiV5OOZ51wd5KaqR1qrpWVnAM5YdMjAF2KpBJbB0=
Date:   Sat, 8 Jul 2023 13:12:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZGo6YC45p6X?= <ylzhou@whu.edu.cn>
Cc:     stable@vger.kernel.org
Subject: Re: A linux kernel bug report about a USBcore driver
Message-ID: <2023070858-ecard-pummel-146b@gregkh>
References: <f7137bb.c0125.18933658fac.Coremail.ylzhou@whu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7137bb.c0125.18933658fac.Coremail.ylzhou@whu.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jul 08, 2023 at 10:47:21AM +0800, 周逸林 wrote:
> Dear developer, I am a security researcher at Wuhan University. Recently I discovered a vulnerability in the driver of the USBcore module in the Linux kernel. This vulnerability will lead to an infinite loop in the probe process of the USB device, which will consume a lot of system resources. The vulnerability was found in kernel version 5.6.19 and tested to exist in the new 6.3.7 kernel version as well. I hope that after your review, you will be able to apply for a CVE number to disclose this vulnerability. If you need more detailed vulnerability information, please   contact me. Thank you for your help.

Hi,

This is not the proper place to report security problems to at all.

Please read the in-kernel documentation for how to do that (hint, email
all the needed information to security@kernel.org) AND the portion about
how the kernel community does not do anything with CVEs in any form and
can not assign them as MITRE wants nothing to do with the Linux kernel
community.

thanks,

greg k-h
