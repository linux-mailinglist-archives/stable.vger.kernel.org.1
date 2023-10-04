Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6927B869C
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 19:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243434AbjJDRcc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 13:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbjJDRcc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 13:32:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BEDA6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 10:32:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21561C433C9;
        Wed,  4 Oct 2023 17:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696440748;
        bh=W9hkSL3Mou8wKa/FxxQNX9QCvyVPYGZ0u/8FwzlXasI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXYPi9UjTP8PQ8stedo0wU9LxoUWM/fYZ+QMZC5fnRES7C46Ds0UCkChL6u0fzOGY
         f1SrEOHO7JjYa8G2kB+cP6U9bs0LKNsWbdCzek0Jd5hz6E+YglF4wPM/zm7W6DVo9o
         /eAzzwyKgocWEhMM9oG+dKUpf7vo5Deij8A+c3yDi2oud8SA3vF2oRrJSi1NzEykqZ
         kmx0QwgWAzGefulqKuoFFx0iwyUgiMKIUyZf1dLdbmU8ojtFUdSHtj6DeISva7OXiQ
         rxXIemlrwAxQP4EU3FvtxaXBM1REHqj3ndvf51Z6DtIepweA2nmVBU5Tk7UlvNPqJO
         Y7WL9ZzloeJWw==
From:   SeongJae Park <sj@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Greg KH <gregkh@linuxfoundation.org>, sj@kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        zahavi.alon@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization setup
Date:   Wed,  4 Oct 2023 17:32:26 +0000
Message-Id: <20231004173226.5992-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <01901640-fc6d-5d15-3aa0-9f4586ba5141@grimberg.me>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 4 Oct 2023 16:25:13 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:

> 
> >>> Hello,
> >>>
> >>> On Mon, 2 Oct 2023 13:54:28 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
> >>>
> >>>>   From Alon:
> >>>> "Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
> >>>> a malicious user can cause a UAF and a double free, which may lead to
> >>>> RCE (may also lead to an LPE in case the attacker already has local
> >>>> privileges)."
> >>>>
> >>>> Hence, when a queue initialization fails after the ahash requests are
> >>>> allocated, it is guaranteed that the queue removal async work will be
> >>>> called, hence leave the deallocation to the queue removal.
> >>>>
> >>>> Also, be extra careful not to continue processing the socket, so set
> >>>> queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.
> >>>>
> >>>> Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
> >>>> Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
> >>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> >>>
> >>> Would it be better to add Fixes: and Cc: stable lines?
> >>
> >> This issue existed since the introduction of the driver, I am not sure
> >> it applies cleanly that far back...

Based on the rule[1], I think people who need this fix on the old kernel would
do that.  I'd just say adding Fixes: would help it, so better than nothing.

[1] https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

> >>
> >> I figured that the description and Reported-by tag will trigger stable
> >> kernel pick up...
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> I could have sworn to have seen patches that did not have stable CCd
> nor a Fixes tag and was picked up for stable kernels :)

I could also swear.  Stable kernel maintainers are great at finding fixes on
their own.  But I think adding those could help them avoiding any mistake, and
therefore better than nothing, again.

> But I guess those were either hallucinations or someone sending patches
> to stable...
> 
> I can resend with CC to stable.

Thank you :)


Thanks,
SJ

> 
> Thanks.
> 
> 
