Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CECF6FAD34
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbjEHLcX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbjEHLbs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:31:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0953D219
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CA75630D6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C936C4339E;
        Mon,  8 May 2023 11:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545463;
        bh=JA25SojDqvxn16AwM279tF7choKsE7axMyHFEfL8Kug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Kp639/08fx9WflW1kff8Tc3IHBWVR9/1volXvxhw6tl9PB//98n5x3kD05dHG/sC
         0IEYLF6VGDToWg2iT9pJXpOheakaUyoEI4AyMTr6Kda2WN6wkVLjh2DBQaX7rjI+Hy
         QTTD/gZV8VQDI3AZ5o5WEincvonav4QutBf0QdhQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 5.15 048/371] ksmbd: fix memleak in session setup
Date:   Mon,  8 May 2023 11:44:09 +0200
Message-Id: <20230508094813.969651242@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

commit 6d7cb549c2ca20e1f07593f15e936fd54b763028 upstream.

If client send session setup request with unknown NTLMSSP message type,
session that does not included channel can be created. It will cause
session memleak. because ksmbd_sessions_deregister() does not destroy
session if channel is not included. This patch return error response if
client send the request unknown NTLMSSP message type.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-20593
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1786,6 +1786,10 @@ int smb2_sess_setup(struct ksmbd_work *w
 				}
 				kfree(sess->Preauth_HashValue);
 				sess->Preauth_HashValue = NULL;
+			} else {
+				pr_info_ratelimited("Unknown NTLMSSP message type : 0x%x\n",
+						le32_to_cpu(negblob->MessageType));
+				rc = -EINVAL;
 			}
 		} else {
 			/* TODO: need one more negotiation */


