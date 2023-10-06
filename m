Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B770C7BB77A
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 14:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjJFMVI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 08:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjJFMVI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 08:21:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F388ED6
        for <stable@vger.kernel.org>; Fri,  6 Oct 2023 05:21:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62803C433C8;
        Fri,  6 Oct 2023 12:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696594864;
        bh=eEAGMHnLPIv/m3ngBpVNSfrVjCGlhTK1953WUjSor24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTXbTRgNaMfuCwMIoA/eYL/Ty2cOHyVRkujckTVIVasdng3pdpgrF5iCuClH+EUSZ
         H10CTbO4yMuEIY5W+wYDXPHgfwcU96fYY6TOdxEo4bUm3dkM0rtwbc5OKECSdesUUl
         9QWWmlTX4Uz0C5qxd4RyhDOibmyK2L3kI5hSbPr/U5jVFxDt2VflX/pNiVuZaJcNrA
         Qc+/vQIM/x4SplFOUOV6Y++ujNO7WYs4Dg60vWukRQutYUIIFLpvLc/h31vPcysN04
         S8HAWiT/vaz35WwZFYo1xTmxvf8jYJqDkmTfxm+hGzHYQ87y6WpR8mtaZ/ohB6wH8n
         0KaRBx8WLSsCw==
Date:   Fri, 6 Oct 2023 08:21:03 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Greg KH <gregkh@linuxfoundation.org>, sj@kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        zahavi.alon@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization
 setup
Message-ID: <ZR_7rzhMCkKAUN_x@sashalap>
References: <20231003164638.2526-1-sj@kernel.org>
 <1ed79a61-0e74-7264-cb70-c65531cf60e2@grimberg.me>
 <2023100445-twisted-everyone-be72@gregkh>
 <01901640-fc6d-5d15-3aa0-9f4586ba5141@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <01901640-fc6d-5d15-3aa0-9f4586ba5141@grimberg.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 04, 2023 at 04:25:13PM +0300, Sagi Grimberg wrote:
>
>>>>Hello,
>>>>
>>>>On Mon, 2 Oct 2023 13:54:28 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
>>>>
>>>>>  From Alon:
>>>>>"Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
>>>>>a malicious user can cause a UAF and a double free, which may lead to
>>>>>RCE (may also lead to an LPE in case the attacker already has local
>>>>>privileges)."
>>>>>
>>>>>Hence, when a queue initialization fails after the ahash requests are
>>>>>allocated, it is guaranteed that the queue removal async work will be
>>>>>called, hence leave the deallocation to the queue removal.
>>>>>
>>>>>Also, be extra careful not to continue processing the socket, so set
>>>>>queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.
>>>>>
>>>>>Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
>>>>>Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
>>>>>Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>>
>>>>Would it be better to add Fixes: and Cc: stable lines?
>>>
>>>This issue existed since the introduction of the driver, I am not sure
>>>it applies cleanly that far back...
>>>
>>>I figured that the description and Reported-by tag will trigger stable
>>>kernel pick up...
>>
>><formletter>
>>
>>This is not the correct way to submit patches for inclusion in the
>>stable kernel tree.  Please read:
>>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>for how to do this properly.
>>
>></formletter>
>
>I could have sworn to have seen patches that did not have stable CCd
>nor a Fixes tag and was picked up for stable kernels :)
>But I guess those were either hallucinations or someone sending patches
>to stable...

That happens, but there are no guarantees around it.

If you really want for a patch to land in stable, and want to know if
for some reason it didn't, the only way to do it is with an explicit
stable tag. Otherwise it's just "best effort".

-- 
Thanks,
Sasha
