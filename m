Return-Path: <stable+bounces-241077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAESM9wJ7GnDTwAAu9opvQ
	(envelope-from <stable+bounces-241077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:25:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 737EE46437F
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43F3530067A5
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D1274BE1;
	Sat, 25 Apr 2026 00:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BCdO4Ntb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9140DFB2
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777076695; cv=none; b=A7DyyqFgfdbhRA3u0O6XQYkLd1EYdWgLnxcrLpUS256s0eVlMo2F+1EqRd6iHDw8P2EW0YOpz0bpMA2xpklKPKzJ7XwvIprHyiak1oCM2q2Oxich3s2NrhGauuSa00xfJFH+k+C5kRWLlgMjLaZPbAZM2oy/dOFetD8ifWFMQ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777076695; c=relaxed/simple;
	bh=WIiyS90pJo/dq1FBk/ThSR2bm4kIjajfTMjARat9LQM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j6XKgSBq4HfaD4UiuxZGHNsYJ3PnzkQfZMHceFaA31sdajgFXp0yWFVg+m2dyUQ1CyZlAWH+dcfIz0B+hg4rdVABBLDoFUCETvDNzGnobbgIc6htLRJEpavMtpDbN1tsZJWWz1PLNM/k2R/s165dMCKHF0n1iDY3hd8CW3Sinw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BCdO4Ntb; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so4280646a12.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 17:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777076694; x=1777681494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PYg1g2whAdToCIlCbKeMv8kVRwwvGZDddkpfcq7roXM=;
        b=BCdO4NtbnrvKNxthjoIzNIv9MiH2umkkpsBrD0n/AD2YSMn6gYps2w1S8QT/J1JYhd
         xsUJXKm7uP9dueAl8DOJbhnii6QVsQebh9djFjsvydca9veFIEJgJFg3gBkwWEMYBUOo
         fsK/i7lQxD5cjou5hnucdfPInhRD0deGfaJBCdp0Pp9wIHs2iXMW56ydwvEG1wVSqZGZ
         ssIkPKj5bz6yVv9OWwqyF+ciM43rUx5Ep61J5jHjeWvaXvl09/Hvbpvet9ZqObmlNPmL
         jwBm9ph7HHdB1OdEEBU19vWiDQnvvreJoKGTwG2xc/90VX7YGyIMvealrWmgLG2VJieU
         tHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777076694; x=1777681494;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYg1g2whAdToCIlCbKeMv8kVRwwvGZDddkpfcq7roXM=;
        b=scoKfMGMPw/nIGhurPLL/R5fUugabCJgxdPTzx8fJ3Ab0l+lpgNIbA5sZv5VJ7Cvcv
         z3+mhx1ubrp4b5OIHYgLKPjjBrgLSTSA2dLa9izqE0u33EYu7sdgovgwu5FPuIQjRKrR
         XntVwKquDoT5oMSfhfCGvqfflS6isQdZE315qkJoAdHI4uR1Rmv9X/hG5EfL2qVKQwFE
         CPZfRVLqTLb7dmWa0FKyX3ZWs42jOLYSaT22gxnVKRd1ovKJDiItzWapOCsj2Hipl7u4
         M49yFCRrIItwZgXOqBFnFRWmjKu15lbTQRF0RScdT8VFFgHcgup65dSpxrKIhCrOU80K
         P6DA==
X-Forwarded-Encrypted: i=1; AFNElJ8yZ6QVfFb5gNM2SCw5CBj8e4+UOuJbauo9sygrkUJ+EnFMPtu2rOiVMr0tS2ecGC8mBKvwhFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwHlLAzLH32xp5GIbfJ4dguL05M4QzrE6ds3xOFbDwcjzCCHgq
	vk/oVy3RqAD/1kSnFfhyGSfOrGa+E9h7+sGBWlRhESbukjNVrTkWzddvisGRIE9MVjBuqfyCbnj
	bxmYvfxxdL4GKYc+pB3d/B0rsfw==
X-Received: from pgde3.prod.google.com ([2002:a05:6a02:303:b0:c76:af01:d1a7])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:72a1:b0:39c:cdb:5d81 with SMTP id adf61e73a8af0-3a08d8a4436mr40480650637.32.1777076693728;
 Fri, 24 Apr 2026 17:24:53 -0700 (PDT)
Date: Sat, 25 Apr 2026 00:24:46 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425002450.163421-1-hramamurthy@google.com>
Subject: [PATCH net v2 0/4] gve: Fixes for issues discovered via net selftests
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 737EE46437F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241077-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Pin-yen Lin <treapking@google.com>

This patch series addresses several issues in the gve driver. All four of
these fixes were uncovered by running the net selftests.

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


Changes in v2:
- Link to v1: https://lore.kernel.org/netdev/20260420171837.455487-1-hramamurthy@google.com/
- Add a NULL pointer check in gve_get_ring_err_stats() (Sashiko)
- Use local variable to prevent inflates from u64_stats_fetch_retry()
  (Sashiko)
- Add u64_stats_fetch/begin to protect base stats (Sashiko)

Debarghya Kundu (2):
  gve: Add NULL pointer checks for per-queue statistics
  gve: Fix backward stats when interface goes down or configuration is
    adjusted

Pin-yen Lin (2):
  gve: Use default min ring size when device option values are 0
  gve: Make ethtool config changes synchronous

 drivers/net/ethernet/google/gve/gve.h        |   7 +
 drivers/net/ethernet/google/gve/gve_adminq.c |   4 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 152 ++++++++++++++-----
 3 files changed, 125 insertions(+), 38 deletions(-)

-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

base-commit: e728258debd553c95d2e70f9cd97c9fde27c7130
branch: gve-misc-fixes

