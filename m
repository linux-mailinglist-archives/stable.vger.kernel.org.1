Return-Path: <stable+bounces-224758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DFaAH3VsWk2FgAAu9opvQ
	(envelope-from <stable+bounces-224758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:50:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8871826A269
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79ADD31ECBD4
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 20:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6082C21D8;
	Wed, 11 Mar 2026 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPou3S9b"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D56285C9D
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261988; cv=none; b=sdFnRFjBF4NG/pbbG9X1+/J95NIqAh8S5e8+Cw9r6jfiG4wjCpT1HCJw0AGxlRDHJOWMv3seDWSAhS591/VcBkD4l7KYfmm5tr4skNIVRlOYyZGOQa0WKmhGCKeXr+MJbEmrnlJZWa27lKovMQSh/E9WoRnsxlw9tmIAtpZRGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261988; c=relaxed/simple;
	bh=XcZvcBRuKrbU8qn7VWZqJYcWSVxpS+i8a3E2p7HOhkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzdncdsUlNGayEypHxbfJvCUVc9ZyNJE+j9DdDinvrxtnBhl4znLAHj8h58adu16ITSYVYhyknQAeAqZwMoZHHOPH3VtAG7qtpbkbTSA42hpD9RPeeD/TL97hN5KF/6kKVOdFlkm0ynUdw+0XbvHUUlBoLwqsZR863BSckY8BtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPou3S9b; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a12c19affeso652403e87.1
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773261984; x=1773866784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9P+Ff12iogmg72x3GEhn1ZYf/TicLhf6XdQjN3H5kE=;
        b=kPou3S9bq6DAH5pNc6fPexwr/EEdm0czflhruuU1aH6shTRjfAtPeOkt6gvcXHMmgQ
         BeSBj1tyhvSWE68YANHBh7MrPXTSD6yHMdY3bdoPlErKD8pylx0dc14PrbxQigHzHaIX
         c1JdG58f4zRnkUY3nqtql0gnAMCgWFyA8Ke1+PpdKwHyQiebA52O5YLyRHrmJxMzzMQJ
         Hcc6GlPeYE3ExzDxDBeMwaROJkZ3sRU77V1z9E+T+9YTvlA7jDThfjsy6j4FTDPZ73pf
         db4PKNbgWsnITlaGoiMVlspShozqbrY6amQUahD05vVpqg9+IU+BbTGUtHsZOiJezbQA
         lc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773261984; x=1773866784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s9P+Ff12iogmg72x3GEhn1ZYf/TicLhf6XdQjN3H5kE=;
        b=qxYybQG9OHySjFdjxQia3y8SilJ+iq6x7SMNTSvef7/G5PZHCiazK7iiKxmbvBs6BE
         /jkNoJtMDd+G4UGTS1F3+s6L6zja+701DuTobmXRpuvEhCXKuJOjB/iY2u70soOFl9J3
         GqSjrHcNSgAMv35GBx2bvXY3u8JLVtpALQIwgA4tSDH+ccOiCXoyNbFoMoazMcktLq/O
         2w1McCM/QyGPOBoxi17YG6TKe4oRs3BptWIMXK0PSP0LEr0ORFEpHuDp13VByFKv+QvI
         4jTwimyaGGEAPrpBqVs6PoZzSe5brt0Ij8K5cjRi3LZZ/LYnBZe2UjsfUamNbZTeNE/z
         tZhA==
X-Forwarded-Encrypted: i=1; AJvYcCXVyeqnPNhQKEAjH24J/tyavui7CtHv2abPGe9Yoj9dzkuv/0hSo+Y66v0tFlbgCljKjSi4IyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhSaKCRS3fVTA8GqwnPdJ+F8lUt8mG/O5o2nRS/JVMZZ8oiRnX
	Q2OqcpBOjbNmKacsNzD4jJ91F1/i0SUfuAJ2e4Uso8o2F2Xv/c2Y9rqdiV1lfLlB
X-Gm-Gg: ATEYQzwCQD3BTGYC8WMxUGSgSYRwCaJCf5eqA1k3HoLnTvdXEtz3BAWzNMTpk/WwWsX
	L3qNu4WbNtOrFfxWgkdrHBjWQcphVWYTvFLYgJ5MTd0EjjFD836HM17MV+2tfqRck2OAD+YMsTc
	IsFGMVNVN9RXOP/2GSNigoP3fjjfX55zcnyodqxMxPvK4FHYQhRbDBsNVYiFJkHBJ903Rv6iyhO
	Wf+ekgTvOkMbg88Vk+cK/GkCIeV5CMg/s8sdCKKbdjZHqOavFyP1AcEOC0jTdU10aQeRyb5QC31
	clAeOUkmeU1V0V+kaK5+7LBZEqNVCyZwaUtRW7bXqd2s9V7k0fsB9ErLu1ERLOZTR+4wwwV/UbD
	H4fB9ZMD9oevVsyhF5EG7Z/29IYS1XMmsIgnkSo/fr4mOhXEv1+mRG++N/gulkRt4qijJJLqn3+
	IWI8xL
X-Received: by 2002:a05:6512:39d4:b0:5a1:3d08:cfab with SMTP id 2adb3069b0e04-5a15a4da7camr370067e87.23.1773261983314;
        Wed, 11 Mar 2026 13:46:23 -0700 (PDT)
Received: from router-0001 ([2a01:4f9:3080:2e0f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15602e749sm594670e87.34.2026.03.11.13.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 13:46:22 -0700 (PDT)
From: Alex Dvoretsky <advoretsky@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	kurt@linutronix.de,
	stable@vger.kernel.org,
	Alex Dvoretsky <advoretsky@gmail.com>
Subject: [PATCH net v2] igb: remove napi_synchronize() in igb_down()
Date: Wed, 11 Mar 2026 21:45:15 +0100
Message-ID: <20260311204620.15763-1-advoretsky@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <abEtQwISGizUXIwf@boxer>
References: <abEtQwISGizUXIwf@boxer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,linutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-224758-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[advoretsky@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8871826A269
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When an AF_XDP zero-copy application terminates abruptly (e.g., kill -9),
the XSK buffer pool is destroyed but NAPI polling continues.
igb_clean_rx_irq_zc() repeatedly returns the full budget, preventing
napi_complete_done() from clearing NAPI_STATE_SCHED.

igb_down() calls napi_synchronize() before napi_disable() for each queue
vector. napi_synchronize() spins waiting for NAPI_STATE_SCHED to clear,
which never happens. igb_down() blocks indefinitely, the TX watchdog
fires, and the TX queue remains permanently stalled.

napi_disable() already handles this correctly: it sets NAPI_STATE_DISABLE.
After a full-budget poll, __napi_poll() checks napi_disable_pending(). If
set, it forces completion and clears NAPI_STATE_SCHED, breaking the loop
that napi_synchronize() cannot.

napi_synchronize() was added in commit 41f149a285da ("igb: Fix possible
panic caused by Rx traffic arrival while interface is down").
napi_disable() provides stronger guarantees: it prevents further
scheduling and waits for any active poll to exit.
Other Intel drivers (ixgbe, ice, i40e) use napi_disable() without a
preceding napi_synchronize() in their down paths.

Remove redundant napi_synchronize() call.

Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Dvoretsky <advoretsky@gmail.com>
---
Thanks for the suggestion, Maciej. I tested removing napi_synchronize()
and it fixes the issue cleanly — napi_disable() handles the stuck poll
via NAPI_STATE_DISABLE without needing any hot-path changes.

v2:
  - Replaced 3-patch series with single napi_synchronize() removal,
    per Maciej Fijalkowski's suggestion. napi_disable() handles the
    stuck NAPI poll via NAPI_STATE_DISABLE, making the __IGB_DOWN
    checks in igb_clean_rx_irq_zc() and igb_tx_timeout(), and the
    transition guards in igb_xdp_setup(), all unnecessary.
  - Tested on Intel I210 (igb) with AF_XDP zero-copy: full E2E
    traffic suite, graceful shutdown, and 5x kill-9 stress cycles.
    Zero tx_timeout events.

 drivers/net/ethernet/intel/igb/igb_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 12e8e30d8a2d..a1b3c5e4f7d2 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2203,7 +2203,6 @@ void igb_down(struct igb_adapter *adapter)

 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
-			napi_synchronize(&adapter->q_vector[i]->napi);
 			igb_set_queue_napi(adapter, i, NULL);
 			napi_disable(&adapter->q_vector[i]->napi);
 		}
--
2.51.0


