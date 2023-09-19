Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C955C7A59EB
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 08:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjISG0t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 02:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjISG0s (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 02:26:48 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E450102
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 23:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=BCMWKUwenmSGfoWqKlw1rkFMGJz45d8jKoWrJi9VHg8=; b=UPYu75ZYtWoHQ4eexBy2gI17Ku
        aQKu9+TBEfoeSGLWsrMPcvRFiyz3ahew6IuQRy2MwSN8ci93riXJ1QETCsmrylFdJZGzO3UAh+Ey6
        WFz92SogHRAYxU/saUC6k8GfC8JM9TLs8s2dAD4BsuecZ0QPLJcJdTL77nGWLmBNIcXdFfXNCXNoZ
        /WDwE+WVRDzBvtoUWZi+Lsa3QfbqQAuqs9ZlxFZjvnIxjNqAfv9Q/brD99KBIEyrQULdf3FDZk1Vm
        KUl2MZz3R6PzusgVAJDueeHCpNE323EaqnQETaBif9Yg/EIczaQvMAkswp02zKpM6geozsIysJBGD
        cxCZFPtw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qiUBp-000ARY-C0; Tue, 19 Sep 2023 08:26:29 +0200
Received: from [85.1.206.226] (helo=linux-3.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qiUBo-000AHq-S0; Tue, 19 Sep 2023 08:26:28 +0200
Subject: Re: [PATCH 6.1 562/600] bpf: Fix issue in verifying allow_ptr_leaks
To:     Greg KH <gregkh@linuxfoundation.org>, gerhorst@cs.fau.de
Cc:     alexei.starovoitov@gmail.com, ast@kernel.org, eddyz87@gmail.com,
        laoar.shao@gmail.com, patches@lists.linux.dev,
        stable@vger.kernel.org, yonghong.song@linux.dev,
        hagarhem@amazon.de, puranjay12@gmail.com,
        Luis Gerhorst <gerhorst@amazon.de>
References: <20230911134650.200439213@linuxfoundation.org>
 <20230914085131.40974-1-gerhorst@amazon.de>
 <2023091653-peso-sprint-889d@gregkh>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b927046b-d1e7-8adf-ebc0-37b92d8d4390@iogearbox.net>
Date:   Tue, 19 Sep 2023 08:26:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2023091653-peso-sprint-889d@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27035/Mon Sep 18 09:40:43 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 9/16/23 1:35 PM, Greg KH wrote:
> On Thu, Sep 14, 2023 at 08:51:32AM +0000, Luis Gerhorst wrote:
>>> 6.1-stable review patch.  If anyone has any objections, please let me know.
>>>
>>> From: Yafang Shao <laoar.shao@gmail.com>
>>>
>>> commit d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2 upstream.
>>
>> I unfortunately have objections, they are pending discussion at [1].
>>
>> Same applies to the 6.4-stable review patch [2] and all other backports.
>>
>> [1] https://lore.kernel.org/bpf/20230913122827.91591-1-gerhorst@amazon.de/
>> [2] https://lore.kernel.org/stable/20230911134709.834278248@linuxfoundation.org/
> 
> As this is in the tree already, and in Linus's tree, I'll wait to see
> if any changes are merged into Linus's tree for this before removing it
> from the stable trees.
> 
> Let us know if there's a commit that resolves this and we will be glad
> to queue that up.

Commit d75e30dddf73 ("bpf: Fix issue in verifying allow_ptr_leaks") is not
stable material. It's not really a "fix", but it will simply make direct
packet access available to applications without CAP_PERFMON - the latter
was required so far given Spectre v1. However, there is ongoing discussion [1]
that potentially not much useful information can be leaked out and therefore
lifting it may or may not be ok. If we queue this to stable and later figure
we need to revert the whole thing again because someone managed to come up
with a PoC in the meantime, then there's higher risk of breakage.

Thanks,
Daniel
