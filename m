Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199F86FAD45
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbjEHLdH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbjEHLcp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997F828AAF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC24B63041
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFCEC433EF;
        Mon,  8 May 2023 11:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545487;
        bh=BeaBmBFLMhn6wR0QhlMdNixRueD2HU3RQaKSeAdF75M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nuwcXkZlKQDNL9qE0sinybGAZ6VYCgejF8hTKeCVIEy9+C7s30HhQmLwe2pISGi+4
         dYskhYQUeg7ANeGrMibcP3Y3UPYR6pgmOn9N3Rg5pJ3wpLbSRcggwmN09WTXO31Nhk
         IXQ3ClgDUsw1akZvrUJ3CC9RHs8mGI1fMxBymKf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wang YanQing <udknight@gmail.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 5.15 055/371] ubi: Fix return value overwrite issue in try_write_vid_and_data()
Date:   Mon,  8 May 2023 11:44:16 +0200
Message-Id: <20230508094814.252269427@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Wang YanQing <udknight@gmail.com>

commit 31a149d5c13c4cbcf97de3435817263a2d8c9d6e upstream.

The commit 2d78aee426d8 ("UBI: simplify LEB write and atomic LEB change code")
adds helper function, try_write_vid_and_data(), to simplify the code, but this
helper function has bug, it will return 0 (success) when ubi_io_write_vid_hdr()
or the ubi_io_write_data() return error number (-EIO, etc), because the return
value of ubi_wl_put_peb() will overwrite the original return value.

This issue will cause unexpected data loss issue, because the caller of this
function and UBIFS willn't know the data is lost.

Fixes: 2d78aee426d8 ("UBI: simplify LEB write and atomic LEB change code")
Cc: stable@vger.kernel.org
Signed-off-by: Wang YanQing <udknight@gmail.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/ubi/eba.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -946,7 +946,7 @@ static int try_write_vid_and_data(struct
 				  int offset, int len)
 {
 	struct ubi_device *ubi = vol->ubi;
-	int pnum, opnum, err, vol_id = vol->vol_id;
+	int pnum, opnum, err, err2, vol_id = vol->vol_id;
 
 	pnum = ubi_wl_get_peb(ubi);
 	if (pnum < 0) {
@@ -981,10 +981,19 @@ static int try_write_vid_and_data(struct
 out_put:
 	up_read(&ubi->fm_eba_sem);
 
-	if (err && pnum >= 0)
-		err = ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1);
-	else if (!err && opnum >= 0)
-		err = ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0);
+	if (err && pnum >= 0) {
+		err2 = ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1);
+		if (err2) {
+			ubi_warn(ubi, "failed to return physical eraseblock %d, error %d",
+				 pnum, err2);
+		}
+	} else if (!err && opnum >= 0) {
+		err2 = ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0);
+		if (err2) {
+			ubi_warn(ubi, "failed to return physical eraseblock %d, error %d",
+				 opnum, err2);
+		}
+	}
 
 	return err;
 }


