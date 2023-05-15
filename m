Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE13703AEC
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbjEOR5N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243918AbjEOR4D (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:56:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1811CA74
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:54:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80CF062216
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E9EC433D2;
        Mon, 15 May 2023 17:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173249;
        bh=DoeMCd1uStccZCBdClFYyd9psEmXblRdmGQVJ48UocU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHlh9fLewjLGQ1vXZ0VWG/3EsU1vck1xMRqJSozTho4DIGzElaoARs4xN+/1nxTok
         XXLEupbcxOOwlfRdtghIyaSCtJzqiio+te3BS4swWV0xjrrH1IXhPWGWmlMcCcSBVe
         uKQiJsmQm1ByRF2C93MePsNYXJI5Swg4g2FmamKQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gao Xiang <hsiangkao@linux.alibaba.com>,
        Chao Yu <chao@kernel.org>, Sasha Levin <sashal@kernel.org>,
        syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com
Subject: [PATCH 5.4 033/282] erofs: stop parsing non-compact HEAD index if clusterofs is invalid
Date:   Mon, 15 May 2023 18:26:51 +0200
Message-Id: <20230515161723.267554103@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit cc4efd3dd2ac9f89143e5d881609747ecff04164 ]

Syzbot generated a crafted image [1] with a non-compact HEAD index of
clusterofs 33024 while valid numbers should be 0 ~ lclustersize-1,
which causes the following unexpected behavior as below:

 BUG: unable to handle page fault for address: fffff52101a3fff9
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 23ffed067 P4D 23ffed067 PUD 0
 Oops: 0000 [#1] PREEMPT SMP KASAN
 CPU: 1 PID: 4398 Comm: kworker/u5:1 Not tainted 6.3.0-rc6-syzkaller-g09a9639e56c0 #0
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
 Workqueue: erofs_worker z_erofs_decompressqueue_work
 RIP: 0010:z_erofs_decompress_queue+0xb7e/0x2b40
 ...
 Call Trace:
  <TASK>
  z_erofs_decompressqueue_work+0x99/0xe0
  process_one_work+0x8f6/0x1170
  worker_thread+0xa63/0x1210
  kthread+0x270/0x300
  ret_from_fork+0x1f/0x30

Note that normal images or images using compact indexes are not
impacted.  Let's fix this now.

[1] https://lore.kernel.org/r/000000000000ec75b005ee97fbaa@google.com

Reported-and-tested-by: syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com
Fixes: 02827e1796b3 ("staging: erofs: add erofs_map_blocks_iter")
Fixes: 152a333a5895 ("staging: erofs: add compacted compression indexes support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230410173714.104604-1-hsiangkao@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index fff5741007214..b5ee58fdd82f3 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -179,6 +179,10 @@ static int vle_legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
+		if (m->clusterofs >= 1 << vi->z_logical_clusterbits) {
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
 		break;
 	default:
-- 
2.39.2



