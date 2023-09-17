Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2E07A381B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbjIQTbM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238549AbjIQTa5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:30:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E29121
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:30:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11181C433C8;
        Sun, 17 Sep 2023 19:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979051;
        bh=bdeAsP9V2ha+7lz5u0uOAgG4pD4Pxe/7DAnB60OvXlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jdFUY9XBUysyeKQLKxWNNt/T49p6d4iqb6SrQlkb/wSZwx66O+RPWuyz2ic6DP619
         GtiE47F6F+LGnd4VvaSFMboIeusZTWpSZJUtNK5ciHww8EPvMLDoL7J1XvRhHKAWXQ
         mAFrzO8NDICpoHSfSG5Qhn4uSo9B00wtnxrBa31Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 200/406] NFSv4.2: fix handling of COPY ERR_OFFLOAD_NO_REQ
Date:   Sun, 17 Sep 2023 21:10:54 +0200
Message-ID: <20230917191106.472878500@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olga Kornievskaia <kolga@netapp.com>

[ Upstream commit 5690eed941ab7e33c3c3d6b850100cabf740f075 ]

If the client sent a synchronous copy and the server replied with
ERR_OFFLOAD_NO_REQ indicating that it wants an asynchronous
copy instead, the client should retry with asynchronous copy.

Fixes: 539f57b3e0fd ("NFS handle COPY ERR_OFFLOAD_NO_REQS")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs42proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index dad32b171e677..dfeea712014b7 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -443,8 +443,9 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 				continue;
 			}
 			break;
-		} else if (err == -NFS4ERR_OFFLOAD_NO_REQS && !args.sync) {
-			args.sync = true;
+		} else if (err == -NFS4ERR_OFFLOAD_NO_REQS &&
+				args.sync != res.synchronous) {
+			args.sync = res.synchronous;
 			dst_exception.retry = 1;
 			continue;
 		} else if ((err == -ESTALE ||
-- 
2.40.1



