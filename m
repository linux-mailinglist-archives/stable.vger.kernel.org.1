Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F3F7758B3
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjHIKzF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjHIKyz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:54:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED412727
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:53:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B28963145
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46409C433C7;
        Wed,  9 Aug 2023 10:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578351;
        bh=QD+2NvHvpYFesV9dgkYpnKxM7sapwZVDek+B14lqOc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q55WGGDwOpdpLf+iueKx9at0bI929a4i0hqttjlXHtnd987s/UzBSMh7TTeM5/LPH
         ZWxtzGrTIJI2Hu2WzboqlTcNfltozrRk7EljWEo1AbdIx3W0fT133e9kk0AzwwKEYT
         Waj1xjttrC0uUF1xqFZnJjCh0ozxTjCKxENZFd/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        Lin Ma <linma@zju.edu.cn>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 028/127] bpf: Add length check for SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
Date:   Wed,  9 Aug 2023 12:40:15 +0200
Message-ID: <20230809103637.589469422@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit bcc29b7f5af6797702c2306a7aacb831fc5ce9cb ]

The nla_for_each_nested parsing in function bpf_sk_storage_diag_alloc
does not check the length of the nested attribute. This can lead to an
out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
be viewed as a 4 byte integer.

This patch adds an additional check when the nlattr is getting counted.
This makes sure the latter nla_get_u32 can access the attributes with
the correct length.

Fixes: 1ed4d92458a9 ("bpf: INET_DIAG support in bpf_sk_storage")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20230725023330.422856-1-linma@zju.edu.cn
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/bpf_sk_storage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 94374d529ea42..ad01b1bea52e4 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -531,8 +531,11 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
 		return ERR_PTR(-EPERM);
 
 	nla_for_each_nested(nla, nla_stgs, rem) {
-		if (nla_type(nla) == SK_DIAG_BPF_STORAGE_REQ_MAP_FD)
+		if (nla_type(nla) == SK_DIAG_BPF_STORAGE_REQ_MAP_FD) {
+			if (nla_len(nla) != sizeof(u32))
+				return ERR_PTR(-EINVAL);
 			nr_maps++;
+		}
 	}
 
 	diag = kzalloc(struct_size(diag, maps, nr_maps), GFP_KERNEL);
-- 
2.40.1



