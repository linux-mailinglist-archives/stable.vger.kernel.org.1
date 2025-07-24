Return-Path: <stable+bounces-164690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93990B111A8
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 21:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF653B3728
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 19:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C802ECD3F;
	Thu, 24 Jul 2025 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="fUT+NkDo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9DD2ECE81
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385230; cv=none; b=H9SeTPzwMl4F2xPE2iPXx5x1nJt26nXozuFiRKqCtEQHk5/zwd0T3qfgRiJAW2zuMaLJnSjLGo03G1dJOdcFjEnpsGkRhhdYDiaZiA0jIUTMRE3w4bWhKt7I4EfNyBdCbkktV0HzfOcVGTwz0X4/qaAHSXlD/oQdFoEp68fU8XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385230; c=relaxed/simple;
	bh=jAT/TUwURPN8GASB5irpI01n1mu6tD5g0uiI2/5mfm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsgaX68Z3Wuis49+1LwXM8sLpKICtP37xfe2xa4l770vdBZ+vVL8Sgv7BAHiJSh75VRxwA3lyujEu/DN//XmdQWM32pBzuwtvrP+i+/2N/wF3D5MWpVHejjk4AyZ4JLorXKprpGzV6aV5ZibWnEAWqh+wJsYuWyQ5oYkIRGImNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=fUT+NkDo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313290ea247so33367a91.3
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753385228; x=1753990028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5VcQ1YDoDCdjFi6qnB26AKzwkL5qLrc0HnnYyjdFeY=;
        b=fUT+NkDoopJ+6YkYdSt/e2EdqR2AYd6seRbMXkYDpsEu07O8wC7bI+/v8SKIqVA2l/
         LtH+JGgstuZeVwxIAGaTrAi90t3gRd64VozIarKm9j8E1WD19W5cP36THsowtWW4xZpd
         n0Y5JWfebg0ofgVTJ5hI4VU0q+yyCn2VWI2vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753385228; x=1753990028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5VcQ1YDoDCdjFi6qnB26AKzwkL5qLrc0HnnYyjdFeY=;
        b=hADMt2ASNrhm7TYFLN9ikhNWk0tE9ngvdIqZfNzd3prJKAb5FR8yFasThVuU32g0CG
         5fFrea3X4GiOFBNVmVdaB4cxA025C65nOQqVe5QotKIMO9YU9zBMi+jfysQQFfIfJQPg
         keg5UJIvpPmmBZUhVslmIrygzx26mKSSiFu2W8n7UelIF8GR1xV+DNBcH0SIJYiz7FoB
         3Y0wdcsmbP8y8FWCurTRlPHzPaOyGN7bmfV4soG7aq0hWnGvH7cFQoIviRGImwvUL9jH
         BLrx4K2j4hvZM3kfQ3LOcwy5VuHH34ri+aqLy0RKRRlB4KtdnWTmSeR3gSpar2kUkvWc
         8V9A==
X-Gm-Message-State: AOJu0Yw3qZ4etoozX80lMWPagyz0lAz1DitLdKLg7XZBlcq19QP4r6vD
	F6QnjmHVkyYTPI0wjST9v3gaTkTPxDUf3B4csrlPrKsfsGNgQoMVXsYvkUZq86sKf+XK3I3kmey
	vcYgDhBCCMg==
X-Gm-Gg: ASbGncuiEdfn33xT8ZquPBaUzRYk7D7nLHI6WridGPGUKUbW8LT2p4Q2XZUH8rvYhCg
	IS2KUk6K3fNas8jO4TTbxu37efoxwpHYk06FNgMJGAwQjsxM7s8O5hc+RXANcBky7gFdovD3Afk
	H1EITQ3UcXhPCFHPWg60ykUo4UVzSZxne1OmeUhvJzy82h+p6F6jer88vxJ4TQHpdZlYyl726nt
	kDpoVKT5B7TRZa0y3LOnG93SpKWswvhJbJc8/2MbKIgrqfsSpgNyjL3JOGJ0zhA97Ouc6DFyiWh
	NaGGWyRBzA5lZ4Nu+6dp7bwbad5rJ7wY5UNZzSVomG2jda3d5iyx7TOTMu4ifWuhUaq4H076kZp
	lSmgsYJH5H5FSiB9EEfD34HRkU80R8lgr1l64Eq6Uoto8
