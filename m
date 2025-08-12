Return-Path: <stable+bounces-167244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46074B22E23
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F701A204F2
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC112FAC04;
	Tue, 12 Aug 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqaCHRUP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEBE2FE58B
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016915; cv=none; b=Hr3Vie+9w2TlN6hpgV1kNJ/XuN96oZfaWXsSFLKpuKiy94p2iPd4M5FlrxHxsd+HGzT3PlExxanhovcOsypL+nVulYzOXtgMS94ofg2KwffuS2eJIVbJt52nxescxkt+p/EKTYjfDrrHLWkhYc7e+DdejTJ4iqk5hHv/1Lz7A20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016915; c=relaxed/simple;
	bh=2f+VWdIR7gBNM4gWQV/bPiXvt46n5AH8wUrabk8WKtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K29Tijd9BhXowH5cl3yRYf1XpYmyy5nA2i4DIQpJ+Vw/QjbRaegmW1oa/Att2rgDj7GPLqNAQcurk7ftrx41T2EY0IoWVxcjezVrvECcl5XkTUd7XEugIxP+uj+2d3dXpYRpF4H5wM4AMbVB/Hv+XiMUNAKC5p1SB1V/7oiEsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqaCHRUP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755016912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5eu+XRjqTd/AazFXfIEmWTurR5MGWO7sJL2MSDLEHI=;
	b=HqaCHRUPLsKg7L89goIJejael6+4GvPG3nQSp07XhH2ZIj90k9oI0JuOZZLRiXG7KNQ1l6
	WEx4b6U7yzvHwXCi6/hocSz3RVWdps9wHgkzJCd1F0008K3tYlAdoo5FzYI5XKDoO++/4J
	6IPA/9xXoZXOGgrVNfZP2JwBrcpzqXU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-RvtsdtB_PuCFdHc-y4Wmxw-1; Tue,
 12 Aug 2025 12:41:49 -0400
X-MC-Unique: RvtsdtB_PuCFdHc-y4Wmxw-1
X-Mimecast-MFC-AGG-ID: RvtsdtB_PuCFdHc-y4Wmxw_1755016907
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A33DA195604F;
	Tue, 12 Aug 2025 16:41:47 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.32.60])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2EBD195608F;
	Tue, 12 Aug 2025 16:41:42 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Lion Ackermann <nnamrec@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org,
	Ivan Vecera <ivecera@redhat.com>,
	Li Shuang <shuali@redhat.com>
Cc: stable@vger.kernel.org
Subject: [PATCH net v2 2/2] selftests: net/forwarding: test purge of active DWRR classes
Date: Tue, 12 Aug 2025 18:40:30 +0200
Message-ID: <489497cb781af7389011ca1591fb702a7391f5e7.1755016081.git.dcaratti@redhat.com>
In-Reply-To: <cover.1755016081.git.dcaratti@redhat.com>
References: <cover.1755016081.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Extend sch_ets.sh to add a reproducer for problematic list deletions when
active DWRR class are purged by ets_qdisc_change() [1] [2].

[1] https://lore.kernel.org/netdev/e08c7f4a6882f260011909a868311c6e9b54f3e4.1639153474.git.dcaratti@redhat.com/
[2] https://lore.kernel.org/netdev/f3b9bacc73145f265c19ab80785933da5b7cbdec.1754581577.git.dcaratti@redhat.com/

Suggested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 tools/testing/selftests/net/forwarding/sch_ets.sh       | 1 +
 tools/testing/selftests/net/forwarding/sch_ets_tests.sh | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/sch_ets.sh b/tools/testing/selftests/net/forwarding/sch_ets.sh
index 1f6f53e284b5..6269d5e23487 100755
--- a/tools/testing/selftests/net/forwarding/sch_ets.sh
+++ b/tools/testing/selftests/net/forwarding/sch_ets.sh
@@ -11,6 +11,7 @@ ALL_TESTS="
 	ets_test_strict
 	ets_test_mixed
 	ets_test_dwrr
+	ets_test_plug
 	classifier_mode
 	ets_test_strict
 	ets_test_mixed
diff --git a/tools/testing/selftests/net/forwarding/sch_ets_tests.sh b/tools/testing/selftests/net/forwarding/sch_ets_tests.sh
index 08240d3e3c87..79d837a2868a 100644
--- a/tools/testing/selftests/net/forwarding/sch_ets_tests.sh
+++ b/tools/testing/selftests/net/forwarding/sch_ets_tests.sh
@@ -224,3 +224,11 @@ ets_test_dwrr()
 	ets_set_dwrr_two_bands
 	xfail_on_slow ets_dwrr_test_01
 }
+
+ets_test_plug()
+{
+	ets_change_qdisc $put 2 "3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3" "1514 1514"
+	tc qdisc add dev $put handle 20: parent 10:4 plug
+	start_traffic_pktsize 100 $h1.10 192.0.2.1 192.0.2.2 00:c1:a0:c1:a0:00 "-c 1"
+	ets_qdisc_setup $put 2
+}
-- 
2.47.0


