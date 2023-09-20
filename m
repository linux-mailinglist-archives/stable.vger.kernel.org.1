Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CAE7A7C18
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjITL54 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjITL5z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:57:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AB7D7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:57:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B223C433C9;
        Wed, 20 Sep 2023 11:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211068;
        bh=U139mmxbUb7599rNLDhtspgdH7dh7BnWFb6FFFA61SM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jm8s6YUXlHyjDmzmFI4ZGvPZKIuqvmLWqMYNpiDTdc+Iv+/aXh/sMOv01PjpLBqf0
         ERNFRz5co90IPh6irKGckxW1F1F3o7LMmrDDDjhEz1OCJnCI3TCRd0L2Tuqeszy5nM
         rydohfCLmwHRRnCG0woOar2+rYtZKhaurNC7g4V8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rakshana Sridhar <rakshanas@chelsio.com>,
        Varun Prakash <varun@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 096/139] nvmet-tcp: pass iov_len instead of sg->length to bvec_set_page()
Date:   Wed, 20 Sep 2023 13:30:30 +0200
Message-ID: <20230920112839.174791103@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit 1f0bbf28940cf5edad90ab57b62aa8197bf5e836 ]

iov_len is the valid data length, so pass iov_len instead of sg->length to
bvec_set_page().

Fixes: 5bfaba275ae6 ("nvmet-tcp: don't map pages which can't come from HIGHMEM")
Signed-off-by: Rakshana Sridhar <rakshanas@chelsio.com>
Signed-off-by: Varun Prakash <varun@chelsio.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index c5759eb503d00..5e29da94f72d6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -321,7 +321,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	while (length) {
 		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
 
-		bvec_set_page(iov, sg_page(sg), sg->length,
+		bvec_set_page(iov, sg_page(sg), iov_len,
 				sg->offset + sg_offset);
 
 		length -= iov_len;
-- 
2.40.1



