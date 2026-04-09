Return-Path: <stable+bounces-235297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBzfGCYU12kSKwgAu9opvQ
	(envelope-from <stable+bounces-235297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 04:51:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F41FE3C5B7B
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 04:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48123303D8A7
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 02:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F10368296;
	Thu,  9 Apr 2026 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pfKkWKzC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dDL0bvUW"
X-Original-To: stable@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0421136215B;
	Thu,  9 Apr 2026 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703015; cv=none; b=h/6UrS4o/HtjVayVjDPM0B3rI1IfouiIHbNTGubDiclIi16ugOV1kLMgcp8rQC4CQd18qPxbobMzd41OHIDdKLkfyPbCJQbmfliAMa6+hhFVwerVxRoZSpKIabguHPX1C8hp6yz7R9yCU8YaPo2EQ73CF/Qv5oKCK8+rFPlh0TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703015; c=relaxed/simple;
	bh=k2WsxS6TNee1zlA88MJ4w2EKnDyli0hS5547M8NYDrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwNpR956uG2Kco0rLX/ld9cXSFY7wSYCysTc3NdQntUwpfhi2l3jDervSnYfHlZR/4NV91q21xD1EFNvKgSwKxlmxO7l0xWDqGBX2sJhWdoG16moJurDXiP8lUhu3IL9n5k9qxCWwEepMUbyt55lXhVqTRCvDeThu0BWX6EVYL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pfKkWKzC; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dDL0bvUW; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4frktr23rGzB14V;
	Thu,  9 Apr 2026 04:50:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775703012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ca/hCivNQ+GfsLCWu5A+fqrBPvC83j+aR85nKjfB7dw=;
	b=pfKkWKzCJ0CcJiTlc6AHSi15+z/f4YL74G0MGa/yUoklO7m8EujxOrpGlN/EqysHIyeakt
	QlO+AvW2CG8WX6kNh4LmXcEx8RHLTlk7OvWOY4qqy3BMww8xrl6oFgTKBNZTtJsicwtmgn
	VDr/N0u7ag/hrFy48vwnHSTHReTEpouUDUJirMr2hIO8Sn0vzlyLX1ycUPtSIE3iAg/DHT
	keZdh0DI5m9II2tO1UTWU6PswEaMTQMtPgZ0zLNUgLJAvan0bQXALRo0Yq4W9XFuMhxVG2
	0FpYadIp1YYI8+svscJM5dNRyHAUlS/REefKpGCTWUKCToyPXHHYrBW2DDPaQg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=dDL0bvUW;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775703010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ca/hCivNQ+GfsLCWu5A+fqrBPvC83j+aR85nKjfB7dw=;
	b=dDL0bvUWqixxzImVwTQW3s6pSadl+H8bX66XM/cBycE7ropjpUUEn4ABPu+/7YHquTXo6m
	Y0uVAtPUQ+C1X3AeAvX7ACDyFaE0qjX7NDoCXAt/tKTLbWNOdOnbKyI4RfoXzaMjNEm9A7
	RR7/73nAkVakCgSJXPjd2Ap/DBo7O7jM6u8XiWpg2U2VPNFklH9FsgcHIoPZez5iv+nmTS
	vYaRGp9jMRcw021wTPzAzbBZY2SKT1SqD2f+y4vYRX+dNQ0pT2iZCcEXauq9+rgPzf8fvK
	CRtaRv1P0mzIdRqUsSBqSt8VvmL24AldzHkW7qixPBnVu2ZwwaHX/DvtoKuIPA==
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jreuter@yaina.de,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 net 2/2] net: hamradio: scc: validate bufsize in SIOCSCCSMEM ioctl
Date: Thu,  9 Apr 2026 10:49:27 +0800
Message-ID: <20260409024927.24397-3-mashiro.chen@mailbox.org>
In-Reply-To: <20260409024927.24397-1-mashiro.chen@mailbox.org>
References: <20260409024927.24397-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f6290bd8d58f4ba352a
X-MBO-RS-META: 3e56zqrj9h4snafz64i6ixnrmmbcwrkd
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235297-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F41FE3C5B7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The SIOCSCCSMEM ioctl copies a scc_mem_config from user space and
assigns its bufsize field directly to scc->stat.bufsize without any
range validation:

  scc->stat.bufsize = memcfg.bufsize;

If a privileged user (CAP_SYS_RAWIO) sets bufsize to 0, the receive
interrupt handler later calls dev_alloc_skb(0) and immediately writes
a KISS type byte via skb_put_u8() into a zero-capacity socket buffer,
corrupting the adjacent skb_shared_info region.

Reject bufsize values smaller than 16; this is large enough to hold
at least one KISS header byte plus useful data.

Cc: stable@vger.kernel.org
Cc: linux-hams@vger.kernel.org
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 drivers/net/hamradio/scc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
index ae5048efde686a..8569db4a71401c 100644
--- a/drivers/net/hamradio/scc.c
+++ b/drivers/net/hamradio/scc.c
@@ -1909,6 +1909,8 @@ static int scc_net_siocdevprivate(struct net_device *dev,
 			if (!capable(CAP_SYS_RAWIO)) return -EPERM;
 			if (!arg || copy_from_user(&memcfg, arg, sizeof(memcfg)))
 				return -EINVAL;
+			if (memcfg.bufsize < 16)
+				return -EINVAL;
 			scc->stat.bufsize   = memcfg.bufsize;
 			return 0;
 		
-- 
2.53.0


