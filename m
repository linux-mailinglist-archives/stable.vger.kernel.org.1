Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB9879B19D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379528AbjIKWok (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbjIKPBn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:01:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68AC125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:01:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABD2C433C7;
        Mon, 11 Sep 2023 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444498;
        bh=8G7Avf1NypFZ9vK1dYsZr2oCWOfmBeMX+ygWvs5tgF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yrJclz+FwXAsZitfushmBatGwPHKkDkk/ojhc2qYSfTIyRy9H9dqBwjvrjflqS58E
         Vnn+4ZrvG9Z0dqx/E5CzRci6EARSdVIQVhqofuBbYVrJ5lO5guY4p0+0ZLZE01NgBT
         q6In245PfifIp3ytHJK5UYCV1fVIlpFXMOxr778Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Simon Horman <simon.horman@corigine.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 014/600] 9p: virtio: fix unlikely null pointer deref in handle_rerror
Date:   Mon, 11 Sep 2023 15:40:47 +0200
Message-ID: <20230911134634.037805470@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

From: Dominique Martinet <asmadeus@codewreck.org>

[ Upstream commit 13ade4ac5c28e8a014fa85278f5a4270b215f906 ]

handle_rerror can dereference the pages pointer, but it is not
necessarily set for small payloads.
In practice these should be filtered out by the size check, but
might as well double-check explicitly.

This fixes the following scan-build warnings:
net/9p/trans_virtio.c:401:24: warning: Dereference of null pointer [core.NullDereference]
                memcpy_from_page(to, *pages++, offs, n);
                                     ^~~~~~~~
net/9p/trans_virtio.c:406:23: warning: Dereference of null pointer (loaded from variable 'pages') [core.NullDereference]
        memcpy_from_page(to, *pages, offs, size);
                             ^~~~~~

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 3f3eb03cda7d6..6a4a29a2703de 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -385,7 +385,7 @@ static void handle_rerror(struct p9_req_t *req, int in_hdr_len,
 	void *to = req->rc.sdata + in_hdr_len;
 
 	// Fits entirely into the static data?  Nothing to do.
-	if (req->rc.size < in_hdr_len)
+	if (req->rc.size < in_hdr_len || !pages)
 		return;
 
 	// Really long error message?  Tough, truncate the reply.  Might get
-- 
2.40.1



