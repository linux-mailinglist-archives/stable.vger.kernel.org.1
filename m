Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA19726561
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 18:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjFGQES (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 12:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbjFGQER (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 12:04:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503B1199D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 09:04:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f78a32266bso38191235e9.3
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686153854; x=1688745854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZ1RnlsaAVzdFhEnLHPku4XYhys2W+vin9u3l3exZdY=;
        b=0jy6lmVGozr8SvtRSw1jYJeyV/apDcqRwcCh3T94wXrdUHV/lBAZxy1ZP2RmqIn/jf
         IFfK9Wxf4UToA9ImKfu1Q+6UdvcqCano/ZC4Ax6NOvuFvVs1Pv6nu7/Vz8khFGdb51k6
         uv9QZAfKiiKd9pcPbji4n2O2ecJCPtQic1djNLPl33uwdFj3LDmBPIbT4BgX9XrdqKV5
         /htpNoyYXU5eFMoDKK14h+BOhFn67bsdDY1qq/RI5prw5IELHCHEkD4tHhyElzoDBj/E
         FiRqxmVzNBE35ZnN/hxbu41tmTwTEM3xvu/LbZxA+N0DoF6MUs2Ojydd262AsFacfF2F
         saTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686153854; x=1688745854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZ1RnlsaAVzdFhEnLHPku4XYhys2W+vin9u3l3exZdY=;
        b=Enh7GV1j1Y+RI27P56sJUC3aan5ynLlH/obKj4zuVikbb/iAg6y010AxEMf311asWc
         M2O77EtrxfUzQVWdNYdNRAU6WiW9Sy81yF51Z9e+pYgt5gEGr64EeXGKrwvlmnUKpOQF
         gvf/5L+MPNSfnqYvLmh7yyuzuZnAv2e3Kz/PQv0sb/vkOEGD1vDOmx50p4tsqrk//pYf
         zpUfGbHSuoKxuHExBN7y5jiD39V1SGCyNJStSTg7ORFizvqBBiChLkk3jYFoMMYSX/ku
         ybCkuK9FHk0wRrMbUH67AlAIjGDQ0+Hkibt0oDU49MYkvmg6CqB/lLUC5XacjilgGlO1
         X1TQ==
X-Gm-Message-State: AC+VfDxGc4WPo4ODopawNGQDXe+lSI4g7Nf4KZ2/tPqq9CRAL6JpnZ3n
        I+/08Ii4KH4vpKXe4SXCNsgLSY2FJc5oKhmBsuNcTA==
X-Google-Smtp-Source: ACHHUZ7xxlNLcdDm63QWIF9QEUP5Hlu1FK4dhBRePROQeB7OQfBjdUOuJo/Rwo5zCvHVlSvVq+Wz4w==
X-Received: by 2002:a7b:c84f:0:b0:3f4:27db:d with SMTP id c15-20020a7bc84f000000b003f427db000dmr7477695wml.17.1686153854422;
        Wed, 07 Jun 2023 09:04:14 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003f60d0eef36sm2624300wmf.48.2023.06.07.09.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 09:04:14 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: avoid using 'cmp --bytes'
Date:   Wed,  7 Jun 2023 18:04:04 +0200
Message-Id: <20230607160404.2716176-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023060758-corset-cramp-8d97@gregkh>
References: <2023060758-corset-cramp-8d97@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=i90SchOWRKUHiohLNW60o908vbydTLrLD/nQb5dyS+8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkgKpzPcb5zemxtTiPWPjftOPIpVPwV2oFsp/vR
 TGr2tj3ZjCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZICqcwAKCRD2t4JPQmmg
 c28XEADC9Di2pIizF8M/F6z9w5IkfGj+yiuemk4m1dB1uFOy35JZFlz195bijKX6sL1OON0/uG/
 rmmPkX7/hWfRswj4K5sA40hfj4WGE4A2sUo1Bpy36lNqOcEqJnuEWV2vOMWCLmctN/MhCPGYoTU
 WF6p6MqIVP7hh8dXOspbonjVFGD3eOIeFARRzR9g1xHhkSt9/yJQlJv2hX2ZTjxejqys6oRVhGh
 cEG2qxoMgJKKr40+830/O4p5xGog38eNjcDpTa7zTzxsFjgqm3D3gxE8mPVGhwO3TK2/ir13JPq
 4Wh0JEvL3TQ+9jUKdBgARlVpYLa5f5/T6RntZCsIXFosPpXQHOZsfDDv9ROjYFdNzUKT7qtqree
 0hGIZs3DsQz6Tx8MfNTt7QvR3RM4qe7bOg9TqNKfy1dVcdmp8fHuCyqdihSGCHWsuH1fZrd6qKG
 4Udi6Ep/Qjym1pXU7aTXvVTg8dl36/MHXiX9VeVEGMoY//Xy5yVBzcChllCvIjsb9dVSpwuuslA
 O4yh6cbhvCCsOfgMCwJYti91s7iuTHiGHkbde/gWcn8KfMIkB1DQIhk7Erk1fCPKpY80jv4JgJo
 5zQltrUSKbaOZYjYltI3gZVHGqUY2GllGWTu4sYHCveP3wzpkRXCIWJT4YfeZPSAjhLUv/B1ux+ 22bQcew2xDgWsxA==
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

commit d328fe87067480cf2bd0b58dab428a98d31dbb7e upstream.

  Backport note: a simple conflict with a3735625572d ("selftests: mptcp:
  make evts global in mptcp_join") where a new line was added for
  something else in the same context.

BusyBox's 'cmp' command doesn't support the '--bytes' parameter.

Some CIs -- i.e. LKFT -- use BusyBox and have the mptcp_join.sh test
failing [1] because their 'cmp' command doesn't support this '--bytes'
option:

    cmp: unrecognized option '--bytes=1024'
    BusyBox v1.35.0 () multi-call binary.

    Usage: cmp [-ls] [-n NUM] FILE1 [FILE2]

Instead, 'head --bytes' can be used as this option is supported by
BusyBox. A temporary file is needed for this operation.

Because it is apparently quite common to use BusyBox, it is certainly
better to backport this fix to impacted kernels.

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Cc: stable@vger.kernel.org
Link: https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc5-5-g148341f0a2f5/testrun/16088933/suite/kselftest-net-mptcp/test/net_mptcp_userspace_pm_sh/log [1]
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 76a197f7b813..3b9abd5de951 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -13,6 +13,7 @@ sout=""
 cin=""
 cinfail=""
 cinsent=""
+tmpfile=""
 cout=""
 capout=""
 ns1=""
@@ -164,6 +165,7 @@ cleanup()
 {
 	rm -f "$cin" "$cout" "$sinfail"
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
+	rm -f "$tmpfile"
 	cleanup_partial
 }
 
@@ -358,9 +360,16 @@ check_transfer()
 			fail_test
 			return 1
 		fi
-		bytes="--bytes=${bytes}"
+
+		# note: BusyBox's "cmp" command doesn't support --bytes
+		tmpfile=$(mktemp)
+		head --bytes="$bytes" "$in" > "$tmpfile"
+		mv "$tmpfile" "$in"
+		head --bytes="$bytes" "$out" > "$tmpfile"
+		mv "$tmpfile" "$out"
+		tmpfile=""
 	fi
-	cmp -l "$in" "$out" ${bytes} | while read -r i a b; do
+	cmp -l "$in" "$out" | while read -r i a b; do
 		local sum=$((0${a} + 0${b}))
 		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
 			echo "[ FAIL ] $what does not match (in, out):"
-- 
2.39.2

