Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C707ED0C3
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343533AbjKOT5X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbjKOT5X (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:57:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33181A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:57:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7C3C433C7;
        Wed, 15 Nov 2023 19:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078239;
        bh=u2ahk3sS4hkb0XTR0SrLd9spFIeUkTKmWY/HJxZnyUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LInZAcDEjreS7CUYRIZtfxPkxQDnSuQpWF5+JB+bqds4SDO+VJTvuH49QRO+T4x40
         g1lkoUXy+VUql0VKrtm9Qd+E/fEr5VsuvhsF0Z1aT4Pto2e9CVZDW4QH57s6tSxZIV
         xCQmq3a0OpGITCRVQ8AL7wSGy08oiEGFTo6rcsqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 190/379] KEYS: Include linux/errno.h in linux/verification.h
Date:   Wed, 15 Nov 2023 14:24:25 -0500
Message-ID: <20231115192656.341193846@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 0a596b0682a7ce37e26c36629816f105c6459d06 ]

Add inclusion of linux/errno.h as otherwise the reference to EINVAL
may be invalid.

Fixes: f3cf4134c5c6 ("bpf: Add bpf_lookup_*_key() and bpf_key_put() kfuncs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308261414.HKw1Mrip-lkp@intel.com/
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/verification.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/verification.h b/include/linux/verification.h
index f34e50ebcf60a..cb2d47f280910 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_VERIFICATION_H
 #define _LINUX_VERIFICATION_H
 
+#include <linux/errno.h>
 #include <linux/types.h>
 
 /*
-- 
2.42.0



