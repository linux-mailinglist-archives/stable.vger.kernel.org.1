Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF1F7B430B
	for <lists+stable@lfdr.de>; Sat, 30 Sep 2023 20:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjI3SdQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 30 Sep 2023 14:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjI3SdP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 30 Sep 2023 14:33:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B42D3
        for <stable@vger.kernel.org>; Sat, 30 Sep 2023 11:33:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE44C433C8;
        Sat, 30 Sep 2023 18:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696098792;
        bh=NxvCnJ9ozRIO7kqIKzF4vstghP2Ga5o0ppsKL1vsXOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wuW3Oo0oqPZd4gWvU4rs8uzXxfEEmS70mSIug4I8tCo5ubBQJ8msHjGzVKEwaA54I
         JTJie8CUtzPNk9YkaM5eXsdZZGWlOQeUHyiLE6pFhTYmQgAV4kvWWybbZse5QU9/bU
         XswzSa49gIdM5QL9j7QTDRUXH7YvV7ifK0YKFDK8=
Date:   Sat, 30 Sep 2023 20:33:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florent DELAHAYE <florent@delahaye.me>
Cc:     stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [Kernel 6.5] Important read()/write() performance regression
Message-ID: <2023093036-swear-snowbird-aeda@gregkh>
References: <28df26a419a041f3c4f44c5e2a6697adbaee83f3.camel@delahaye.me>
 <94a7f9171b60c0d2430106632db84276f516d454.camel@delahaye.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94a7f9171b60c0d2430106632db84276f516d454.camel@delahaye.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Sep 30, 2023 at 07:07:06PM +0200, Florent DELAHAYE wrote:
> Hello guys,
> 
> During the last few months, I felt a performance regression when using
> read() and write() on my high-speed Nvme SSD (about 7GB/s).
> 
> To get more precise information about it I quickly developed benchmark
> tool basically running read() or write() in a loop to simulate a
> sequential file read or write. The tool also measures the real time
> consumed by the loop. Finally, the tool can call open() with or without
> O_DIRECT.
> 
> I ran the tests on EXT4 and Exfat with following settings (buffer
> values have been set for best result):  
> - Write settings: buffer 400mb * 100  
> - Read settings: buffer 200mb  
> - Drop caches before non-direct read/write test
> 
> With this hardware:  
> - CPU AMD Ryzen 7600X  
> - RAM DDR5 5200 32GB  
> - SSD Kingston Fury Renegade 4TB with 4K LBA
> 
> 
> Here are some results I got with last upstream kernels (default
> config):
> +------------------+----------+------------------+------------------+--
> ----------------+------------------+------------------+
> | ~42GB            | O_DIRECT | Linux 6.2.0      | Linux 6.3.0      |
> Linux 6.4.0      | Linux 6.5.0      | Linux 6.5.5      |
> +------------------+----------+------------------+------------------+--
> ----------------+------------------+------------------+
> | Ext4 (sector 4k) |          |                  |                  | 
> |                  |                  |
> | Read             | no       | 7.2s (5800MB/s)  | 7.1s (5890MB/s)  |
> 8.3s (5050MB/s)  | 13.2s (3180MB/s) | 13.2s (3180MB/s) |
> | Write            | no       | 12.0s (3500MB/s) | 12.6s (3340MB/s) |
> 12.2s (3440MB/s) | 28.9s (1450MB/s) | 28.9s (1450MB/s) |
> | Read             | yes      | 6.0s (7000MB/s)  | 6.0s (7020MB/s)  |
> 5.9s (7170MB/s)  | 5.9s (7100MB/s)  | 5.9s (7100MB/s)  |
> | Write            | yes      | 6.7s (6220MB/s)  | 6.7s (6290MB/s)  |
> 6.9s (6080MB/s)  | 6.9s (6080MB/s)  | 6.9s (6970MB/s)  |
> | Exfat (sector ?) |          |                  |                  | 
> |                  |                  |
> | Read             | no       | 7.3s (5770MB/s)  | 7.2s (5830MB/s)  |
> 9s (4620MB/s)    | 13.3s (3150MB/s) | 13.2s (3180MB/s) |
> | Write            | no       | 8.3s (5040MB/s)  | 8.9s (4750MB/s)  |
> 8.3s (5040MB/s)  | 18.3s (2290MB/s) | 18.5s (2260MB/s) |
> | Read             | yes      | 6.2s (6760MB/s)  | 6.1s (6870MB/s)  |
> 6.0s (6980MB/s)  | 6.5s (6440MB/s)  | 6.6s (6320MB/s)  |
> | Write            | yes      | 16.1s (2610MB/s) | 16.0s (2620MB/s) |
> 18.7s (2240MB/s) | 34.1s (1230MB/s) | 34.5s (1220MB/s) |
> +------------------+----------+------------------+------------------+--
> ----------------+------------------+------------------+
> 
> Please note that I rounded some values to clarify readiness. Small
> variations can be considered as margin error.
> 
> Ext4 results: cached reads/writes time have increased of almost 100%
> from 6.2.0 to 6.5.0 with a first increase with 6.4.0. Direct access
> times have stayed similar though.  
> Exfat results: performance decrease too with and without direct access
> this time.
> 
> I realize there are thousands of commits between, plus the issue can
> come from multiple kernel parts such as the page cache, the file system
> implementation (especially for Exfat), the IO engine, a driver, etc.
> The results also showed that there is not only a specific version
> impacted. Anyway, at the end the performance have highly decreased.
> 
> If you want to verify my benchmark tool source code, please ask.

Have you tried something like fio instead of a new benchmark tool?  That
way others can test and verify the results on their systems as that is a
well-known and tested benchmark tool.

Also, are you sure you just haven't been hit by the spectre fixes that
slow down the I/O path a lot?  Be sure you have feature parity on those
older kernels please.  Many of the ones you list above do NOT have those
required changes.

thanks,

greg k-h
