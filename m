Return-Path: <stable+bounces-239959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNi4F5Ry5mlgwgEAu9opvQ
	(envelope-from <stable+bounces-239959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:38:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D19432F62
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB6B130A1396
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D79B39D6D5;
	Mon, 20 Apr 2026 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WR5UDxRa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0839C015
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705522; cv=none; b=JzMC8LcgIU5wW4HSPqd8orGTSEUj4suh43o7UmhPxj1FcbsrqpZo0h30tj1CFv2MynSBIFwetKJ7FR4jsQFXBdKpeqDAF/szKEAh6vEEZWRfYBBUomEt39sMjg9M+mKBfTilTaEmXTyCL86BSUIavgig8PMU5mzXnlLS9Y1EFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705522; c=relaxed/simple;
	bh=NC2vt/oMVH3SUHwWhJX191I0AVsA2MCRqj6NCbXBJHc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HgME9ZjF1LT0DyWnijYumnL7qEC2Ba4W5GltzwMkxqW6FgquMKz6UMBNMkM53b0ebg7WD8Kh4+1Fa8ND2uYe9VDf+M+2VBA5vPDzrRTKRXPHC3qPueyS/ryGWRUcL2uRTku8r0f8LPKcxRVw+AA1hp9RClw1zknAL29ZBsjekqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WR5UDxRa; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35d9278587bso3778971a91.2
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776705521; x=1777310321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P1pFD8c+B3MWSO6HzZ+QwDA2dWr+pU0xKoLUDgGQ0/E=;
        b=WR5UDxRafDgFqu7DLmxZ748urrcv1C/+M8dBkiIKuRFGdV+k87Lz8ePUHVie0VYC6R
         jtmtJLX0F05UAv0I6rX2pKvfTH/JCsMSpWNpp+CuYC1+KWnCnBPTSKJ/sC7ySXm8Y52d
         aQ1Sxpu8AJoN/rjqr2WR+ihkjs8LBMspN22qd8EBULM6IHToHd9sV1ZpOe/fZ/0cGxVP
         Z20XJH/wqNmJPvDXydfcFmbd/ObFoWQUn8x4caTBi1sd1D+/LgNTpJ1oSdC0VpQ5SltK
         nHs8yOY7v54BHLv7K6Fq/827doeTBpuiNDEFqwnvNpmZ9VqXw40PgOt3G0naUxR2DFFt
         OMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776705521; x=1777310321;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1pFD8c+B3MWSO6HzZ+QwDA2dWr+pU0xKoLUDgGQ0/E=;
        b=KZWgvVYvtlrIgBHaCWoSvK6mOdBG0EAZGtUUdDLjt31Tp2b/BdicCAxtOfDT0mt/qe
         kkbVqIX3SlNlXLr8o7qWqEOkILOuGyAi/ghvuJ6nKYN1oVOogwLV1HDgL7iYza9Dii4l
         QB3kLoT/iT6veKiReu6hs2gD0NWkREUb6hO968W1y5L7WZsPE7Z7peKtg6OGV7ENssfV
         FhMb7f4M+dXt2kasoEy9pfhwuzU+vOZp/y7tM6S9dLDrn5O/O0gDc9vCtny4ZD79Ddyr
         f0Q6SZklXp5cuODny3Vsrpq3upqoe75G7P1RelazYZDUFv3rVdrByndLtwzTmnSJNAZw
         MhSw==
X-Forwarded-Encrypted: i=1; AFNElJ90Ys5apwCGOyTCMCzqgl7EjlMMjrAPbHqmY1vc9HU8z4uF/hJvjqx9EVX1ujMRz7QYIMKLM7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25NFmEBe9wOQpYnjg8aZO4GvRjiKzGdCKaNlTz+KX8QHiZUV2
	56uDIqBOMkzgzTR7F1BUaDvWrhNVwqBq7/eqUUwReTUr5qX8yBaNBYH+6AUKxd2QRNUNyDJ0u1c
	4/tEFfa3B/rRTIaDRHye0mm8UcA==
X-Received: from pjzi12.prod.google.com ([2002:a17:90a:ee8c:b0:35d:9536:315f])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c52:b0:35f:b50e:defc with SMTP id 98e67ed59e1d1-36140473f07mr15386341a91.16.1776705520611;
 Mon, 20 Apr 2026 10:18:40 -0700 (PDT)
Date: Mon, 20 Apr 2026 17:18:33 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420171837.455487-1-hramamurthy@google.com>
Subject: [PATCH net 0/4] gve: Fixes for issues discovered via net selftests
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239959-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92D19432F62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pin-yen Lin <treapking@google.com>

This patch series addresses several issues in the gve driver. All four of these
fixes were uncovered by running the net selftests.

The series includes the following changes:

- Patch 1 adds NULL pointer checks for the per-queue statistics code to
  prevent crashes when the rings are queried while the link is down. This
  was discovered by the drivers/net/stats.py selftest.
- Patch 2 fixes an issue where interface stats would go backwards when the
  interface was brought down or its configuration was adjusted. This was
  also discovered by the drivers/net/stats.py selftest.
- Patch 3 ensures the driver falls back to the default minimum ring size if
  the corresponding device option values are exposed as 0. This prevents
  userspace from configuring unexpectedly small ring sizes. This was
  discovered by the drivers/net/ring_reconfig.py selftest.
- Patch 4 makes sure ethtool configuration modifications are done
  synchronously before returning to the userspace. This was discovered by
  the drivers/net/ping.py selftest.

Debarghya Kundu (2):
  gve: Add NULL pointer checks for per-queue statistics
  gve: Fix backward stats when interface goes down or configuration is
    adjusted

Pin-yen Lin (2):
  gve: Use default min ring size when device option values are 0
  gve: Make ethtool config changes synchronous

 drivers/net/ethernet/google/gve/gve.h        |   6 +
 drivers/net/ethernet/google/gve/gve_adminq.c |   4 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 128 +++++++++++++------
 3 files changed, 100 insertions(+), 38 deletions(-)

-- 
2.54.0.rc0.605.g598a273b03-goog

base-commit: 2dddb34dd0d07b01fa770eca89480a4da4f13153
branch: gve-misc-fixes

