Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FE170C81D
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjEVTf5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjEVTfz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:35:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AF2E78
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:35:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDD206288F
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA28C433D2;
        Mon, 22 May 2023 19:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784082;
        bh=qhbOK6fI3RUsD3s2Q+BB078Hdq4q8lEbKfKsd1/52X8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lrLBALYzmTY6eRBlG7wc6SVoCRP9vhpwD5XyEyhoNlcU5rhycB9UyFfC6TV0s3X4P
         soxhYTcjQZXae5LE9NVZHL5P2UwhetDH3HE2GIt6b1E8Nia/lcxVCZ9NpKDSOpEVEZ
         uc4qzGODSnVMJKQyzHvKDWGZdHjUX9KORu+HdTMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chih-Yen Chang <cc85nod@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 257/292] ksmbd: allocate one more byte for implied bcc[0]
Date:   Mon, 22 May 2023 20:10:14 +0100
Message-Id: <20230522190412.368305831@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Chih-Yen Chang <cc85nod@gmail.com>

commit 443d61d1fa9faa60ef925513d83742902390100f upstream.

ksmbd_smb2_check_message allows client to return one byte more, so we
need to allocate additional memory in ksmbd_conn_handler_loop to avoid
out-of-bound access.

Cc: stable@vger.kernel.org
Signed-off-by: Chih-Yen Chang <cc85nod@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/connection.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -353,7 +353,8 @@ int ksmbd_conn_handler_loop(void *p)
 			break;
 
 		/* 4 for rfc1002 length field */
-		size = pdu_size + 4;
+		/* 1 for implied bcc[0] */
+		size = pdu_size + 4 + 1;
 		conn->request_buf = kvmalloc(size, GFP_KERNEL);
 		if (!conn->request_buf)
 			break;


