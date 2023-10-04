Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4307B893E
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244129AbjJDSYA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244148AbjJDSX6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:23:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119D2AD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:23:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558D9C433C7;
        Wed,  4 Oct 2023 18:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443834;
        bh=7DDFO70f2tHKJtwbjHe8zezFmT/hWY8HpwpeUQlr5do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1Y4b0U+zvUr0yCwrzWcsAc3pODLyftx8iNzGjzE2GW4pXGjEX+jWxJum4vy3Pl1e
         BhjZmRrOI6Mwkz3+sMpBX+6S7r+keIc0vJOH8TYUIncyaa70aBQZuWw9H/zbRAYhz6
         wV2hVMjixyWciCPwObl5u6PAnFhkXEPeR1YKCxig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 037/321] bpf: Fix a erroneous check after snprintf()
Date:   Wed,  4 Oct 2023 19:53:02 +0200
Message-ID: <20231004175230.880663614@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit a8f12572860ad8ba659d96eee9cf09e181f6ebcc ]

snprintf() does not return negative error code on error, it returns the
number of characters which *would* be generated for the given input.

Fix the error handling check.

Fixes: 57539b1c0ac2 ("bpf: Enable annotating trusted nested pointers")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/393bdebc87b22563c08ace094defa7160eb7a6c0.1694190795.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4b38c97990872..197d8252ffc65 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8498,7 +8498,7 @@ bool btf_nested_type_is_trusted(struct bpf_verifier_log *log,
 	tname = btf_name_by_offset(btf, walk_type->name_off);
 
 	ret = snprintf(safe_tname, sizeof(safe_tname), "%s%s", tname, suffix);
-	if (ret < 0)
+	if (ret >= sizeof(safe_tname))
 		return false;
 
 	safe_id = btf_find_by_name_kind(btf, safe_tname, BTF_INFO_KIND(walk_type->info));
-- 
2.40.1



