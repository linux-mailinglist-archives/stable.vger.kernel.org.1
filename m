Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB57578ABAD
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjH1Kdb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjH1KdI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458C0CF5
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B30FC63D6C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5749C433C8;
        Mon, 28 Aug 2023 10:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218764;
        bh=uFEkGqbVSO7r09zOLQcyma6L9nSCv2pbiCBmA411N88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1na9p6s3418fapHo1fFhI48oY30ySTU1sBPoLivZy9fKsrJ6yRswhlzZBJBzRlYV3
         WhtYeWZkft5P9hnNFB7CHIuJBEevFKoMOVHrQnXhto4Ac4lG0a7VMjWvuVDw3NWx/e
         vjskV66hU2L2S2jXdrnYv9JEzKS3iww0rIBtqWsw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1 075/122] nfsd: Fix race to FREE_STATEID and cl_revoked
Date:   Mon, 28 Aug 2023 12:13:10 +0200
Message-ID: <20230828101158.920135142@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Coddington <bcodding@redhat.com>

commit 3b816601e279756e781e6c4d9b3f3bd21a72ac67 upstream.

We have some reports of linux NFS clients that cannot satisfy a linux knfsd
server that always sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED even though
those clients repeatedly walk all their known state using TEST_STATEID and
receive NFS4_OK for all.

Its possible for revoke_delegation() to set NFS4_REVOKED_DELEG_STID, then
nfsd4_free_stateid() finds the delegation and returns NFS4_OK to
FREE_STATEID.  Afterward, revoke_delegation() moves the same delegation to
cl_revoked.  This would produce the observed client/server effect.

Fix this by ensuring that the setting of sc_type to NFS4_REVOKED_DELEG_STID
and move to cl_revoked happens within the same cl_lock.  This will allow
nfsd4_free_stateid() to properly remove the delegation from cl_revoked.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2217103
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2176575
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Cc: stable@vger.kernel.org # v4.17+
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1368,9 +1368,9 @@ static void revoke_delegation(struct nfs
 	WARN_ON(!list_empty(&dp->dl_recall_lru));
 
 	if (clp->cl_minorversion) {
+		spin_lock(&clp->cl_lock);
 		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
 		refcount_inc(&dp->dl_stid.sc_count);
-		spin_lock(&clp->cl_lock);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
 		spin_unlock(&clp->cl_lock);
 	}