X-Google-Smtp-Source: AGHT+IF3wC5m18xOhikzN8U3n2m32zlz8iNzYzumkjDBNC85J8clwHWJxPeyI1iHorW75bobDDDyZA==
X-Received: by 2002:a17:90b:164f:b0:314:2d38:3e4d with SMTP id 98e67ed59e1d1-31e507e77a5mr4483279a91.3.1753385228366;
        Thu, 24 Jul 2025 12:27:08 -0700 (PDT)
Received: from shubhamPC.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6635f0a0sm1945884a91.24.2025.07.24.12.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:27:08 -0700 (PDT)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: akuster@mvista.com,
	cminyard@mvista.com,
	Jiri Pirko <jiri@mellanox.com>,
	Ido Schimmel <idosch@mellanox.com>,
	"David S . Miller" <davem@davemloft.net>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.4.y 5/8] selftests: forwarding: tc_actions.sh: add matchall mirror test
Date: Fri, 25 Jul 2025 00:56:16 +0530
Message-Id: <20250724192619.217203-6-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250724192619.217203-1-skulkarni@mvista.com>
References: <20250724192619.217203-1-skulkarni@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@mellanox.com>

[ Upstream commit 075c8aa79d541ea08c67a2e6d955f6457e98c21c ]

Add test for matchall classifier with mirred egress mirror action.

Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: ca22da2fbd69 ("act_mirred: use the backlog for nested calls to mirred ingress")
Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
---
 .../selftests/net/forwarding/tc_actions.sh    | 26 +++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index 813d02d1939d..d9eca227136b 100755
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -2,7 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ALL_TESTS="gact_drop_and_ok_test mirred_egress_redirect_test \
-	mirred_egress_mirror_test gact_trap_test"
+	mirred_egress_mirror_test matchall_mirred_egress_mirror_test \
+	gact_trap_test"
 NUM_NETIFS=4
 source tc_common.sh
 source lib.sh
@@ -50,6 +51,9 @@ switch_destroy()
 mirred_egress_test()
 {
 	local action=$1
+	local protocol=$2
+	local classifier=$3
+	local classifier_args=$4
 
 	RET=0
 
@@ -62,9 +66,9 @@ mirred_egress_test()
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched without redirect rule inserted"
 
-	tc filter add dev $swp1 ingress protocol ip pref 1 handle 101 flower \
-		$tcflags dst_ip 192.0.2.2 action mirred egress $action \
-		dev $swp2
+	tc filter add dev $swp1 ingress protocol $protocol pref 1 handle 101 \
+		$classifier $tcflags $classifier_args \
+		action mirred egress $action dev $swp2
 
 	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
 		-t ip -q
@@ -72,10 +76,11 @@ mirred_egress_test()
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_err $? "Did not match incoming $action packet"
 
-	tc filter del dev $swp1 ingress protocol ip pref 1 handle 101 flower
+	tc filter del dev $swp1 ingress protocol $protocol pref 1 handle 101 \
+		$classifier
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 
-	log_test "mirred egress $action ($tcflags)"
+	log_test "mirred egress $classifier $action ($tcflags)"
 }
 
 gact_drop_and_ok_test()
@@ -187,12 +192,17 @@ cleanup()
 
 mirred_egress_redirect_test()
 {
-	mirred_egress_test "redirect"
+	mirred_egress_test "redirect" "ip" "flower" "dst_ip 192.0.2.2"
 }
 
 mirred_egress_mirror_test()
 {
-	mirred_egress_test "mirror"
+	mirred_egress_test "mirror" "ip" "flower" "dst_ip 192.0.2.2"
+}
+
+matchall_mirred_egress_mirror_test()
+{
+	mirred_egress_test "mirror" "all" "matchall" ""
 }
 
 trap cleanup EXIT
-- 
2.25.1


