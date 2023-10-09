Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4278A7BE254
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 16:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjJIOR7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 10:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjJIOR6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 10:17:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E182B8E
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 07:17:56 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1qpr4z-0004rd-Uc; Mon, 09 Oct 2023 16:17:53 +0200
Message-ID: <6092d57f-4688-aaf2-120d-0e10c40f89c6@pengutronix.de>
Date:   Mon, 9 Oct 2023 16:17:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: Drop from 5.15 and older -- clk: imx: pll14xx: dynamically
 configure PLL for 393216000/361267200Hz
To:     Greg KH <gregkh@linuxfoundation.org>, Marek Vasut <marex@denx.de>
Cc:     linux-stable <stable@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <4e5fa5b2-66b8-8f0b-ccb9-c2b774054e4e@denx.de>
 <2023100738-shell-scant-cfb6@gregkh>
Content-Language: en-US
In-Reply-To: <2023100738-shell-scant-cfb6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello Greg,

On 07.10.23 13:44, Greg KH wrote:
> On Tue, Oct 03, 2023 at 10:52:25PM +0200, Marek Vasut wrote:
>> Please drop the following commits from stable 5.10.y and 5.15.y respectively
>>
>> 972acd701b19 ("clk: imx: pll14xx: dynamically configure PLL for
>> 393216000/361267200Hz")
>> a8474506c912 ("clk: imx: pll14xx: dynamically configure PLL for
>> 393216000/361267200Hz")
>>
>> The commit message states 'Cc: stable@vger.kernel.org # v5.18+'
>> and the commit should only be applied to Linux 5.18.y and newer,
>> on anything older it breaks PLL configuration due to missing
>> prerequisite patches.
> 
> Ok, I'll go revert them, but the Fixes: tag in this commit is very wrong
> as that's what we used to determine how far back to take these changes.

The Fixes tag is correct. The PLL parameters added in that commit were
deemed suboptimal. Kernels >= v5.18 can compute better parameters on the fly,
so that's why the patch says

  Cc: stable@vger.kernel.org # v5.18+

Which is the syntax described in Documentation/admin-guide/reporting-issues.rst.
I see now though that Documentation/process/stable-kernel-rules.rst has a slightly
different syntax:

  Cc: <stable@vger.kernel.org> # 3.3.x

Perhaps your maintainer scripts can't handle both cases?

FWIW, I've reached out multiple times about that the patches aren't suitable for
backports:

  - https://lore.kernel.org/all/6e3ad25c-1042-f786-6f0e-f71ae85aed6b@pengutronix.de/
  - <a76406b2-4154-2de4-b1f5-43e86312d487@pengutronix.de> (reply to linux-stable-commits)
  - https://lore.kernel.org/all/7df69de2-1b3a-5226-7dc2-d1489e48f6a2@pengutronix.de/
  - https://lore.kernel.org/all/e85da95c-5451-31ea-cae9-76d697fb548f@pengutronix.de/

Yet, today I got an email[1] telling me that it's being added to v5.4.258-rc1, although
it had been dropped from v5.4.257-rc1 after I objected to it.

So that looks like another potential avenue for improving the maintainer scripts.

[1]: https://lore.kernel.org/all/20231009130131.263594775@linuxfoundation.org/

Thanks,
Ahmad


> 
> thanks,
> 
> greg k-h
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

