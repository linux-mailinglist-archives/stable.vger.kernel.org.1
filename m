Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A307264E8
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 17:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbjFGPne (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240088AbjFGPnd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 11:43:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8043D1BC5
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 08:43:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30e5b017176so579744f8f.1
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686152610; x=1688744610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvdcF5ODlE1scfXyxy/9HvHWKr3SGe9UMSQZtO/8Ap0=;
        b=Xs55NtO8G40CmYdlkjz0BVQsjCyEq8y/uP6tct+QJ02XRVbQg+3k92tZEWTC4JfeHO
         6YE26EYI8XVcL9ANinXHqasvmyj6NncFmIocOXTXorpsWECQwj55HkFOOfmVkxmO/eUS
         /j08GuaSEUCGvnxPEdIB8DhjKwlmHL9cjsDJ/7TaWKWi6vYSg99Ry9O3h/NpzunIxCdA
         b252XnXza+QHnrgkFGVPFjd1VVpmY0a3RVeeWkn4uo/+LXhxZLd1zSTI4fs+GWaoz98d
         /m0Jf9I28v79BoLT+0JVXC1CQdZr0teceafOqianl9oLGfzOJ9thReLYKBUECHcXhBAR
         yfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686152610; x=1688744610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvdcF5ODlE1scfXyxy/9HvHWKr3SGe9UMSQZtO/8Ap0=;
        b=gCqd+xHIlQo7kY2xaf7qoI9lOwNtrj9jsMT73Au/eA6Db1xrn8hYrUYIDWvgH5uxAR
         KtQ9U4SBOWlVAha49ul7UYaku13nALUeYrl7yjDhNAe8hxpDYL/cxWSezQQWFoIvya98
         XoRG+CnOQg/vYW6hp9L66H02jCf9ouCm42uhtsizzSvUSrF+G+TMPa/Zc6mtXslLZi+k
         HH6YgTHP46vaUGAc6UHKROJMN7fAmCgmo4wLjU3wqj8C8YTBFDs+KWhmsF3w5oRJAT82
         yKXfklI+AVl5C68bRHK5MBa9xOEJqJnj2mWQtSfuFVZHDdKtOjxihAwaWi8mhUcJZILr
         yh/g==
X-Gm-Message-State: AC+VfDw8wqlZPb3cTUxWRO83TzqqPLJ9k8Hv5vMPjrpDpbPBkzzykOr9
        3/EV28xwyvBa+RgRkfPNJVQ4ZhApHsy29l4NwwUJWw==
X-Google-Smtp-Source: ACHHUZ5bEL58i4nNqbml0UvwdoX719OlX2O8ubgij7t8h0aDB6yqdTf7WFfHHdpJ5+ECOq5BooSTAA==
X-Received: by 2002:a05:6000:11c6:b0:2fe:c0ea:18b4 with SMTP id i6-20020a05600011c600b002fec0ea18b4mr4450937wrx.24.1686152610657;
        Wed, 07 Jun 2023 08:43:30 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id b14-20020a5d40ce000000b002e5ff05765esm15998406wrq.73.2023.06.07.08.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:43:30 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] selftests: mptcp: simult flows: skip if MPTCP is not supported
Date:   Wed,  7 Jun 2023 17:43:17 +0200
Message-Id: <20230607154317.2690210-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023060731-sauna-stonewall-d2db@gregkh>
References: <2023060731-sauna-stonewall-d2db@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=eb7H3UwJy5uaeMY+x5W+KwmtVszSr87DzGJvDM41y4s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkgKWVakkt7T1K8KkqSsayhsCODzTO4M7UPbMKt
 h2srKtAOEGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZICllQAKCRD2t4JPQmmg
 c5SVD/9ePMnEdezqUxBXtiNGJqYV7Dy8WNDwrul3coDkB5Y/kAwScCOIhulwAeAi9ZU3KiZJgiM
 4fnFRd0ZbQl6P/WsPV9XXQ7mubmihHTVNiPNT+3VlIKpZqEG/v7KwFvm6/uTLz7cHbNO72oGhoU
 ECJbt6RkGc4Fx0yfeXczmFer/rKtdQZo6eZYLk/W81Yo3hUFbUGiSAVzoeS8UFeVGbb7Vq80eoZ
 R698NLnryflLHDpEB3Buat4m486QLuur8JW67czM4Sjb0Gn0X+7eJ2umZ2Tkss/JWlHnI3aZYdH
 svpJgU8Fkhoil2fNjT1/LbmbCcmzg+JaOta935IFwliydcLvoeVb98jAdnd0XO0TvKbhGAtczgi
 oaYBicrsQg8HFE0/gOyt6E8Rs3qWrDP+pkLQobngSW7dqnwBWG8HwiDSpHH7tvXtRGLs6kmhvvO
 ufzTeQqdcXH0HixYcIH5K27Vve6DsCQoquWOBl0z4qIzpu0G94nhtBVm7DEIgoqRzLVWkZ3PF0H
 RePaXnaOaA0O5P3zwskZpL1UzgGoA12SP996evrOi8wO6kQoKRw1sn7X03tEDsQHO39j3PHN898
 COtvwbVb2yYf+HLe9oYWBSI1mIbo5Otg9H26vzO1Ye8JXQ6KSpYR6ugphL80hNbNqtFl256KVEU e2ropH8xkd7C8eQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 9161f21c74a1a0e7bb39eb84ea0c86b23c92fc87 upstream.

  Backport note: a simple conflict with 787eb1e4df93 ("selftests: mptcp:
  uniform 'rndh' variable") where a new line was added for something
  else in the same context.

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 7df4900dfaf7..752cef168804 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
@@ -32,6 +34,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-- 
2.39.2

