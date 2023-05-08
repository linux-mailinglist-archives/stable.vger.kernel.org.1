Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5906FA629
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjEHKQ5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbjEHKQ4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:16:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE6B1BCB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63A9B624C2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F45C433EF;
        Mon,  8 May 2023 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541013;
        bh=igBr8KG5u2kXdscMaY5PQYK+1u2WVLWqe8jKSxfCcuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2DyFvV7lvPx1Cz03dkvoDmMwLgRqnf7SSLSwwL/lE/gq9WxkMwy9lhM7kYpWk9Kx
         KqJ4J5tWW2bVFwkJl4l9vewdg/EZHZ4wwQhTSQG1hKLsvlyBU5vj16XY+VQ84fX4e0
         5L/fikf9ynFSMOmxwHgnf+Ono9nUzgWWXvvlLkHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 6.1 582/611] clk: microchip: fix potential UAF in auxdev release callback
Date:   Mon,  8 May 2023 11:47:04 +0200
Message-Id: <20230508094440.841082597@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

commit 7455b7007b9e93bcc2bc9c1c6c73a228e3152069 upstream.

Similar to commit 1c11289b34ab ("peci: cpu: Fix use-after-free in
adev_release()"), the auxiliary device is not torn down in the correct
order. If auxiliary_device_add() fails, the release callback will be
called twice, resulting in a UAF. Due to timing, the auxdev code in this
driver "took inspiration" from the aforementioned commit, and thus its
bugs too!

Moving auxiliary_device_uninit() to the unregister callback instead
avoids the issue.

CC: stable@vger.kernel.org
Fixes: b56bae2dd6fd ("clk: microchip: mpfs: add reset controller")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20230413-critter-synopsis-dac070a86cb4@spud
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/microchip/clk-mpfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 4f0a19db7ed7..cc5d7dee59f0 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -374,14 +374,13 @@ static void mpfs_reset_unregister_adev(void *_adev)
 	struct auxiliary_device *adev = _adev;
 
 	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
 }
 
 static void mpfs_reset_adev_release(struct device *dev)
 {
 	struct auxiliary_device *adev = to_auxiliary_dev(dev);
 
-	auxiliary_device_uninit(adev);
-
 	kfree(adev);
 }
 
-- 
2.40.1



