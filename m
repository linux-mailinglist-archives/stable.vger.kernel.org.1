Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD077559E2
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 05:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjGQDLO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 23:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjGQDLM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 23:11:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2793AE41;
        Sun, 16 Jul 2023 20:11:08 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R46TG148ZzNmPY;
        Mon, 17 Jul 2023 11:07:46 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 17 Jul
 2023 11:11:04 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <amir73il@gmail.com>, <gregkh@linuxfoundation.org>,
        <miklos@szeredi.hu>
CC:     <linux-unionfs@vger.kernel.org>, <stable@vger.kernel.org>,
        <sashal@kernel.org>
Subject: [PATCH 6.1 0/2] ovl: fix null pointer dereference in ovl_get_acl rcu path
Date:   Mon, 17 Jul 2023 11:09:02 +0800
Message-ID: <20230717030904.1669754-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Zhihao Cheng (2):
  ovl: let helper ovl_i_path_real() return the realinode
  ovl: fix null pointer dereference in ovl_get_acl_rcu()

 fs/overlayfs/inode.c     | 12 ++++++------
 fs/overlayfs/overlayfs.h |  2 +-
 fs/overlayfs/util.c      |  7 ++++---
 3 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.39.2

