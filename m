Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF747BDF32
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376771AbjJIN1b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376791AbjJIN1a (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:27:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4282099
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:27:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8050CC433C8;
        Mon,  9 Oct 2023 13:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858048;
        bh=T1HCmUKgadPmgBC3OLAaSZCc3Q+kV+pQrFPgs/bPpq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5tMnE2R6cjySfqFWolPAcPK1pn+MWf0O9hLqR1qdpTOtWOOCTx6pxPECMvMEXWXD
         d/wj7n11bxl1zOM9tHpJsW/vK9JhZMzW2bWa2QHdvR+sJmWZQGvLZDgObDKy930dSF
         wSID+tn+XlJsvQxQZxfPjavG8OcJiUUy3RPYJu/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xin Long <lucien.xin@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 60/75] sctp: update hb timer immediately after users change hb_interval
Date:   Mon,  9 Oct 2023 15:02:22 +0200
Message-ID: <20231009130113.359749808@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 1f4e803cd9c9166eb8b6c8b0b8e4124f7499fc07 ]

Currently, when hb_interval is changed by users, it won't take effect
until the next expiry of hb timer. As the default value is 30s, users
have to wait up to 30s to wait its hb_interval update to work.

This becomes pretty bad in containers where a much smaller value is
usually set on hb_interval. This patch improves it by resetting the
hb timer immediately once the value of hb_interval is updated by users.

Note that we don't address the already existing 'problem' when sending
a heartbeat 'on demand' if one hb has just been sent(from the timer)
mentioned in:

  https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg590224.html

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/r/75465785f8ee5df2fb3acdca9b8fafdc18984098.1696172660.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 36a37fef27719..57acf7ed80de3 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -2452,6 +2452,7 @@ static int sctp_apply_peer_addr_params(struct sctp_paddrparams *params,
 			if (trans) {
 				trans->hbinterval =
 				    msecs_to_jiffies(params->spp_hbinterval);
+				sctp_transport_reset_hb_timer(trans);
 			} else if (asoc) {
 				asoc->hbinterval =
 				    msecs_to_jiffies(params->spp_hbinterval);
-- 
2.40.1



