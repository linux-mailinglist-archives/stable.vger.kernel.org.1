Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FBE7CAC3D
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjJPOvm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjJPOvl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:51:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0986B4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:51:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E184C433C7;
        Mon, 16 Oct 2023 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467898;
        bh=lqKiGsdgX6pEbEBgsbkQqv7m7Na2Pfwud/4LZA1lHck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zYqZir0F6rcRHuGH8HZBNKDo/mkOsqfm8LDhboVxa3JKmb4Fh1BS5XFhemix29mOA
         57BhgSGfjfa6a45aC/HO5nUybhwTp4rpb/6O0fwuzY2HnE7U94yQq0QgBE+685Fa91
         RokcHvhxYlzn1MCxlg5cSAtLAUjM+vfAU+ZD5N2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ratheesh Kannoth <rkannoth@marvell.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 088/191] octeontx2-pf: Fix page pool frag allocation warning
Date:   Mon, 16 Oct 2023 10:41:13 +0200
Message-ID: <20231016084017.450859680@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ratheesh Kannoth <rkannoth@marvell.com>

[ Upstream commit 50e492143374c17ad89c865a1a44837b3f5c8226 ]

Since page pool param's "order" is set to 0, will result
in below warn message if interface is configured with higher
rx buffer size.

Steps to reproduce the issue.
1. devlink dev param set pci/0002:04:00.0 name receive_buffer_size \
   value 8196 cmode runtime
2. ifconfig eth0 up

[   19.901356] ------------[ cut here ]------------
[   19.901361] WARNING: CPU: 11 PID: 12331 at net/core/page_pool.c:567 page_pool_alloc_frag+0x3c/0x230
[   19.901449] pstate: 82401009 (Nzcv daif +PAN -UAO +TCO -DIT +SSBS BTYPE=--)
[   19.901451] pc : page_pool_alloc_frag+0x3c/0x230
[   19.901453] lr : __otx2_alloc_rbuf+0x60/0xbc [rvu_nicpf]
[   19.901460] sp : ffff80000f66b970
[   19.901461] x29: ffff80000f66b970 x28: 0000000000000000 x27: 0000000000000000
[   19.901464] x26: ffff800000d15b68 x25: ffff000195b5c080 x24: ffff0002a5a32dc0
[   19.901467] x23: ffff0001063c0878 x22: 0000000000000100 x21: 0000000000000000
[   19.901469] x20: 0000000000000000 x19: ffff00016f781000 x18: 0000000000000000
[   19.901472] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   19.901474] x14: 0000000000000000 x13: ffff0005ffdc9c80 x12: 0000000000000000
[   19.901477] x11: ffff800009119a38 x10: 4c6ef2e3ba300519 x9 : ffff800000d13844
[   19.901479] x8 : ffff0002a5a33cc8 x7 : 0000000000000030 x6 : 0000000000000030
[   19.901482] x5 : 0000000000000005 x4 : 0000000000000000 x3 : 0000000000000a20
[   19.901484] x2 : 0000000000001080 x1 : ffff80000f66b9d4 x0 : 0000000000001000
[   19.901487] Call trace:
[   19.901488]  page_pool_alloc_frag+0x3c/0x230
[   19.901490]  __otx2_alloc_rbuf+0x60/0xbc [rvu_nicpf]
[   19.901494]  otx2_rq_aura_pool_init+0x1c4/0x240 [rvu_nicpf]
[   19.901498]  otx2_open+0x228/0xa70 [rvu_nicpf]
[   19.901501]  otx2vf_open+0x20/0xd0 [rvu_nicvf]
[   19.901504]  __dev_open+0x114/0x1d0
[   19.901507]  __dev_change_flags+0x194/0x210
[   19.901510]  dev_change_flags+0x2c/0x70
[   19.901512]  devinet_ioctl+0x3a4/0x6c4
[   19.901515]  inet_ioctl+0x228/0x240
[   19.901518]  sock_ioctl+0x2ac/0x480
[   19.901522]  __arm64_sys_ioctl+0x564/0xe50
[   19.901525]  invoke_syscall.constprop.0+0x58/0xf0
[   19.901529]  do_el0_svc+0x58/0x150
[   19.901531]  el0_svc+0x30/0x140
[   19.901533]  el0t_64_sync_handler+0xe8/0x114
[   19.901535]  el0t_64_sync+0x1a0/0x1a4
[   19.901537] ---[ end trace 678c0bf660ad8116 ]---

Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
Link: https://lore.kernel.org/r/20231010034842.3807816-1-rkannoth@marvell.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 20ecc90d203e0..379e1510b70c0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1401,6 +1401,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 		return 0;
 	}
 
+	pp_params.order = get_order(buf_size);
 	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
 	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
 	pp_params.nid = NUMA_NO_NODE;
-- 
2.40.1



