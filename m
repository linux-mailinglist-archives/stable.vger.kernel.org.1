Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4087C9569
	for <lists+stable@lfdr.de>; Sat, 14 Oct 2023 18:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjJNQiS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 14 Oct 2023 12:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjJNQiR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 14 Oct 2023 12:38:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C668A2
        for <stable@vger.kernel.org>; Sat, 14 Oct 2023 09:38:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A811CC433CB;
        Sat, 14 Oct 2023 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697301495;
        bh=1+e5A2m+zBIKAjjdqJRN/YeoEFSr+Dhufs1McprSZs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJzMUADvdWlqbuomZpTMADkBxYsSgCMFAVcLO849T7CHNe8jgmQXdDBPrPn5RKM8X
         Pbp0uAk64sFyJDLWjSAXK1npsQjKYUR+re80TFMn3Th18PMVGK77eZeGihHXZ2Ps3k
         VM/C3MFDKdt9cXM0mO9GS6TcY0qbPRYR/DX3XGa/0oKCDNBjWQ62YJXAcJeZksOBEc
         VM6TEQ/Xd0ffkOCQ142F03SPt5Y/+zN0IkDN+wJhPxcu5lTrU03wl2W9Lm3FmK0X/B
         U6N2QNSqIIBEmlpcwvWe3QZqtNZU5moRW4JCPytpV8Eb9qLK+S9YcAIqjgX1dRxhZb
         8ZRYBbq+IUSBw==
Date:   Sat, 14 Oct 2023 12:38:14 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     craig <craig@haquarter.de>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: tcp: enforce receive buffer memory limits by allowing the tcp
 window to shrink
Message-ID: <ZSrD9s8UPGFq1Wpu@sashalap>
References: <MzUupJN3oxWdw7O3tyFkgevmIelXS340Dl-1oKnkGG-e4G5sqRpblEfCpbKyAzk3x3SmccNR9egn4F5j-H7eiojEJW1HlrtBIfxhamuf7W4=@haquarter.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MzUupJN3oxWdw7O3tyFkgevmIelXS340Dl-1oKnkGG-e4G5sqRpblEfCpbKyAzk3x3SmccNR9egn4F5j-H7eiojEJW1HlrtBIfxhamuf7W4=@haquarter.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 09:02:54AM +0000, craig wrote:
>Hi,
>
>I hope I'm doing this correctly, as per https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html, Option 2. :)
>
>Subject of the patch: tcp: enforce receive buffer memory limits by allowing the tcp window to shrink
>Full details including reproducers, impact, tests are available here: https://blog.cloudflare.com/unbounded-memory-usage-by-tcp-for-receive-buffers-and-how-we-fixed-it/
>
>commit ID: b650d953cd391595e536153ce30b4aab385643ac
>
>Why I think it should be applied:
>- linux TCP sessions are allocating more memory than they should
>- the kernel drops incoming packets which it should not drop
>- large amounts of memory can be saved (see https://blog.cloudflare.com/unbounded-memory-usage-by-tcp-for-receive-buffers-and-how-we-fixed-it/#memory)
>
>What kernel versions you wish it to be applied to: 6.1.x (stable).
>Thank you! :)

Queued up, thanks.

-- 
Thanks,
Sasha
