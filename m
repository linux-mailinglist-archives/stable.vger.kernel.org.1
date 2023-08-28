Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58A478AADB
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjH1KZ5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjH1KZY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:25:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203E3103
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A91DC63A50
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD22C433C7;
        Mon, 28 Aug 2023 10:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218319;
        bh=dSsKS1Bw35F3vG7h86sqTHxDbNgZUoRL4YrQc9W0Png=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkAyKq6N4wuAsmxJDCxWCjtySrc/kunI19Xsl1h6jqNCNnjvgf7TXFSwQlscoNmZh
         ThCyOS0mrtWR716uz13qB/mbEhKz/QE+y5gO40NxDDlBjobM746HIR6fsgVWMxwxiX
         kzrodXMSUtd1ZTwlCx9dbw/3l+knlW0fpTUBPtVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "J. Bruce Fields" <bfields@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 044/129] nfsd4: kill warnings on testing stateids with mismatched clientids
Date:   Mon, 28 Aug 2023 12:12:18 +0200
Message-ID: <20230828101154.822127743@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: J. Bruce Fields <bfields@redhat.com>

[ Upstream commit 663e36f07666ff924012defa521f88875f6e5402 ]

It's normal for a client to test a stateid from a previous instance,
e.g. after a network partition.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: f75546f58a70 ("nfsd: Remove incorrect check in nfsd4_validate_stateid")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 78191320f8e21..653ba2ffd4339 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4998,15 +4998,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return status;
-	/* Client debugging aid. */
-	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid)) {
-		char addr_str[INET6_ADDRSTRLEN];
-		rpc_ntop((struct sockaddr *)&cl->cl_addr, addr_str,
-				 sizeof(addr_str));
-		pr_warn_ratelimited("NFSD: client %s testing state ID "
-					"with incorrect client ID\n", addr_str);
+	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid))
 		return status;
-	}
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s)
-- 
2.40.1



