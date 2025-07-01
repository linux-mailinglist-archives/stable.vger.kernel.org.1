Return-Path: <stable+bounces-159145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A12AEF9F5
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 15:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 166ED7AAF3A
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 13:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225A273D91;
	Tue,  1 Jul 2025 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v6A8ZDSM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bw4fkKkk"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A561A27467A;
	Tue,  1 Jul 2025 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375620; cv=none; b=VILSxU96uEvFxfJFyj7bUGkkMhHGEV+OUgoypFqvh7olEws6hbhCIMT0bFcvz7GZa9W62OIFT9bB2oi2tIPmXH0xYX582tTKX5mHGdKmtQQow5NoaOXmIrx27x62Le+/8MAaLxkPvtFOH2IAC7YsxWH26GMcq1WokZfcQ+wuaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375620; c=relaxed/simple;
	bh=Zltaw00URak9GeEgwVFv4Bd1ZSosQfXDmktsFL+8niA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jgGMTsajRwG7tC9YsA4DF/i2YN99V+gL0slYZfE4Mo8lXLBTdqdff6eS5E0u8hVicgFatUxYYIL0IsHIylBOx4gdhwGcAfqiX1pdDG7GImC0tSg8y4vKql+TfzSNbelu+mwb0xqCf7dSqwWYXvYGCYkCXOhcHi3eYQLL6fyquS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v6A8ZDSM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bw4fkKkk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Jul 2025 13:13:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751375617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvtI0DmMWLEjDJjj1u4uMpHmrQUBwBqWCR9zqd1OlSk=;
	b=v6A8ZDSMSRQ5ob1EPUOufXnv+V82H+Tixgl0tllYqGejGUgh62ylymeoF1iJcUzBQC24ir
	Z99PsqmHY8xp+3OEf/bEBLc8/x/n6941eBn2MaD8OGjrvhfZ00tTQUmESG143+iL1D1peb
	MXDbdsaDEiN07pR8MDcDRkBH6cs2mXl8+QTO4ADEGPQ0QeBN9yuO1lh5jL15p8lXjd9tAb
	7VUklwEZPDxokMuYjeEt3tgAKJJ85RjVk6IRdcl/wof5MVUh0iONPH/88Sj1NF0Ll6e0ia
	+byGRsJsgjZEPYAREbherBkAKq9i6AOwVo87xbxGU8JONnjOV9nY246RoJMFNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751375617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvtI0DmMWLEjDJjj1u4uMpHmrQUBwBqWCR9zqd1OlSk=;
	b=bw4fkKkkB6ltF8TrhIf69htfd1AvDrRr4NzPxxSRux4rtk91n3oe8nK9QCXFE5RRuFj4MU
	hONG9g6hYNIqcdBQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched: Fix preemption string of preempt_dynamic_none
Cc: thomas.weissschuh@linutronix.de,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250626-preempt-str-none-v2-1-526213b70a89@linutronix.de>
References: <20250626-preempt-str-none-v2-1-526213b70a89@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175137561585.406.15071962076426718884.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     3ebb1b6522392f64902b4e96954e35927354aa27
Gitweb:        https://git.kernel.org/tip/3ebb1b6522392f64902b4e96954e3592735=
4aa27
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 26 Jun 2025 11:23:44 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Jul 2025 15:02:02 +02:00

sched: Fix preemption string of preempt_dynamic_none

Zero is a valid value for "preempt_dynamic_mode", namely
"preempt_dynamic_none".

Fix the off-by-one in preempt_model_str(), so that "preempty_dynamic_none"
is correctly formatted as PREEMPT(none) instead of PREEMPT(undef).

Fixes: 8bdc5daaa01e ("sched: Add a generic function to return the preemption =
string")
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250626-preempt-str-none-v2-1-526213b70a89@l=
inutronix.de
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8988d38..cd80b66 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7663,7 +7663,7 @@ const char *preempt_model_str(void)
=20
 		if (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC)) {
 			seq_buf_printf(&s, "(%s)%s",
-				       preempt_dynamic_mode > 0 ?
+				       preempt_dynamic_mode >=3D 0 ?
 				       preempt_modes[preempt_dynamic_mode] : "undef",
 				       brace ? "}" : "");
 			return seq_buf_str(&s);

