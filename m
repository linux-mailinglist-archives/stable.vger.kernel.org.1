Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E40702DC0
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 15:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbjEONOD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 09:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbjEONNh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 09:13:37 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4642619B3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 06:13:11 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34FDBaVk034128;
        Mon, 15 May 2023 22:11:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Mon, 15 May 2023 22:11:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34FDBZE4034120
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 May 2023 22:11:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7f66845a-d27f-f1c8-fccf-91cd3be95024@I-love.SAKURA.ne.jp>
Date:   Mon, 15 May 2023 22:11:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 5.10.y] printk: declare printk_deferred_{enter,safe}() in
 include/linux/printk.h
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
References: <2023042446-gills-morality-d566@gregkh>
 <767ab028-d946-98d5-4a13-d6ed6df77763@I-love.SAKURA.ne.jp>
 <2023051537-embargo-scouting-a849@gregkh>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2023051537-embargo-scouting-a849@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023/05/15 21:56, Greg Kroah-Hartman wrote:
> On Sun, May 14, 2023 at 01:41:27PM +0900, Tetsuo Handa wrote:
>> commit 85e3e7fbbb720b9897fba9a99659e31cbd1c082e upstream.
>>
>> [This patch implements subset of original commit 85e3e7fbbb72 ("printk:
>> remove NMI tracking") where commit 1007843a9190 ("mm/page_alloc: fix
>> potential deadlock on zonelist_update_seq seqlock") depends on, for
>> commit 3d36424b3b58 ("mm/page_alloc: fix race condition between
>> build_all_zonelists and page allocation") was backported to stable.]
> 
> All now queued up, thanks.

Thank you. Then, please also queue original "[PATCH] mm/page_alloc: fix potential
deadlock on zonelist_update_seq" (Message ID listed below) to stable kernels.

  <2023042446-gills-morality-d566@gregkh>
  <2023042449-wobbling-putdown-13ea@gregkh>
  <2023042452-stopper-engross-e9da@gregkh>
  <2023042455-skinless-muzzle-1c50@gregkh>

