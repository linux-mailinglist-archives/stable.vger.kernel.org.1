Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A942D6FAAD2
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjEHLGv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjEHLGd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:06:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED62B2FA2D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:05:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 659AA62A82
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7500FC433EF;
        Mon,  8 May 2023 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543931;
        bh=xanyatdq1bsbYdTHI1mkiw2Pea0+KDoWVlqAfqiP77E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDMM0BlP9NG1USNwYAmU5pSkqxy/WXL9BZeXUGGztAJpjPWUNrF1NGzv9/maBmOWx
         NWd206+Hbz43EI4vruvzoM3+scq8NdpTbjZFe6XriLVW0EvkoWV904yIOSIVJSvT7z
         bXDmRtgh3kdDCMwQ4G3v1NCGLvLjBiiMymwjZ4gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kiran K <kiran.k@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 216/694] ACPI: utils: Fix acpi_evaluate_dsm_typed() redefinition error
Date:   Mon,  8 May 2023 11:40:51 +0200
Message-Id: <20230508094439.368174890@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Kiran K <kiran.k@intel.com>

[ Upstream commit 2c5a06e5505a716387a4d86f1f39de506836435a ]

acpi_evaluate_dsm_typed() needs to be gaurded with CONFIG_ACPI to avoid
a redefintion error when the stub is also enabled.

In file included from ../drivers/bluetooth/btintel.c:13:
../include/acpi/acpi_bus.h:57:1: error: redefinition of 'acpi_evaluate_dsm_typed'
   57 | acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid,..
      | ^~~~~~~~~~~~~~~~~~~~~~~
In file included from ../drivers/bluetooth/btintel.c:12:
../include/linux/acpi.h:967:34: note: previous definition of
'acpi_evaluate_dsm_typed' with type 'union acpi_object *(void *,
const guid_t *, u64,  u64,  union acpi_object *, acpi_object_type)'
{aka 'union acpi_object *(void *, const guid_t *, long long unsigned int,
long long unsigned int,  union acpi_object *, unsigned int)'}
  967 | static inline union acpi_object
*acpi_evaluate_dsm_typed(acpi_handle handle,

Fixes: 1b94ad7ccc21 ("ACPI: utils: Add acpi_evaluate_dsm_typed() and acpi_check_dsm() stubs")
Signed-off-by: Kiran K <kiran.k@intel.com>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/acpi/acpi_bus.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 57acb895c0381..a6affc0550b0f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -52,7 +52,7 @@ bool acpi_dock_match(acpi_handle handle);
 bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs);
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
 			u64 rev, u64 func, union acpi_object *argv4);
-
+#ifdef CONFIG_ACPI
 static inline union acpi_object *
 acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 			u64 func, union acpi_object *argv4,
@@ -68,6 +68,7 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 
 	return obj;
 }
+#endif
 
 #define	ACPI_INIT_DSM_ARGV4(cnt, eles)			\
 	{						\
-- 
2.39.2



