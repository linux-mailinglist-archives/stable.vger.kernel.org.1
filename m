Return-Path: <stable+bounces-231216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADNXOWZ2ymnZ9AUAu9opvQ
	(envelope-from <stable+bounces-231216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:11:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE37135BB02
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCD1330095C3
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0339B3D332C;
	Mon, 30 Mar 2026 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVt5pSJB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8463CFF61
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875853; cv=pass; b=dgwIRqgX25hxwvHFaPJbRFLI3k7QT4gXDmU4pnezfrjn8ukL5XFHRblQeD7MicCm1On4aoOyofVUaHkSyoyS6d3LPImF/zuBZ7DWs1XxRrH0Kq/GYmhKIMRcYgNiiLX6rMMRNEfGooM36KhsHtOU24uDrL+c8bLWvDU7i+pqTQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875853; c=relaxed/simple;
	bh=0Cwdb/46OgW5VjkNSZbAZFMjeairSLyPIs4ZEcz5EQw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hVxcmsPHXGC39aWp8bKKUMWTgiQtR4O5pXCSwSB7RJ8Daoss+4RE+8ssX/xjfiAZa3/ne0LpQwVjHiAN1Qs0Av275CAFkTgnTznubIjIm4Cs+/JtqkgOeGBurSPudCfAoImiD3Jzbo6/JrXwigawEDT2yKU6qQVuHRxQ2ivW4wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVt5pSJB; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66b957dd76dso2291066a12.3
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 06:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774875851; cv=none;
        d=google.com; s=arc-20240605;
        b=bzSn6S4MujSQ/vpn2rIq17JvykXo4xXDFWP2E5+SaDIM05iN2mKAlGBWlkka5IaWC5
         wTNSE/aF2Fsayv5ZhFtXlHupRYcyBx7ffXrBWfXqCcAZn6kp0Dt1Ihtls8p0ZSqFMExj
         88hEdBdDdFTu6fJy1M/bi7RrIjipQsW3XUNcSgKimSt+XR9U2JtrUbdKdjbwB5VcaeKK
         tuuyL5vc/xcLCemirkHXym+1qnk73Rh4iKGyhdwF13qpNOuPuAPRR+VcqLCt/LSbD6aq
         GfXzp6w4zvuhDN3O/2c9QKGBOAPLX8/mPXZDpoGoflkq19sGIrCC7NssUnl+z/3a5E+J
         H/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=V0WKfufc+UkKVXOEWdhXWE4oAi0whRIif5wlHsWbgx4=;
        fh=1NxLiEhMoqV9lOhJV8BVyymHwxXCacL1MyR/M+KaDMA=;
        b=JBEVcE0E2NDOXOmbeWDJ5jBuhcRhCUad+9WXGiG6Mf5ThywglS9MvoZ8H9fPlZca12
         WOJIHN++YmylnoXHzYzv+Hu3atkSvTz/qBgp9jIIQY88fGzsF4m+SajAyuX8GiKgMQ5R
         4SYM5z6clJJESN9P2Ia9vRZikRYy1QW9B/bquVIcOrMH2Sn+849wxmopPOCs28erCG7L
         05q5prW1cWewrDKQmdB70i18KuBxIXgK23nxTTyT6n97IpggPJhWYiwyXdlJOJ1hZqGa
         MvETYqdKVUCdgRZARnkZMYpmg1HZVPPQTx1YgTM+AkMndtT2N4x8vxgTnRHofJqoJbHq
         0ynQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774875851; x=1775480651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V0WKfufc+UkKVXOEWdhXWE4oAi0whRIif5wlHsWbgx4=;
        b=AVt5pSJBnuAY4A6BNO4rMOeV/GtmXiEMAy/MSDyq6tKpW2pcl82zOpD/iTxjVo2pdz
         EPCREXVaV+qkKcfIp6d6hiD6pONGf6tuoxYGy3iNjZPMXA7TA2DM3UTb9r+zgIOyXgOI
         w8Q68dHe+/6PJ0uXx0GJvrkbXvSqX+NF56ix/9f4Q4Zo6v7trXUBqi31pkwNnfEr6GMy
         jyntZBRa2kDZGbsNVnWUeVLVxoxybER9nT96//z0g7Cc2qZLvCeogJ3RBnHdQDCFQXeh
         ldLr4k8F96h81ixhistQhjrvciJsNvtYsVM2MvizerhXySnyuuDIiLDjfIXreKkvqoOS
         bO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774875851; x=1775480651;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0WKfufc+UkKVXOEWdhXWE4oAi0whRIif5wlHsWbgx4=;
        b=APV1cLvhfSSkLn89/IZsdwcxZwqEr9+G3+YCfqaWKT9bYHDimyBd3CHXYOMcT/31PH
         ciMQ/F2GwK3stPim8TQuQz9HBjZutb2j6R8janTxxe+7dA/g2cSAF6FsvLaKeygHeOlB
         XhaHRXl2FCiSumI1w13RBCZdZsv7cHqF2ALhc4YLsVUABowDYWTchqkXVSSmHGQkRn0h
         dNW7W3SB5NLMFV5TTx+06g0aLkGxJIX0L81KzUv4Pw90+1OkknxMtT3hzCea2CemeK6Q
         BTvRZten2FL2VJLRFg/duapSBhZzVZNR3qlouNy5CGGL8W9wVdwIEp9GD39Oj+72ih0Z
         ZCYg==
X-Gm-Message-State: AOJu0Yxy4gO66cqsxZzdP+WgzL/MF08llNOgieFs8HhPLxlSFNQ1LoVf
	QsV9sTZP3bK7S4p+JA2D/SCL+qW67vOCkYvFxWuJ05O/p229tO3bAclZA020klKg4QumRdA+ZQ0
	wpy3U8MLcnyBPNwdZ6+FWtSd7nsd+jGA=
X-Gm-Gg: ATEYQzz3lwzsaIz7W7OpOruJ6d71E1XhUKzm3c2m3UxchWpMzXEBdFk0Y/plerVUH5b
	e/gDUznKd1SrJfXG3JKibPZfhp3IT0Quop1z8v3+CrG7RA6ZbVJ2wPSNShdC8GCR/zoJiid16ys
	R++HCI3SAAbhH3URkyZ0Soe3LWUktPD0or1nVNgiUuk/mSBsraau6o2FIraRruPWSjkp3D1OODy
	B+UH4NvmQvcECvwtBD1+Tyig7p9XURzxagXILTfmmq6+MBDPAHKwuFgWrNh3W4fw2JXkGaAWnPV
	qonGNfLtA9Xuxslmuxsaz0cAUshqCARc0EgS0ZCKTnxUXbvBLfpAO7RditvUpja3kvpTwZdH6g=
	=
X-Received: by 2002:a05:6402:530c:b0:66a:16ed:46cb with SMTP id
 4fb4d7f45d1cf-66b290775bdmr6447498a12.26.1774875850266; Mon, 30 Mar 2026
 06:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Zen <kai.aizen.dev@gmail.com>
Date: Mon, 30 Mar 2026 16:03:43 +0300
X-Gm-Features: AQROBzAd3o8frkHTSwmLZErgd2pRzfZsX2CL5hHa_Z9yzJCi4yGbZ9r1XQr0XWY
Message-ID: <CALynFi5d0DuGW50xq7xQnsDPdEuN5jBGTqh8bcsUwxk6L-FAdA@mail.gmail.com>
Subject: [PATCH net v2] tipc: fix UAF race in tipc_mon_peer_up/down/remove_peer
 vs bearer teardown
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org, jmaloy@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231216-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EE37135BB02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CVE-2025-40280 fixed tipc_mon_reinit_self() accessing monitors[] from a
workqueue without RTNL.  That patch closed the workqueue path by adding
rtnl_lock() around the call.

However, three additional functions in the same subsystem access
tipc_net->monitors[] from softirq context with no RCU protection at all:

  tipc_mon_peer_up()    - called from tipc_node_write_unlock()
  tipc_mon_peer_down()  - called from tipc_node_write_unlock()
  tipc_mon_remove_peer() - called from tipc_node_link_down()

These three are invoked from the packet receive path (tipc_rcv ->
tipc_node_write_unlock / tipc_node_link_down) and hold only the per-node
rwlock, not RTNL.

Concurrently, bearer_disable() -- which always holds RTNL per its own
inline documentation -- calls tipc_mon_delete(), which:

  1. acquires mon->lock
  2. sets tn->monitors[bearer_id] = NULL
  3. frees all peer entries
  4. releases mon->lock
  5. calls kfree(mon)  <-- no synchronize_rcu()

The race is structural: there is no shared lock between the data-path
reader (which reads monitors[id] then acquires mon->lock) and the
teardown path (which acquires mon->lock, NULLs the slot, then frees).
A softirq thread can read a non-NULL mon pointer, get preempted, and
resume after kfree(mon) has run on another CPU, then call
write_lock_bh(&mon->lock) on freed memory:

  CPU 0 (softirq / tipc_rcv)          CPU 1 (RTNL / bearer_disable)
  tipc_mon_peer_up()
    mon = tipc_monitor(net, id)
    [mon is non-NULL]
                                       tipc_mon_delete()
                                         write_lock_bh(&mon->lock)
                                         tn->monitors[id] = NULL
                                         ...
                                         write_unlock_bh(&mon->lock)
                                         kfree(mon)
    write_lock_bh(&mon->lock)  <-- UAF

The fix mirrors the existing bearer_list[] pattern in the same module:
convert monitors[] to __rcu, use rcu_assign_pointer() on creation,
RCU_INIT_POINTER() + synchronize_rcu() on deletion (before the kfree),
and the appropriate rcu_dereference_bh() vs rtnl_dereference() variant
at each read site depending on execution context.

synchronize_rcu() in tipc_mon_delete() is placed after the
write_unlock_bh() and before timer_shutdown_sync() + kfree() to ensure
all softirq-context readers that already observed the old pointer have
completed before the memory is freed.

Fixes: 35c55c9877f8 ("tipc: add neighbor monitoring framework")
Cc: stable@vger.kernel.org
Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
---
v2: Resubmit targeting mainline via netdev per stable-kernel-rules (Option 1).
    No code changes from v1.

 net/tipc/core.h    |  2 +-
 net/tipc/monitor.c | 51 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/net/tipc/core.h b/net/tipc/core.h
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -109,7 +109,7 @@
  u32 num_links;
  /* Neighbor monitoring list */
- struct tipc_monitor *monitors[MAX_BEARERS];
+ struct tipc_monitor __rcu *monito[MAX_BEARERS];
 rs
+

