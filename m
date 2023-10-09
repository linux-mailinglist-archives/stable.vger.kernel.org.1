Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C327A7BDDC8
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376894AbjJINNU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376930AbjJINNG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDFE1710
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:12:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D20C433C8;
        Mon,  9 Oct 2023 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857125;
        bh=Vsl2icVuKSfobVfvwl1xzRYnrXZafKMLNVCVYcxZrsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rPnuqjlY9CiFMVRdprZnC90wNMtSr7gPbhxsfNTflEdKMk5KjXN+fA7ueWkCfluGn
         rIbk217I/g1czDHPF2Oth5cmXxWyy7ZK6tYnjieUUxmRHHmpAT8sMrztxuQpM9vAoa
         cqzyhCj8SlXpWDLvKS86daCLxthq4PgGbnrRg0rA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Vadim Feodrenko <vadim.fedorenko@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 105/163] ptp: ocp: Fix error handling in ptp_ocp_device_init
Date:   Mon,  9 Oct 2023 15:01:09 +0200
Message-ID: <20231009130126.928612025@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit caa0578c1d487d39e4bb947a1b4965417053b409 ]

When device_add() fails, ptp_ocp_dev_release() will be called
after put_device(). Therefore, it seems that the
ptp_ocp_dev_release() before put_device() is redundant.

Fixes: 773bda964921 ("ptp: ocp: Expose various resources on the timecard.")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Vadim Feodrenko <vadim.fedorenko@linux.dev>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_ocp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 20a974ced8d6c..a7a6947ab4bc5 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3998,7 +3998,6 @@ ptp_ocp_device_init(struct ptp_ocp *bp, struct pci_dev *pdev)
 	return 0;
 
 out:
-	ptp_ocp_dev_release(&bp->dev);
 	put_device(&bp->dev);
 	return err;
 }
-- 
2.40.1



