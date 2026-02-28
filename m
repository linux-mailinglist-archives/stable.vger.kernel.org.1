Return-Path: <stable+bounces-220498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO3rKww7o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:59:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4299A1C67CD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB15A31DB5F4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BECC3C861A;
	Sat, 28 Feb 2026 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE2PGgmc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F64E3C8612;
	Sat, 28 Feb 2026 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300383; cv=none; b=BoJYRLLgP8H4nswi6tzGfV/gVFh9KWp246bmo7zfzz8G4gThS8oz1u3yacnfQKAr4D3PIbgYtksPp6cLMZk9o/HMpKxEBrpsj9ftY3kGMf6IxiBW0aqkm9ciwXrNXBIZcEwhkenm+hZmxCvbWm3o3iNaQ0xO1TkacNZTnYzvQ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300383; c=relaxed/simple;
	bh=FESLrKIy69xsfGW/tTxfnfUnMZGuw9zNEDOrNDVSBQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlmlQVkaaN8xp9Q1cM3drKVhkLM42DW7TH0tTCNLJD5Eq1QYARZmX2qFvgv8DOD8nusab/DOOMrY8t7PFhJjEmDD8Fb36kAk30WfFFq1JlPCtIQ3pSwDEwb5ujW1JocgMm7G49KDLebLaMDtFtWaLk6sLS6X8tS4krsHAQJIzkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE2PGgmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD112C116D0;
	Sat, 28 Feb 2026 17:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300383;
	bh=FESLrKIy69xsfGW/tTxfnfUnMZGuw9zNEDOrNDVSBQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TE2PGgmc/6og8rA0vC5XKRvs1OOesnvyz4DKzgbjLIxoGwkun2ONEF+YM6LfOpgMd
	 +Dk0tcWn4iaM/B6+EQi0vaXuuZGytSD1TPLZGzT9WYqu0KDI252JaJjXV7KfoLLIFy
	 2TYzKMzVu84YKk9hGUQvkj8AbJlXxcBDu3+SAybDh4RhefJOIgGt5XDZ9fCagfG7Ts
	 OjmkLwOAmjOA+HsFjJ34PVS3gzT/2u6vs7iw86alhYyDBNnodKckrhyZ7onXk0XGNt
	 /Ok8uGkLDALG25vZIdQHvXO0tXLo8g87IcyzaduLanYkIanLESlnM1MflEIDkt367v
	 tOcnSHM5VqPlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mukesh R <mrathor@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 419/844] x86/hyperv: Move hv crash init after hypercall pg setup
Date: Sat, 28 Feb 2026 12:25:32 -0500
Message-ID: <20260228173244.1509663-420-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220498-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4299A1C67CD
X-Rspamd-Action: no action

From: Mukesh R <mrathor@linux.microsoft.com>

[ Upstream commit c3a6ae7ea2d3f507cbddb5818ccc65b9d84d6dc7 ]

hv_root_crash_init() is not setting up the hypervisor crash collection
for baremetal cases because when it's called, hypervisor page is not
setup.

Fix is simple, just move the crash init call after the hypercall
page setup.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/hv_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 14de43f4bc6c1..7f3301bd081ec 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -558,7 +558,6 @@ void __init hyperv_init(void)
 		memunmap(src);
 
 		hv_remap_tsc_clocksource();
-		hv_root_crash_init();
 		hv_sleep_notifiers_register();
 	} else {
 		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
@@ -567,6 +566,9 @@ void __init hyperv_init(void)
 
 	hv_set_hypercall_pg(hv_hypercall_pg);
 
+	if (hv_root_partition())        /* after set hypercall pg */
+		hv_root_crash_init();
+
 skip_hypercall_pg_init:
 	/*
 	 * hyperv_init() is called before LAPIC is initialized: see
-- 
2.51.0


