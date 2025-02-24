Return-Path: <stable+bounces-118907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB95A41E6A
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9621E7A38D1
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF223BCED;
	Mon, 24 Feb 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PFSS5W9z"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3AF23BCE9
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398458; cv=none; b=JdF7I90F+mnyCyqznFbkA8QdtAQRnD1QOz0GSzYVbtczDgW+dTzxFGJnpssUhZbIXNFqL/pGX2T27WrlGGPaK8+lEwjMMdTEjfXr/7smhpx5aYr6ArKBT3yQKkX22ECJjp2XMNZwNHTnKZDzCb9mE2/WTryNkJ99eKYiHI9HfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398458; c=relaxed/simple;
	bh=+XtxspdCBV02g9qkPq63bw+cw0FS5J//iQIim4KVEM4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OI+uD0/RnYk+FU23k4S/9u0PpjeyCG9zQOUXOjw/pdi+SwJPAwNcMJMZfcAAklkicezhPybFoA8pKsplBHTqI5D2tRkinVa0OSh3kdFm5D2ZcBtu/y61kKv1w8+2VSKUgofTrWGLkVS/Bnwfl31N/Z2RdCCTATpSQ/7BVLrUVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PFSS5W9z; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/csMBt5DN6UehnHaMMTaHal6CVF7I4lLvpFkLHJTe2E=; b=PFSS5W9zpGz2fqbK8uzYu+9jd6
	F/DI8SXo6uyQ1n5AvVgFtjHNYEygip2OobcMnpRrnsyvUC6TqqMwMs6zMcJQUbSx3JgVvOgcSjapV
	8SUP0/0VSyJdKgSgvQJVBt0r80V9EIViDReSRNyc7C/JC2/20/S/NfgxPZH8C9hdWk9RCFBGRzWKf
	Zu44PkjkdGUj2+xuOORDFIAQAGtj6t5/+VK5rNUZqoUZ/JomYwqNDSiuSsC1vxOtVwZErjO3rhB7v
	638c5hsvUoU+mj33mCOTPLrQUxvVu4fFdK6s8zuz9HSnp23QdlvgaGlv9/VLHE7262PoxFa47o9Eh
	5pWAjQ1w==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tmX8Y-00HSyG-Ke; Mon, 24 Feb 2025 13:00:44 +0100
From: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Subject: [PATCH 6.6 0/2] Set the bpf_net_context before invoking BPF XDP in
 the TUN driver
Date: Mon, 24 Feb 2025 13:00:00 +0100
Message-Id: <20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v1-0-de5d47556d96@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEBfvGcC/yWOwQ6CMBAFf8Xs2TW1AoK/YkyzyKtulIotJSaEf
 5fobeY0M1NCVCQ6bWaKmDTpK6yy327oepdwA2u3OlljS2NtwX8wBT8kSeD0lJZzAosfEdlHgCO
 kYw3cYXK9DA7hnZHhXMptryO3jTmKrw9NbUpaQ0OE189v4kzVrqLLsnwBejaispkAAAA=
X-Change-ID: 20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-b907af839805
To: stable@vger.kernel.org, bigeasy@linutronix.de
Cc: revest@google.com, kernel-dev@igalia.com
X-Mailer: b4 0.14.2

A private syzbot instance reported "KASAN: slab-use-after-free Read in
dev_map_enqueue" under some runtime environments.

Upstream patch fecef4cd42c6 ("tun: Assign missing bpf_net_context")
fixes the issue. In order to bring this patch to stable v6.6 it's also
necessary to bring upstream patch 401cb7dae813 ("net: Reference
bpf_redirect_info via task_struct on PREEMPT_RT.") as a dependency.

Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>

---
Sebastian Andrzej Siewior (2):
      net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
      tun: Assign missing bpf_net_context.

 drivers/net/tun.c      |  7 +++++++
 include/linux/filter.h | 56 +++++++++++++++++++++++++++++++++++++++++---------
 include/linux/sched.h  |  3 +++
 kernel/bpf/cpumap.c    |  3 +++
 kernel/bpf/devmap.c    |  9 +++++++-
 kernel/fork.c          |  1 +
 net/bpf/test_run.c     | 11 +++++++++-
 net/core/dev.c         | 33 ++++++++++++++++++++++++++++-
 net/core/filter.c      | 41 +++++++++++-------------------------
 net/core/lwt_bpf.c     |  3 +++
 10 files changed, 125 insertions(+), 42 deletions(-)
---
base-commit: c0249d3a0c3cf082d56f4285647ddba19ef604a7
change-id: 20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-b907af839805

Best regards,
-- 
Ricardo Cañuelo Navarro <rcn@igalia.com>


