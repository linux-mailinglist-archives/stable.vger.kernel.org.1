Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD7A739CE6
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 11:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjFVJ10 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 05:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjFVJ1J (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 05:27:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210D42682
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 02:17:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f769c37d26so9529546e87.1
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687425439; x=1690017439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pc7U6SRidtTX1zCBXgzSY6hnDrminqKvrdYX1VYMLoI=;
        b=SK72i4I2TibeBpEEdhaMnEf7voxc2e70wgH3aM4TGgnQgf3NMNfOZIoJIzYJtEa+EW
         /bpsSA/GmhoOTgJKC+NHKL5ZlskfCUCo8Z4rQgFlKpof2XgT8IICs1Ap0N/texYomqe/
         m8K8vd/rzsuAo1YvRclZdhS841gSAB46kqY1OawF5OioJoGbBpv1kW9Vi6qyJJ0SpbWW
         YN/lXFtdBCK9w22XhmyCvnyfBh5yK4g+PADx145uZZAil2hh3NVwS59MguNeNtNvr/Dg
         H+lgmPIEcYXNMZfDbUOOCWfGWAgW65lymJrDq61t7SDnKmCoM0eXspDk3ppwzuwNhX30
         JkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687425439; x=1690017439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pc7U6SRidtTX1zCBXgzSY6hnDrminqKvrdYX1VYMLoI=;
        b=UVQiaaIRbFckYIzceH4HYgMeCdSiFuBDFw8MjBLB/iz8/KHbP74rt5P3UwKbIDWBxj
         Q6xd/pnMCJ+LEalhQeUVAGvuYCQ6h9G6n7BusWyfK8ATGI1BzWoLL83U1GU6nAiXnsD7
         rY8XIn5C5h5JNrR0qddgLBOfGpaVSvbBbfBXhTVO9JGv/r20gyQIFkvwwS6KCHFepIDL
         7r9wGBUfEaX4gY5tSFFqjPeGdmc9xJWlQ8A+XQvsuEu9qxN3JLGQFxlRZj1nQVZHcrfz
         luah9ik5u9W2HT6WRyaB4SfZ97x+Bd+Kdvz36E256IGMlL/GCuKMcaJXeG1A6Vdh/ofN
         LYCA==
X-Gm-Message-State: AC+VfDzy/GiP8tZrpFZIXtrAnUq8W2HHUEsz/67yQv7S4kSOo6Tc4GaG
        YucvvX5xbuXyZLbtkZcZNGbvYimMTLBrKVEso7vmMRuQ
X-Google-Smtp-Source: ACHHUZ4rG2kfT1i6VrP9TgcX61WHxj5E8GiwltdCtKykL0rNzx/0sma+JZEPV5Sz8DcIOlqeqzoNqg==
X-Received: by 2002:ac2:499b:0:b0:4f8:8342:b776 with SMTP id f27-20020ac2499b000000b004f88342b776mr5586011lfl.57.1687425439112;
        Thu, 22 Jun 2023 02:17:19 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003f7361ca753sm17932229wmq.24.2023.06.22.02.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:17:18 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: sockopt: skip TCP_INQ checks if not supported
Date:   Thu, 22 Jun 2023 11:17:09 +0200
Message-Id: <20230622091709.2857780-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023062206-muzzle-pope-0802@gregkh>
References: <2023062206-muzzle-pope-0802@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2628; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=3TBXOIszq3BbObgLGyBbH8dQpTDWlin4jjMmBTp+ivA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBklBGVoSHTGs638z7kqSHRpGPEiTEoypVUbDi2u
 6x6W9/8JFqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJQRlQAKCRD2t4JPQmmg
 c6DZD/9AVk2Uhx5zp4v4KpVdlE+GUmEVN0c9HOFkYjz0q/M4heuPHGjzGpojUwXsSqs4vj8Rh8n
 V1UBl6XYNkGvbPJERh/jfDkApjEfjrLFvs3rU5qsBdhhhfu86pjD0oruk1CuHsoYAcrezbp4MJm
 bzFpJ+jDzm44t0n0oyIMsR29HntfjGLPZ2ff0i5Ybo7gSDVCzenSvTnRlw1RI8hL7CFnhbJDXmk
 8ZKeGkW0yd0g4ayK79oSzdrxDViFcLQTSVC+6tVfP88v+o1SOBsgNp9sYw9G+fb2Za7vh99LY34
 0q/YvYYMo1ylGZcUSTUHpVYI2Fbng7oWIXIdEKA9pvxKNodBXZxaZW3MvDrTDRqfVNPFxht23jg
 NrL6NcfqI67ef6ElRy+9tF0RpeEilndFDXsdFHddx0bpmBSXrLE7d4ZCq0xz7eaJESZSArHzwtV
 X5LHSQ3QgeE1wIVpWe018Xo/ja/cU3l56NJSMCx6nUH0SIuitotWgwl46up40rXsRaUXwu3IJN1
 NOErvOFORFFYRs01rDBZvhMpVeP4n53K/JG9opUlrk6lS2oh0yM9Txpqs0xhIfWMb3H5iCXkuFd
 mLC3ilKA25QK7xuVgmzRA6C8JPjkbrxRwAEhD9ELK8CZNBGBQGtZgQq9Zz1R2BNOVQ1TRxVWgUj GHJ+hBGVUmoYKnw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit b631e3a4e94c77c9007d60b577a069c203ce9594 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is TCP_INQ cmsg support introduced in commit 2c9e77659a0c
("mptcp: add TCP_INQ cmsg support").

It is possible to look for "mptcp_ioctl" in kallsyms because it was
needed to introduce the mentioned feature. We can skip these tests and
not set TCPINQ option if the feature is not supported.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 5cbd886ce2a9 ("selftests: mptcp: add TCP_INQ support")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Applied on top of stable-rc/linux-6.1.y: 639ecee7e0d3 ("Linux 6.1.36-rc1")
Conflicting with commits b4e0df4cafe1 ("selftests: mptcp: run mptcp_inq
from a clean netns") and 5f17f8e315ad ("selftests: mptcp: declare var as
local"): I took only the new code in do_tcpinq_tests().
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index d31be7229cdb..a493eaf8633f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -182,9 +182,14 @@ do_transfer()
 		local_addr="0.0.0.0"
 	fi
 
+	cmsg="TIMESTAMPNS"
+	if mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		cmsg+=",TCPINQ"
+	fi
+
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
-			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c "${cmsg}" \
 				${local_addr} < "$sin" > "$sout" &
 	spid=$!
 
@@ -192,7 +197,7 @@ do_transfer()
 
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
-			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c "${cmsg}" \
 				$connect_addr < "$cin" > "$cout" &
 
 	cpid=$!
@@ -311,6 +316,11 @@ do_tcpinq_tests()
 	ip netns exec "$ns1" iptables -F
 	ip netns exec "$ns1" ip6tables -F
 
+	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		echo "INFO: TCP_INQ not supported: SKIP"
+		return
+	fi
+
 	for args in "-t tcp" "-r tcp"; do
 		do_tcpinq_test $args
 		lret=$?
-- 
2.40.1

