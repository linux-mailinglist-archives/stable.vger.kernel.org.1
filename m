Return-Path: <stable+bounces-71555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B63B9656A3
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 07:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C31C4B2378C
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 05:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6391422B1;
	Fri, 30 Aug 2024 05:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="SpPccA1K"
X-Original-To: stable@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492551D1301
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 05:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724994246; cv=none; b=jIu2mPxqtwFSnKSUYGZTeiw+AJ0VVBuvybd8g5B37OqLMr4pwKnwe0kXcDKc+Ti1JBQIoa4AkW/xLm0ShacKXqtBAlU9Ceh54BFx6WPrXlZPnZP8iF2fPhqYwLzPm5zLt97pFatXhSUx1vP4MP8vYYBvOnITiQxrDSmxttjjPco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724994246; c=relaxed/simple;
	bh=HJIBHsb+pG4OJ3YHQjLLneMy7DBgN37FKEWs1Hsxxto=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GipaRrYNyrO+JnymuF2MhszOgnyWUqJQHpWvEquiYcMnrI/h/bC+8o4gTxS7i8Dx206BLJmldPuuF/BvuSZ/k6Rwcp8/EfFWW9owHMRQu0N3MnJfoE42uUcOndJEr1rzBfaLTc1O5C4ORFlmzV4DvcFHwpAltQQSCtZjRDVh484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=SpPccA1K; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1724994242; x=1725253442;
	bh=Lkl/4iBF6JIYsf4lrgb1MIvDWPSfZ6J3feAMHghzPp4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SpPccA1Kkd6uWpYxovbtlT2At5q3Oh3huitfEbEoYnloKiwodx5StzOfd8jTUQDA/
	 FtYZrGIjG1rs/pBadAzswQtHAlTfKRevwGq60VmkQxwq2RXaXtGZiQPUt5G+6yPjBS
	 LXC5Hy2s5eY7eGRokL+vm7xp4TU8pP14VKkIhpKr3mbinmDxhRlBGemoKAT+rbDKJe
	 vGU+ILje5Ee/br0BYDICGwjtv4WU8P30A7ut2cC2Gw4hOm2fi9tqCdza9yN7QX6n3c
	 VLuVY+eW7QsLMjYCXM8c6zOGvDvRdcOgyEXENBeRN7qh2scKTO2K9FH2aPpXe0TzyH
	 E3ZTb5JY8hyFw==
Date: Fri, 30 Aug 2024 05:03:56 +0000
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>
From: Michael Pratt <mcpratt@pm.me>
Cc: linux-kernel@vger.kernel.org, Michael Pratt <mcpratt@pm.me>, stable@vger.kernel.org
Subject: [PATCH] sched/syscalls: Allow setting niceness using sched_param struct
Message-ID: <20240830050238.30420-1-mcpratt@pm.me>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: 2c3c6e397f48f7704fd857406eb15900762cb796
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From userspace, spawning a new process with, for example,
posix_spawn(), only allows the user to work with
the scheduling priority value defined by POSIX
in the sched_param struct.

However, sched_setparam() and similar syscalls lead to
__sched_setscheduler() which rejects any new value
for the priority other than 0 for non-RT schedule classes,
a behavior kept since Linux 2.6 or earlier.

Linux translates the usage of the sched_param struct
into it's own internal sched_attr struct during the syscall,
but the user has no way to manage the other values
within the sched_attr struct using only POSIX functions.

The only other way to adjust niceness while using posix_spawn()
would be to set the value after the process has started,
but this introduces the risk of the process being dead
before the next syscall can set the priority after the fact.

To resolve this, allow the use of the priority value
originally from the POSIX sched_param struct in order to
set the niceness value instead of rejecting the priority value.

Edit the sched_get_priority_*() POSIX syscalls
in order to reflect the range of values accepted.

Cc: stable@vger.kernel.org # Apply to kernel/sched/core.c
Signed-off-by: Michael Pratt <mcpratt@pm.me>
---
 kernel/sched/syscalls.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ae1b42775ef9..52c02b80f037 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -853,6 +853,19 @@ static int _sched_setscheduler(struct task_struct *p, =
int policy,
 =09=09attr.sched_policy =3D policy;
 =09}
=20
+=09if (attr.sched_priority > MAX_PRIO-1)
+=09=09return -EINVAL;
+
+=09/*
+=09 * If priority is set for SCHED_NORMAL or SCHED_BATCH,
+=09 * set the niceness instead, but only for user calls.
+=09 */
+=09if (check && attr.sched_priority > MAX_RT_PRIO-1 &&
+=09   ((policy !=3D SETPARAM_POLICY && fair_policy(policy)) || fair_policy=
(p->policy))) {
+=09=09attr.sched_nice =3D PRIO_TO_NICE(attr.sched_priority);
+=09=09attr.sched_priority =3D 0;
+=09}
+
 =09return __sched_setscheduler(p, &attr, check, true);
 }
 /**
@@ -1598,9 +1611,11 @@ SYSCALL_DEFINE1(sched_get_priority_max, int, policy)
 =09case SCHED_RR:
 =09=09ret =3D MAX_RT_PRIO-1;
 =09=09break;
-=09case SCHED_DEADLINE:
 =09case SCHED_NORMAL:
 =09case SCHED_BATCH:
+=09=09ret =3D MAX_PRIO-1;
+=09=09break;
+=09case SCHED_DEADLINE:
 =09case SCHED_IDLE:
 =09=09ret =3D 0;
 =09=09break;
@@ -1625,9 +1640,11 @@ SYSCALL_DEFINE1(sched_get_priority_min, int, policy)
 =09case SCHED_RR:
 =09=09ret =3D 1;
 =09=09break;
-=09case SCHED_DEADLINE:
 =09case SCHED_NORMAL:
 =09case SCHED_BATCH:
+=09=09ret =3D MAX_RT_PRIO;
+=09=09break;
+=09case SCHED_DEADLINE:
 =09case SCHED_IDLE:
 =09=09ret =3D 0;
 =09}

base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
--=20
2.30.2



