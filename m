Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A927BDE01
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376693AbjJINOx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376619AbjJINOw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:14:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33A891
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:14:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12757C433C9;
        Mon,  9 Oct 2023 13:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857290;
        bh=EH05vGOIRCQjwVkxqv6JaifPO7BaRP03W06rzXCowvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTmKZmGbpBemBJSt4abpuIJPHhQHHC5RXPa8zT0lp+vigUUuSurzyx/+FpdmjiSov
         x01zomWN8D7Y2OzErfqo8NkKuPOqeoV1Z4Wf8B+146KssysRW1ihietj0oyChjVha4
         0bdesV1WtoWL96BY6Z1C0tXMGw0Iw1j5nAHEiP+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, luosili <rootlab@huawei.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.5 161/163] ksmbd: fix uaf in smb20_oplock_break_ack
Date:   Mon,  9 Oct 2023 15:02:05 +0200
Message-ID: <20231009130128.448565245@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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
@@ -8036,10 +8036,10 @@ static void smb20_oplock_break_ack(struc
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


