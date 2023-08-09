Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3406775D91
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjHILjF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbjHILjE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:39:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED171173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:39:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84961635D3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D146C433C8;
        Wed,  9 Aug 2023 11:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581142;
        bh=SG27IMz9V0ivSMFL9ya2R/4CplalVjSLkTvmbsGVf5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1Y56D+MmYDgULCaUV0IobqFnR8jEGckkIGOtVBbvpQCG6i/EXyFI2TZrbm7SywAX
         daSZ4ZBS/gAv3uFhjbc3KXYaEry49MWw3vxPvrq8WfoReS9vHbDCCy8sCks9bC4pFd
         3iIvpJT68ABzSk5DFPoxOKObtABtRLTgb4aLJhyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Frank Ch. Eigler" <fche@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.10 090/201] nfsd: Remove incorrect check in nfsd4_validate_stateid
Date:   Wed,  9 Aug 2023 12:41:32 +0200
Message-ID: <20230809103646.835618315@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
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
@@ -5656,8 +5656,6 @@ static __be32 nfsd4_validate_stateid(str
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return status;
-	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid))
-		return status;
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s)


