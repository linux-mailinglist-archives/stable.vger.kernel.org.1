Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CEA726C22
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjFGUbA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjFGUao (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C5B1BFA
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:30:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B5EB644DD
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C826C433D2;
        Wed,  7 Jun 2023 20:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169841;
        bh=bGHS3tOR1qiz/0FkRLD/dcSGoDztp6yKtm9PHrVJ4SY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7Rle1iEHlXr0gnQapGUV8VUkxKiSz3N0b1EsxpQgvJ/erBonvCZljPklacJ95exp
         j/TIEzJfKk8cM/FRqWXbd1CywuB1GvPK74McZcdyzM3phzPUsHocQmHZVuF/cb5n9c
         HQZjNz080pTg+2ddfDff7jpRXp/zZuTKsIMn50fQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.3 235/286] module/decompress: Fix error checking on zstd decompression
Date:   Wed,  7 Jun 2023 22:15:34 +0200
Message-ID: <20230607200930.974276492@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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

From: Lucas De Marchi <lucas.demarchi@intel.com>

commit fadb74f9f2f609238070c7ca1b04933dc9400e4a upstream.

While implementing support for in-kernel decompression in kmod,
finit_module() was returning a very suspicious value:

	finit_module(3, "", MODULE_INIT_COMPRESSED_FILE) = 18446744072717407296

It turns out the check for module_get_next_page() failing is wrong,
and hence the decompression was not really taking place. Invert
the condition to fix it.

Fixes: 169a58ad824d ("module/decompress: Support zstd in-kernel decompression")
Cc: stable@kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/module/decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index e97232b125eb..8a5d6d63b06c 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -257,7 +257,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	do {
 		struct page *page = module_get_next_page(info);
 
-		if (!IS_ERR(page)) {
+		if (IS_ERR(page)) {
 			retval = PTR_ERR(page);
 			goto out;
 		}
-- 
2.41.0



