Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1F7BDEF2
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376499AbjJINYt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376489AbjJINYs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:24:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869439C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:24:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3C3C433C7;
        Mon,  9 Oct 2023 13:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857887;
        bh=dJHr/KYxy401iZgRUlmLKRaUzp5O5RlVKigEn2avK9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HmCFOtZIXtjHUbhfw3RAsSELcWIPoTxyF2Jx2tc6wMwLvgNMeVSgo6MlvAUnPsx34
         kkijq87Mj61fZvpkNFRruDoYhyR5zDqZ9NhOqgij+SumGZRgURjq12Se9UOWjhJCN3
         TssIKw99eFGrvcQitUMHh3Vm1EemHP1rTqNL9BlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 5.15 24/75] btrfs: reject unknown mount options early
Date:   Mon,  9 Oct 2023 15:01:46 +0200
Message-ID: <20231009130112.084701927@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1182,6 +1182,10 @@ static int btrfs_parse_subvol_options(co
 
 			*subvol_objectid = subvolid;
 			break;
+		case Opt_err:
+			btrfs_err(NULL, "unrecognized mount option '%s'", p);
+			error = -EINVAL;
+			goto out;
 		default:
 			break;
 		}


