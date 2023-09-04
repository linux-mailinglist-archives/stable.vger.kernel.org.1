Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41986790FE9
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 04:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjIDCIs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 3 Sep 2023 22:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjIDCIr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 3 Sep 2023 22:08:47 -0400
X-Greylist: delayed 162 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Sep 2023 19:08:43 PDT
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1801.securemx.jp [210.130.202.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE3AA9
        for <stable@vger.kernel.org>; Sun,  3 Sep 2023 19:08:43 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1801) id 384261En1501091; Mon, 4 Sep 2023 11:06:01 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 38425ePM3329831; Mon, 4 Sep 2023 11:05:41 +0900
X-Iguazu-Qid: 2yAaEO0URQNLxWl940
X-Iguazu-QSIG: v=2; s=0; t=1693793140; q=2yAaEO0URQNLxWl940; m=geEFo7xm1tX5fsfk8eN+5BnXb138i6Mf0xCJVcwY+go=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1803) id 38425dwn1923936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 4 Sep 2023 11:05:39 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, sashal@kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Steve French <stfrench@microsoft.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 5.4, 5.10, 5.15] cifs: Remove duplicated include in cifsglob.h
Date:   Mon,  4 Sep 2023 11:05:29 +0900
X-TSB-HOP2: ON
Message-Id: <20230904020529.343589-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yang Li <yang.lee@linux.alibaba.com>

commit d74f4a3f6d88a2416564bc6bf937e423a4ae8f8e upstream.

./fs/cifs/cifsglob.h: linux/scatterlist.h is included more than once.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3459
Fixes: f7f291e14dde ("cifs: fix oops during encryption")
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 fs/cifs/cifsglob.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 92a7628560ccb0..80b570026c2c0d 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -29,7 +29,6 @@
 #include "cifs_fs_sb.h"
 #include "cifsacl.h"
 #include <crypto/internal/hash.h>
-#include <linux/scatterlist.h>
 #include <uapi/linux/cifs/cifs_mount.h>
 #include "smb2pdu.h"
 #include "smb2glob.h"
-- 
2.40.1


