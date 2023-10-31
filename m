Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EAE7DD55C
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376518AbjJaRtu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376531AbjJaRts (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:49:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93194A2
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:49:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5623C433C8;
        Tue, 31 Oct 2023 17:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774586;
        bh=iOsyg6n+q7ITCbgxSl0zwfG6hk4SjuAlJ81JKdHPdDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tIf966C0JKWcxZjo31EmZq2E4ONCXGY7v9OsE0EnsU1mKbWyA3nw2ZwoslVL/nyPc
         jyyLQ49LDG0nY9ou0wk6u/iNabGh7UWY/29E1xBWdZOFZJyghdxWoRrIEVvxsr8mSJ
         96X1GRjszSA9/Jujzu4JbZJUZKrhapG19OwWIguo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6.5 095/112] misc: fastrpc: Reset metadata buffer to avoid incorrect free
Date:   Tue, 31 Oct 2023 18:01:36 +0100
Message-ID: <20231031165904.288118865@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

commit 1c29d80134ac116e0196c7bad58a2121381b679c upstream.

Metadata buffer is allocated during get_args for any remote call.
This buffer carries buffers, fdlists and other payload information
for the call. If the buffer is not reset, put_args might find some
garbage FDs in the fdlist which might have an existing mapping in
the list. This could result in improper freeing of FD map when DSP
might still be using the buffer. Added change to reset the metadata
buffer after allocation.

Fixes: 8f6c1d8c4f0c ("misc: fastrpc: Add fdlist implementation")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20231013122007.174464-2-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -957,6 +957,7 @@ static int fastrpc_get_args(u32 kernel,
 	if (err)
 		return err;
 
+	memset(ctx->buf->virt, 0, pkt_size);
 	rpra = ctx->buf->virt;
 	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);


