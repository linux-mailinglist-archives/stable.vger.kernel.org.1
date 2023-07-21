Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC8E75CDC2
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjGUQOk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjGUQOZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:14:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587833A8E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE72C61D14
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF376C433C8;
        Fri, 21 Jul 2023 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956030;
        bh=Oxgdi4g396zCwsMl/G1VUZUjqRDnVmIsTYYSZyBJP5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2JOtnM57BZFMPuE8cWHT3n7cDg5ZW9NktnjAfiksUASKawuqou0crwqpAzEN+/d6A
         yPfOdOTNuHIoKyZHsWRxAHSF6H6aMdiQKgsTc9oOvTVejwg/Q78xZ3DkdGoj60M4i5
         Y+WFIu+KEN0or/ZLs0Je4aqn4rFFbN2+wS9jSOkM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Winston Wen <wentao@uniontech.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.4 109/292] cifs: fix session state check in smb2_find_smb_ses
Date:   Fri, 21 Jul 2023 18:03:38 +0200
Message-ID: <20230721160533.494854644@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: Winston Wen <wentao@uniontech.com>

commit 66be5c48ee1b5b8c919cc329fe6d32e16badaa40 upstream.

Chech the session state and skip it if it's exiting.

Signed-off-by: Winston Wen <wentao@uniontech.com>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2transport.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -153,7 +153,14 @@ smb2_find_smb_ses_unlocked(struct TCP_Se
 	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
 		if (ses->Suid != ses_id)
 			continue;
+
+		spin_lock(&ses->ses_lock);
+		if (ses->ses_status == SES_EXITING) {
+			spin_unlock(&ses->ses_lock);
+			continue;
+		}
 		++ses->ses_count;
+		spin_unlock(&ses->ses_lock);
 		return ses;
 	}
 


