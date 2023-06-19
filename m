Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E8B734DA7
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 10:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjFSI2Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 04:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFSI2X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 04:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C1AA8
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 01:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 541AB60B6A
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 08:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB75CC433C0;
        Mon, 19 Jun 2023 08:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687163301;
        bh=6mC7CP2PSK5GVYu0NULvIVfC/QcCHB5Iom/xqR44lCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JHqWIJHU6Or0qXpG2rsDfMBnBH8ZSbGwdOSOswqP8kRxc7kB/k1ml4YnzXGfG/36n
         JB3aAmxB8Chs0t5cg/XN6TaOeqc7L3UPdoO+VnVfVBGaGoUDTUvu4mJR1sj5RDamvx
         5b2Gx4hM6zbVeChvXXrwgmXbYp3zqiZhRjizlAKk=
Date:   Mon, 19 Jun 2023 10:28:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     stable@vger.kernel.org, tony.luck@intel.com,
        dan.j.williams@intel.com, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, glider@google.com
Subject: Re: [5.15-stable PATCH 0/2] Copy-on-write hwpoison recovery
Message-ID: <2023061926-copied-glowworm-8cee@gregkh>
References: <20230615015255.1260473-1-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615015255.1260473-1-jane.chu@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 14, 2023 at 07:52:53PM -0600, Jane Chu wrote:
> I was able to reproduce crash on 5.15.y kernel during COW, and
> when the grandchild process attempts a write to a private page
> inherited from the child process and the private page contains
> a memory uncorrectable error. The way to reproduce is described
> in Tony's patch, using his ras-tools/einj_mem_uc.
> And the patch series fixed the panic issue in 5.15.y.

But you are skipping 6.1.y, which is not ok as it would cause
regressions when you upgrade.

I'll drop this from my review queue now, please provide working
backports for this and newer releases, and I'll be glad to take them.

thanks,

greg k-h
