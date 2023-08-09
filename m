Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA257757C1
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjHIKtn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjHIKtn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:49:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892541FF5
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2082663124
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F26C433C7;
        Wed,  9 Aug 2023 10:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578181;
        bh=8ubs4RcrbBIeXpq2NzUn76EDHrR9zFkXbvjB4VCqmUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E45eH7rvCwyCoV9PgOXP4u0KGAGlYkWdHbj15Lrw7yzZrsLUI59lZIkdwtNyv9+o6
         hy7Tk9ym0DAYoBUc3D+mOZeLpgPgKrW6iDwqmt8dSu94JzyL3t5cQLmo9Gfib+DwKd
         l0Es9/1YrDJ9+1N10HU6w+WUCQyX1RT8UNwZeZMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, AVKrasnov@sberdevices.ru,
        Stefano Garzarella <sgarzare@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 095/165] test/vsock: remove vsock_perf executable on `make clean`
Date:   Wed,  9 Aug 2023 12:40:26 +0200
Message-ID: <20230809103645.891726314@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit 3c50c8b240390907c9a33c86d25d850520db6dfa ]

We forgot to add vsock_perf to the rm command in the `clean`
target, so now we have a left over after `make clean` in
tools/testing/vsock.

Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
Cc: AVKrasnov@sberdevices.ru
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
Link: https://lore.kernel.org/r/20230803085454.30897-1-sgarzare@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/vsock/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
index 43a254f0e14dd..21a98ba565ab5 100644
--- a/tools/testing/vsock/Makefile
+++ b/tools/testing/vsock/Makefile
@@ -8,5 +8,5 @@ vsock_perf: vsock_perf.o
 CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
 .PHONY: all test clean
 clean:
-	${RM} *.o *.d vsock_test vsock_diag_test
+	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf
 -include *.d
-- 
2.40.1



