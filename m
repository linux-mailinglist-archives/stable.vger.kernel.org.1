Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D577E7264E6
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjFGPm1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 11:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbjFGPm1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 11:42:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95DF173B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 08:42:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30ad458f085so641344f8f.0
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 08:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686152544; x=1688744544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+DqCWT1PL2NXYDYZekwQ9s3ajT+Nf7MmO7pvHKWm9I=;
        b=G0mse0M3Kg949m8v4O6wKgIEmRlJF+di6g7W5t8TgVL/VTn+ch12Z3Cb4BZ0JCZyeg
         QhehFsA/HxiVqqLTmeCchwjJYsjVodLMOzOKDdQNZS5nIuYOc6C8OUttpuZXDU3cmXIu
         Mt/diBEZ38LLr0oGzTGMv9zqO5rUowF7k4JObj92dEaPcXYhlx5k2UzlWwd0f6/c9xlU
         djIyBwvVNhGP3fMCPInSehm4/ymMMGJ2SmaK20Q63m/clLjwab0LE85ca7Jgo3DMHBAn
         JQQrUXrgu1WWvXzivYHxNVEWdSZaXI2enR16h5DqQSu47pvWS6clkhIU1+/lGG2IGLwl
         9trQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686152544; x=1688744544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+DqCWT1PL2NXYDYZekwQ9s3ajT+Nf7MmO7pvHKWm9I=;
        b=Vfy8BCyU5V6Co63uz33JUepGmKjB9y9P+e6kiojPohkcaB6S0DIrBRd6/m3UQwSwnk
         LSj1k844yGzoKLAodmi5L1/6uri9L1D+1BbV33rGmG6DG+Xj5palJ9ogDHD/aav/2m1b
         97M8u541I4YNHRZ5clQkK6qxOmSRwMm0wqpaztGtEPC47LdcYZoFX4+to1xhw5o2fD2u
         H+mkT9EoffPVEMf8gEnLBE6NGtcJKqPWXxmuALyZwMIJrLzdlCXLCKcEqSvCwrefpVaL
         Fg2xBUMTPWtV6uS6BArhhsImO7UbB1HaxpcypWHdmRDz4rKSq1TwEa11Fh6GcIKvUmXv
         CNmQ==
X-Gm-Message-State: AC+VfDx3/ULa7WOjMf9HugMb/6vDLtgI5t9ToTCf+jYq0JJMoLQnXL8d
        v9NA+5qBwaKNL3ltR0wlIs94I3EVZCER1DseqbCOgQ==
X-Google-Smtp-Source: ACHHUZ6XVpDUQheeOHK8Y3n//oBeeZFZDsjgSie6dgeTNkdHFHn6uz4JVN8/f0s9Q7MAdkSuaBKRaw==
X-Received: by 2002:a5d:534c:0:b0:30a:a193:3987 with SMTP id t12-20020a5d534c000000b0030aa1933987mr11031256wrv.30.1686152543894;
        Wed, 07 Jun 2023 08:42:23 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4c89000000b002fe96f0b3acsm15994478wrs.63.2023.06.07.08.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:42:23 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] selftests: mptcp: diag: skip if MPTCP is not supported
Date:   Wed,  7 Jun 2023 17:42:12 +0200
Message-Id: <20230607154212.2688867-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023060715-deeply-subtype-6c5d@gregkh>
References: <2023060715-deeply-subtype-6c5d@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1544; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=Rr1y2V+TpVqWLg8e/bQ8TVqU2L1+WVf0Yecwd4yHBj0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkgKVUBGZPeXzydGO5YCn5dWH/MgyZNcImvRfcr
 q+kWXCzuzSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIClVAAKCRD2t4JPQmmg
 cw3DEADEtM3wtGYvGJ/pKQmVFpqpqD22A3xO0oOwQ0Jgpnxt8nrLlR6RESNxymNJ2pIuNLtb4bt
 lyB4cuZPAW3gTi8xUQtTG0OBECoP5FrJFTcEmSZA33LCa2hvDLBzGwyKRtnJp+wKVKCdspjFj3f
 MrH92nXfB98St5xJMA9zfQMUyoAEqS4UIbAn0BsHfoO9H/uTt8TViqViRrQHfdLwbX4iofsW1EC
 6D1wAdnQbhjHHSeXbM5QCyrxBqi+mAt3W0WI0aVcsBChxs6AYB/G5tVBs1Jcr2WecSMZcD3PWt9
 wyFN1wxeMsuGgfH68hqHtFHtwyU1mZAo6+hq7IhRyTPmtNYb8G3rcSiu8rXyR/qyUi0SQSAbILY
 Mk+gJ4Eb3OP861FHsszKfuv0ps0++llOYId0Y/0dY3B9r2HXe6HO687ms3UuoLs/ykJgNK6fSf2
 Z8ctp17U3tOHAvyDdm+21Xul2dzEqQPa8SV3TsKHg6SXywZxmKML6NJKJlsuAxoKmdVxWbiKOMl
 3opjMGtkmK7nocDWTrUOnsRhyMRfAjz2dUzND5YjcIaTqkX4F6iMa/UzB2DPtsXs9W/CIB1jdHz
 e0xiesWRLFbf8g9pTihbf4e0cJlp2esebl5Es91MyA4G7GM1rtutF7MDMCu0/WDC7qTulc/Wl3M drw3hzqhJXLY//A==
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

commit 46565acdd29facbf418a11e4a3791b3c8967308d upstream.

  Backport note: a simple conflict with 787eb1e4df93 ("selftests: mptcp:
  uniform 'rndh' variable") where a new line was added for something
  else in the same context.

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 49dfabded1d4..57a681107f73 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns="ns1-$rndh"
 ksft_skip=4
@@ -25,6 +27,8 @@ cleanup()
 	ip netns del $ns
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-- 
2.39.2

