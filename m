Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724CE7D3348
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjJWL2n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjJWL2m (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:28:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B3AC1
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:28:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D23C433C8;
        Mon, 23 Oct 2023 11:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060520;
        bh=HAUlVMis6ioY8cP9KhvnvX7F0qvc3iT/iIC1GQpgc6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSgwhOcsaYq5Y9JrNfIC2J1pB9PdSsYR1SlVf2DW02uCG9TbyDTUsNYghLXAen0f+
         lY0SXFA6heWAuWZE8tsDiZIzvawr4O09i8NZ09UpVMTF2LB568LJSEorUm3la0vjBe
         4MilBY/xeeNUP6CKRxSDP25BxKbdEc2W0fwAKVkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.1 173/196] platform/x86: intel-uncore-freq: Conditionally create attribute for read frequency
Date:   Mon, 23 Oct 2023 12:57:18 +0200
Message-ID: <20231023104833.307819145@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit 4d73c6772ab771cbbe7e46a73e7c78ba490350fa upstream.

When the current uncore frequency can't be read, don't create attribute
"current_freq_khz" as any read will fail later. Some user space
applications like turbostat fail to continue with the failure. So, check
error during attribute creation.

Fixes: 414eef27283a ("platform/x86/intel/uncore-freq: Display uncore current frequency")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20231004181915.1887913-1-srinivas.pandruvada@linux.intel.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -153,7 +153,7 @@ show_uncore_data(initial_max_freq_khz);
 
 static int create_attr_group(struct uncore_data *data, char *name)
 {
-	int ret, index = 0;
+	int ret, freq, index = 0;
 
 	init_attribute_rw(max_freq_khz);
 	init_attribute_rw(min_freq_khz);
@@ -165,7 +165,11 @@ static int create_attr_group(struct unco
 	data->uncore_attrs[index++] = &data->min_freq_khz_dev_attr.attr;
 	data->uncore_attrs[index++] = &data->initial_min_freq_khz_dev_attr.attr;
 	data->uncore_attrs[index++] = &data->initial_max_freq_khz_dev_attr.attr;
-	data->uncore_attrs[index++] = &data->current_freq_khz_dev_attr.attr;
+
+	ret = uncore_read_freq(data, &freq);
+	if (!ret)
+		data->uncore_attrs[index++] = &data->current_freq_khz_dev_attr.attr;
+
 	data->uncore_attrs[index] = NULL;
 
 	data->uncore_attr_group.name = name;


