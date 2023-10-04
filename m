Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731177B893F
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244146AbjJDSYD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244142AbjJDSYB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:24:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC47A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:23:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBF8C433CC;
        Wed,  4 Oct 2023 18:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443837;
        bh=CxO1MQH/F0AL/ksyccRvd4u6OjccmWJtxgJMyplXb4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CXylN54xUL1bdwVhR1a8NaN2NBg19s3A73xtTdJEFniJaFkgcmFQUo1DxrHs7X3Lr
         stJtiTj3oy+HAVZo02+IUbtW7jAX4XR1uO8gzv0RdW7KZBxQJOE1LVlMa8y3DRB5Pr
         g7KrX1z/Oosav4kjD5x5aAK2h6dXdOmUJ6mHu5yk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Artem Savkov <asavkov@redhat.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 038/321] selftests/bpf: fix unpriv_disabled check in test_verifier
Date:   Wed,  4 Oct 2023 19:53:03 +0200
Message-ID: <20231004175230.926948469@linuxfoundation.org>
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

From: Artem Savkov <asavkov@redhat.com>

[ Upstream commit d128860dbb29cafc3c65ca2d22082745a32829dd ]

Commit 1d56ade032a49 changed the function get_unpriv_disabled() to
return its results as a bool instead of updating a global variable, but
test_verifier was not updated to keep in line with these changes. Thus
unpriv_disabled is always false in test_verifier and unprivileged tests
are not properly skipped on systems with unprivileged bpf disabled.

Fixes: 1d56ade032a49 ("selftests/bpf: Unprivileged tests for test_loader.c")
Signed-off-by: Artem Savkov <asavkov@redhat.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20230912120631.213139-1-asavkov@redhat.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 31f1c935cd07d..98107e0452d33 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1880,7 +1880,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	get_unpriv_disabled();
+	unpriv_disabled = get_unpriv_disabled();
 	if (unpriv && unpriv_disabled) {
 		printf("Cannot run as unprivileged user with sysctl %s.\n",
 		       UNPRIV_SYSCTL);
-- 
2.40.1



