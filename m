Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8177DD573
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbjJaRvA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbjJaRu6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:50:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6B5A2
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:50:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ABEC433C8;
        Tue, 31 Oct 2023 17:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774656;
        bh=Jn/fscTC40WucxoDOG6mkkxJ7fZ3oQ/3NaXDbI8D2JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOzFLRvOw/FOUWTrzpVyk+K80EyU5+12NFpmt3QtuMp6bsHPyWLukxPNKadNGFzDO
         +tpy2PdIgpYnSE2CoKQC6Z+0sMtHVVBkUcXqOsyXk1n1UO6fIbDggXtCFRU66HiCYJ
         auqO/IeMj6iG0I+LHB5+RZ2WyC3QZ7W6LC1aQI38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6.5 098/112] misc: fastrpc: Unmap only if buffer is unmapped from DSP
Date:   Tue, 31 Oct 2023 18:01:39 +0100
Message-ID: <20231031165904.376411753@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

commit 509143385db364c67556a914bef6c9a42fd2c74c upstream.

For unmapping any buffer from kernel, it should first be unmapped
from DSP. In case unmap from DSP request fails, the map should not
be removed from kernel as it might lead to SMMU faults and other
memory issues.

Fixes: 5c1b97c7d7b7 ("misc: fastrpc: add support for FASTRPC_IOCTL_MEM_MAP/UNMAP")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20231013122007.174464-5-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1980,11 +1980,13 @@ static int fastrpc_req_mem_unmap_impl(st
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
 	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
 				      &args[0]);
-	fastrpc_map_put(map);
-	if (err)
+	if (err) {
 		dev_err(dev, "unmmap\tpt fd = %d, 0x%09llx error\n",  map->fd, map->raddr);
+		return err;
+	}
+	fastrpc_map_put(map);
 
-	return err;
+	return 0;
 }
 
 static int fastrpc_req_mem_unmap(struct fastrpc_user *fl, char __user *argp)


