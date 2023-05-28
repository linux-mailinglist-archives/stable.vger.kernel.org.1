Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DF0713EB1
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjE1Th6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjE1Th5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941D8AB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BB2F61E6F
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF6EC433D2;
        Sun, 28 May 2023 19:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302675;
        bh=guxoDaOfg2nxB76Uq6kbYWKFXDOU2gubYzDBYTEQPYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zPBPnlQVX9jSsZz+rkhXXwflALKNsdBl4seicz5rUYIp+hlhodlj0OZTdLXFx4Hnr
         XxMW6akkqfLUicG/Lfh9xM+GsZ01z0gwokYFje0FbPZ9s4ZdWFCC3mqaU/SLZX67KR
         OYUyiPNSNp19IDrrmzwkgyENGebH3Gh+Sbw984zc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tyler Spivey <tspivey8@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 072/119] cifs: mapchars mount option ignored
Date:   Sun, 28 May 2023 20:11:12 +0100
Message-Id: <20230528190837.911411359@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

commit cb8b02fd6343228966324528adf920bfb8b8e681 upstream.

There are two ways that special characters (not allowed in some
other operating systems like Windows, but allowed in POSIX) have
been mapped in the past ("SFU" and "SFM" mappings) to allow them
to be stored in a range reserved for special chars. The default
for Linux has been to use "mapposix" (ie the SFM mapping) but
the conversion to the new mount API in the 5.11 kernel broke
the ability to override the default mapping of the reserved
characters (like '?' and '*' and '\') via "mapchars" mount option.

This patch fixes that - so can now mount with "mapchars"
mount option to override the default ("mapposix" ie SFM) mapping.

Reported-by: Tyler Spivey <tspivey8@gmail.com>
Fixes: 24e0a1eff9e2 ("cifs: switch to new mount api")
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/fs_context.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -904,6 +904,14 @@ static int smb3_fs_context_parse_param(s
 			ctx->sfu_remap = false; /* disable SFU mapping */
 		}
 		break;
+	case Opt_mapchars:
+		if (result.negated)
+			ctx->sfu_remap = false;
+		else {
+			ctx->sfu_remap = true;
+			ctx->remap = false; /* disable SFM (mapposix) mapping */
+		}
+		break;
 	case Opt_user_xattr:
 		if (result.negated)
 			ctx->no_xattr = 1;


