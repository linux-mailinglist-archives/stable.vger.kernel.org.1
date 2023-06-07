Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7012726ADF
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjFGUUs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjFGUUm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:20:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2242270E
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DA7960F16
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B1DC433EF;
        Wed,  7 Jun 2023 20:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169200;
        bh=R0DELvf/YMrD0zJkos1kwz8fEahoXM96yNAJdbs+Qls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ep2Gz8R4GP0sryhFtmE0T6WMhDwEikLXruY3VrzU02XBvInmBTNk6+Si+LRjZAnPB
         Oh0fH7niDNo/v3wo2dpbNiD+/CMVjZyNlOyzbJkIGGn0YKbmdW+3JVbH7NNJiNwlLK
         v27eckq2xNytEeFlC81BOUg8vo/0fT5nPYBTYpdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Erwan Velu <e.velu@criteo.com>,
        Luiz Capitulino <luizcap@amazon.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.14 52/61] selinux: dont use makes grouped targets feature yet
Date:   Wed,  7 Jun 2023 22:16:06 +0200
Message-ID: <20230607200853.130655586@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200835.310274198@linuxfoundation.org>
References: <20230607200835.310274198@linuxfoundation.org>
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

From: Paul Moore <paul@paul-moore.com>

commit 42c4e97e06a839b07d834f640a10911ad84ec8b3 upstream.

The Linux Kernel currently only requires make v3.82 while the grouped
target functionality requires make v4.3.  Removed the grouped target
introduced in 4ce1f694eb5d ("selinux: ensure av_permissions.h is
built when needed") as well as the multiple header file targets in
the make rule.  This effectively reverts the problem commit.

We will revisit this change when make >= 4.3 is required by the rest
of the kernel.

Cc: stable@vger.kernel.org
Fixes: 4ce1f694eb5d ("selinux: ensure av_permissions.h is built when needed")
Reported-by: Erwan Velu <e.velu@criteo.com>
Reported-by: Luiz Capitulino <luizcap@amazon.com>
Tested-by: Luiz Capitulino <luizcap@amazon.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/selinux/Makefile |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -22,5 +22,9 @@ quiet_cmd_flask = GEN     $(obj)/flask.h
       cmd_flask = $< $(obj)/flask.h $(obj)/av_permissions.h
 
 targets += flask.h av_permissions.h
-$(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/genheaders/genheaders FORCE
+# once make >= 4.3 is required, we can use grouped targets in the rule below,
+# which basically involves adding both headers and a '&' before the colon, see
+# the example below:
+#   $(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/...
+$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
 	$(call if_changed,flask)


