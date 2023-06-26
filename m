Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C215673E8E8
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjFZSao (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjFZSaF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:30:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BE81704
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BD5560E76
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C86C433C9;
        Mon, 26 Jun 2023 18:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804203;
        bh=rrs4nCHkru8iasTk9B7yIUjabFLcWPWOQER3r64I9c8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iG9WwYnd4EtX0Hiva11672EU6EJxFdsmOVLD9pqCTTJhKWiGMOKheZOVCqA0z1U0R
         /mloXKB5l2i20DggU2r7QSb/0BWIWR/UsbeH2DZSAFjbqh5xyESRd88gB58eEZ+j6u
         6y21Jxwhe2pUc33kozSCBMPhmnnrUjRkXMJSzsDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Starks <jostarks@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 6.1 049/170] Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to scan present CPUs
Date:   Mon, 26 Jun 2023 20:10:18 +0200
Message-ID: <20230626180802.765220185@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

commit 320805ab61e5f1e2a5729ae266e16bec2904050c upstream.

vmbus_wait_for_unload() may be called in the panic path after other
CPUs are stopped. vmbus_wait_for_unload() currently loops through
online CPUs looking for the UNLOAD response message. But the values of
CONFIG_KEXEC_CORE and crash_kexec_post_notifiers affect the path used
to stop the other CPUs, and in one of the paths the stopped CPUs
are removed from cpu_online_mask. This removal happens in both
x86/x64 and arm64 architectures. In such a case, vmbus_wait_for_unload()
only checks the panic'ing CPU, and misses the UNLOAD response message
except when the panic'ing CPU is CPU 0. vmbus_wait_for_unload()
eventually times out, but only after waiting 100 seconds.

Fix this by looping through *present* CPUs in vmbus_wait_for_unload().
The cpu_present_mask is not modified by stopping the other CPUs in the
panic path, nor should it be.

Also, in a CoCo VM the synic_message_page is not allocated in
hv_synic_alloc(), but is set and cleared in hv_synic_enable_regs()
and hv_synic_disable_regs() such that it is set only when the CPU is
online.  If not all present CPUs are online when vmbus_wait_for_unload()
is called, the synic_message_page might be NULL. Add a check for this.

Fixes: cd95aad55793 ("Drivers: hv: vmbus: handle various crash scenarios")
Cc: stable@vger.kernel.org
Reported-by: John Starks <jostarks@microsoft.com>
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/1684422832-38476-1-git-send-email-mikelley@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hv/channel_mgmt.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -829,11 +829,22 @@ static void vmbus_wait_for_unload(void)
 		if (completion_done(&vmbus_connection.unload_event))
 			goto completed;
 
-		for_each_online_cpu(cpu) {
+		for_each_present_cpu(cpu) {
 			struct hv_per_cpu_context *hv_cpu
 				= per_cpu_ptr(hv_context.cpu_context, cpu);
 
+			/*
+			 * In a CoCo VM the synic_message_page is not allocated
+			 * in hv_synic_alloc(). Instead it is set/cleared in
+			 * hv_synic_enable_regs() and hv_synic_disable_regs()
+			 * such that it is set only when the CPU is online. If
+			 * not all present CPUs are online, the message page
+			 * might be NULL, so skip such CPUs.
+			 */
 			page_addr = hv_cpu->synic_message_page;
+			if (!page_addr)
+				continue;
+
 			msg = (struct hv_message *)page_addr
 				+ VMBUS_MESSAGE_SINT;
 
@@ -867,11 +878,14 @@ completed:
 	 * maybe-pending messages on all CPUs to be able to receive new
 	 * messages after we reconnect.
 	 */
-	for_each_online_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		page_addr = hv_cpu->synic_message_page;
+		if (!page_addr)
+			continue;
+
 		msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
 		msg->header.message_type = HVMSG_NONE;
 	}


