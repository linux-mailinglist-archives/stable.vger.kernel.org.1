Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB4078AA59
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjH1KVn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjH1KVL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:21:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85241119
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:20:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6687E60F95
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D1EC433C8;
        Mon, 28 Aug 2023 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218051;
        bh=AyyoPJC8TvlQnMoaogIbi65ViLopIxqkmh5ukjLqWio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRn9AIYbIExn4gCxKysXXxxFpPPnhiPWpMg2kucql6/819PIRPVsmhtHHUq3QEwZ6
         hLBjAsSGKMObPtvadr7908ZIRJZI7mPb4bUtWw8b7DAz0YsNWqA/Dcdufv06AB4wqD
         L5QfLmwYTrfzpsKYqt6+RLm8eLAa/pp7WJT1IVak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Michael <fedora.dm0@gmail.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH 6.4 070/129] drm/panfrost: Skip speed binning on EOPNOTSUPP
Date:   Mon, 28 Aug 2023 12:12:29 +0200
Message-ID: <20230828101159.673979015@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Michael <fedora.dm0@gmail.com>

commit f19df6e4de64b7fc6d71f192aa9ff3b701e4bade upstream.

Encountered on an ARM Mali-T760 MP4, attempting to read the nvmem
variable can also return EOPNOTSUPP instead of ENOENT when speed
binning is unsupported.

Cc: <stable@vger.kernel.org>
Fixes: 7d690f936e9b ("drm/panfrost: Add basic support for speed binning")
Signed-off-by: David Michael <fedora.dm0@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Link: https://patchwork.freedesktop.org/patch/msgid/87msyryd7y.fsf@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 58dfb15a8757..e78de99e9933 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -96,7 +96,7 @@ static int panfrost_read_speedbin(struct device *dev)
 		 * keep going without it; any other error means that we are
 		 * supposed to read the bin value, but we failed doing so.
 		 */
-		if (ret != -ENOENT) {
+		if (ret != -ENOENT && ret != -EOPNOTSUPP) {
 			DRM_DEV_ERROR(dev, "Cannot read speed-bin (%d).", ret);
 			return ret;
 		}
-- 
2.42.0



