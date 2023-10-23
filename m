Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973447D2EDA
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 11:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjJWJue (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 05:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjJWJu2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 05:50:28 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C72D6E6
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 02:50:25 -0700 (PDT)
Received: from pwmachine.numericable.fr (unknown [188.24.154.80])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1401D20B74C0;
        Mon, 23 Oct 2023 02:50:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1401D20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1698054625;
        bh=9lF80QwakaNxjweC4+4+yDzMOo/8RyRoSEvX93N6quU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnyGw4E4GAkVGzbvsxP15DqudXPzbrcganCgRrOq1JrJXgUM3keIlO50OJn26e+SG
         Es4+6dS/yHF64/qH773MsWlha4mtKiKasfgqv64s8Q6+5qUgDB8M7Y92ZgCkp5rhrU
         yB82a307JvtY13QbjX/qVXGoN6otI/oxxBYW9js4=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>
Subject: [PATCH 4.14.y 0/1] Return EADDRNOTAVAIL when func matches several symbols during kprobe creation
Date:   Mon, 23 Oct 2023 12:49:46 +0300
Message-Id: <20231023094947.258663-1-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023102140-tartly-democrat-140d@gregkh>
References: <2023102140-tartly-democrat-140d@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi.


I received messages regarding problems to apply the upstream patch.
I was able to reproduce the problem on the following stable kernels:
* 4.14,
* 4.19,
* 5.4
* and 5.10
But it seems to be false positive for kernel 5.15 and 6.1, is this case possible
or I did something wrong?

For kernel 4.14, I adapted the patch and tested it to confirm its behavior:
root@vm-amd64:~# uname -a
Linux vm-amd64 4.14.327+ #120 SMP Mon Oct 23 12:26:47 EEST 2023 x86_64 GNU/Linux
root@vm-amd64:~# echo 'p:probe/name_show name_show' > /sys/kernel/tracing/kprobe_events
-bash: echo: write error: Cannot assign requested address

I would nonetheless like to get reviews before having it merged as it is a bit
different from upstream patch.
In the meanwhile, I will work on applying this patch to other kernels.
The goal would be to have two versions of the patch:
1. One for "older" kernels (i.e before 5.15).
2. Another for "younger" kernels (i.e. 5.15 and above).
I am not really sure if this is way to work with stable kernels, as this is
first time I have to deal with such a case.
So, any feedback on how to handle it properly would be more than welcome.

Francis Laniel (1):
  tracing/kprobes: Return EADDRNOTAVAIL when func matches several
    symbols

 kernel/trace/trace_kprobe.c | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)


Best regards and thank you in advance.
--
2.34.1

