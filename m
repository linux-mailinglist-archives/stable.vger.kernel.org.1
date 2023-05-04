Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC606F63DF
	for <lists+stable@lfdr.de>; Thu,  4 May 2023 06:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjEDEKG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 4 May 2023 00:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjEDEKF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 4 May 2023 00:10:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEDF1FE2;
        Wed,  3 May 2023 21:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47B9B63172;
        Thu,  4 May 2023 04:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87905C433EF;
        Thu,  4 May 2023 04:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683173403;
        bh=lTuua+4JAOfkciipChX6mQdrAKwFqWKQRQW16YJov6U=;
        h=From:To:Cc:Subject:Date:From;
        b=gu4oxcrajsjhIQD2iC1o2NMHyiEWPjuKyooncQXq4qqVXrt5qAqNUVNl3ps35RZzC
         erEQdx9kW9W0Zqq1t13qexcErAX6/3iL0xKKAyr2w6xS1Yv+LDYd/UqZvAFSdk2Ggf
         h4KQS+p3f/4kEd3DrDHIe7PR09q7ETjAJ1HVZQvFHKSNNz8HFpSGjta3QY8W2w6flR
         S2nBnn27BCF794V5A7RZbGm/4fdFe1Lr567GIzcAYPgDxpaLao8J305A9l0GCrecjB
         S3cMga6vo4gty9JFtvPYjw48fBFzPYR+ALUeNrnwouDAHC/RQqxjJIGyFkPgC7waXI
         58/Xx6fsqtPAA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 5.10 0/3] blk-crypto fixes for 5.10
Date:   Wed,  3 May 2023 21:09:38 -0700
Message-Id: <20230504040941.152614-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This series backports some blk-crypto fixes to 5.10.

Eric Biggers (3):
  blk-mq: release crypto keyslot before reporting I/O complete
  blk-crypto: make blk_crypto_evict_key() return void
  blk-crypto: make blk_crypto_evict_key() more robust

 block/blk-core.c            |  7 ++++
 block/blk-crypto-internal.h | 25 +++++++++++---
 block/blk-crypto.c          | 69 +++++++++++++++++++++----------------
 block/blk-merge.c           |  2 ++
 block/blk-mq.c              |  2 +-
 block/keyslot-manager.c     | 43 +++++++++++------------
 include/linux/blk-crypto.h  |  4 +--
 7 files changed, 94 insertions(+), 58 deletions(-)


base-commit: f1b32fda06d2cfb8eea9680b0ba7a8b0d5b81eeb
-- 
2.40.1

