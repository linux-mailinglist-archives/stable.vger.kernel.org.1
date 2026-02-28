Return-Path: <stable+bounces-220425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMC1JKA6o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:57:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B88C1C6736
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E2E1326F91F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6783B2B71;
	Sat, 28 Feb 2026 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASGh9P28"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24E3B2B69;
	Sat, 28 Feb 2026 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300315; cv=none; b=bj8rPi/eTDXncGOjsbvG3MqtHkl5KJZtKkJWewJyrYzkzzjZ/x5MCk86gAVHmlniuU/oj9yV/0ojnIpqkGAQM/lucm+sl0iztLEkt/rlW6qZjBgLjDGhWsmmMCEf8jmOw5Enrq9t3Bs87D8yUeAVPXnUKgAKAZ7xQJWWMFWFWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300315; c=relaxed/simple;
	bh=W9Ht9061eXlsgXJAa/mgHZ9alCq4zRwr8EaSMiXPFq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/WOua1+nuTPd9vcaU2dCMcN9mM9TJA6Nks/G8busdloI+moelSxt46kYTjX4T9vhRH1y5nxq4cu5ljDfe0s/uhKjTHCFoCc3QGiuKzLI6PCQkttnEBLj5U91y30qZorTuQnt8NbaTApZnpl5GVcsukMohKvgSI0EAcR6/xsP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASGh9P28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918CEC116D0;
	Sat, 28 Feb 2026 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300315;
	bh=W9Ht9061eXlsgXJAa/mgHZ9alCq4zRwr8EaSMiXPFq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ASGh9P28VGsDBnvuUViELcfFY4jFnNJriBW1cMgNdW/nZYF13naZHD+dT44DiV5B+
	 K/gtUu6Hpad7adx2SzenxkbUsMIdAgk/lDdDlKRWzBifyiQirZz4hEEggQUbkc5RQq
	 ECYH0RhEjScEax3UL6fSENwXqIBfSXjVsU1PCbR8R7FomCT6SmYSI2etz78geHbEim
	 lPIVg2DCkMFV/KFVwvYdzE9baYpsigZ0Z9cv+mmhNbXHdR2oyAU28c70Ah/7ivRcDh
	 Nxsx9mqBecBQfM5jl1I17to9TTZbUAJE1mjBRnGrQNu4u8ziHRlbufNGLyg/ufg8GT
	 kBx4F6pbcH4Bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 346/844] scsi: buslogic: Reduce stack usage
Date: Sat, 28 Feb 2026 12:24:19 -0500
Message-ID: <20260228173244.1509663-347-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220425-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1B88C1C6736
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit e17f0d4cc006265dd92129db4bf9da3a2e4a4f66 ]

Some randconfig builds run into excessive stack usage with gcc-14 or
higher, which use __attribute__((cold)) where earlier versions did not do
that:

drivers/scsi/BusLogic.c: In function 'blogic_init':
drivers/scsi/BusLogic.c:2398:1: error: the frame size of 1680 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

The problem is that a lot of code gets inlined into blogic_init() here. Two
functions stick out, but they are a bit different:

 - blogic_init_probeinfo_list() actually uses a few hundred bytes of kernel
   stack, which is a problem in combination with other functions that also
   do. Marking this one as noinline means that the stack slots get get
   reused between function calls

 - blogic_reportconfig() has a few large variables, but whenever it is not
   inlined into its caller, the compiler is actually smart enough to reuse
   stack slots for these automatically, so marking it as noinline saves
   most of the stack space by itself.

The combination of both of these should avoid the problem entirely.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://patch.msgid.link/20260203163321.2598593-1-arnd@kernel.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/BusLogic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index a86d780d1ba40..026c3e617cb1c 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -920,7 +920,8 @@ static int __init blogic_init_fp_probeinfo(struct blogic_adapter *adapter)
   a particular probe order.
 */
 
-static void __init blogic_init_probeinfo_list(struct blogic_adapter *adapter)
+static noinline_for_stack void __init
+blogic_init_probeinfo_list(struct blogic_adapter *adapter)
 {
 	/*
 	   If a PCI BIOS is present, interrogate it for MultiMaster and
@@ -1690,7 +1691,8 @@ static bool __init blogic_rdconfig(struct blogic_adapter *adapter)
   blogic_reportconfig reports the configuration of Host Adapter.
 */
 
-static bool __init blogic_reportconfig(struct blogic_adapter *adapter)
+static noinline_for_stack bool __init
+blogic_reportconfig(struct blogic_adapter *adapter)
 {
 	unsigned short alltgt_mask = (1 << adapter->maxdev) - 1;
 	unsigned short sync_ok, fast_ok;
-- 
2.51.0


