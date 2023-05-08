Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF806FAA3E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjEHLBA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbjEHLA0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9995333846
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30BBA62A0B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212B1C433D2;
        Mon,  8 May 2023 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543554;
        bh=eUicCCTacN+4HZa4ZS17SedqqLgYkcBdUACFtoKMKHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZUR1icCGcN+kAKk/hWEzEjHz7moQjPGVAlx9apeCgcIABwFsq1KoQw3RkT2HNEXV
         Nj7fc7/yLp/Oh+167ZyYQr/ymT3VCDtrAKOlohK8qlc1j5TA74FCs8wtxjOPl0pPzE
         mNX/cnaoqYX8ljhUP0NVsGYgUqvwwFAhytYCykcM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 6.3 128/694] clk: microchip: fix potential UAF in auxdev release callback
Date:   Mon,  8 May 2023 11:39:23 +0200
Message-Id: <20230508094436.626002671@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 drivers/clk/microchip/clk-mpfs.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -374,14 +374,13 @@ static void mpfs_reset_unregister_adev(v
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
 


