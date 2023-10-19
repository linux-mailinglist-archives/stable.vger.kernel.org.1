Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F807D0080
	for <lists+stable@lfdr.de>; Thu, 19 Oct 2023 19:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjJSR1v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 19 Oct 2023 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjJSR1u (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Oct 2023 13:27:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4325126
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 10:27:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5142C433C8;
        Thu, 19 Oct 2023 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697736468;
        bh=2k9qLbSMVDP8lL8VSNbuCrhK8bPQDEuvouvPNMB5CLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=beTwvJ6EGi4WXK5aiFboSi/9/GJGXwaIgAlVQPaTBRvR/aWylwXiz5neXP55wGRt8
         C9prYxRs86CHkaOFzIAhqVJbTXJyT8nEtEQCw4pQZT5dbZ32KAWBBNS+PKgwODS089
         63jtaInK34v9lue0z3HY9evmo1CpLvaqzXhrWTRs=
Date:   Thu, 19 Oct 2023 19:27:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     aftermath digital <aftermath.digital0@gmail.com>
Cc:     stable@vger.kernel.org, jan.kiszka@siemens.com, kbingham@kernel.org
Subject: Re: vmlinux-gdb unable to parse_and_eval("hrtimer_resolution") on
 mainline
Message-ID: <2023101904-eats-expletive-3142@gregkh>
References: <CADwTF6=b4wuC4ESVTZsAidDhxMj-A9RU6wOYShJcuhMKQFfVaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADwTF6=b4wuC4ESVTZsAidDhxMj-A9RU6wOYShJcuhMKQFfVaw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 18, 2023 at 08:57:47PM +0100, aftermath digital wrote:
> Hi,
> 
> I've tested the below on both linux-6.5.7 and mainline linux-6.6-rc6,
> both of which seem to have the same issue.
> 
> GDB 13.2 isn't able to load vmlinux-gdb.py as it throws the following:
> 
> Traceback (most recent call last):
>   File "/home/user/debug_kernel/linux-6.6-rc6/vmlinux-gdb.py", line
> 25, in <module>
>     import linux.constants
>   File "/home/user/debug_kernel/linux-6.6-rc6/scripts/gdb/linux/constants.py",
> line 11, in <module>
>     LX_hrtimer_resolution = gdb.parse_and_eval("hrtimer_resolution")
> gdb.error: 'hrtimer_resolution' has unknown type; cast it to its declared type
> 
> I've built-linux like so:
> 
> make defconfig
> scripts/config --disable SYSTEM_TRUSTED_KEYS
> scripts/config --disable SYSTEM_REVOCATION_KEYS
> scripts/config --set-str SYSTEM_TRUSTED_KEYS ""
> scripts/config -e CONFIG_DEBUG_INFO -e CONFIG_GDB_SCRIPTS -e
> CONFIG_FRAME_POINTER
> make -j$(nproc)
> make scripts_gdb
> 
> $ gcc --version
> gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
> $ gdb --version
> GNU gdb (GDB) 13.2
> 
> This is my first time submitting a bug to the LK mailing list, please
> let me know if this format is not correct or if you need more
> information.

Has this ever worked with any kernel version you have tried?  If so,
what was the last good version?  Can you run 'git bisect' to find the
offending commit?

thanks,

greg k-h
