Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D0870391E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244357AbjEORjT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244349AbjEORiw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:38:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF3A1B77A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7869862DDE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6861AC433D2;
        Mon, 15 May 2023 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172172;
        bh=gUsLYDrdJw3o6YNcAkfmqQJTy4eBF7YssFNUN/JNt1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nnbS/kF7ZAuW2g7FiOvN1zB1mf7UOsf+Y7VJeXsoirsffLtsYQNITnYbgElkYDviT
         225YvL0wG4vi7rwjPuC/kk2HoHulaCJ1CJuHQMHdAsPtS2UaoTtcgzBkoCS+xkCtTq
         P3gRVnZiMdAYkmZLlFNyNdkW8S/0Y1rrSd2KTUIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.10 038/381] crypto: api - Demote BUG_ON() in crypto_unregister_alg() to a WARN_ON()
Date:   Mon, 15 May 2023 18:24:49 +0200
Message-Id: <20230515161738.536273522@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Toke Høiland-Jørgensen <toke@redhat.com>

commit a543ada7db729514ddd3ba4efa45f4c7b802ad85 upstream.

The crypto_unregister_alg() function expects callers to ensure that any
algorithm that is unregistered has a refcnt of exactly 1, and issues a
BUG_ON() if this is not the case. However, there are in fact drivers that
will call crypto_unregister_alg() without ensuring that the refcnt has been
lowered first, most notably on system shutdown. This causes the BUG_ON() to
trigger, which prevents a clean shutdown and hangs the system.

To avoid such hangs on shutdown, demote the BUG_ON() in
crypto_unregister_alg() to a WARN_ON() with early return. Cc stable because
this problem was observed on a 6.2 kernel, cf the link below.

Link: https://lore.kernel.org/r/87r0tyq8ph.fsf@toke.dk
Cc: stable@vger.kernel.org
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/algapi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -456,7 +456,9 @@ void crypto_unregister_alg(struct crypto
 	if (WARN(ret, "Algorithm %s is not registered", alg->cra_driver_name))
 		return;
 
-	BUG_ON(refcount_read(&alg->cra_refcnt) != 1);
+	if (WARN_ON(refcount_read(&alg->cra_refcnt) != 1))
+		return;
+
 	if (alg->cra_destroy)
 		alg->cra_destroy(alg);
 


