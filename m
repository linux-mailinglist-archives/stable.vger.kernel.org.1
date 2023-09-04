Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC01791D0D
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbjIDSed (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345095AbjIDSeb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:34:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D7CE2
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B6BEB80E6F
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DFDC433C7;
        Mon,  4 Sep 2023 18:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852464;
        bh=64e37i4ndX5t9oEQgDe6Np7d4UglnE3NMgn3bNf+saY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgghW3HdbPby2+xztr1+bGcTJv5SANBbdCu7Q+O0DWDPN5gSJWE+7aN0J/p+DvF6k
         XjR6vQkUxl6b+ZQMXNFEG45cJ67UNzRGUaj2E9xtOm3Ukv7VNo3dMuex+guUPIVn/K
         F4d079f2nydvEASAkZSK45zFOk7J7po3jlAXQY74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, keltargw <keltar.gw@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6.1 01/31] erofs: ensure that the post-EOF tails are all zeroed
Date:   Mon,  4 Sep 2023 19:30:09 +0100
Message-ID: <20230904182947.070801380@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182946.999390199@linuxfoundation.org>
References: <20230904182946.999390199@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
 fs/erofs/zdata.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -869,6 +869,8 @@ hitted:
 	cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
+		++spiltted;
+		tight = false;
 		goto next_part;
 	}
 	if (map->m_flags & EROFS_MAP_FRAGMENT) {


