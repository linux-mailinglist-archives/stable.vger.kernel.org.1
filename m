Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268687E22FF
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjKFNHm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjKFNHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:07:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7B8BD
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:07:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F283C433C7;
        Mon,  6 Nov 2023 13:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276058;
        bh=naU3X0ITaSUJprCr+rapqMX0gZyk+jLcfVcnwzqa6tA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmInH/gfHu7z2VfCpN8fqtHoyyKpno9M3ec75dEetSnXarHWwUcpqDK1y6FUtKKRF
         V4mvq03B86p5ftNjVFLbvHXtpEkertXhaZIH5HMKl5mkMO+mgKrPJ0UzKNnjCLhgvO
         VmVSStpcs3Cq9XmpHr667p+pQTaExLt+51TF2nJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org, lee@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hangyu Hua <hbh25y@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4.14 27/48] rpmsg: Fix possible refcount leak in rpmsg_register_device_override()
Date:   Mon,  6 Nov 2023 14:03:18 +0100
Message-ID: <20231106130258.793865287@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.862199836@linuxfoundation.org>
References: <20231106130257.862199836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangyu Hua <hbh25y@gmail.com>

commit d7bd416d35121c95fe47330e09a5c04adbc5f928 upstream.

rpmsg_register_device_override need to call put_device to free vch when
driver_set_override fails.

Fix this by adding a put_device() to the error path.

Fixes: bb17d110cbf2 ("rpmsg: Fix calling device_lock() on non-initialized device")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Link: https://lore.kernel.org/r/20220624024120.11576-1-hbh25y@gmail.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
(cherry picked from commit d7bd416d35121c95fe47330e09a5c04adbc5f928)
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rpmsg/rpmsg_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -499,6 +499,7 @@ int rpmsg_register_device_override(struc
 					  strlen(driver_override));
 		if (ret) {
 			dev_err(dev, "device_set_override failed: %d\n", ret);
+			put_device(dev);
 			return ret;
 		}
 	}


