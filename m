Return-Path: <stable+bounces-154558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB951ADDAAC
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1420A1886BF6
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24144224220;
	Tue, 17 Jun 2025 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gptwfej2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183812046B3
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181230; cv=none; b=uw/1Nrn+RUSLCGcugx/mDm6Nr3mEFkdzw8PSiiQdJRMfCLDaa6N6vN1HY2ziuQ4wZD8PyGxA/cnr6HTYSvsyz68E85HFkdSKqrmwt+SyMSpWOJ6VcYWM2Ihsu7foIGftPU+0b5kDwC09FXZ/uxRg1NfA9k+ibyxKAYdQ0mHYugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181230; c=relaxed/simple;
	bh=fkOjroXdX6GBhq4CcrKYPV1tmEy1+MgMGmfMV6y0QYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfV9/fNTksb68EAqI8hQGxDZR+uHIKrkZhUNoPmJqcgiilcL1bz/ARGkRTrsZd2X94dixqkkL7sXFNQInc2TU/kXumSUtAP1cmxCqdZ+AavBWUarsfaCSizF2sGDWMhgj5Mp9IrJIupQa/3VNlSp2mHYQQAZ+GjEDCf4GZ1MyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gptwfej2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750181227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4M4M1fZ6z4P0+p9GRKn9ol39qCtvalplEGP1i4fV4/8=;
	b=gptwfej2aqvYHEn9epx8+LVdzO4oexr7gGwsrgssZcG1RW8JsOixmh/zCjNHiuZh+aUA++
	/h49SQXAa6FvFILndGENbFN79AcS5VP0HWjlRLtBkdQiUsuAKS82yd6VMdH9abuEDN05lW
	eC2Zhlm8MGY7E2UFy0oJ5PPf+PzInzg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-Z5j1WKLaMwSmI2YvvRyoeA-1; Tue,
 17 Jun 2025 13:27:03 -0400
X-MC-Unique: Z5j1WKLaMwSmI2YvvRyoeA-1
X-Mimecast-MFC-AGG-ID: Z5j1WKLaMwSmI2YvvRyoeA_1750181222
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19C971800292;
	Tue, 17 Jun 2025 17:27:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 50C5A19560A3;
	Tue, 17 Jun 2025 17:27:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 17 Jun 2025 19:26:18 +0200 (CEST)
Date: Tue, 17 Jun 2025 19:26:14 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: gregkh@linuxfoundation.org
Cc: bsevens@google.com, torvalds@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] posix-cpu-timers: fix race between
 handle_posix_cpu_timers()" failed to apply to 5.4-stable tree
Message-ID: <20250617172613.GA19542@redhat.com>
References: <2025061744-precinct-rubble-45c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025061744-precinct-rubble-45c9@gregkh>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 06/17, gregkh@linuxfoundation.org wrote:
>
> The patch below does not apply to the 5.4-stable tree.

Please see the attached patch for 5.4.y

Oleg.

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="0001-posix-cpu-timers-fix-race-between-handle_posix_cpu_t.patch"
Content-Transfer-Encoding: 8bit

From a3dbb5447bc9a8f9c04ffa5381b0a0bd77b1bdd5 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Tue, 17 Jun 2025 19:15:50 +0200
Subject: [PATCH 5.4.y] posix-cpu-timers: fix race between
 handle_posix_cpu_timers() and posix_cpu_timer_del()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit f90fff1e152dedf52b932240ebbd670d83330eca upstream.

If an exiting non-autoreaping task has already passed exit_notify() and
calls handle_posix_cpu_timers() from IRQ, it can be reaped by its parent
or debugger right after unlock_task_sighand().

If a concurrent posix_cpu_timer_del() runs at that moment, it won't be
able to detect timer->it.cpu.firing != 0: cpu_timer_task_rcu() and/or
lock_task_sighand() will fail.

Add the tsk->exit_state check into run_posix_cpu_timers() to fix this.

This fix is not needed if CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y, because
exit_task_work() is called before exit_notify(). But the check still
makes sense, task_work_add(&tsk->posix_cputimers_work.work) will fail
anyway in this case.

Cc: stable@vger.kernel.org
Reported-by: Benoît Sevens <bsevens@google.com>
Fixes: 0bdd2ed4138e ("sched: run_posix_cpu_timers: Don't check ->exit_state, use lock_task_sighand()")
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 kernel/time/posix-cpu-timers.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index eacb0ca30193..c77433047a9d 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1119,6 +1119,15 @@ void run_posix_cpu_timers(void)
 
 	lockdep_assert_irqs_disabled();
 
+	/*
+	 * Ensure that release_task(tsk) can't happen while
+	 * handle_posix_cpu_timers() is running. Otherwise, a concurrent
+	 * posix_cpu_timer_del() may fail to lock_task_sighand(tsk) and
+	 * miss timer->it.cpu.firing != 0.
+	 */
+	if (tsk->exit_state)
+		return;
+
 	/*
 	 * The fast path checks that there are no expired thread or thread
 	 * group timers.  If that's so, just return.
-- 
2.25.1.362.g51ebf55


--liOOAslEiF7prFVr--


