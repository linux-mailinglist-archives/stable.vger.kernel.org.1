Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6707BE1DA
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377576AbjJINyh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377580AbjJINyg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:54:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC03ACF
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:54:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B14CC433CC;
        Mon,  9 Oct 2023 13:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859674;
        bh=85I0nDnbOwDCqJb0R9zE9W13VPrXR1DlQR6dObkIS7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWrEfNug8jvbkD62KjE6aQk2o5LH6pFK0KNAv4IFKDb6qwFXjQW1TI0fZkYnPbKgt
         vktFDyuG++M1HoIfnQirptVsu7RmieZD3NjlLsgr0FzjA0IbBDKpKZS1l6BYK3U0b6
         j81vKeCwzMLt07XYbY0vbp8D8C4xVw6I0GsMiSI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 70/91] btrfs: reject unknown mount options early
Date:   Mon,  9 Oct 2023 15:06:42 +0200
Message-ID: <20231009130113.943075052@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit 5f521494cc73520ffac18ede0758883b9aedd018 upstream.

[BUG]
The following script would allow invalid mount options to be specified
(although such invalid options would just be ignored):

  # mkfs.btrfs -f $dev
  # mount $dev $mnt1		<<< Successful mount expected
  # mount $dev $mnt2 -o junk	<<< Failed mount expected
  # echo $?
  0

[CAUSE]
For the 2nd mount, since the fs is already mounted, we won't go through
open_ctree() thus no btrfs_parse_options(), but only through
btrfs_parse_subvol_options().

However we do not treat unrecognized options from valid but irrelevant
options, thus those invalid options would just be ignored by
btrfs_parse_subvol_options().

[FIX]
Add the handling for Opt_err to handle invalid options and error out,
while still ignore other valid options inside btrfs_parse_subvol_options().

Reported-by: Anand Jain <anand.jain@oracle.com>
CC: stable@vger.kernel.org # 4.14+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/super.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -991,6 +991,10 @@ static int btrfs_parse_subvol_options(co
 		case Opt_subvolrootid:
 			pr_warn("BTRFS: 'subvolrootid' mount option is deprecated and has no effect\n");
 			break;
+		case Opt_err:
+			btrfs_err(NULL, "unrecognized mount option '%s'", p);
+			error = -EINVAL;
+			goto out;
 		default:
 			break;
 		}


