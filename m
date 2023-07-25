Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ABA76160D
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbjGYLgF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjGYLgF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:36:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EF71BD7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:35:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 052616166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8D1C433C8;
        Tue, 25 Jul 2023 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284949;
        bh=puvGtCHrfFjPOy2iCaOxBGZxvH48hW5OyqAOqpcDZmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddXxWJE0uOo50la/ilGcNINIa4j1Rsd6vlVMkXJeB+sJ0rcQfB2GtFHqxsBr55tOt
         YrbHdUXHg7jx4snMre0ggce1RMM00hop35BgahxHEmNnY4Bk58ou2pUPEHgdLC3Zp3
         mM20g6rRzxqEMJOwerb5Q31cKBhSCXTg4tb0UKXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH 5.4 006/313] drm/i915: Initialise outparam for error return from wait_for_register
Date:   Tue, 25 Jul 2023 12:42:39 +0200
Message-ID: <20230725104521.465745459@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

commit b79ffa914ede785a721f42d8ee3ce7b8eeede2bb upstream.

Just in case the caller passes in 0 for both slow&fast timeouts, make
sure we initialise the stack value returned. Add an assert so that we
don't make the mistake of passing 0 timeouts for the wait.

drivers/gpu/drm/i915/intel_uncore.c:2011 __intel_wait_for_register_fw() error: uninitialized symbol 'reg_value'.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200916105022.28316-1-chris@chris-wilson.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/intel_uncore.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_uncore.c
+++ b/drivers/gpu/drm/i915/intel_uncore.c
@@ -1926,13 +1926,14 @@ int __intel_wait_for_register_fw(struct
 				 unsigned int slow_timeout_ms,
 				 u32 *out_value)
 {
-	u32 reg_value;
+	u32 reg_value = 0;
 #define done (((reg_value = intel_uncore_read_fw(uncore, reg)) & mask) == value)
 	int ret;
 
 	/* Catch any overuse of this function */
 	might_sleep_if(slow_timeout_ms);
 	GEM_BUG_ON(fast_timeout_us > 20000);
+	GEM_BUG_ON(!fast_timeout_us && !slow_timeout_ms);
 
 	ret = -ETIMEDOUT;
 	if (fast_timeout_us && fast_timeout_us <= 20000)


