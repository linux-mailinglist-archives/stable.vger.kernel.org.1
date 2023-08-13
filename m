Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45BD77AC2A
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjHMVaC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjHMVaB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C37010DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC8CE62AF8
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1D8C433C7;
        Sun, 13 Aug 2023 21:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962202;
        bh=Pgcw3N54tL+sWquBCVfFx6nLtmYeczE7L2bOtp0Sueo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yJsW/xeqApjsa5nsI2u5jbqDxiabPll2dneE1xrU862SXECxgXO3AlmFC1sNTDec8
         MEtmLWyJvcDV8lIbBow3XH5BT6mr1jtRPhd4LjbyFGNBQE0WBHqc8gO/dee2OC1OED
         vb7/iGIanUT2POXA4E2GZK3Qb2YiBuX+dXVgc4Jw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.4 150/206] RDMA/bnxt_re: Properly order ib_device_unalloc() to avoid UAF
Date:   Sun, 13 Aug 2023 23:18:40 +0200
Message-ID: <20230813211729.325118514@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
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

From: Selvin Xavier <selvin.xavier@broadcom.com>

commit 5363fc488da579923edf6a2fdca3d3b651dd800b upstream.

ib_dealloc_device() should be called only after device cleanup.  Fix the
dealloc sequence.

Fixes: 6d758147c7b8 ("RDMA/bnxt_re: Use auxiliary driver interface")
Link: https://lore.kernel.org/r/1691642677-21369-2-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1425,8 +1425,8 @@ static void bnxt_re_remove(struct auxili
 	}
 	bnxt_re_setup_cc(rdev, false);
 	ib_unregister_device(&rdev->ibdev);
-	ib_dealloc_device(&rdev->ibdev);
 	bnxt_re_dev_uninit(rdev);
+	ib_dealloc_device(&rdev->ibdev);
 skip_remove:
 	mutex_unlock(&bnxt_re_mutex);
 }


