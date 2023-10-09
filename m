Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFEF7BDDB2
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376809AbjJINMb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376977AbjJINMN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:12:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47091BDF
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:11:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF372C433CC;
        Mon,  9 Oct 2023 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857066;
        bh=KIUVSilA47RqfjFvLPfuKDnnNsX+gUtj9Nhnw77kYpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAjcO8UmBZciSL5H9pAeTuohcO20lt8YdaJMddvwdpnNy3tADA36kBQ5rcgKLP8cn
         UfTt8OIDn/DID8BEUtGR3qf8tnnKKVZ4V+gcG5sIMtT/iBnXqVmzDU7lfDOXA5squ0
         ZnC9oKDdGfhM/IrpgvNXz0XpJUQ9p6lDnmfDpD3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 084/163] rtla/timerlat: Do not stop user-space if a cpu is offline
Date:   Mon,  9 Oct 2023 15:00:48 +0200
Message-ID: <20231009130126.365453664@linuxfoundation.org>
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

From: Daniel Bristot de Oliveira <bristot@kernel.org>

[ Upstream commit e8c44d3b713b96cda055a23b21e8c4f931dd159f ]

If no CPU list is passed, timerlat in user-space will dispatch
one thread per sysconf(_SC_NPROCESSORS_CONF). However, not all
CPU might be available, for instance, if HT is disabled.

Currently, rtla timerlat is stopping the session if an user-space
thread cannot set affinity to a CPU, or if a running user-space
thread is killed. However, this is too restrictive.

So, reduce the error to a debug message, and rtla timerlat run as
long as there is at least one user-space thread alive.

Link: https://lore.kernel.org/lkml/59cf2c882900ab7de91c6ee33b382ac7fa6b4ed0.1694781909.git.bristot@kernel.org

Fixes: cdca4f4e5e8e ("rtla/timerlat_top: Add timerlat user-space support")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/timerlat_u.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index 05e310696dd5c..01dbf9a6b5a51 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -45,7 +45,7 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
 
 	retval = sched_setaffinity(gettid(), sizeof(set), &set);
 	if (retval == -1) {
-		err_msg("Error setting user thread affinity\n");
+		debug_msg("Error setting user thread affinity %d, is the CPU online?\n", cpu);
 		exit(1);
 	}
 
@@ -193,7 +193,9 @@ void *timerlat_u_dispatcher(void *data)
 					procs_count--;
 				}
 			}
-			break;
+
+			if (!procs_count)
+				break;
 		}
 
 		sleep(1);
-- 
2.40.1



