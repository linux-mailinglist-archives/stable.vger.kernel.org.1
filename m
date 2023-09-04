Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71B8791D18
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjIDSfB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242766AbjIDSfB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:35:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB7FCD4
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 57A15CE0D97
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68614C433C8;
        Mon,  4 Sep 2023 18:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852494;
        bh=hE4lDAafTrw+NTvZJAYfnYATW/2VaRSOOvhXDDwSxNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGO27SerouQHFxBZMNlwUyFsOZnFjTrN/x2254Zsi0DJHMtuWHo+QhwLRaKKGh6Rc
         35vSP/3Yak7Tm6JOvJKNBVzh5me4q2y4zsd7tWVyoxbsbkDEeuS+bCavIMJAZ39kab
         lf79kTyJ8t4w4+q+BqKV0ZpjABTZcoK9oi4wOEfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 6.1 02/31] ksmbd: fix wrong DataOffset validation of create context
Date:   Mon,  4 Sep 2023 19:30:10 +0100
Message-ID: <20230904182947.115465529@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182946.999390199@linuxfoundation.org>
References: <20230904182946.999390199@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 17d5b135bb720832364e8f55f6a887a3c7ec8fdb upstream.

If ->DataOffset of create context is 0, DataBuffer size is not correctly
validated. This patch change wrong validation code and consider tag
length in request.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21824
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/oplock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1492,7 +1492,7 @@ struct create_context *smb2_find_context
 		    name_len < 4 ||
 		    name_off + name_len > cc_len ||
 		    (value_off & 0x7) != 0 ||
-		    (value_off && (value_off < name_off + name_len)) ||
+		    (value_len && value_off < name_off + (name_len < 8 ? 8 : name_len)) ||
 		    ((u64)value_off + value_len > cc_len))
 			return ERR_PTR(-EINVAL);
 


