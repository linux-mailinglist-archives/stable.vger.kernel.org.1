Return-Path: <stable+bounces-255786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDamE/mlGGrClggAu9opvQ
	(envelope-from <stable+bounces-255786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:30:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B9A5F8DB2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F2B831286ED
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B04317163;
	Thu, 28 May 2026 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FI2EfCNB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62333C51D;
	Thu, 28 May 2026 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999879; cv=none; b=tZYqZQ7QUgM+DlM2wUq8tZlwZNWca8xthyjNtIeM/rEkoLGOLmA0S4cekvVDyMEZl2lMvgzv2/Mv3ZGNh8/h7bcuQQzo5MPWcOdQfzY43Uan+o9Va20d1TI22OvgdKKvesqwwMgAsl+VIhwIqPGqPEiaVGCkaIqyglmJovWzTD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999879; c=relaxed/simple;
	bh=517p9j9WozpB3EC+5Q2CUE7pePp9qe6OJ/kTdJCI3J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTErr/ww9C2J1/dg4sbW0FAlL1genXTXStDhKA52wokyi5k19sHgbN1acXTzfqfVcIJrRkCmfLz8Sq1oVIRZqpxEwyeXhgAqOSId2xvqj+ifw1uWk9byIKKSwo7NzRndDC97VCtd5W5RpU4hiFEei/mw5h3ElGzx2rq+UAKb5BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FI2EfCNB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A491F000E9;
	Thu, 28 May 2026 20:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999878;
	bh=k+jhgIHdRMmSFg3yDmRW8SVYNNm7JHSnqFRGCFHSzWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FI2EfCNBwkbvToCvkolgGkiKMnHHvQaMukh1s3E/PwGdgDNQpurTtN19f97aOU903
	 CIBxGChnRYeuHRPlX10S6cjtf8bZj4P3A8Zu+mWm7iCdsAP2bZ4nhuLoJorCzRDPEp
	 xubfygcjYnUcY5liMAXEQMSaECvkzcMZioXxA2tE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Rosen Penev <rosenp@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 222/377] irqchip/ath79-cpu: Remove unused function
Date: Thu, 28 May 2026 21:47:40 +0200
Message-ID: <20260528194644.821374203@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,intel.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-255786-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C1B9A5F8DB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit 0fa10fb77069fb67aa51384868ef3702b7791465 ]

ath79_cpu_irq_init() was part of the legacy pre-OF code that got removed a
while back.

Remove it to get rid of a missing prototype warning, reported by the kernel test
robot.

[ tglx: Fix the subject prefix. Sigh ... ]

Fixes: 51fa4f8912c0 ("MIPS: ath79: drop legacy IRQ code")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260506085522.1210143-1-rosenp@gmail.com
Closes: https://lore.kernel.org/oe-kbuild-all/202412011509.kGQkDr1y-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-ath79-cpu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/irqchip/irq-ath79-cpu.c b/drivers/irqchip/irq-ath79-cpu.c
index 923e4bba37767..9b7273a7f8ced 100644
--- a/drivers/irqchip/irq-ath79-cpu.c
+++ b/drivers/irqchip/irq-ath79-cpu.c
@@ -85,10 +85,3 @@ static int __init ar79_cpu_intc_of_init(
 }
 IRQCHIP_DECLARE(ar79_cpu_intc, "qca,ar7100-cpu-intc",
 		ar79_cpu_intc_of_init);
-
-void __init ath79_cpu_irq_init(unsigned irq_wb_chan2, unsigned irq_wb_chan3)
-{
-	irq_wb_chan[2] = irq_wb_chan2;
-	irq_wb_chan[3] = irq_wb_chan3;
-	mips_cpu_irq_init();
-}
-- 
2.53.0




