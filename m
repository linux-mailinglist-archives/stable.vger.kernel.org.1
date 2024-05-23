Return-Path: <stable+bounces-45945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8A28CD4AC
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCCC2810E3
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A323B13C66A;
	Thu, 23 May 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bpPU7Pd4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623441D545;
	Thu, 23 May 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470815; cv=none; b=EI4PNXQ5xWyERIMYGb2YCWN6lcbsEzrnaWw9FEvBijQ/MQyGiCAvOWTQJ7/66WQZDIuOuX4z9qwBSkTlgSVhPBOzkv16e0jZN++wdJrOA3eywY2Uoq0el+aBOqo5wKCuATEAQk52tBDXyYi8TqjWAvGmO+GhkmEoS1ItyP82YOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470815; c=relaxed/simple;
	bh=v3/1w+Ix7o4P1xji5rjpWpUu2GREbVJx3AxXGKpH0cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVarpUkge5wuyOCiLY2Vqaw+bm50b5O/ONbOP96DQZJom6SeKkzAOk0vxdTMUll4t+tqAOBc4IkLQmWrt03xkYxww3+NX7GcwUv9j1wGNoJVFgFjNW3Dac6S75tLg8n+AOD8OfLU5lftPv7R2fo2XoI9pyBAgG7zCmB4AnLA5yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bpPU7Pd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C44C2BD10;
	Thu, 23 May 2024 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470815;
	bh=v3/1w+Ix7o4P1xji5rjpWpUu2GREbVJx3AxXGKpH0cA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bpPU7Pd4+nh230tKrtjaiEnuAd4YrrfC8YS7hXTJm+yIvmLqj/mJYWae8+7YPR4C6
	 AXVxAETKgBuAyz8jUnu8/G285KCpQZL+TqyWoX9wChNwcZ8lHzN0M7TQ5H3PmcpEnA
	 yDFAeYpw8lbOVure50llQYvYEy4ZxR2hqshuUNOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Chris Hyser <chris.hyser@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 6.6 098/102] admin-guide/hw-vuln/core-scheduling: fix return type of PR_SCHED_CORE_GET
Date: Thu, 23 May 2024 15:14:03 +0200
Message-ID: <20240523130346.170373785@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130342.462912131@linuxfoundation.org>
References: <20240523130342.462912131@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <linux@weissschuh.net>

commit 8af2d1ab78f2342f8c4c3740ca02d86f0ebfac5a upstream.

sched_core_share_pid() copies the cookie to userspace with
put_user(id, (u64 __user *)uaddr), expecting 64 bits of space.
The "unsigned long" datatype that is documented in core-scheduling.rst
however is only 32 bits large on 32 bit architectures.

Document "unsigned long long" as the correct data type that is always
64bits large.

This matches what the selftest cs_prctl_test.c has been doing all along.

Fixes: 0159bb020ca9 ("Documentation: Add usecases, design and interface for core scheduling")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/util-linux/df7a25a0-7923-4f8b-a527-5e6f0064074d@t-8ch.de/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Link: https://lore.kernel.org/r/20240423-core-scheduling-cookie-v1-1-5753a35f8dfc@weissschuh.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/hw-vuln/core-scheduling.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -67,8 +67,8 @@ arg4:
     will be performed for all tasks in the task group of ``pid``.
 
 arg5:
-    userspace pointer to an unsigned long for storing the cookie returned by
-    ``PR_SCHED_CORE_GET`` command. Should be 0 for all other commands.
+    userspace pointer to an unsigned long long for storing the cookie returned
+    by ``PR_SCHED_CORE_GET`` command. Should be 0 for all other commands.
 
 In order for a process to push a cookie to, or pull a cookie from a process, it
 is required to have the ptrace access mode: `PTRACE_MODE_READ_REALCREDS` to the



