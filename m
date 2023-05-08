Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454E66FA3F1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjEHJx1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjEHJxU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:53:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9725C23A0B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:53:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A89962207
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B01C433D2;
        Mon,  8 May 2023 09:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539598;
        bh=4IMqw7B48W9IWVbDxGbY5899AKY6+X8OaWpTGG2ZuuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pji05HC9z/CxypeeIHTRJ9ZX9obwRGVQ+glTFqZWi8yYdy3LqB+zu3SgTvMg648fl
         CoHYQrpuLXEuXoaLCm9Oezemr8wdPBhu5syiEiQT1CqOuFi7HKNuGMub6H7mq9hCu6
         eWo06Ld8u7SAI6WPAvD+PeKZyIApG9cLIVAlTCmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Biggers <ebiggers@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 044/611] blk-crypto: Add a missing include directive
Date:   Mon,  8 May 2023 11:38:06 +0200
Message-Id: <20230508094423.283193389@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Bart Van Assche <bvanassche@acm.org>

commit 85168d416e5d3184b77dbec8fee75c9439894afa upstream.

Allow the compiler to verify consistency of function declarations and
function definitions. This patch fixes the following sparse errors:

block/blk-crypto-profile.c:241:14: error: no previous prototype for ‘blk_crypto_get_keyslot’ [-Werror=missing-prototypes]
  241 | blk_status_t blk_crypto_get_keyslot(struct blk_crypto_profile *profile,
      |              ^~~~~~~~~~~~~~~~~~~~~~
block/blk-crypto-profile.c:318:6: error: no previous prototype for ‘blk_crypto_put_keyslot’ [-Werror=missing-prototypes]
  318 | void blk_crypto_put_keyslot(struct blk_crypto_keyslot *slot)
      |      ^~~~~~~~~~~~~~~~~~~~~~
block/blk-crypto-profile.c:344:6: error: no previous prototype for ‘__blk_crypto_cfg_supported’ [-Werror=missing-prototypes]
  344 | bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
block/blk-crypto-profile.c:373:5: error: no previous prototype for ‘__blk_crypto_evict_key’ [-Werror=missing-prototypes]
  373 | int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
      |     ^~~~~~~~~~~~~~~~~~~~~~

Cc: Eric Biggers <ebiggers@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20221123172923.434339-1-bvanassche@acm.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-crypto-profile.c |    1 +
 1 file changed, 1 insertion(+)

--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -32,6 +32,7 @@
 #include <linux/wait.h>
 #include <linux/blkdev.h>
 #include <linux/blk-integrity.h>
+#include "blk-crypto-internal.h"
 
 struct blk_crypto_keyslot {
 	atomic_t slot_refs;


