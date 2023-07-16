Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D2F755700
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjGPU4O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjGPU4N (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:56:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFBBE54
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:56:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 412F660EAD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAB3C433C8;
        Sun, 16 Jul 2023 20:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540971;
        bh=FWQD2QO8jybz1qxsN0ZByN3w8b+lUw/krCs9GI/86KY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rEcazSejlxKXpUO2mIMhSl/LeIWZ6Jw4ARV4r06lwlO3zTfhfUhwnlVaTA7+dmNaM
         8ftp+Qh6so1rQwsOixB+8K+s4Q5jpoQYVNPp6Wy19gvrNlTygfQwsk1ZqDlzneOGGB
         3PjrgmJwGOU0zLyDyAH4Nazs/USGRBMpa2K6k1kQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dai Ngo <dai.ngo@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1 526/591] NFSD: add encoding of op_recall flag for write delegation
Date:   Sun, 16 Jul 2023 21:51:05 +0200
Message-ID: <20230716194937.480976116@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dai Ngo <dai.ngo@oracle.com>

commit 58f5d894006d82ed7335e1c37182fbc5f08c2f51 upstream.

Modified nfsd4_encode_open to encode the op_recall flag properly
for OPEN result with write delegation granted.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4xdr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3872,7 +3872,7 @@ nfsd4_encode_open(struct nfsd4_compoundr
 		p = xdr_reserve_space(xdr, 32);
 		if (!p)
 			return nfserr_resource;
-		*p++ = cpu_to_be32(0);
+		*p++ = cpu_to_be32(open->op_recall);
 
 		/*
 		 * TODO: space_limit's in delegations


