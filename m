Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A087D7A8A
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 03:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjJZB5i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 21:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZB5i (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 21:57:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AF7115
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 18:57:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a88f9a1cf7so3520537b3.3
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 18:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698285455; x=1698890255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WaJiW8ZqUlaOkGekwXpkEpdhjo6wn/mCZGxdsbuO8+0=;
        b=G9+W/nQfG8OqrPDbNoS0f9X/Hh0a7b7nZiBt76Bg+hctWPGTlQ7e2Ds9B412nu0c+K
         soLWrcgW2nUcBTseKL8Fxg4aDiWYCQZDjGl5dHGGbaJuo8N786Ex3xCdjUT8YoZgL2QP
         znCzg9SCGIoupMEBMNth9Nq8aKQCslIs4UKvHTPxK/XNE/WCwwo1lFJnenbEIJWGU3pa
         5ZBS6ILWMdw/zsDuRh2gXODZLhosUmXX8YFnZ6uhlh5L/FMZfi/ZA/r3tpIU/WcReS9F
         FIs6myQxzLGeVqtqcrVH5/rDNofkAV2GXSrNjBEFX2h2U2srNhPp/U3gXxoMvJuy6zoy
         2Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698285455; x=1698890255;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WaJiW8ZqUlaOkGekwXpkEpdhjo6wn/mCZGxdsbuO8+0=;
        b=mtRfWcGsz/3epNF8SOK11+xWWYLlCT6ZRYvuQUrQpXs2+2Szp7FspZwsW8QoZ5ViNJ
         QVnA0yaC7QpFFRTXn/w0IHoxO33rs6Rs/JSdhETfWlNVAynY89JD+NvQHHl33hptviIV
         htZotza6krYmMIZ7ShAh6umc7YV8Zei3BrB1lkqvGN5mIWpUIr6ZTwnJgKpWeudXsnkC
         o0FMQYJILf9m35GQyi6yotwEWLjpaWknjdf0eCRaGKI3D+S+AiIWQ/jkP95Yhdv5sKFI
         9OI1dZsPBJs8GqoF8AcEMnc6JOQI37ksiBgXoe0fWg6oX/kX6qMBaY/+sagMZM3GsmYf
         01WA==
X-Gm-Message-State: AOJu0YzwgTrtogBe6PSyBAhQFCSURg4c7T5i0uHuhWJhi5ohpD6bFq6a
        CECC9oppwIlDg1bPnHZDOBoIY8rKgWh1BFA=
X-Google-Smtp-Source: AGHT+IF4p1oV+2CqeMCMlv/k56PYabc6mXGjVHsj9UjxG+nv9+k46ltCltThkTDsUQgq23/EshVv1Y5T12VaYCM=
X-Received: from jsperbeck7.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:26dc])
 (user=jsperbeck job=sendgmr) by 2002:a81:4c8f:0:b0:59f:3cde:b33a with SMTP id
 z137-20020a814c8f000000b0059f3cdeb33amr145545ywa.6.1698285455478; Wed, 25 Oct
 2023 18:57:35 -0700 (PDT)
Date:   Thu, 26 Oct 2023 01:57:28 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231026015728.1601280-1-jsperbeck@google.com>
Subject: [PATCH] objtool/x86: add missing embedded_insn check
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
in is_special_call() was missed.  Add it back in.

Signed-off-by: John Sperbeck <jsperbeck@google.com>
---


I think 6.1.y, 5.15.y, and 5.10.y are the LTS branches missing the
bit of code that this patch re-adds.


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
 

base-commit: 7d24402875c75ca6e43aa27ae3ce2042bde259a4
-- 
2.42.0.758.gaed0368e0e-goog

