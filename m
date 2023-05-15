Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD757022A1
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 05:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjEODv5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 14 May 2023 23:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbjEODvz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 14 May 2023 23:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90C6189
        for <stable@vger.kernel.org>; Sun, 14 May 2023 20:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59FC06113D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 03:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE70C433D2;
        Mon, 15 May 2023 03:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684122712;
        bh=8tUhIgsf/aABc0z3KyTOyOwL8BqBKwM0KGPzl9xAYHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgGuJC/n9FgWdvSKMcwNWnEEA4M8qKM3yKYEBpAzEUKAzQNFB26rneeSibzELSMcH
         DJsLZATXQsQ2zW+HLUS2DUIMgmy/2SdTfCSCyKXz9aZZ1AJsFu8Wyi400WdS2H6DL4
         07H+wLCyqHi5PbJTZlHbjzXec2VsBKHBkQnlgYbE=
Date:   Mon, 15 May 2023 05:51:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yeongjin Gil <youngjin.gil@samsung.com>
Cc:     stable@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v2] dm verity: fix error handling for check_at_most_once
 on FEC
Message-ID: <2023051508-payphone-dimly-b417@gregkh>
References: <2023050701-epileptic-unethical-f46c@gregkh>
 <CGME20230515011823epcas1p2e05135dda9e7e159d637016d81d55abc@epcas1p2.samsung.com>
 <20230515011816.25372-1-youngjin.gil@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515011816.25372-1-youngjin.gil@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 15, 2023 at 10:18:16AM +0900, Yeongjin Gil wrote:
> In verity_end_io(), if bi_status is not BLK_STS_OK, it can be return
> directly. But if FEC configured, it is desired to correct the data page
> through verity_verify_io. And the return value will be converted to
> blk_status and passed to verity_finish_io().
> 
> BTW, when a bit is set in v->validated_blocks, verity_verify_io() skips
> verification regardless of I/O error for the corresponding bio. In this
> case, the I/O error could not be returned properly, and as a result,
> there is a problem that abnormal data could be read for the
> corresponding block.
> 
> To fix this problem, when an I/O error occurs, do not skip verification
> even if the bit related is set in v->validated_blocks.
> 
> Fixes: 843f38d382b1 ("dm verity: add 'check_at_most_once' option to only validate hashes once")
> Cc: stable@vger.kernel.org
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> (cherry picked from commit e8c5d45f82ce0c238a4817739892fe8897a3dcc3)

Why did you send this 3 times?

And what kernel(s) is this to be applied to?

confused,

greg k-h
