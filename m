Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952497A03E5
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 14:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbjINMbn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 08:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjINMbm (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 08:31:42 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0BA1FC8
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 05:31:37 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id EA6D8186555D;
        Thu, 14 Sep 2023 15:31:34 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LjUIgLVK1RQt; Thu, 14 Sep 2023 15:31:34 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 11BDE1863792;
        Thu, 14 Sep 2023 15:31:34 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zZDO0oB3hcqP; Thu, 14 Sep 2023 15:31:33 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.181.102])
        by mail.astralinux.ru (Postfix) with ESMTPS id 8C73E186378A;
        Thu, 14 Sep 2023 15:31:33 +0300 (MSK)
Received: from [10.177.13.132] (unknown [10.177.13.132])
        by new-mail.astralinux.ru (Postfix) with ESMTPA id 4RmcBX6Xd5zlVsN;
        Thu, 14 Sep 2023 15:31:32 +0300 (MSK)
Message-ID: <7526ff3d-0b89-1e3a-12c6-8b64b7705705@astralinux.ru>
Date:   Thu, 14 Sep 2023 15:30:57 +0300
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH 5.10] btrfs: fix region size in count_bitmap_extents
To:     kernel test robot <lkp@intel.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
References: <ZQLWykRVfQf/0jxh@6fe19fc45f19>
Content-Language: ru
From:   =?UTF-8?B?0JDQvdCw0YHRgtCw0YHQuNGPINCb0Y7QsdC40LzQvtCy0LA=?= 
        <abelova@astralinux.ru>
In-Reply-To: <ZQLWykRVfQf/0jxh@6fe19fc45f19>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

14/09/23 12:47, kernel test:
> Hi,
>
> Thanks for your patch.
>
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
>
> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html/#option-3
>
> Rule: The upstream commit ID must be specified with a separate line above the commit text.
> Subject: [PATCH 5.10] btrfs: fix region size in count_bitmap_extents
> Link: https://lore.kernel.org/stable/20230914094555.25657-1-abelova%40astralinux.ru
>
> Please ignore this mail if the patch is not relevant for upstream.
Right, this patch can not be applied to upstream because this part of 
code was deleted in version 5.11.
However there is still a possible typo.

