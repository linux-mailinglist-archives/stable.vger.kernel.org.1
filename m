Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7C07A7D37
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjITMHf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjITMHa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:07:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C68AC
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:07:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8C9C433CB;
        Wed, 20 Sep 2023 12:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211644;
        bh=3mS4+DpU89y/RxZvDWuynocvnzotOt8xozVMSFcTvm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2M5XNCq52o1IRQ6a271giedh1gsdUryDYju391thY2mwBrkh3HvwqstXnF/DXl+J
         U1q8adl3IV88MRPzMYhxgiIwldx4Qzi3oaT2pW1H/hxl5s2XHk1qPEJw0Ib0eF82wk
         vEBxydYSJNJYBPIF6hv6iyT49GHLFSreC+enfuqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 170/186] iio: core: Use min() instead of min_t() to make code more robust
Date:   Wed, 20 Sep 2023 13:31:13 +0200
Message-ID: <20230920112843.026201069@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit cb1d17535061ca295903f97f5cb0af9db719c02c ]

min() has strict type checking and preferred over min_t() for
unsigned types to avoid overflow. Here it's unclear why min_t()
was chosen since both variables are of the same type. In any
case update to use min().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20230721170022.3461-5-andriy.shevchenko@linux.intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 97b7266ee0ffa..12d73ebcadfa3 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -328,7 +328,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 	char buf[80];
 	int ret;
 
-	count = min_t(size_t, count, (sizeof(buf)-1));
+	count = min(count, sizeof(buf) - 1);
 	if (copy_from_user(buf, userbuf, count))
 		return -EFAULT;
 
-- 
2.40.1



