Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1CB7BDECB
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376434AbjJINXL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376436AbjJINXL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:23:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E06C8F
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:23:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF10C433C7;
        Mon,  9 Oct 2023 13:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857789;
        bh=28y/hV1MSU6gZ/zG0qp7mqiRX6w4hXiwNfblMt1U3P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v6HHrlza4u25OSxS2XjkOIqoDrURZKklCjOnlfmiZeivJXgVmXnhHmI/9p9GEVwFb
         aMwEly8EDVu+6qAA72HkLpdbF0cft5wBBByYSLOgvbKriZ1Wrxs2+WYyQEyycxDbSg
         cf2qyt3HrwT6gDBPahwA7NTdJjUZx0CousRv4RNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, luosili <rootlab@huawei.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 156/162] ksmbd: fix uaf in smb20_oplock_break_ack
Date:   Mon,  9 Oct 2023 15:02:17 +0200
Message-ID: <20231009130127.219822562@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

From: luosili <rootlab@huawei.com>

commit c69813471a1ec081a0b9bf0c6bd7e8afd818afce upstream.

drop reference after use opinfo.

Signed-off-by: luosili <rootlab@huawei.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8128,10 +8128,10 @@ static void smb20_oplock_break_ack(struc
 		goto err_out;
 	}
 
-	opinfo_put(opinfo);
-	ksmbd_fd_put(work, fp);
 	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
+	opinfo_put(opinfo);
+	ksmbd_fd_put(work, fp);
 
 	rsp->StructureSize = cpu_to_le16(24);
 	rsp->OplockLevel = rsp_oplevel;


