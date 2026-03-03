Return-Path: <stable+bounces-222894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJz/BmfzpmkzawAAu9opvQ
	(envelope-from <stable+bounces-222894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 15:42:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 856C61F1B51
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 15:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C113630CDAF2
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7942315F;
	Tue,  3 Mar 2026 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KIHyNZF9"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6935CB70;
	Tue,  3 Mar 2026 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548691; cv=none; b=lgQ7KbCrTJ7CwpTTTLqqgOFdoITx0p4UU1Spdzk6/98UJK8cVQNVqjMckOrhtElP/0nfjfiYFrgoG9Li9cro4QH2RXDZoVStvfGUv5qrwIQcO/h9GqIpQ+uZVr4YrtImWY45Hr/YVhlKwuS7frCE8ealMJkBAnMIokBWPqlJmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548691; c=relaxed/simple;
	bh=C8/PO83Q2Din2/lr3WwejMQpaaI7Juh5iQMzPDJxdz4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mEpfIfyz5V/NPfneoWJGJOjCVfEZYN5L0x8QskVZcp7BqpdsdvKz7YwnSueEQ7sj/Lu/JZcAtnFPqIRaoGrPkuKz7qCmJuAO3p7KilFRv1y2YoEGiinrPsQNC0A8GDakuf19u7vIQHy0maNVUbcwWQhLI6agbZrunRSnpUxegEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KIHyNZF9; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1772548689; x=1804084689;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MpS4sVC3hqe8pCkVdEGIPoy6oo+rArp6AEF/WIq0eFU=;
  b=KIHyNZF9wru8tnbHQfuyeIA6xDuzMZmugwn1ml+fNWzOySTcseTDpqtb
   IE44jaKFZ7+jXUc0dwWBAxrHuWW4ZhDC4ToBiDI0CrWkeyk6644bhw8OQ
   NsY7cE4Fm1GtkzjRLlZF+tpmixP+XqFE3fuhqkCVw0CrX51BOhMOrQW9y
   Wq/bUfJtJ8SVySKxgH3tRJsDvTHgWK+PcvGqKjyjOpgBX1aSUq6xUb1NO
   FYCsSnZ9fMb9WFy/Wst7Z/9pIhI2+DDEP1To5bfPXR5MvUysef44p8lFx
   js7p5cHIRp2aHvqb3Oa78oR9N2dLwuSeYcRn1jbPaANsZEZCx+nZg6FPk
   g==;
X-CSE-ConnectionGUID: hEvhgFTESEKkBaKofoRIqA==
X-CSE-MsgGUID: E94225xzTNSH15MhaFZTRA==
X-IronPort-AV: E=Sophos;i="6.21,322,1763424000"; 
   d="scan'208";a="14070024"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 14:38:09 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:26174]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.67:2525] with esmtp (Farcaster)
 id 63560b5f-7e28-490b-8e43-a2241f2b96ce; Tue, 3 Mar 2026 14:38:09 +0000 (UTC)
X-Farcaster-Flow-ID: 63560b5f-7e28-490b-8e43-a2241f2b96ce
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 3 Mar 2026 14:38:09 +0000
Received: from 6c7e67c92ceb.amazon.com (10.106.178.6) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 3 Mar 2026 14:38:07 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ap420073@gmail.com>, <zcgao@amazon.com>
Subject: [PATCH 6.1.y] Revert "selftests: net: amt: wait longer for connection before sending packets"
Date: Tue, 3 Mar 2026 06:37:50 -0800
Message-ID: <20260303143750.57741-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 856C61F1B51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com,amazon.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222894-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zcgao@amazon.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.991];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This reverts commit 7724036d4804222007689cd69f248347eb154793 which is
commit 04708606fd7bdc34b69089a4ff848ff36d7088f9 upstream.

The reverted patch introduced dependency on lib.sh under net selftests.
The file was introduced in v6.8-rc1 via commit 25ae948b4478
("selftests/net: add lib.sh").

Without lib.sh, the amt test fails with:
./amt.sh: line 76: source: lib.sh: file not found

The whole history of lib.sh includes about 50 commits and considering
the file never landed on 6.1 it may be better to not introduce it.

Signed-off-by: Nathan Gao <zcgao@amazon.com>
---
 tools/testing/selftests/net/amt.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
index ea40b469a8c1..7e7ed6c558da 100755
--- a/tools/testing/selftests/net/amt.sh
+++ b/tools/testing/selftests/net/amt.sh
@@ -73,8 +73,6 @@
 #       +------------------------+
 #==============================================================================
 
-source lib.sh
-
 readonly LISTENER=$(mktemp -u listener-XXXXXXXX)
 readonly GATEWAY=$(mktemp -u gateway-XXXXXXXX)
 readonly RELAY=$(mktemp -u relay-XXXXXXXX)
@@ -242,15 +240,14 @@ test_ipv6_forward()
 
 send_mcast4()
 {
-	sleep 5
-	wait_local_port_listen ${LISTENER} 4000 udp
+	sleep 2
 	ip netns exec "${SOURCE}" bash -c \
 		'printf "%s %128s" 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
 }
 
 send_mcast6()
 {
-	wait_local_port_listen ${LISTENER} 6000 udp
+	sleep 2
 	ip netns exec "${SOURCE}" bash -c \
 		'printf "%s %128s" 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000' &
 }
-- 
2.47.3


