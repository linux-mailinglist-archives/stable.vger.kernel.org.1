Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1355D726DFE
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbjFGUrR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbjFGUqq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:46:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B0270B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FED963C18
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660CCC433EF;
        Wed,  7 Jun 2023 20:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170802;
        bh=6YsYYRAJbpN9oOEQnpDa7qJZI+T9Lc/w9ciHPgIEx9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4XLADtkoS0jlc5TjNQ3O+Rek/0lV4wxfVLnyEfrRLW1Q2WG3AaoMjQf8uaD2h0lC
         VoKE/vSMFp7pyrNE7Hl77lgkwd95qLIkOwbI49bdm0/a6IPpNZG54+kTE4S6ftyZgP
         4nkl+DnKgu8lCIZ9kORSAKAaynJ3jetPdXOSK8bk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH 6.1 224/225] selftests: mptcp: join: avoid using cmp --bytes
Date:   Wed,  7 Jun 2023 22:16:57 +0200
Message-ID: <20230607200921.710630563@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit d328fe87067480cf2bd0b58dab428a98d31dbb7e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -15,6 +15,7 @@ sout=""
 cin=""
 cinfail=""
 cinsent=""
+tmpfile=""
 cout=""
 capout=""
 ns1=""
@@ -168,6 +169,7 @@ cleanup()
 {
 	rm -f "$cin" "$cout" "$sinfail"
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
+	rm -f "$tmpfile"
 	cleanup_partial
 }
 
@@ -362,9 +364,16 @@ check_transfer()
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


