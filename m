Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5766FACE1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjEHL2t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbjEHL21 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:28:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002603CD9A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D318162E36
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0B4C433D2;
        Mon,  8 May 2023 11:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545289;
        bh=CPqYJM3/bse83eMz/FeEinnYs3/0/El4TpEx5F3NN0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8IsqJIFKbJhTqf4w15BQV+M7fVoHQiNgorc5g4vS5dvwnE9DdjSbM0ELTNAvydw9
         O7ndyAIMw3jrZ1XYKXWLvsg8zalHweN85kcgxXV9dXkfE4pW4hC0dEs9nlsaUVpfXa
         OgQp81aJixYLagXFPYiMfyAmTXVfe/kWGZiLbdC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tobias Holl <tobias@tholl.xyz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.3 687/694] io_uring/rsrc: check for nonconsecutive pages
Date:   Mon,  8 May 2023 11:48:42 +0200
Message-Id: <20230508094458.678191803@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Tobias Holl <tobias@tholl.xyz>

commit 776617db78c6d208780e7c69d4d68d1fa82913de upstream.

Pages that are from the same folio do not necessarily need to be
consecutive. In that case, we cannot consolidate them into a single bvec
entry. Before applying the huge page optimization from commit 57bebf807e2a
("io_uring/rsrc: optimise registered huge pages"), check that the memory
is actually consecutive.

Cc: stable@vger.kernel.org
Fixes: 57bebf807e2a ("io_uring/rsrc: optimise registered huge pages")
Signed-off-by: Tobias Holl <tobias@tholl.xyz>
[axboe: formatting]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/rsrc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1230,7 +1230,12 @@ static int io_sqe_buffer_register(struct
 	if (nr_pages > 1) {
 		folio = page_folio(pages[0]);
 		for (i = 1; i < nr_pages; i++) {
-			if (page_folio(pages[i]) != folio) {
+			/*
+			 * Pages must be consecutive and on the same folio for
+			 * this to work
+			 */
+			if (page_folio(pages[i]) != folio ||
+			    pages[i] != pages[i - 1] + 1) {
 				folio = NULL;
 				break;
 			}


