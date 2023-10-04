Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19D27B8783
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243557AbjJDSGO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243802AbjJDSGN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:06:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD779E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:06:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23BBC433C8;
        Wed,  4 Oct 2023 18:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442770;
        bh=gLNww7weW5YKyZCSbfQVpVKI3XfNFu6EIq/FnYAcxHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tuBsGGv8a7Aca/FO1I9fXclMk2aq2iBXzj2j/ixqA/BRxLOb59lSfcJk8lJdeJgAe
         zBLoDl1TMXhUjZI8Ck+kviylsHOdQR5NilkXdeW1iWy8yD2LsvMYb90UCBwhDSBZZl
         AD4fUZ+odfUF/wCuGwWqWg77BFZxUqqAyzF2abww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 103/183] xtensa: add default definition for XCHAL_HAVE_DIV32
Date:   Wed,  4 Oct 2023 19:55:34 +0200
Message-ID: <20231004175208.193509701@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit 494e87ffa0159b3f879694a9231089707792a44d ]

When variant FSF is set, XCHAL_HAVE_DIV32 is not defined. Add default
definition for that macro to prevent build warnings:

arch/xtensa/lib/divsi3.S:9:5: warning: "XCHAL_HAVE_DIV32" is not defined, evaluates to 0 [-Wundef]
    9 | #if XCHAL_HAVE_DIV32
arch/xtensa/lib/modsi3.S:9:5: warning: "XCHAL_HAVE_DIV32" is not defined, evaluates to 0 [-Wundef]
    9 | #if XCHAL_HAVE_DIV32

Fixes: 173d6681380a ("xtensa: remove extra header files")
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: lore.kernel.org/r/202309150556.t0yCdv3g-lkp@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/include/asm/core.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/xtensa/include/asm/core.h b/arch/xtensa/include/asm/core.h
index a4e40166ff4bb..0fa3649649e98 100644
--- a/arch/xtensa/include/asm/core.h
+++ b/arch/xtensa/include/asm/core.h
@@ -6,6 +6,10 @@
 
 #include <variant/core.h>
 
+#ifndef XCHAL_HAVE_DIV32
+#define XCHAL_HAVE_DIV32 0
+#endif
+
 #ifndef XCHAL_HAVE_EXCLUSIVE
 #define XCHAL_HAVE_EXCLUSIVE 0
 #endif
-- 
2.40.1



