Return-Path: <stable+bounces-87779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9659AB91C
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 23:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34EC1C22EBB
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 21:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E75B1CEAB2;
	Tue, 22 Oct 2024 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aXjBu+Ot";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CHNQSvKC"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92081BCA19;
	Tue, 22 Oct 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634037; cv=none; b=mwbjZjCybkMKDHvcqiDX8/VpUHfxfBNEHzCzSr9kj0V1ng7zhGzHs0Ww55fE5kZwFnNhZMDq7zrWiFRnYV46ToKD+ihdfJRtlAS1Vc7qEDVtsQoyW5Gad4MrOBFksnLzsx0umBnhj1q83/UFYFBIl0zu15ITgsD212RvANfFFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634037; c=relaxed/simple;
	bh=yNhlqtA5xfbHqN41tlsJm8nfUPmh7DgH5LI52TrsbmI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=q3eU1aMI9kA7/jGYWXO6I7hNOxkmunQOsAFRD0G9dzMvxgT+erAT0s93uCKNBU7V5BldN++MytNhxyuvQcjjU5of6VTesJLWxt1z8xfjxuVmHBrGCG0RZ3RRP0H+NqzGsIfdem1qiwgx0bR1ArcHFLcTCAUDHUta6GrMQ3uHtbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aXjBu+Ot; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CHNQSvKC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Oct 2024 21:53:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729634034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qS94Uvne5lMzZuSP6I9KuEYUZabmOozzLI7+Tv2vgBw=;
	b=aXjBu+OtAYH6Ku9Esa5bCAxiAGsNBQb91Y8KIURBqMtKyy74p0cAbOSZVVvlqgnDxawagu
	rLDGgg5qIX9cwSIcgGKYC8Yj9WUI7Y8/u2PV5xjA/1aLo+EEG5HLlcjkEoUR73NTCwAqOh
	e9w9G7YEtciisvmY9A8BS3w361okOH846R9hgl/xaulq8X3YpZIgAr4SzpkfNpvvrz6/I2
	FPtUsySVvnsE3jQDXbNBAWr/QatgVBEp+pxi7M6oBd3p8clgQ8jPh/EUi4dFFkSquW5vIz
	gWcRsZZyaXjHAls3EsKkP/mvDJH6QbaOw53+p+yFqGm8tErM+td1olQ76L0M9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729634034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qS94Uvne5lMzZuSP6I9KuEYUZabmOozzLI7+Tv2vgBw=;
	b=CHNQSvKCg36sv8AEeUO3Bw5C/bxtVfkWFoDgGSDglXvxiE0o7niuz9RBxXEqnLEZCyKozq
	eqNF+APZKIHHTFDQ==
From: "tip-bot2 for Ahmed Ehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Avoid creating new name string
 literals in lockdep_set_subclass()
Cc:  <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>,
 stable@vger.kernel.org, Ahmed Ehab <bottaawesome633@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172963403329.1442.9197378305906823159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d7fe143cb115076fed0126ad8cf5ba6c3e575e43
Gitweb:        https://git.kernel.org/tip/d7fe143cb115076fed0126ad8cf5ba6c3e575e43
Author:        Ahmed Ehab <bottaawesome633@gmail.com>
AuthorDate:    Sun, 25 Aug 2024 01:10:30 +03:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Thu, 17 Oct 2024 20:07:23 -07:00

locking/lockdep: Avoid creating new name string literals in lockdep_set_subclass()

Syzbot reports a problem that a warning will be triggered while
searching a lock class in look_up_lock_class().

The cause of the issue is that a new name is created and used by
lockdep_set_subclass() instead of using the existing one. This results
in a lock instance has a different name pointer than previous registered
one stored in lock class, and WARN_ONCE() is triggered because of that
in look_up_lock_class().

To fix this, change lockdep_set_subclass() to use the existing name
instead of a new one. Hence, no new name will be created by
lockdep_set_subclass(). Hence, the warning is avoided.

[boqun: Reword the commit log to state the correct issue]

Reported-by: <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
Fixes: de8f5e4f2dc1f ("lockdep: Introduce wait-type checks")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/lkml/20240824221031.7751-1-bottaawesome633@gmail.com/
---
 include/linux/lockdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 217f7ab..67964dc 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -173,7 +173,7 @@ static inline void lockdep_init_map(struct lockdep_map *lock, const char *name,
 			      (lock)->dep_map.lock_type)
 
 #define lockdep_set_subclass(lock, sub)					\
-	lockdep_init_map_type(&(lock)->dep_map, #lock, (lock)->dep_map.key, sub,\
+	lockdep_init_map_type(&(lock)->dep_map, (lock)->dep_map.name, (lock)->dep_map.key, sub,\
 			      (lock)->dep_map.wait_type_inner,		\
 			      (lock)->dep_map.wait_type_outer,		\
 			      (lock)->dep_map.lock_type)

