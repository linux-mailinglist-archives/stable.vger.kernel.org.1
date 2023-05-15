Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC82B70367C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243408AbjEORK2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243870AbjEORKC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:10:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1B9DDA6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:08:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90C3962AFB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838C7C433EF;
        Mon, 15 May 2023 17:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170476;
        bh=La+TMCYqUeVRQ9MEU1KsG7otk7sYZpad77LkhIdDuWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xDkl8s9GFBTBZHQOy2qfqcV61Djy8OIqAjK+4fNa92b9YUFzn5ZjCsDj3f5O5Cm3/
         mWwVfG7a3l7srH3E3eY+jb/pjzrM4Wd9yd1TDECi9AG0uAVhoyBvn/XYsQOAs58bJj
         t87nnpryWwoPWvhoOhWyQcZ34+YZBafCDxW4cMkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 6.1 142/239] sysctl: clarify register_sysctl_init() base directory order
Date:   Mon, 15 May 2023 18:26:45 +0200
Message-Id: <20230515161725.948596721@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Luis Chamberlain <mcgrof@kernel.org>

commit 228b09de936395ddd740df3522ea35ae934830d8 upstream.

Relatively new docs which I added which hinted the base directories needed
to be created before is wrong, remove that incorrect comment. This has been
hinted before by Eric twice already [0] [1], I had just not verified that
until now. Now that I've verified that updates the docs to relax the context
described.

[0] https://lkml.kernel.org/r/875ys0azt8.fsf@email.froward.int.ebiederm.org
[1] https://lkml.kernel.org/r/87ftbiud6s.fsf@x220.int.ebiederm.org

Cc: stable@vger.kernel.org # v5.17
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/proc_sysctl.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1439,10 +1439,7 @@ EXPORT_SYMBOL(register_sysctl);
  * register_sysctl() failing on init are extremely low, and so for both reasons
  * this function does not return any error as it is used by initialization code.
  *
- * Context: Can only be called after your respective sysctl base path has been
- * registered. So for instance, most base directories are registered early on
- * init before init levels are processed through proc_sys_init() and
- * sysctl_init_bases().
+ * Context: if your base directory does not exist it will be created for you.
  */
 void __init __register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name)


