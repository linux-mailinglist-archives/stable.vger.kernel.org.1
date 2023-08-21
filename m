Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F7F7832E6
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjHUUIs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjHUUIr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:08:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C483E4
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02C9064A15
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C49C433C8;
        Mon, 21 Aug 2023 20:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648525;
        bh=hVo8r1J1bmzh7XurJYBE4Ckc8A413nsLSwryrhcX2EY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t3S5q+z9AWd49CA3l8ncrLRF0oUg45LwbV/K5Zi2IdRf9cr90TwTUWWcpqMLcEJBq
         ht1qjV+FeMbZcE3+jlvIehVWsFRZQG6HHngxArp+2Q30M0WfXrOfc62EKLoLJuz6Ex
         LRiyy/IeHHb1DRCklG5Ry6eNTIZqXfETmtH0e3mA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Scott Mayhew <smayhew@redhat.com>,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.4 206/234] smb: client: fix null auth
Date:   Mon, 21 Aug 2023 21:42:49 +0200
Message-ID: <20230821194137.964383468@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Scott Mayhew <smayhew@redhat.com>

commit 270d73e6507f9c7fff43844d74f86365df000b36 upstream.

Commit abdb1742a312 removed code that clears ctx->username when sec=none, so attempting
to mount with '-o sec=none' now fails with -EACCES.  Fix it by adding that logic to the
parsing of the 'sec' option, as well as checking if the mount is using null auth before
setting the username when parsing the 'user' option.

Fixes: abdb1742a312 ("cifs: get rid of mount options string parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/fs_context.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 4946a0c59600..67e16c2ac90e 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -231,6 +231,8 @@ cifs_parse_security_flavors(struct fs_context *fc, char *value, struct smb3_fs_c
 		break;
 	case Opt_sec_none:
 		ctx->nullauth = 1;
+		kfree(ctx->username);
+		ctx->username = NULL;
 		break;
 	default:
 		cifs_errorf(fc, "bad security option: %s\n", value);
@@ -1201,6 +1203,8 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 	case Opt_user:
 		kfree(ctx->username);
 		ctx->username = NULL;
+		if (ctx->nullauth)
+			break;
 		if (strlen(param->string) == 0) {
 			/* null user, ie. anonymous authentication */
 			ctx->nullauth = 1;
-- 
2.41.0



