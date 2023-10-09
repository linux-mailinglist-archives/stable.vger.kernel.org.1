Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAA27BDE6B
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377038AbjJINTb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377040AbjJINTb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:19:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC9D94
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:19:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369EEC433CB;
        Mon,  9 Oct 2023 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857569;
        bh=MB9J7nd3O7gX0LG7cx2c15shubYHPS22Zx08CebNJYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTGbC80aeGOZATs2LCT6BY6BGFFQwEURYsQhVNlOwsFy+bgCLTTvmCsOM6ULzgWP8
         6B8lVuFd0Euq6Tx4o2DJLRyh/eiO9TLqjmQ5za/LjwWB13FB42b9S2KlsNO1DKElxe
         GJAnDRbj9NB8TII7E9XVQmP7JSgn9GlLi5TD5aK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yao Xiao <xiaoyao@rock-chips.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 088/162] Bluetooth: Delete unused hci_req_prepare_suspend() declaration
Date:   Mon,  9 Oct 2023 15:01:09 +0200
Message-ID: <20231009130125.349909918@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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



