Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EC77BDDA6
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376835AbjJINL6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376859AbjJINLh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:11:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983841704
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:10:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69119C433CA;
        Mon,  9 Oct 2023 13:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857045;
        bh=Trpygucir1k3YN21eGca4cMtV84JBn6+1kmYZbd37gA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQzxBupkR4IxXFTFd5T8qYI31/ZIihb7Sxev2K9ITT6iZFsnANqQFoGmBxL99YQmI
         Um227hgtpoxy7oYAjpTbkAYL1vqdoxb8sBXPl0AluUj4xCMgSPNLm+szZsBYWmQY20
         MG+h6uNeUj04tRT5oFwRI/ODMUocadsPQSv8YkPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yao Xiao <xiaoyao@rock-chips.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 078/163] Bluetooth: Delete unused hci_req_prepare_suspend() declaration
Date:   Mon,  9 Oct 2023 15:00:42 +0200
Message-ID: <20231009130126.207645049@linuxfoundation.org>
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

From: Yao Xiao <xiaoyao@rock-chips.com>

[ Upstream commit cbaabbcdcbd355f0a1ccc09a925575c51c270750 ]

hci_req_prepare_suspend() has been deprecated in favor of
hci_suspend_sync().

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Signed-off-by: Yao Xiao <xiaoyao@rock-chips.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_request.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index b9c5a98238374..0be75cf0efed8 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -71,7 +71,5 @@ struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn);
 void hci_req_add_le_passive_scan(struct hci_request *req);
 
-void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next);
-
 void hci_request_setup(struct hci_dev *hdev);
 void hci_request_cancel_all(struct hci_dev *hdev);
-- 
2.40.1



