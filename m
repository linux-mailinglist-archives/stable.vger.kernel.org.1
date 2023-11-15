Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A287ECBC0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjKOTYP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjKOTYO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:24:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4693A1AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:24:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7119C433C8;
        Wed, 15 Nov 2023 19:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076250;
        bh=/tJaZvSAl5zZitAOYS2GiTobvrPHJcTs1oNdDyL0zz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vqJw0MeZ3qUO+vhIH0qLIA6ZvKHKG59JkndyEu8E4V0JG6JlpQZVXMQGzhPHRimiK
         HLxi/UeiQ+prnVvLR5vkDVIPrWdfpK/rCDH5Invy2XO+FSRcuJ5lvnr2WXkT9iTuAD
         +Gi7DJjyPbadp05Msmtqxy8wrwc5+vScjGlgV/+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 146/550] mptcp: properly account fastopen data
Date:   Wed, 15 Nov 2023 14:12:10 -0500
Message-ID: <20231115191610.823576645@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit bf0e96108fb6707613dd055aff5e98b02b99bb14 ]

Currently the socket level counter aggregating the received data
does not take in account the data received via fastopen.

Address the issue updating the counter as required.

Fixes: 38967f424b5b ("mptcp: track some aggregate data counters")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231023-send-net-next-20231023-2-v1-2-9dc60939d371@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/fastopen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index bceaab8dd8e46..74698582a2859 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -52,6 +52,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 
 	mptcp_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	mptcp_sk(sk)->bytes_received += skb->len;
 
 	sk->sk_data_ready(sk);
 
-- 
2.42.0



