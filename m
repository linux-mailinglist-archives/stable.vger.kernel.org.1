Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA3979BC1B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349089AbjIKVca (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbjIKOso (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:48:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3259F106
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:48:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753BAC433C8;
        Mon, 11 Sep 2023 14:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443718;
        bh=1B19DuM9AqzOLMNiIGZwvMcAz+YEcFB5PqjD5CSBEmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAHmwJM1f8PvE3k1Ds4NWn13d3gRGsarCP1k3ZJeiyjgYlkRYE+JyHyNwblVbV7Jw
         0yInItFwXGOb8xWDc1NHplYS1xcv+FV0NZ/gTDwdogSBZkwibh800Ik2q/nS2R99gM
         Uee5h+AH6zsr6MA8O+9Zjazsfun7GjKisnOygcdI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 476/737] NFSv4.2: fix handling of COPY ERR_OFFLOAD_NO_REQ
Date:   Mon, 11 Sep 2023 15:45:35 +0200
Message-ID: <20230911134703.876163708@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

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
index 5d7e0511f3513..d5ec3d5568da5 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -471,8 +471,9 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
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



