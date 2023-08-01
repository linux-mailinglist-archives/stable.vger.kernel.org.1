Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8DD76AD76
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjHAJ3l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjHAJ3T (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B15326A2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0490361508
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D338BC433C7;
        Tue,  1 Aug 2023 09:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882082;
        bh=GuopNbTdn6LI8WT4q6RKIgulfvL9MeCeqdAXhbY/ztU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g0Yn3CdGd4K07/Z7A2SF5HpMcDXi+YFphSHfdgjHWDwwBy3ctcVHzqsFIIr/GW41z
         RV5T196JRPWdMNJLNnVGNGzAQ9LhZzb1281nVQaJ+1lpEz4xQ27cGJL6uvWa39wa/0
         3QzoHmpTmFTMzd3AF3RPuXKqzePPgW/E8dXg1Xv0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Frank Ch. Eigler" <fche@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 134/155] nfsd: Remove incorrect check in nfsd4_validate_stateid
Date:   Tue,  1 Aug 2023 11:20:46 +0200
Message-ID: <20230801091914.947501783@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit f75546f58a70da5cfdcec5a45ffc377885ccbee8 upstream.

If the client is calling TEST_STATEID, then it is because some event
occurred that requires it to check all the stateids for validity and
call FREE_STATEID on the ones that have been revoked. In this case,
either the stateid exists in the list of stateids associated with that
nfs4_client, in which case it should be tested, or it does not. There
are no additional conditions to be considered.

Reported-by: "Frank Ch. Eigler" <fche@redhat.com>
Fixes: 7df302f75ee2 ("NFSD: TEST_STATEID should not return NFS4ERR_STALE_STATEID")
Cc: stable@vger.kernel.org # v5.7+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |    2 --
 1 file changed, 2 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5833,8 +5833,6 @@ static __be32 nfsd4_validate_stateid(str
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return status;
-	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid))
-		return status;
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s)


