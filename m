Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3E37B8A23
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244320AbjJDScm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244361AbjJDScl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:32:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34436A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:32:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78569C433C8;
        Wed,  4 Oct 2023 18:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444357;
        bh=Qsw9FFYaX06WTYXImgxgSLLpXOJwNSYb56sL4szC31M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oy2FPjNOdOY1kPLZ65z6l7ZbfTbiYVrehUvwdoaOybaf85t2iwHvMMjMW/okgczg/
         xbUsJlbJ0DFtMy4fNHprz833gKPfc7V0eidQhv4Wgq+/Nf/I+FYAH23Jv0N2pIJT/S
         OZMeLLNuloPCC2SnFqXgZkHB1hVzyXNZI+GUcP9k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Olga Kornievskaia <kolga@netapp.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 222/321] NFSv4.1: fix zero value filehandle in post open getattr
Date:   Wed,  4 Oct 2023 19:56:07 +0200
Message-ID: <20231004175239.500617364@linuxfoundation.org>
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

From: Olga Kornievskaia <kolga@netapp.com>

[ Upstream commit 4506f23e117161a20104c8fa04f33e1ca63c26af ]

Currently, if the OPEN compound experiencing an error and needs to
get the file attributes separately, it will send a stand alone
GETATTR but it would use the filehandle from the results of
the OPEN compound. In case of the CLAIM_FH OPEN, nfs_openres's fh
is zero value. That generate a GETATTR that's sent with a zero
value filehandle, and results in the server returning an error.

Instead, for the CLAIM_FH OPEN, take the filehandle that was used
in the PUTFH of the OPEN compound.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3bc6bfdf7b814..890ae26006ee1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2703,8 +2703,12 @@ static int _nfs4_proc_open(struct nfs4_opendata *data,
 			return status;
 	}
 	if (!(o_res->f_attr->valid & NFS_ATTR_FATTR)) {
+		struct nfs_fh *fh = &o_res->fh;
+
 		nfs4_sequence_free_slot(&o_res->seq_res);
-		nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr, NULL);
+		if (o_arg->claim == NFS4_OPEN_CLAIM_FH)
+			fh = NFS_FH(d_inode(data->dentry));
+		nfs4_proc_getattr(server, fh, o_res->f_attr, NULL);
 	}
 	return 0;
 }
-- 
2.40.1



