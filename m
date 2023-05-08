Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C36A6FA657
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjEHKSi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjEHKS0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:18:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9349D2CC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7007D61031
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8496EC433EF;
        Mon,  8 May 2023 10:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541104;
        bh=sFrfPY7EMkBSX+YimTIkq9AjymcaZRkC1tl3CcGmGv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkAutgEynKYOfCbcyCNhAqIF4QsYZorPgiyjDTZFBpoqjBA3k86JN12MhPNzxyUDf
         cFY4thoj/WUZeDQR3WOk4kDUaQadsIUOke6JXIQD8Bi9iAJcFNaFi8VLPjK488HUzf
         OOBVAKx5fSlCzX912Q2ZOFWjYeGEYzXKO5xAgKcA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 6.1 593/611] dm flakey: fix a crash with invalid table line
Date:   Mon,  8 May 2023 11:47:15 +0200
Message-Id: <20230508094441.170979162@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Mikulas Patocka <mpatocka@redhat.com>

commit 98dba02d9a93eec11bffbb93c7c51624290702d2 upstream.

This command will crash with NULL pointer dereference:
 dmsetup create flakey --table \
  "0 `blockdev --getsize /dev/ram0` flakey /dev/ram0 0 0 1 2 corrupt_bio_byte 512"

Fix the crash by checking if arg_name is non-NULL before comparing it.

Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-flakey.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -124,9 +124,9 @@ static int parse_features(struct dm_arg_
 			 * Direction r or w?
 			 */
 			arg_name = dm_shift_arg(as);
-			if (!strcasecmp(arg_name, "w"))
+			if (arg_name && !strcasecmp(arg_name, "w"))
 				fc->corrupt_bio_rw = WRITE;
-			else if (!strcasecmp(arg_name, "r"))
+			else if (arg_name && !strcasecmp(arg_name, "r"))
 				fc->corrupt_bio_rw = READ;
 			else {
 				ti->error = "Invalid corrupt bio direction (r or w)";


