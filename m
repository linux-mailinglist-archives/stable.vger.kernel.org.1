Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3BB783295
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjHUUK3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjHUUK3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E9DDF
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FCBC6164F
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8E3C433C8;
        Mon, 21 Aug 2023 20:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648626;
        bh=7a8AK98anMFfua3NLL8RUEamcE2sPD8UDE4T5o3pr8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=scdfoHO90ogQFsM2dmwUchrpjXfWWYG03aRfHqZ+CufMyXfSz71FvidSTFrch3Slh
         1RT48YpWqY5Sx3FZql1uCsHlAGsG3pibK3o2Z47mEwlM0yq0VAsoIaS/yhbzsBrSbc
         wyNKEPbz/7uB/L8cz0uBcJQJvM6xmp1bAziRycVs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Yingliang <yangyingliang@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.4 216/234] mmc: wbsd: fix double mmc_free_host() in wbsd_init()
Date:   Mon, 21 Aug 2023 21:42:59 +0200
Message-ID: <20230821194138.423828380@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

commit d83035433701919ac6db15f7737cbf554c36c1a6 upstream.

mmc_free_host() has already be called in wbsd_free_mmc(),
remove the mmc_free_host() in error path in wbsd_init().

Fixes: dc5b9b50fc9d ("mmc: wbsd: fix return value check of mmc_add_host()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230807124443.3431366-1-yangyingliang@huawei.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/wbsd.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1705,8 +1705,6 @@ static int wbsd_init(struct device *dev,
 
 		wbsd_release_resources(host);
 		wbsd_free_mmc(dev);
-
-		mmc_free_host(mmc);
 		return ret;
 	}
 


