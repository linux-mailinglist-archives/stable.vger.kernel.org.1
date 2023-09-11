Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDBC79B5B9
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344784AbjIKVOp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbjIKOZa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:25:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED12EDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:25:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1FFC433C8;
        Mon, 11 Sep 2023 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442325;
        bh=kUv2N4bWDE8iOQg4/lvkvMkOhL49QOMYvGyZmj5f3ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvZMGHiV3uyA2Jxw0U5ons/1AP9ghdomA74oHIltOuqu8nQNMubKxGuB8V8s+oJqc
         VWFlztgz/nhvk7ylETvW1PwxPuokGANE/2RkEjV73lVVZ77WY6AuOWc2YfZD2lloCa
         SOHM4Bqkr/xYwkzp7iGFBJF5vN3N6kDxMEJ3fcZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Zhang <yu.zhang@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kai Huang <kai.huang@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>
Subject: [PATCH 6.5 725/739] x86/sgx: Break up long non-preemptible delays in sgx_vepc_release()
Date:   Mon, 11 Sep 2023 15:48:44 +0200
Message-ID: <20230911134711.326265761@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Wang <jinpu.wang@ionos.com>

commit 3d7d72a34e05b23e21bafc8bfb861e73c86b31f3 upstream.

On large enclaves we hit the softlockup warning with following call trace:

	xa_erase()
	sgx_vepc_release()
	__fput()
	task_work_run()
	do_exit()

The latency issue is similar to the one fixed in:

  8795359e35bc ("x86/sgx: Silence softlockup detection when releasing large enclaves")

The test system has 64GB of enclave memory, and all is assigned to a single VM.
Release of 'vepc' takes a longer time and causes long latencies, which triggers
the softlockup warning.

Add cond_resched() to give other tasks a chance to run and reduce
latencies, which also avoids the softlockup detector.

[ mingo: Rewrote the changelog. ]

Fixes: 540745ddbc70 ("x86/sgx: Introduce virtual EPC for use by KVM guests")
Reported-by: Yu Zhang <yu.zhang@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Yu Zhang <yu.zhang@ionos.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Acked-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/sgx/virt.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -204,6 +204,7 @@ static int sgx_vepc_release(struct inode
 			continue;
 
 		xa_erase(&vepc->page_array, index);
+		cond_resched();
 	}
 
 	/*
@@ -222,6 +223,7 @@ static int sgx_vepc_release(struct inode
 			list_add_tail(&epc_page->list, &secs_pages);
 
 		xa_erase(&vepc->page_array, index);
+		cond_resched();
 	}
 
 	/*
@@ -243,6 +245,7 @@ static int sgx_vepc_release(struct inode
 
 		if (sgx_vepc_free_page(epc_page))
 			list_add_tail(&epc_page->list, &secs_pages);
+		cond_resched();
 	}
 
 	if (!list_empty(&secs_pages))


