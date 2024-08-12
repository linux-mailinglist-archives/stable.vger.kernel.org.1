Return-Path: <stable+bounces-66859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F227D94F2CC
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D416B2402E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6BA18734B;
	Mon, 12 Aug 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="llOk2g+v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C58187347;
	Mon, 12 Aug 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479019; cv=none; b=laG4aCjoNm9HBMIl0nU+UTR8J631v8DKlwZpvLSKPfPgkEnzh5xeC7byNprax+c5usqUPTGVR0ww1wkl2tcIa9u3CLMoeVLMgqDPXBQ42OolDdiVzWMHpLj7BD8H1F+fYwHa2ct0wsYarkU0KtZjbOvpAFwpLT7WhAl+x3JOVXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479019; c=relaxed/simple;
	bh=5VpuwUlATsGVhWW7vYhW8xVtVG0Ynunxv3s507DD2GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu447IIslV/sFoQShPFeALsvi0EA2la0SrekYWQZOhwbaszjm/UWlf+yLmQyK8ArvupWx9z3EjBT4oqfWog6hIv2L85He8htEyVRurODA0we/vkpgHdmJyRDIClMobWkgHlYnlXuc9PHzpnT8cPqewcTgRy8S93BVkFva9MNlNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=llOk2g+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8641CC32782;
	Mon, 12 Aug 2024 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479019;
	bh=5VpuwUlATsGVhWW7vYhW8xVtVG0Ynunxv3s507DD2GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llOk2g+vgL80GkRnyCeoQFXFM6OCFfUsZzHRDndBzhiKmJ6DCj9NGaCM6RKO565uK
	 Oc0VCEE0v9V3HbWgHSFO1f1jIGrL5pIhebqfSMlo7g2mUNkuqUuugtPZXP6TVeZwmy
	 DgXfmLFyj5Sd5KL9SmUc/nlAC9hlPYnBLt+mija8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.1 108/150] timekeeping: Fix bogus clock_was_set() invocation in do_adjtimex()
Date: Mon, 12 Aug 2024 18:03:09 +0200
Message-ID: <20240812160129.329056838@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160125.139701076@linuxfoundation.org>
References: <20240812160125.139701076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 5916be8a53de6401871bdd953f6c60237b47d6d3 upstream.

The addition of the bases argument to clock_was_set() fixed up all call
sites correctly except for do_adjtimex(). This uses CLOCK_REALTIME
instead of CLOCK_SET_WALL as argument. CLOCK_REALTIME is 0.

As a result the effect of that clock_was_set() notification is incomplete
and might result in timers expiring late because the hrtimer code does
not re-evaluate the affected clock bases.

Use CLOCK_SET_WALL instead of CLOCK_REALTIME to tell the hrtimers code
which clock bases need to be re-evaluated.

Fixes: 17a1b8826b45 ("hrtimer: Add bases argument to clock_was_set()")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/877ccx7igo.ffs@tglx
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/timekeeping.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2476,7 +2476,7 @@ int do_adjtimex(struct __kernel_timex *t
 		clock_set |= timekeeping_advance(TK_ADV_FREQ);
 
 	if (clock_set)
-		clock_was_set(CLOCK_REALTIME);
+		clock_was_set(CLOCK_SET_WALL);
 
 	ntp_notify_cmos_timer();
 



