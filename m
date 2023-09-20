Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548927A7D55
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjITMIl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbjITMIl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:08:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B34DCE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:08:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A128BC433C9;
        Wed, 20 Sep 2023 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211715;
        bh=7hiIGOj++9dRbCxwCD+vdX5zn2rZ5l/TdQcam0UZW2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xoZCBrotc2Wbx+HO2jsVuNKic7CMu6cNEIG/jB03kM/mECSacshlE7GxUW8/82oB9
         lMqNAB4wVXHriY5gRox5XbnKJgu6qnC8QJ9SNgn8DqnG1Qds2JbuPuGZ2zCTk3kihT
         6JIN7K0NYSmRhzDb1fjB+2gwzq+VBVKVqC5mYa4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, keltargw <keltar.gw@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4.19 001/273] erofs: ensure that the post-EOF tails are all zeroed
Date:   Wed, 20 Sep 2023 13:27:21 +0200
Message-ID: <20230920112846.486047057@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@linux.alibaba.com>

commit e4c1cf523d820730a86cae2c6d55924833b6f7ac upstream.

This was accidentally fixed up in commit e4c1cf523d82 but we can't
take the full change due to other dependancy issues, so here is just
the actual bugfix that is needed.

[Background]

keltargw reported an issue [1] that with mmaped I/Os, sometimes the
tail of the last page (after file ends) is not filled with zeroes.

The root cause is that such tail page could be wrongly selected for
inplace I/Os so the zeroed part will then be filled with compressed
data instead of zeroes.

A simple fix is to avoid doing inplace I/Os for such tail parts,
actually that was already fixed upstream in commit e4c1cf523d82
("erofs: tidy up z_erofs_do_read_page()") by accident.

[1] https://lore.kernel.org/r/3ad8b469-25db-a297-21f9-75db2d6ad224@linux.alibaba.com

Reported-by: keltargw <keltar.gw@gmail.com>
Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/erofs/unzip_vle.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -675,6 +675,8 @@ hitted:
 	cur = end - min_t(unsigned, offset + end - map->m_la, end);
 	if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED))) {
 		zero_user_segment(page, cur, end);
+		++spiltted;
+		tight = false;
 		goto next_part;
 	}
 


