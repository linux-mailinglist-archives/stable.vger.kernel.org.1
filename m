Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A5B7D31B6
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjJWLMO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjJWLMN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:12:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B4999
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:12:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D417EC433C7;
        Mon, 23 Oct 2023 11:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059531;
        bh=hagnu/DQnbWHjOzlAc5m1PCotn8o6G9Ob8JYNQAvTF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XNMopWdyI5g79Zs7VbM8M4SaPFdoBRNFD3TPjQVHUZtOJRgWH13plLOP2awgCapyG
         /IhNCrhGystZKN7WJzenkBq3tMQQxm/WV/hoIR46NQr6Wp/ZRsmboj17LAsVoAlf6u
         xyBgmiXfJovKG/GYVCaFLyAQUlk5KoIbQh4KqdwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 6.5 181/241] NFSv4.1: fixup use EXCHGID4_FLAG_USE_PNFS_DS for DS server
Date:   Mon, 23 Oct 2023 12:56:07 +0200
Message-ID: <20231023104838.294987634@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olga Kornievskaia <kolga@netapp.com>

commit 379e4adfddd6a2f95a4f2029b8ddcbacf92b21f9 upstream.

This patches fixes commit 51d674a5e488 "NFSv4.1: use
EXCHGID4_FLAG_USE_PNFS_DS for DS server", purpose of that
commit was to mark EXCHANGE_ID to the DS with the appropriate
flag.

However, connection to MDS can return both EXCHGID4_FLAG_USE_PNFS_DS
and EXCHGID4_FLAG_USE_PNFS_MDS set but previous patch would only
remember the USE_PNFS_DS and for the 2nd EXCHANGE_ID send that
to the MDS.

Instead, just mark the pnfs path exclusively.

Fixes: 51d674a5e488 ("NFSv4.1: use EXCHGID4_FLAG_USE_PNFS_DS for DS server")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4proc.c |    2 --
 1 file changed, 2 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8870,8 +8870,6 @@ static int _nfs4_proc_exchange_id(struct
 	/* Save the EXCHANGE_ID verifier session trunk tests */
 	memcpy(clp->cl_confirm.data, argp->verifier.data,
 	       sizeof(clp->cl_confirm.data));
-	if (resp->flags & EXCHGID4_FLAG_USE_PNFS_DS)
-		set_bit(NFS_CS_DS, &clp->cl_flags);
 out:
 	trace_nfs4_exchange_id(clp, status);
 	rpc_put_task(task);


