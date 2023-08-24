Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E507872C4
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbjHXO4r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241978AbjHXO4i (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:56:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C191995
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08945612C4
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBA8C433C7;
        Thu, 24 Aug 2023 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888995;
        bh=1dO6tuPTmhp1VGa1InoeoViU2iS31kF3itFd3LFyfAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+tJVDLkedOVadM7zto5xt7Hmx7vkI+obh5htFUGfTKkIxICxvRwV8n9P6QQQF2xG
         AE+88YHqirHg/j20uvbYP8/+IFHwW9F3poo9Gt3oFaU5syu1DYzsSMP2V3jrwMwyHH
         4chTOAPlBtNfJHC6PNbanNEur0z3cP++NqOvsup8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuezhang Mo <Yuezhang.Mo@sony.com>,
        Maxim Suhanov <dfirblog@gmail.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15 117/139] exfat: check if filename entries exceeds max filename length
Date:   Thu, 24 Aug 2023 16:50:40 +0200
Message-ID: <20230824145028.582929000@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

commit d42334578eba1390859012ebb91e1e556d51db49 upstream.

exfat_extract_uni_name copies characters from a given file name entry into
the 'uniname' variable. This variable is actually defined on the stack of
the exfat_readdir() function. According to the definition of
the 'exfat_uni_name' type, the file name should be limited 255 characters
(+ null teminator space), but the exfat_get_uniname_from_ext_entry()
function can write more characters because there is no check if filename
entries exceeds max filename length. This patch add the check not to copy
filename characters when exceeding max filename length.

Cc: stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reported-by: Maxim Suhanov <dfirblog@gmail.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Harshit: backport to 5.15.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/exfat/dir.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -34,6 +34,7 @@ static void exfat_get_uniname_from_ext_e
 {
 	int i;
 	struct exfat_entry_set_cache *es;
+	unsigned int uni_len = 0, len;
 
 	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES);
 	if (!es)
@@ -52,7 +53,10 @@ static void exfat_get_uniname_from_ext_e
 		if (exfat_get_entry_type(ep) != TYPE_EXTEND)
 			break;
 
-		exfat_extract_uni_name(ep, uniname);
+		len = exfat_extract_uni_name(ep, uniname);
+		uni_len += len;
+		if (len != EXFAT_FILE_NAME_LEN || uni_len >= MAX_NAME_LENGTH)
+			break;
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
 
@@ -1032,7 +1036,8 @@ rewind:
 			if (entry_type == TYPE_EXTEND) {
 				unsigned short entry_uniname[16], unichar;
 
-				if (step != DIRENT_STEP_NAME) {
+				if (step != DIRENT_STEP_NAME ||
+				    name_len >= MAX_NAME_LENGTH) {
 					step = DIRENT_STEP_FILE;
 					continue;
 				}


