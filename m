Return-Path: <stable+bounces-163706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10525B0D9C9
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F033B052D
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502A32E92BD;
	Tue, 22 Jul 2025 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PGb3ZP68";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f1kTWZ2p"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A922E3AE4;
	Tue, 22 Jul 2025 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187844; cv=none; b=LNRzMKH2FhvVkb3NL/N3fzsQ7RutPBfIg7IDa/VB6jXfJ3kENz57jFlWoLVWig3cSaWwmwKc2sgesfSLt74MVJHKjvduv7lKAb/LCaMqdp/rYFa/onVR41xs+nz0ey2rzvo6kFds9/8T3PDnkPD48h9xylYTxT+5G9QbZYQwkd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187844; c=relaxed/simple;
	bh=bGhKMVHdpFfrLajjJU9NNrRCtCrMdUhBZrHf2+KD1eQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oKlIPAk8z2tQE1CZwww6v+WXzCLFOLsK0KRhh3ENL8/crT5cvt423wRl5tE/h+NwxVhRmsFdMNczIGhG6AH5mzRkC5DMKhaA52IlJoHmC+vN5nppNOksXYnSRk8JIGF+zD8vhppGXe+n4NpvbT8DhIQGHmv5jb8aSQ88zcQVZYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PGb3ZP68; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f1kTWZ2p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Jul 2025 12:37:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753187839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSN+57bUdSAASPNRSh7B8cTDUyZPdO1WhS/qa0EAPCs=;
	b=PGb3ZP68N7zk43qgOaREf5k+W30nHqdz3JqfHmEf22VnydB5Mk8clFyyF8JCRydmbbGUL9
	GTiWHO7g5LEzz19VEXlv/oh9HCIuHIvc+ow6lerHGdvFxcnJhVHtopi+r/qYhzn9xUr1y3
	0PQpriMq2ZYc4UZooyUku/x0YueBTs4x9YVTy/j3aQAkluG3puIaH06nUtRbIlBZKP76Vf
	H/q73oVaB6ts63jHWQRrS0qi9y2iIUKQ2X6hbiEz3fAxXI33e8XaIDkxFKUhqc2pU/uNRH
	MxecUSja0hjFJqik6ezqAC6gF2f6fDV2UNlj61kDh9gUlMhYgJx7nbvP+iZQYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753187839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSN+57bUdSAASPNRSh7B8cTDUyZPdO1WhS/qa0EAPCs=;
	b=f1kTWZ2pa0GOJR5LwbBvxQVYhUPUyG86MyE5aNdBI5KBd968EZXJrVy3GAjnI0U+oZoj6v
	+jl8u6sknWOWGYCg==
From: tip-bot2 for Markus =?utf-8?q?Bl=C3=B6chl?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping: Zero initialize system_counterval
 when querying time from phc drivers
Cc: markus@blochl.de, Thomas Gleixner <tglx@linutronix.de>,
 John Stultz <jstultz@google.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250720-timekeeping_uninit_crossts-v2-1-f513c885b7c2@blochl.de>
References: <20250720-timekeeping_uninit_crossts-v2-1-f513c885b7c2@blochl.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175318783799.1420.6062932319598101589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     67c632b4a7fbd6b76a08b86f4950f0f84de93439
Gitweb:        https://git.kernel.org/tip/67c632b4a7fbd6b76a08b86f4950f0f84de=
93439
Author:        Markus Bl=C3=B6chl <markus@blochl.de>
AuthorDate:    Sun, 20 Jul 2025 15:54:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jul 2025 14:25:21 +02:00

timekeeping: Zero initialize system_counterval when querying time from phc dr=
ivers

Most drivers only populate the fields cycles and cs_id of system_counterval
in their get_time_fn() callback for get_device_system_crosststamp(), unless
they explicitly provide nanosecond values.

When the use_nsecs field was added to struct system_counterval, most
drivers did not care.  Clock sources other than CSID_GENERIC could then get
converted in convert_base_to_cs() based on an uninitialized use_nsecs field,
which usually results in -EINVAL during the following range check.

Pass in a fully zero initialized system_counterval_t to cure that.

Fixes: 6b2e29977518 ("timekeeping: Provide infrastructure for converting to/f=
rom a base clock")
Signed-off-by: Markus Bl=C3=B6chl <markus@blochl.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250720-timekeeping_uninit_crossts-v2-1-f5=
13c885b7c2@blochl.de

---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index a009c91..83c65f3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1256,7 +1256,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 				  struct system_time_snapshot *history_begin,
 				  struct system_device_crosststamp *xtstamp)
 {
-	struct system_counterval_t system_counterval;
+	struct system_counterval_t system_counterval =3D {};
 	struct timekeeper *tk =3D &tk_core.timekeeper;
 	u64 cycles, now, interval_start;
 	unsigned int clock_was_set_seq =3D 0;

