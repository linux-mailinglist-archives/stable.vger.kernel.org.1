Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332217033E8
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242410AbjEOQmx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242228AbjEOQmv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:42:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC8649C5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:42:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E926289E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CFBC433EF;
        Mon, 15 May 2023 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168959;
        bh=gbsgF0jUZQHzoprFJRgaCygFbigEFv3rZN2HwzN1HcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wap682dZmZjaxS9yXejc+fTfAiKMVBfAuSLbN9hunOeBgDp3vjuzfTa4Twtq8XZkY
         karWe1LenYtv1KywPJwjdinDSQA+NRal9lXBx/gZr5OkrTUzNmnzzldqFAn6FbXCHA
         1Ni+04q+bAVmMLXHQRFgfinXY4hEaL57/+rYyl+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kevin Brodsky <kevin.brodsky@arm.com>,
        Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>,
        Petr Vorel <pvorel@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 097/191] uapi/linux/const.h: prefer ISO-friendly __typeof__
Date:   Mon, 15 May 2023 18:25:34 +0200
Message-Id: <20230515161710.797568285@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit 31088f6f7906253ef4577f6a9b84e2d42447dba0 ]

typeof is (still) a GNU extension, which means that it cannot be used when
building ISO C (e.g.  -std=c99).  It should therefore be avoided in uapi
headers in favour of the ISO-friendly __typeof__.

Unfortunately this issue could not be detected by
CONFIG_UAPI_HEADER_TEST=y as the __ALIGN_KERNEL() macro is not expanded in
any uapi header.

This matters from a userspace perspective, not a kernel one. uapi
headers and their contents are expected to be usable in a variety of
situations, and in particular when building ISO C applications (with
-std=c99 or similar).

This particular problem can be reproduced by trying to use the
__ALIGN_KERNEL macro directly in application code, say:

#include <linux/const.h>

int align(int x, int a)
{
	return __KERNEL_ALIGN(x, a);
}

and trying to build that with -std=c99.

Link: https://lkml.kernel.org/r/20230411092747.3759032-1-kevin.brodsky@arm.com
Fixes: a79ff731a1b2 ("netfilter: xtables: make XT_ALIGN() usable in exported headers by exporting __ALIGN_KERNEL()")
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Reported-by: Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>
Tested-by: Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/const.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index af2a44c08683d..a429381e7ca50 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
-#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
+#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
 #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 
 #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-- 
2.39.2



