Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CCA7ED16D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbjKOUBg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbjKOUBe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:01:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9B019E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:01:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3281AC433C8;
        Wed, 15 Nov 2023 20:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078490;
        bh=uxNt+wBkDc0LCRvik+g8is3AmwaohYpTkDIx95tu8MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SVCU30WdH+P3Lx459Jc58ArvDlSbs/q9vjRGWlZHf6MhBnty9i08ZI7kNQ7VRQGuA
         spGQgVVt92GPxiqxwPngpEhPVXm65FO95wHL6Kf37Yh8EI2O0yRzn5PQSxMJqlpUw6
         TJMp9k0vv52CmS+kZgAyRdIOF69CcF9xjYV3gJJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 329/379] media: cec: meson: always include meson sub-directory in Makefile
Date:   Wed, 15 Nov 2023 14:26:44 -0500
Message-ID: <20231115192704.613090771@linuxfoundation.org>
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

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 94e27fbeca27d8c772fc2bc807730aaee5886055 ]

'meson' directory contains two separate drivers, so it should be added
to Makefile compilation hierarchy unconditionally, because otherwise the
meson-ao-cec-g12a won't be compiled if meson-ao-cec is not selected.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 4be5e8648b0c ("media: move CEC platform drivers to a separate directory")
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/platform/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/cec/platform/Makefile b/drivers/media/cec/platform/Makefile
index 26d2bc7783944..a51e98ab4958d 100644
--- a/drivers/media/cec/platform/Makefile
+++ b/drivers/media/cec/platform/Makefile
@@ -6,7 +6,7 @@
 # Please keep it in alphabetic order
 obj-$(CONFIG_CEC_CROS_EC) += cros-ec/
 obj-$(CONFIG_CEC_GPIO) += cec-gpio/
-obj-$(CONFIG_CEC_MESON_AO) += meson/
+obj-y += meson/
 obj-$(CONFIG_CEC_SAMSUNG_S5P) += s5p/
 obj-$(CONFIG_CEC_SECO) += seco/
 obj-$(CONFIG_CEC_STI) += sti/
-- 
2.42.0



