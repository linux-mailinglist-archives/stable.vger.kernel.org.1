Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA67DA8AB
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 20:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjJ1Slj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 28 Oct 2023 14:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Sli (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 28 Oct 2023 14:41:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE267D9
        for <stable@vger.kernel.org>; Sat, 28 Oct 2023 11:41:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7cc433782so26820477b3.3
        for <stable@vger.kernel.org>; Sat, 28 Oct 2023 11:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698518495; x=1699123295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LT/obDBJABfb8QCqKTqEEdFn+fX3d4iF5BqppBNxXsU=;
        b=piSo4TGc7gM2i2QFChqTVMouiYt19wmkHoG97MUyxLOAs2hOzJgANVvyaOY9yK14oN
         3E3kAemYBbZWM+uhgz+FNonpZwV9by0OFmKADbVSSc1OpeMdzW0pz4N1+dpbgZ7G8ou4
         dxuyvtRRel4J+hZdjVFC9zsKAY8vGoLW2RmRaR0k5xfzqrrZs4VxXlUjAYA/y1yijczw
         HNsr4MUBUg3927FNdvMPzDQ1+/8JboDYipRfCYAd6EhN52Uq8aKAtRv3qbVbsJ3gm+h4
         6Mr3DyV+iXrDv8GvP/EDCZ4U0RN1TGs/SEA3l0Afep4H6gFTvxiyZq9Mc7aOrJk1YTGJ
         VkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698518495; x=1699123295;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LT/obDBJABfb8QCqKTqEEdFn+fX3d4iF5BqppBNxXsU=;
        b=oqlWV3w1xoOPTw+Ztx9W3g13feHcwS5/b8yZcVMUygPy5GXddMJC2bxR/qFHZ+9JeS
         xAXJvBUnqMzpEY/HH0gjVFpzcANnni0JeO97lcfaK7AL0y2uCs+6xdl9Xhsxf2dZTbf8
         KNjgJLd3jZuEofLXjfTL4bZW/Fo9WMEwbUsvFhrSPCIA7kDZwgZQkHlF59mbfCZEYxkI
         lWYEQjEmw7agBv0nRTCcz/jrwKDdzQa2EtXNJAkwnVrMiPAxJlqwsixT4/FfI9W+FEpW
         Jl7TtDm29KHfAmW281W1hxqjMGyv3GP9nhxC1/0ktURRgDrg5d1lCGkNiAgJbNukVTq+
         wblQ==
X-Gm-Message-State: AOJu0YzTHVCpNb6GBOqC0zI/TiLY8m/sw8EiY2CKswhZGIhhz+SKeqZn
        PbA7WDNFg5sz3pbXUoTr1vSU70jeyaOxLyQ=
X-Google-Smtp-Source: AGHT+IEWcYRt5CfYLxiiSv7LopaNWnrosDwtfmpOMt7IrDJPoCJywxVs2ewKYzO/4eNde4EHQG+2mTTUCRrvH6U=
X-Received: from jsperbeck7.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:26dc])
 (user=jsperbeck job=sendgmr) by 2002:a81:6c49:0:b0:5a7:ba09:44b6 with SMTP id
 h70-20020a816c49000000b005a7ba0944b6mr124674ywc.0.1698518494827; Sat, 28 Oct
 2023 11:41:34 -0700 (PDT)
Date:   Sat, 28 Oct 2023 18:41:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231028184131.2103810-1-jsperbeck@google.com>
Subject: [PATCH v2] objtool/x86: add missing embedded_insn check
From:   John Sperbeck <jsperbeck@google.com>
To:     gregkh@linuxfoundation.org
Cc:     bp@alien8.de, jpoimboe@kernel.org, patches@lists.linux.dev,
        peterz@infradead.org, stable@vger.kernel.org, jsperbeck@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

When dbf460087755 ("objtool/x86: Fixup frame-pointer vs rethunk")
was backported to some stable branches, the check for dest->embedded_insn
in is_special_call() was missed.  The result is that the warning it
was intended to suppress still appears.  For example on 6.1 (on kernels
before 6.1, the '-s' argument would instead be 'check'):

$ tools/objtool/objtool -s arch/x86/lib/retpoline.o
arch/x86/lib/retpoline.o: warning: objtool: srso_untrain_ret+0xd:
    call without frame pointer save/setup

With this patch, the warning is correctly suppressed, and the
kernel still passes the normal Google kernel developer tests.

Signed-off-by: John Sperbeck <jsperbeck@google.com>
---

I think 6.1.y, 5.15.y, and 5.10.y are the LTS branches missing the
bit of code that this patch re-adds.

Changes from v1 to v2:
* include more context in the commit message.


 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f8008ab31eef..cb363b507a32 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2478,7 +2478,7 @@ static bool is_special_call(struct instruction *insn)
 		if (!dest)
 			return false;
 
-		if (dest->fentry)
+		if (dest->fentry || dest->embedded_insn)
 			return true;
 	}
 
-- 
2.42.0.820.g83a721a137-goog

