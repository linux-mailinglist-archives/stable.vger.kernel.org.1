Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614EF789806
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 18:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjHZQbP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 12:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjHZQaj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 12:30:39 -0400
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2A81FCB
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 09:30:36 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5b2e8104.dip0.t-ipconnect.de [91.46.129.4])
        by mail.itouring.de (Postfix) with ESMTPSA id 48250147;
        Sat, 26 Aug 2023 18:30:35 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 0B625F01600;
        Sat, 26 Aug 2023 18:30:35 +0200 (CEST)
Subject: Re: Wrong patch queued up for 6.4:
 mm-disable-config_per_vma_lock-until-its-fixed.patch
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <ab4017e3-31ce-f1d0-b2b4-331868f1f643@applied-asynchrony.com>
 <2023082655-designer-moistness-0a6f@gregkh>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <afb5de81-e869-68b4-1d1d-16cd54129a21@applied-asynchrony.com>
Date:   Sat, 26 Aug 2023 18:30:34 +0200
MIME-Version: 1.0
In-Reply-To: <2023082655-designer-moistness-0a6f@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023-08-26 18:10, Greg KH wrote:
> On Sat, Aug 26, 2023 at 05:46:40PM +0200, Holger Hoffstätte wrote:
>> Hi Sasha
>>
>> I just saw that you queued up mm-disable-config_per_vma_lock-until-its-fixed.patch for 6.4.
>> The problems that this patch tried to prevent were fixed before it actually made it into a
>> release, and Linus un-did the commit in his merge (at the bottom):
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/mm/Kconfig?id=7fa8a8ee9400fe8ec188426e40e481717bc5e924
>>
>> Since the fixes for PER_VMA_LOCK have been in 6.4 releases for a while, this patch
>> should not go in.
> 
> Thanks, I've dropped this patch from the queue now, can you provide a
> working version?

There is no alternative version - everything is fine in 6.4. :)

thanks
Holger
