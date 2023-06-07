Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F470726DE7
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjFGUqd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbjFGUqQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:46:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627E510EA
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:46:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBCF964697
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90D5C433EF;
        Wed,  7 Jun 2023 20:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170763;
        bh=NoXGJDsHf96ZtB8bjoZdgOBpCuSqudCgUPLR+s4g7bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8etF77dqnku9X3T9EXdn08rDiepQubKngfr7uK0W+fmFNrvKPTXpq0eswzbFrX3J
         d9V8LZLfvtF5DBC7l3/rR0JrSoq+PNvo9CekGqigjckBBKkrSdIOVbFlHSeerjCqpy
         GyG9lmKHddSanHKTYrGiFu7PLi0hNV9usowNP1eA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 208/225] ksmbd: fix credit count leakage
Date:   Wed,  7 Jun 2023 22:16:41 +0200
Message-ID: <20230607200921.166816467@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

commit 84c5aa47925a1f40d698b6a6a2bf67e99617433d upstream.

This patch fix the failure from smb2.credits.single_req_credits_granted
test. When client send 8192 credit request, ksmbd return 8191 credit
granted. ksmbd should give maximum possible credits that must be granted
within the range of not exceeding the max credit to client.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -326,13 +326,9 @@ int smb2_set_rsp_credits(struct ksmbd_wo
 	if (hdr->Command == SMB2_NEGOTIATE)
 		aux_max = 1;
 	else
-		aux_max = conn->vals->max_credits - credit_charge;
+		aux_max = conn->vals->max_credits - conn->total_credits;
 	credits_granted = min_t(unsigned short, credits_requested, aux_max);
 
-	if (conn->vals->max_credits - conn->total_credits < credits_granted)
-		credits_granted = conn->vals->max_credits -
-			conn->total_credits;
-
 	conn->total_credits += credits_granted;
 	work->credits_granted += credits_granted;
 


