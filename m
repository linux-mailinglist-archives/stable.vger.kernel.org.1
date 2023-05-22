Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69E70C9D9
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjEVTwm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbjEVTw2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:52:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F215E5F
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30E8062B04
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EC6C433EF;
        Mon, 22 May 2023 19:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785134;
        bh=GSIn+nF2typbYbJIOKFrYK6nXpPY50OOcI1kChhm4wI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQLJtqEifm9WHawcH84nvn9OCbZ7tV8LhfsM3oNZD+TfO2mhDBk19dprWepGz+KId
         kz5O6yj0KjdQEb6eVeXFLSNAvN69/Y0+Q0OO0wUYeIfTSu9tPWc9CYfTgr7J4DDp7m
         t3ofO63LDjX3oi2FAXnkK31mu++joV53RdHBJ66o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gustav Johansson <gustajo@axis.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.3 321/364] ksmbd: smb2: Allow messages padded to 8byte boundary
Date:   Mon, 22 May 2023 20:10:26 +0100
Message-Id: <20230522190420.800778437@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gustav Johansson <gustajo@axis.com>

commit e7b8b8ed9960bf699bf4029f482d9e869c094ed6 upstream.

clc length is now accepted to <= 8 less than length,
rather than < 8.

Solve issues on some of Axis's smb clients which send
messages where clc length is 8 bytes less than length.

The specific client was running kernel 4.19.217 with
smb dialect 3.0.2 on armv7l.

Cc: stable@vger.kernel.org
Signed-off-by: Gustav Johansson <gustajo@axis.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2misc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -416,8 +416,11 @@ int ksmbd_smb2_check_message(struct ksmb
 
 		/*
 		 * Allow a message that padded to 8byte boundary.
+		 * Linux 4.19.217 with smb 3.0.2 are sometimes
+		 * sending messages where the cls_len is exactly
+		 * 8 bytes less than len.
 		 */
-		if (clc_len < len && (len - clc_len) < 8)
+		if (clc_len < len && (len - clc_len) <= 8)
 			goto validate_credit;
 
 		pr_err_ratelimited(


