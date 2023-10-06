Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CF67BB91F
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 15:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjJFNcm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 09:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjJFNcl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 09:32:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC59F9E
        for <stable@vger.kernel.org>; Fri,  6 Oct 2023 06:32:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACF5C433C7;
        Fri,  6 Oct 2023 13:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696599160;
        bh=ciRjjLrQLqS27FehHSpPFGBMu5nU/kEm8LML/tA0quo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vR6mkTb1YTXAiyZEQPk2/vb2HilYGoqQK3MwNeWIS9gCU1F8jtINStW8DjIEeO987
         nz+lxtfXrK49ocgAxy4hHSH0o8YuQ8JfQey1t5JuiXSE0Z9GhgE0iRPnFedIMIIzGD
         MMy1aFakWz7a4EsczMb9DemHn5HRjfYfs6nfcabIocvfXHlcB3W87RKF2QKSnSJDQV
         Nr+al6R8yZxabNNqZfWpjhu3LJNvzVtyWYr5fclw6VMXCMHjxRcDRmtXs3/XOROtDt
         QiMVmQVuxhCzzjRDTn3FVOFRnCtWphehjuD35L1s3RMc4Ma8PPLTJb8psRfGYsaDsf
         KNe5OmivNXTyw==
Date:   Fri, 6 Oct 2023 09:32:39 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>, krisman@suse.de,
        will@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        anshuman.khandual@arm.com, catalin.marinas@arm.com
Subject: Re: [5.15,6.1] Please apply a89c6bcdac22bec1bfbe6e64060b4cf5838d4f47
Message-ID: <ZSAMd5jUScAlmzEc@sashalap>
References: <010edf5a-453d-4c98-9c07-12e75d3f983c@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <010edf5a-453d-4c98-9c07-12e75d3f983c@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 05, 2023 at 10:59:28AM -0400, Luiz Capitulino wrote:
>Hi,
>
>We found that commits 46bdb4277f98 and 0388f9c74330 (merged in v5.12)
>introduced more than 40% performance regression in UnixBench's process
>creation benchmark when comparing 5.10 with 5.15 and 6.1 on AWS'
>virtualized Graviton instances.
>
>This has been mostly fixed by the following upstream commit:
>
>"""
>commit a89c6bcdac22bec1bfbe6e64060b4cf5838d4f47
>Author: Gabriel Krisman Bertazi <krisman@suse.de>
>Date: Mon Jan 9 12:19:55 2023 -0300
>
> arm64: Avoid repeated AA64MMFR1_EL1 register read on pagefault path
>"""

Queued up, thanks!

-- 
Thanks,
Sasha
