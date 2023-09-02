Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9E5790813
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 15:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbjIBN27 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 09:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbjIBN26 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 09:28:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0DF10D2
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 06:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BD7BB826E9
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 13:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DE2C433C7;
        Sat,  2 Sep 2023 13:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693661333;
        bh=eALcj6IxaPggKFuTcUcn6yPNhJdmLuTGL/8JBMDNTAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EkkQLLTEBFpk/nYlkZunBRGbLqy4VHU4YqyXNg4Krj+sSvcqIKvxef2FcCxGf0X1g
         VcxJxUkLP95RRhzENkpbZnG/k0JQLP5ZP2rwDsFFlWTl398uXXzEsxDpoCGR+DiZR7
         tKer9oic22pLF2mE7SqhZyS9JHmEaAdTbRT569GE=
Date:   Sat, 2 Sep 2023 15:28:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Denis Efremov (Oracle)" <efremov@linux.com>
Cc:     stable@vger.kernel.org, Zheng Wang <zyytlz.wz@163.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Message-ID: <2023090239-excavator-marina-4479@gregkh>
References: <20230902102200.24474-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902102200.24474-1-efremov@linux.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Sep 02, 2023 at 02:21:56PM +0400, Denis Efremov (Oracle) wrote:
> From: Zheng Wang <zyytlz.wz@163.com>
> 
> [ Upstream commit 73f7b171b7c09139eb3c6a5677c200dc1be5f318 ]
> 
> In btsdio_probe, the data->work is bound with btsdio_work. It will be
> started in btsdio_send_frame.
> 
> If the btsdio_remove runs with a unfinished work, there may be a race
> condition that hdev is freed but used in btsdio_work. Fix it by
> canceling the work before do cleanup in btsdio_remove.
> 
> Fixes: CVE-2023-1989
> Fixes: ddbaf13e3609 ("[Bluetooth] Add generic driver for Bluetooth SDIO devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> [ Denis: Added CVE-2023-1989 and fixes tags. ]
> Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
> ---
> 
> CVE-2023-1989 is 1e9ac114c4428fdb7ff4635b45d4f46017e8916f.
> However, the fix was reverted and replaced with 73f7b171b7.
> In stable branches we've got only the original fix and its
> revert. I'm sending the replacement fix. One can find a
> reference to the new fix 73f7b171b7 in the revert commit
> db2bf510bd5d.

Now queued up, thanks.

greg k-h
