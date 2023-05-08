Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FF86FA655
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjEHKSg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbjEHKSV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43B6D2E2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:18:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A80D61031
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52560C4339B;
        Mon,  8 May 2023 10:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541099;
        bh=twQBlo0z1/wngMaLnICujCMwfJjvC6WMoe/YUvdsOSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXHr1jsdEx8VzxNhzIfA/28NBeduEIOXzNI89UtFbmB0svD0jQIJLcctRkLVvR5s2
         z/CDW2WT/Gp/Z2CUXuR5QAlf/Yfk6zP/7kgXAsi2OSy5FMkiK8/0q0LNvI7IpOSSUh
         pvmS3JuoQCjFdKHg9UBYcnFkv0uMEupbHZc21sVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 6.1 591/611] dm clone: call kmem_cache_destroy() in dm_clone_init() error path
Date:   Mon,  8 May 2023 11:47:13 +0200
Message-Id: <20230508094441.111730617@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mike Snitzer <snitzer@kernel.org>

commit 6827af4a9a9f5bb664c42abf7c11af4978d72201 upstream.

Otherwise the _hydration_cache will leak if dm_register_target() fails.

Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-clone-target.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -2205,6 +2205,7 @@ static int __init dm_clone_init(void)
 	r = dm_register_target(&clone_target);
 	if (r < 0) {
 		DMERR("Failed to register clone target");
+		kmem_cache_destroy(_hydration_cache);
 		return r;
 	}
 


