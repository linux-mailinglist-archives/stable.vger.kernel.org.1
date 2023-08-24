Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8B37872F7
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241941AbjHXO65 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242005AbjHXO6p (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:58:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C830EC7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65CEF67069
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A0DC433C8;
        Thu, 24 Aug 2023 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889122;
        bh=ZH+J2kkMaIzPO6JFbPrrs8r1dX5V9u+MvTuyQuZ18pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iIBk6zuu5nbCUXgy6w4EzKo0ztfjR42wglq8peaxt9IfLf92PSo7UUF2URO3jCqfs
         /qf9+FXK/i1knKRsrFNfuUWEbxE/uQm0q8keD0uuR0XbQNaNO759WsaJVwgjvqMLaQ
         oUhy6TLRKlKSarPJ1SXYrEZa03dY2cA0eofj7fUo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+cd311b1e43cc25f90d18@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 022/135] udf: Fix uninitialized array access for some pathnames
Date:   Thu, 24 Aug 2023 16:49:25 +0200
Message-ID: <20230824145027.910412050@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit 028f6055c912588e6f72722d89c30b401bbcf013 ]

For filenames that begin with . and are between 2 and 5 characters long,
UDF charset conversion code would read uninitialized memory in the
output buffer. The only practical impact is that the name may be prepended a
"unification hash" when it is not actually needed but still it is good
to fix this.

Reported-by: syzbot+cd311b1e43cc25f90d18@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000e2638a05fe9dc8f9@google.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/unicode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
index 622569007b530..2142cbd1dde24 100644
--- a/fs/udf/unicode.c
+++ b/fs/udf/unicode.c
@@ -247,7 +247,7 @@ static int udf_name_from_CS0(struct super_block *sb,
 	}
 
 	if (translate) {
-		if (str_o_len <= 2 && str_o[0] == '.' &&
+		if (str_o_len > 0 && str_o_len <= 2 && str_o[0] == '.' &&
 		    (str_o_len == 1 || str_o[1] == '.'))
 			needsCRC = 1;
 		if (needsCRC) {
-- 
2.40.1



