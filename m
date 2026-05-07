Return-Path: <stable+bounces-244472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFHyEF/e+2k2GAAAu9opvQ
	(envelope-from <stable+bounces-244472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 02:35:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A824E1B61
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 02:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8F3A3016C9B
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 00:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5555D192D97;
	Thu,  7 May 2026 00:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hn9bfeZ4"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119B740DFD3;
	Thu,  7 May 2026 00:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114139; cv=none; b=XYupWp19h9yxLagGQOUvv58MkY4J0hMd0VmPDoYzKlSXeEjY5YABrmDYty4Q8AAybwZN5oIaNo5/Cvy8tBAr2aF07+5nXp/N/pSLB1QoBj3zV85N9Niy1LvwEDufV3drwfZcz6mBTIeoxmtY6ba7YSmaWSBHtDLS6x2Lllxg1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114139; c=relaxed/simple;
	bh=sLt55pcK0rHXDHdos4Kb5swzryqs4t8yZbPad7qkXGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P3vXDAVH0ty+b0z8CleAsYNwas7OmQ7hlwOgwn2KvL6j9qtVIKjfWiajO6thyP4+C9B1BE9BdnMZSxUcC0uztRILMMidLB4D61p/qaKwYKj5hz70QtuaPwtY8nyg3OnG0viTvrgnTP9PnJXH1TV3AOlFLme5Hz3V3u1nosnLvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hn9bfeZ4; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778114138; x=1809650138;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yAfa9z/M5BpV7v6kn7A1vrdmJ9zU9WEKwjIOsqBs1Bo=;
  b=hn9bfeZ41MHyKBcX4FxDZ4qEw0ax6A71CVtHa30yTmf9zSaeO4l2xHNr
   2TeHe5058FCVilQAQaM2x8/MhZc60Fet+EWv2lfHL4cc6P16RN8e0IzJy
   fA4Vmq7XG3OPAEckl39v7+rE8iMbqXOrjW5BFl8Ds2+hkxbbQ2aLJ5b7K
   hei2R9RmEWX2Zz0gCo9TqB3g+9A+nsk+C3BsR+cE3JjrUA9lV3voJ9S0f
   A69S941dmLpoedfLnIEqStunpozKLHfG5zrtEz+/r+fqmJj53/4dJCYL+
   AI7lRfPdchCJhQqEr47bVaIIXw7ce1iBD6UVv9NkHN8PcvELukQ2iWp+n
   A==;
X-CSE-ConnectionGUID: ilWi1k35RrSYfoC5C2nIwQ==
X-CSE-MsgGUID: nCzSc9L3ScatlWC/yjPeew==
X-IronPort-AV: E=Sophos;i="6.23,220,1770595200"; 
   d="scan'208";a="19046485"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 00:35:35 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:2622]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.77:2525] with esmtp (Farcaster)
 id f26e7759-5087-4e81-b9f4-5154edc77345; Thu, 7 May 2026 00:35:35 +0000 (UTC)
X-Farcaster-Flow-ID: f26e7759-5087-4e81-b9f4-5154edc77345
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 7 May 2026 00:35:34 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 7 May 2026 00:35:30 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, David Woodhouse <dwmw@amazon.com>, "Yonatan
 Sarna" <ysarna@amazon.com>, Zorik Machulsky <zorik@amazon.com>, "Alexander
 Matushevsky" <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, Matt
 Wilson <msw@amazon.com>, Anthony Liguori <aliguori@amazon.com>, Nafea Bshara
	<nafea@amazon.com>, Evgeny Schmeilin <evgenys@amazon.com>, Netanel Belgazal
	<netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Benjamin Herrenschmidt
	<benh@amazon.com>, Noam Dagan <ndagan@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Evgeny Ostrovsky <evostrov@amazon.com>, Ofir Tabachnik
	<ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
	<stable@vger.kernel.org>
Subject: [PATCH net] net: ena: PHC: Check return code before setting timestamp output
Date: Thu, 7 May 2026 00:35:15 +0000
Message-ID: <20260507003518.22554-1-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: E6A824E1B61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244472-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

ena_phc_gettimex64() is setting the output parameter regardless
of whether ena_com_phc_get_timestamp() succeeded or failed.

When ena_com_phc_get_timestamp() returns an error, the timestamp
parameter may contain uninitialized stack memory (e.g., when PHC is
disabled or in blocked state) or invalid hardware values. Passing
these to userspace via the PTP ioctl is both a security issue
(information leak) and a correctness bug.

Fix by checking the return code after releasing the lock and only
setting the output timestamp on success.

Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
Cc: stable@vger.kernel.org
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_phc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.c b/drivers/net/ethernet/amazon/ena/ena_phc.c
index 7867e893fd15..c2a3ff1ef645 100644
--- a/drivers/net/ethernet/amazon/ena/ena_phc.c
+++ b/drivers/net/ethernet/amazon/ena/ena_phc.c
@@ -46,9 +46,12 @@ static int ena_phc_gettimex64(struct ptp_clock_info *clock_info,
 
 	spin_unlock_irqrestore(&phc_info->lock, flags);
 
+	if (rc)
+		return rc;
+
 	*ts = ns_to_timespec64(timestamp_nsec);
 
-	return rc;
+	return 0;
 }
 
 static int ena_phc_settime64(struct ptp_clock_info *clock_info,
-- 
2.47.3


