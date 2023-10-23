Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8267D34F3
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjJWLoN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjJWLoF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:44:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C3F1729
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:43:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7759FC433CA;
        Mon, 23 Oct 2023 11:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061435;
        bh=LMj5ja0ULzeQZwnrvseQxFyhhphlBkCXtWOiKScDGqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vS9I1ln7zeMBqG/ATYRby5lTtQ8a0DUwgeOVkFDMPrN8xlyXYRXO++ugHArQ37c7n
         H/W9QnCFkCqfoelCtQBLQHKWpbat4LRE8es3Ku8zzcrY7+zidrXeSTk2d9H7hkeoQ4
         cOXk0AKyxrOr0E0OE4SJlbIbNNX+cF3Yg1J66qgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.10 047/202] ceph: fix type promotion bug on 32bit systems
Date:   Mon, 23 Oct 2023 12:55:54 +0200
Message-ID: <20231023104827.959753874@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 07bb00ef00ace88dd6f695fadbba76565756e55c upstream.

In this code "ret" is type long and "src_objlen" is unsigned int.  The
problem is that on 32bit systems, when we do the comparison signed longs
are type promoted to unsigned int.  So negative error codes from
do_splice_direct() are treated as success instead of failure.

Cc: stable@vger.kernel.org
Fixes: 1b0c3b9f91f0 ("ceph: re-org copy_file_range and fix some error paths")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2428,7 +2428,7 @@ static ssize_t __ceph_copy_file_range(st
 		ret = do_splice_direct(src_file, &src_off, dst_file,
 				       &dst_off, src_objlen, flags);
 		/* Abort on short copies or on error */
-		if (ret < src_objlen) {
+		if (ret < (long)src_objlen) {
 			dout("Failed partial copy (%zd)\n", ret);
 			goto out;
 		}


