Return-Path: <stable+bounces-220387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLEjN/4zo2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DB81C5D9B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86FC032FBCFD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082063A8629;
	Sat, 28 Feb 2026 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7YYrYTy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3C48094E;
	Sat, 28 Feb 2026 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300280; cv=none; b=V+6QIXJ+N/lvINxN84qiMhx8aAdq2j9mVvtuy9YptwpSe7xOHJRzBl83NDv8CXO+OjeOSR3VK5S1SMCRzmpYYztf04RoPYyiaZnvmCgTf+e6B7mdumJFR9mB2kaSrwGUeKicaigDynOo7+IeJtaRmch0QH/BnFtq4HTBFArv7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300280; c=relaxed/simple;
	bh=fT5XQ90LQsVw7mKPiPlUtlk1NvZ5frplEmUQTEt3UJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZU4pokG9MsC6RpDSyZJ/sED/QoaLF1lMe347VCYGKYhxGGTakkp/yEdJXkp8PU6T+YcCZtbiPUzouJj0eUUm+Y/4UljhjBgZIdmr7SsYr3WjBrasiYwFK/uvn6ohB4RAJfoTzjrkNDEnCe4EwNAJbUwljTvgrBh0wfEHq29IgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7YYrYTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5A9C116D0;
	Sat, 28 Feb 2026 17:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300280;
	bh=fT5XQ90LQsVw7mKPiPlUtlk1NvZ5frplEmUQTEt3UJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7YYrYTydMBoVB5vh6rRImfEJdB6P5BC1QdL4vBsu41ZC+dEz66nql07xnDUEW5aD
	 bcePb3YQ9jN7PR23rjtcaPD4LDjvVdn/n84Uh24IA/ecZNeBY+BHvr8vDW8f3dKMJP
	 vqkofC6LeOvVO9+c3La2LdCCUKoczevrjTSIBGIVuBllXOpUNrBOdf35WxN9VnV4Hl
	 605IQCrmedMMrCMt/P8ycgJMzZKPs0PH0ad+sv8gKbI1y9flz+SqMN0Egc2EaRcmpV
	 T+ssYALQIf36RNWzUa4Or9iGVCmFsCnrg1dhsJrMWi3WOV4bnJoERDngn0oSJu32+p
	 uTd3YkpkiYuqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 308/844] ipv4: igmp: annotate data-races around idev->mr_maxdelay
Date: Sat, 28 Feb 2026 12:23:41 -0500
Message-ID: <20260228173244.1509663-309-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220387-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 93DB81C5D9B
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit e4faaf65a75f650ac4366ddff5dabb826029ca5a ]

idev->mr_maxdelay is read and written locklessly,
add READ_ONCE()/WRITE_ONCE() annotations.

While we are at it, make this field an u32.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20260122172247.2429403-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/inetdevice.h | 2 +-
 net/ipv4/igmp.c            | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index 5730ba6b1cfaf..dccbeb25f7014 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -38,11 +38,11 @@ struct in_device {
 	struct ip_mc_list	*mc_tomb;
 	unsigned long		mr_v1_seen;
 	unsigned long		mr_v2_seen;
-	unsigned long		mr_maxdelay;
 	unsigned long		mr_qi;		/* Query Interval */
 	unsigned long		mr_qri;		/* Query Response Interval */
 	unsigned char		mr_qrv;		/* Query Robustness Variable */
 	unsigned char		mr_gq_running;
+	u32			mr_maxdelay;
 	u32			mr_ifc_count;
 	struct timer_list	mr_gq_timer;	/* general query timer */
 	struct timer_list	mr_ifc_timer;	/* interface change timer */
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 7182f1419c2a4..0adc993c211d7 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -227,7 +227,7 @@ static void igmp_start_timer(struct ip_mc_list *im, int max_delay)
 
 static void igmp_gq_start_timer(struct in_device *in_dev)
 {
-	int tv = get_random_u32_below(in_dev->mr_maxdelay);
+	int tv = get_random_u32_below(READ_ONCE(in_dev->mr_maxdelay));
 	unsigned long exp = jiffies + tv + 2;
 
 	if (in_dev->mr_gq_running &&
@@ -1009,7 +1009,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
 		if (!max_delay)
 			max_delay = 1;	/* can't mod w/ 0 */
-		in_dev->mr_maxdelay = max_delay;
+		WRITE_ONCE(in_dev->mr_maxdelay, max_delay);
 
 		/* RFC3376, 4.1.6. QRV and 4.1.7. QQIC, when the most recently
 		 * received value was zero, use the default or statically
-- 
2.51.0


