Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E8D7D307E
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 12:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjJWK7W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 06:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjJWK7V (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 06:59:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58ADD7B
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 03:59:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7A7C433C8;
        Mon, 23 Oct 2023 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058759;
        bh=fL5ns77IheIJFHiKQGIh4RdFSRrtlYavQ/lx2kLl7Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8PPe5oL3G/KiQx8DDftZQy4WhsPNWbyivV6UREw+5cVU8B3cW3r0+Lu1ozm9JYCX
         ItAIGuQY5MniVuJtI9Nnn0Rhw3DgEuQns0xKy17rlUjB6hWD5vJcZ9qTSNq8aixqjK
         CXZ5QqdBHTco6GJiaReT1ZIm9IT+Fgow5jw2UQY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiubo Li <xiubli@redhat.com>,
        Milind Changire <mchangir@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.14 17/66] ceph: fix incorrect revoked caps assert in ceph_fill_file_size()
Date:   Mon, 23 Oct 2023 12:56:07 +0200
Message-ID: <20231023104811.433841736@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104810.781270702@linuxfoundation.org>
References: <20231023104810.781270702@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiubo Li <xiubli@redhat.com>

commit 15c0a870dc44ed14e01efbdd319d232234ee639f upstream.

When truncating the inode the MDS will acquire the xlock for the
ifile Locker, which will revoke the 'Frwsxl' caps from the clients.
But when the client just releases and flushes the 'Fw' caps to MDS,
for exmaple, and once the MDS receives the caps flushing msg it
just thought the revocation has finished. Then the MDS will continue
truncating the inode and then issued the truncate notification to
all the clients. While just before the clients receives the cap
flushing ack they receive the truncation notification, the clients
will detecte that the 'issued | dirty' is still holding the 'Fw'
caps.

Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/56693
Fixes: b0d7c2231015 ("ceph: introduce i_truncate_mutex")
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/inode.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -615,9 +615,7 @@ int ceph_fill_file_size(struct inode *in
 			ci->i_truncate_seq = truncate_seq;
 
 			/* the MDS should have revoked these caps */
-			WARN_ON_ONCE(issued & (CEPH_CAP_FILE_EXCL |
-					       CEPH_CAP_FILE_RD |
-					       CEPH_CAP_FILE_WR |
+			WARN_ON_ONCE(issued & (CEPH_CAP_FILE_RD |
 					       CEPH_CAP_FILE_LAZYIO));
 			/*
 			 * If we hold relevant caps, or in the case where we're


