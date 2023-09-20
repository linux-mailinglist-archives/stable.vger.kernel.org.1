Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FCD7A7ECE
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbjITMUw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbjITMUv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:20:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5C583
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:20:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD549C433C9;
        Wed, 20 Sep 2023 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212446;
        bh=gemPILUFLBeNlYw80gnxbqjN0fVSEhvRVE5eAqrYUek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBGqUf7fH4li59EJPusE6pKU4FUb9YsVR2Kukdj7uYa4QWRqKRj+ejyQPceW0kME0
         NTFLvcSOC40W+i6OHfPNoUmQPAnTPB/1yILK82vuLvgFxcUYsl0qKeW5v1GaSrdCqc
         WFjKcTun6AQMgLniqEAyO5kCndLGb+5GxHxQH9mY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhi Li <yieli@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 4.19 270/273] nfsd: fix change_info in NFSv4 RENAME replies
Date:   Wed, 20 Sep 2023 13:31:50 +0200
Message-ID: <20230920112854.558826840@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

commit fdd2630a7398191e84822612e589062063bd4f3d upstream.

nfsd sends the transposed directory change info in the RENAME reply. The
source directory is in save_fh and the target is in current_fh.

Reported-by: Zhi Li <yieli@redhat.com>
Reported-by: Benjamin Coddington <bcodding@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2218844
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4proc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -870,8 +870,8 @@ nfsd4_rename(struct svc_rqst *rqstp, str
 			     rename->rn_tname, rename->rn_tnamelen);
 	if (status)
 		return status;
-	set_change_info(&rename->rn_sinfo, &cstate->current_fh);
-	set_change_info(&rename->rn_tinfo, &cstate->save_fh);
+	set_change_info(&rename->rn_sinfo, &cstate->save_fh);
+	set_change_info(&rename->rn_tinfo, &cstate->current_fh);
 	return nfs_ok;
 }
 


