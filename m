Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0A270330F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbjEOQcj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242752AbjEOQch (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:32:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4063199
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:32:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5133A62526
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0097DC433A0;
        Mon, 15 May 2023 16:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168354;
        bh=B1D0B69W3ayQ+VLKZmFFAwMOKcHG+IM3AFk1dqjbArk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cwZNzQp1015qgQt25VdDoU+kVshGDYNParZQkdu+1XKuCwPzmwTCyFqrCktwwqBKD
         JnEncijzmscz/pjkdZ/BHzlxPtjfE3lhPmr1zKh9NCZvq6Mct+3JJPeo6QakgPuTVW
         O+CXty5tDy0oZvR+MQZf0b2Ah4St45kBfLcWWubo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <error27@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 022/116] media: av7110: prevent underflow in write_ts_to_decoder()
Date:   Mon, 15 May 2023 18:25:19 +0200
Message-Id: <20230515161659.020265396@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <error27@gmail.com>

[ Upstream commit eed9496a0501357aa326ddd6b71408189ed872eb ]

The buf[4] value comes from the user via ts_play().  It is a value in
the u8 range.  The final length we pass to av7110_ipack_instant_repack()
is "len - (buf[4] + 1) - 4" so add a check to ensure that the length is
not negative.  It's not clear that passing a negative len value does
anything bad necessarily, but it's not best practice.

With the new bounds checking the "if (!len)" condition is no longer
possible or required so remove that.

Fixes: fd46d16d602a ("V4L/DVB (11759): dvb-ttpci: Add TS replay capability")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ttpci/av7110_av.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/ttpci/av7110_av.c b/drivers/media/pci/ttpci/av7110_av.c
index 2aa4ba675194e..43b780aadf5fe 100644
--- a/drivers/media/pci/ttpci/av7110_av.c
+++ b/drivers/media/pci/ttpci/av7110_av.c
@@ -836,10 +836,10 @@ static int write_ts_to_decoder(struct av7110 *av7110, int type, const u8 *buf, s
 		av7110_ipack_flush(ipack);
 
 	if (buf[3] & ADAPT_FIELD) {
+		if (buf[4] > len - 1 - 4)
+			return 0;
 		len -= buf[4] + 1;
 		buf += buf[4] + 1;
-		if (!len)
-			return 0;
 	}
 
 	av7110_ipack_instant_repack(buf + 4, len - 4, ipack);
-- 
2.39.2



