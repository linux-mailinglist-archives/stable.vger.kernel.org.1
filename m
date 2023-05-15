Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35506703A63
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbjEORvB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244887AbjEORue (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48CA19F18
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC28362F3E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11BDC4339E;
        Mon, 15 May 2023 17:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172910;
        bh=UqsV6kpN6V5dhZKIggXFyrj9RMxF6R5AszPr6eTzBb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qyctGcJEDZaJCEo4jUcG4ZdH2wiNGb+NwZYrLqnlMUxPp9J1x0Z2h1ap52bNsvip8
         zayO36oR5+co4fKtJvqSfXG9uFzTvTrQkcEmXflt0ycWwZgpKAF41t/DLEONwL6ztR
         h0qTq5hBaptXvQPN1BHCtA6jFJ7OyytasMm6affg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>,
        Akilesh Kailash <akailash@google.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 306/381] dm verity: skip redundant verity_handle_err() on I/O errors
Date:   Mon, 15 May 2023 18:29:17 +0200
Message-Id: <20230515161750.661730862@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Akilesh Kailash <akailash@google.com>

[ Upstream commit 2c0468e054c0adb660ac055fc396622ec7235df9 ]

Without FEC, dm-verity won't call verity_handle_err() when I/O fails,
but with FEC enabled, it currently does even if an I/O error has
occurred.

If there is an I/O error and FEC correction fails, return the error
instead of calling verity_handle_err() again.

Suggested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Akilesh Kailash <akailash@google.com>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Stable-dep-of: e8c5d45f82ce ("dm verity: fix error handling for check_at_most_once on FEC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity-target.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index c801f6b93b7b4..d9c388e6ce76c 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -475,6 +475,7 @@ static int verity_verify_io(struct dm_verity_io *io)
 	struct bvec_iter start;
 	unsigned b;
 	struct crypto_wait wait;
+	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
 	for (b = 0; b < io->n_blocks; b++) {
 		int r;
@@ -529,9 +530,17 @@ static int verity_verify_io(struct dm_verity_io *io)
 		else if (verity_fec_decode(v, io, DM_VERITY_BLOCK_TYPE_DATA,
 					   cur_block, NULL, &start) == 0)
 			continue;
-		else if (verity_handle_err(v, DM_VERITY_BLOCK_TYPE_DATA,
-					   cur_block))
-			return -EIO;
+		else {
+			if (bio->bi_status) {
+				/*
+				 * Error correction failed; Just return error
+				 */
+				return -EIO;
+			}
+			if (verity_handle_err(v, DM_VERITY_BLOCK_TYPE_DATA,
+					      cur_block))
+				return -EIO;
+		}
 	}
 
 	return 0;
-- 
2.39.2



