Return-Path: <stable+bounces-132207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1687BA8558F
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 09:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F08E468205
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 07:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF8428D838;
	Fri, 11 Apr 2025 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OcCm9IfO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="82Ba8Mym"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1231EFF9F;
	Fri, 11 Apr 2025 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357089; cv=none; b=bCadaqQrJZBmVgEPwwUrKBnLy16BNkBn2rvQUKwah12HTBZGC/rL9TKYlNcwJ1U+j3gIL11TfuiLoaEGIx5n60OPJcEgGMnE21EQewJLz42eYbczBXknKtOLP28ice2aLgaatnURSvoyeImZX8WP5GD/NSrPnpXA69VdVVZctmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357089; c=relaxed/simple;
	bh=kP7Qc2Kk+6spiyf5wu/9CUlZRshIhHpxl2AyE4vpSYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D5sqIhVII9lKSRxCoOTam9uAHp5R/iZojinEtB3oeKDKlxOWM/1eALJkXIZwvp0tYlVqIZIhwInKCZHeb3dfX8GY9Fg9fNObKv32gyIbaWt7+HIUHhx5U93mWemvdtQdoDiTaKvDl9ncdoIiPDFnYODSDTndLw7xO8TlxxwbCX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OcCm9IfO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=82Ba8Mym; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744357086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R69BKFZ/X7gOuR6lw+BNy+4jgpSDRBZOyCINRsZoZyA=;
	b=OcCm9IfOubBz8mreRq05rv43e9y4Rr9l7TbvIphrygSbL2ZLQnIWzpPLvO0ieIhpCZUwH0
	LGp7tDNuuREhDszqHGI5ee/LqRSACqupsoRsDCqbXKh0rQjqyNPEhwh7YRRlLyJtCkgXcn
	1k9mbcUGFZkyA7URHsIPiJvjmYRihM7APUuYjzkgpjPXFgDbLCfRnIjpgxjb/LFdbSUDG2
	R8s7Q8TYcwS75KLayu3UEZr5n8mt2YaCymPQM3Kt0DIWxeD21GCikjvBma17EoLUaw4En7
	Ov6fz9kHdSHc9Jkl8yAtqrp2qtXc8IwD+rcoYUUjvjVnJwQWJhaqInpp19DZBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744357086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R69BKFZ/X7gOuR6lw+BNy+4jgpSDRBZOyCINRsZoZyA=;
	b=82Ba8MymXu4oqcKU7ce26Yj8XsAAKsmvgx4STxnT/D5QfNP38d3T29i9eAM5xnx0F8L1Ig
	rsQQPMDGYFTBiMAQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/22] rv: Fix out-of-bound memory access in rv_is_container_monitor()
Date: Fri, 11 Apr 2025 09:37:17 +0200
Message-Id: <e85b5eeb7228bfc23b8d7d4ab5411472c54ae91b.1744355018.git.namcao@linutronix.de>
In-Reply-To: <cover.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When rv_is_container_monitor() is called on the last monitor in
rv_monitors_list, KASAN yells:

  BUG: KASAN: global-out-of-bounds in rv_is_container_monitor+0x101/0x110
  Read of size 8 at addr ffffffff97c7c798 by task setup/221

  The buggy address belongs to the variable:
   rv_monitors_list+0x18/0x40

This is due to list_next_entry() is called on the last entry in the list.
It wraps around to the first list_head, and the first list_head is not
embedded in struct rv_monitor_def.

Fix it by checking if the monitor is last in the list.

Fixes: cb85c660fcd4 ("rv: Add option for nested monitors and include sched")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
 kernel/trace/rv/rv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 50344aa9f7f9..544acb1f6a33 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -225,7 +225,12 @@ bool rv_is_nested_monitor(struct rv_monitor_def *mdef)
  */
 bool rv_is_container_monitor(struct rv_monitor_def *mdef)
 {
-	struct rv_monitor_def *next =3D list_next_entry(mdef, list);
+	struct rv_monitor_def *next;
+
+	if (list_is_last(&mdef->list, &rv_monitors_list))
+		return false;
+
+	next =3D list_next_entry(mdef, list);
=20
 	return next->parent =3D=3D mdef->monitor || !mdef->monitor->enable;
 }
--=20
2.39.5


