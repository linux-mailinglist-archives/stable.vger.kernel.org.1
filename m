Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45256FA986
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjEHKwg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbjEHKwJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:52:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3FE171F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0976462941
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0EFC433EF;
        Mon,  8 May 2023 10:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543066;
        bh=GO+g1i9UxogZgOCkeV6t2pu5jA4dSAgcypdHLR0ElUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T3Mf3Hj86Ty0yNikqUrtCxhJGOOseicgLka0Uy139magJx7qg8OreiYj+CWJPqucd
         HPMXv/kxtCeahN6Qu3yRGtatz2r6JdeKLQJyYu01JLcS8RBcd8dJ7pD/8XSn95yFW+
         ti1/SJjSLoubso+iRLaJQSiV6RQAZBGuxROKTJu4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 6.2 640/663] btrfs: scrub: reject unsupported scrub flags
Date:   Mon,  8 May 2023 11:47:46 +0200
Message-Id: <20230508094450.738983706@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Qu Wenruo <wqu@suse.com>

commit 604e6681e114d05a2e384c4d1e8ef81918037ef5 upstream.

Since the introduction of scrub interface, the only flag that we support
is BTRFS_SCRUB_READONLY.  Thus there is no sanity checks, if there are
some undefined flags passed in, we just ignore them.

This is problematic if we want to introduce new scrub flags, as we have
no way to determine if such flags are supported.

Address the problem by introducing a check for the flags, and if
unsupported flags are set, return -EOPNOTSUPP to inform the user space.

This check should be backported for all supported kernels before any new
scrub flags are introduced.

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ioctl.c           |    5 +++++
 include/uapi/linux/btrfs.h |    1 +
 2 files changed, 6 insertions(+)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3160,6 +3160,11 @@ static long btrfs_ioctl_scrub(struct fil
 	if (IS_ERR(sa))
 		return PTR_ERR(sa);
 
+	if (sa->flags & ~BTRFS_SCRUB_SUPPORTED_FLAGS) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (!(sa->flags & BTRFS_SCRUB_READONLY)) {
 		ret = mnt_want_write_file(file);
 		if (ret)
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -187,6 +187,7 @@ struct btrfs_scrub_progress {
 };
 
 #define BTRFS_SCRUB_READONLY	1
+#define BTRFS_SCRUB_SUPPORTED_FLAGS	(BTRFS_SCRUB_READONLY)
 struct btrfs_ioctl_scrub_args {
 	__u64 devid;				/* in */
 	__u64 start;				/* in */


