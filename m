Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CF375CD80
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjGUQMP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjGUQL5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B5A3A82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:11:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB7A061D2A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE76C433C7;
        Fri, 21 Jul 2023 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955889;
        bh=HKBEmBd27pcF6D8aceliQSWbvgzbOnfwvtRzJVyaHd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwsP6k92KDzudaEHhEVRATtqByG6/RcgD5hkTz/TnkcmUTCtDo05FglmXT7b4ddDv
         pQRMnSLDhMvfZZByXzDJjNrLppC1qfHctHstZB2EvNq+0NutISGq00HuWkEHuU336O
         sBMr57/0ztCbs4v2h6dFUvj3HkDnXRVylqXz9XCg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 065/292] HID: hyperv: avoid struct memcpy overrun warning
Date:   Fri, 21 Jul 2023 18:02:54 +0200
Message-ID: <20230721160531.583982861@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 5f151364b1da6bd217632fd4ee8cc24eaf66a497 ]

A previous patch addressed the fortified memcpy warning for most
builds, but I still see this one with gcc-9:

In file included from include/linux/string.h:254,
                 from drivers/hid/hid-hyperv.c:8:
In function 'fortify_memcpy_chk',
    inlined from 'mousevsc_on_receive' at drivers/hid/hid-hyperv.c:272:3:
include/linux/fortify-string.h:583:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  583 |    __write_overflow_field(p_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

My guess is that the WARN_ON() itself is what confuses gcc, so it no
longer sees that there is a correct range check. Rework the code in a
way that helps readability and avoids the warning.

Fixes: 542f25a94471 ("HID: hyperv: Replace one-element array with flexible-array member")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20230705140242.844167-1-arnd@kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-hyperv.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 49d4a26895e76..f33485d83d24f 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -258,19 +258,17 @@ static void mousevsc_on_receive(struct hv_device *device,
 
 	switch (hid_msg_hdr->type) {
 	case SYNTH_HID_PROTOCOL_RESPONSE:
+		len = struct_size(pipe_msg, data, pipe_msg->size);
+
 		/*
 		 * While it will be impossible for us to protect against
 		 * malicious/buggy hypervisor/host, add a check here to
 		 * ensure we don't corrupt memory.
 		 */
-		if (struct_size(pipe_msg, data, pipe_msg->size)
-			> sizeof(struct mousevsc_prt_msg)) {
-			WARN_ON(1);
+		if (WARN_ON(len > sizeof(struct mousevsc_prt_msg)))
 			break;
-		}
 
-		memcpy(&input_dev->protocol_resp, pipe_msg,
-				struct_size(pipe_msg, data, pipe_msg->size));
+		memcpy(&input_dev->protocol_resp, pipe_msg, len);
 		complete(&input_dev->wait_event);
 		break;
 
-- 
2.39.2



