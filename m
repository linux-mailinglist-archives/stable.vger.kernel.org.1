Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62376FA8AC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjEHKoR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbjEHKnf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:43:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFCB26E80
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:42:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DF2B6285E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932A2C433EF;
        Mon,  8 May 2023 10:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542547;
        bh=W5dXkr+r5xUyDXHbAK4x4mXIDeWryIxamq/GQNcZtTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opEI45gS3hfW89bHA8LmNxsp1SrlYdBWXd7F0Gd2/TlsdNpp4euKqDKkr6y4POXsL
         RX8U3h+vtSzMngPR53e82utYftv5JW3mRdOiZh6iSebEMRRat0sCwEefyo7tv22fjl
         jTXvvBZZbN1q90yAaL6DsFU4UBT8DZA9UvuiBlYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Piotr Gorski <piotrgorski@cachyos.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 453/663] module/decompress: Never use kunmap() for local un-mappings
Date:   Mon,  8 May 2023 11:44:39 +0200
Message-Id: <20230508094442.807921943@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Fabio M. De Francesco <fmdefrancesco@gmail.com>

[ Upstream commit 3c17655ab13704582fe25e8ea3200a9b2f8bf20a ]

Use kunmap_local() to unmap pages locally mapped with kmap_local_page().

kunmap_local() must be called on the kernel virtual address returned by
kmap_local_page(), differently from how we use kunmap() which instead
expects the mapped page as its argument.

In module_zstd_decompress() we currently map with kmap_local_page() and
unmap with kunmap(). This breaks the code and so it should be fixed.

Cc: Piotr Gorski <piotrgorski@cachyos.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Fixes: 169a58ad824d ("module/decompress: Support zstd in-kernel decompression")
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Piotr Gorski <piotrgorski@cachyos.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/module/decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index bb79ac1a6d8f7..7ddc87bee2741 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -267,7 +267,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 		zstd_dec.size = PAGE_SIZE;
 
 		ret = zstd_decompress_stream(dstream, &zstd_dec, &zstd_buf);
-		kunmap(page);
+		kunmap_local(zstd_dec.dst);
 		retval = zstd_get_error_code(ret);
 		if (retval)
 			break;
-- 
2.39.2



