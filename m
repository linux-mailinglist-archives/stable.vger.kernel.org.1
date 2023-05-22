Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6404170C6A7
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjEVTUl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjEVTUl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:20:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499B493
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBB3962811
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023E7C433D2;
        Mon, 22 May 2023 19:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783239;
        bh=zTe+coZ0s4202QjBGbx/sm2KcEoJ3wbD+8J1vMtbv8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGLBhmF8o0CGTGN5lBZZSh7I779i+LH+YETJM5WR1i3XjWsEXHi/cmi9bJmy5XJRU
         LEwhJJ7S3vdnImzDMcKID92R16ecRjSw3l8Xqdgq2+dywifXv1hMazOCuUn0462UbZ
         9LWHDtNgtSIjLCwQszjJ2z1n+VA0O6VFFvTgl24I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Boris Fiuczynski <fiuczy@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 147/203] s390/cio: include subchannels without devices also for evaluation
Date:   Mon, 22 May 2023 20:09:31 +0100
Message-Id: <20230522190359.038251530@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Vineeth Vijayan <vneethv@linux.ibm.com>

[ Upstream commit b1b0d5aec1cf9f9a900a14964f869c68688d923e ]

Currently when the new channel-path is enabled, we do evaluation only
on the subchannels with a device connected on it. This is because,
in the past, if the device in the subchannel is not working or not
available, we used to unregister the subchannels. But, from the 'commit
2297791c92d0 ("s390/cio: dont unregister subchannel from child-drivers")'
we allow subchannels with or without an active device connected
on it. So, when we do the io_subchannel_verify, make sure that,
we are evaluating the subchannels without any device too.

Fixes: 2297791c92d0 ("s390/cio: dont unregister subchannel from child-drivers")
Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 61cde02b23fec..b21fa57d1a46b 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1116,6 +1116,8 @@ static void io_subchannel_verify(struct subchannel *sch)
 	cdev = sch_get_cdev(sch);
 	if (cdev)
 		dev_fsm_event(cdev, DEV_EVENT_VERIFY);
+	else
+		css_schedule_eval(sch->schid);
 }
 
 static void io_subchannel_terminate_path(struct subchannel *sch, u8 mask)
-- 
2.39.2



