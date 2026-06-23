Return-Path: <stable+bounces-267854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fMJeDjL7OWrBzgcAu9opvQ
	(envelope-from <stable+bounces-267854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 05:19:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F206B3C72
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 05:19:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=OAt6C8kf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267854-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267854-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7861C300EC97
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 03:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5272749DF;
	Tue, 23 Jun 2026 03:19:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE51DD0D4;
	Tue, 23 Jun 2026 03:19:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184751; cv=none; b=EPlMk7fQovS+CaYnlMQUXP9NKReMH8B81wMAbnPaX4Cpy0wvtJd5fdzGw2CWp9Eu1loGcsb6wnqpO2ZlyBzhN6CAR1Mwo6BVISnr6bT6i4Vr5UNwyokoWsNqg5gZJsTtnigbJ3TZ+JGcFmDguM6SoFYzg0hk4WbBmOFRgWwAJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184751; c=relaxed/simple;
	bh=YllO2QVTAT1SFaMzvpUbzJxA7PweExikM79fzqpVlcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PCNyIm0aiDmstriAshN9V0QmLoEgZNfy+Hsw+9sLoCppJoU3xeOHxYwQvYi99OVSnhA4JiE5K1ikqlv95jsqULE5rEl/iAZKzS7fGwV1yr7B4vDpWjNxwlEN7yrx4MTYz7r3QYeID2WGVOLbPmtxttWvWezJ/XFBiWrOvlpBofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OAt6C8kf; arc=none smtp.client-ip=220.197.31.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1B
	uUpZ90jBptaMLID11KjRp832BAUFG617V2AppAcJo=; b=OAt6C8kfv/uuxglvDk
	BvIO7Fmbx9jahvnYLQZKEKxfIlZ+rkXRdKQWc72yd640waGhyDhO8FDyUj1r/01r
	C0dywpy+a1Po1x4gpM6aq8gtc2wbFE36EuAcGVLtvLtMoZFccZ0+NMhyN9zokhTk
	J5Hq1QcXwrKG8bGMwzZV1/XLI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnuBcI+zlqJmmCDg--.9919S2;
	Tue, 23 Jun 2026 11:18:34 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: elder@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: ipa: fix SMEM state handle leaks in SMP2P init
Date: Tue, 23 Jun 2026 11:18:31 +0800
Message-Id: <20260623031831.1788454-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAnuBcI+zlqJmmCDg--.9919S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1fGry3Xw4ftF1xGw1kGrg_yoW8XF48pw
	s8CasIkry5AFWIg3ZrCry8WF98u340grs8GrZ8Kas5uay3AF4rJF1kKFyrJay0vFy8CFyD
	Zw13Aa1Duay5ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piVT5JUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxgrpWGo5+wpUrQAA3m
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267854-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86F206B3C72

ipa_smp2p_init() acquires two Qualcomm SMEM state handles with
qcom_smem_state_get(). However, neither the init error paths
nor ipa_smp2p_exit() release them.

Use devm_qcom_smem_state_get() for both state handles so the
references are released automatically when the platform device
is removed.

Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ipa/ipa_smp2p.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 2f0ccdd937cc..d8fd56949082 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -228,15 +228,15 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
 	u32 valid_bit;
 	int ret;
 
-	valid_state = qcom_smem_state_get(dev, "ipa-clock-enabled-valid",
-					  &valid_bit);
+	valid_state = devm_qcom_smem_state_get(dev, "ipa-clock-enabled-valid",
+					       &valid_bit);
 	if (IS_ERR(valid_state))
 		return PTR_ERR(valid_state);
 	if (valid_bit >= 32)		/* BITS_PER_U32 */
 		return -EINVAL;
 
-	enabled_state = qcom_smem_state_get(dev, "ipa-clock-enabled",
-					    &enabled_bit);
+	enabled_state = devm_qcom_smem_state_get(dev, "ipa-clock-enabled",
+						 &enabled_bit);
 	if (IS_ERR(enabled_state))
 		return PTR_ERR(enabled_state);
 	if (enabled_bit >= 32)		/* BITS_PER_U32 */
-- 
2.25.1


