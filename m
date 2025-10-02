Return-Path: <stable+bounces-183027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5429BB3419
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 10:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F14854455E
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 08:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B222F6194;
	Thu,  2 Oct 2025 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YREhaQKg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LGw8F6xx"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520562D8364;
	Thu,  2 Oct 2025 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393371; cv=none; b=KbB4o2CcbSB0CTFGFucx+lGtcwORrKmmC6tOCTRtn0FPpXC/JiADIm5QxIYGDzy7MlDGYhcf/LdaSGM2y5091Mg/KYLiycP5JaPJ8ccBxy4lBS62hnnB3N8/Xd7aaRG/wVSQOdVS4skQoa8nBcFT+vgZ2pVbnLjuNiwQcD00804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393371; c=relaxed/simple;
	bh=Rh+vZsuywxgXT5kbbk7FsSWZPFPS/72Dgvm68jbrNqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEpS8RZZLnGm49QilPlEUB8l0v+AGqf8t3jw3hne4/ZLHZ+jRQxszX6eD5U4oZKAm2Z/vTyRn1+ObdqxAcouj8oRFJPqzYazwkyK99flZwRiC9k+VYEhXxr0HDfDWuP+rcEjdx5J0vUn+lyXT22SWwyI4ybjetwp5YMfCFE1qRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YREhaQKg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LGw8F6xx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759393367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rax2zvR/5mLDyta3ww16+HDvwZeDy6hDdlvvfsJS2mc=;
	b=YREhaQKg5AOghGOkPnK06UEkJxAzxmwqF28HqFI/ZWc2JpJLoNyhPBdCsO3sb6kldKz/7b
	4hx5Qh8g2elGzTLAMNYsyQomzSWn0LWsbz9IuXBdl3zD73yY2gMxYH6QKvsZbSPiezcO/4
	QCcrMygpJh15fO+9BATDFOvXFDVoY9ux0EVYI4wu1MVHhpJrShQkROMA40S2oOseNjwqyp
	I0BEU+T0ceGDs6ocQV5aZEUfPTi6gaiosLsRWvhjipu9bomBRJDJqawmZRo0oRE+ToeLdG
	HyjHgMNl2g1N49hV7Ay4kPt6OAB0YDmZ9e9kYy7Gf4+QstncP43SbPyIRY+D+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759393367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rax2zvR/5mLDyta3ww16+HDvwZeDy6hDdlvvfsJS2mc=;
	b=LGw8F6xxLG0bFOq3CIbue8EjHV34+cxiiHA7Y6nPdFGglYp6Khkb/iqzDlHx0aEyinj9ut
	VBoJSFY3xYWW33Bg==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] rv: Fully convert enabled_monitors to use list_head as iterator
Date: Thu,  2 Oct 2025 08:22:35 +0000
Message-ID: <20251002082235.973099-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The callbacks in enabled_monitors_seq_ops are inconsistent. Some treat the
iterator as struct rv_monitor *, while others treat the iterator as struct
list_head *.

This causes a wrong type cast and crashes the system as reported by Nathan.

Convert everything to use struct list_head * as iterator. This also makes
enabled_monitors consistent with available_monitors.

Fixes: de090d1ccae1 ("rv: Fix wrong type cast in enabled_monitors_next()")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/linux-trace-kernel/20250923002004.GA2836051=
@ax162/
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: <stable@vger.kernel.org>
---
 kernel/trace/rv/rv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 48338520376f..43e9ea473cda 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -501,7 +501,7 @@ static void *enabled_monitors_next(struct seq_file *m, =
void *p, loff_t *pos)
=20
 	list_for_each_entry_continue(mon, &rv_monitors_list, list) {
 		if (mon->enabled)
-			return mon;
+			return &mon->list;
 	}
=20
 	return NULL;
@@ -509,7 +509,7 @@ static void *enabled_monitors_next(struct seq_file *m, =
void *p, loff_t *pos)
=20
 static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
 {
-	struct rv_monitor *mon;
+	struct list_head *head;
 	loff_t l;
=20
 	mutex_lock(&rv_interface_lock);
@@ -517,15 +517,15 @@ static void *enabled_monitors_start(struct seq_file *=
m, loff_t *pos)
 	if (list_empty(&rv_monitors_list))
 		return NULL;
=20
-	mon =3D list_entry(&rv_monitors_list, struct rv_monitor, list);
+	head =3D &rv_monitors_list;
=20
 	for (l =3D 0; l <=3D *pos; ) {
-		mon =3D enabled_monitors_next(m, mon, &l);
-		if (!mon)
+		head =3D enabled_monitors_next(m, head, &l);
+		if (!head)
 			break;
 	}
=20
-	return mon;
+	return head;
 }
=20
 /*
--=20
2.51.0


