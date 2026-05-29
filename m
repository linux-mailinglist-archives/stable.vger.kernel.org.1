Return-Path: <stable+bounces-256727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP/nKV3kGWrwzggAu9opvQ
	(envelope-from <stable+bounces-256727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:09:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0787F607BA7
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 040233010381
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21262409DEA;
	Fri, 29 May 2026 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YeUUfS4V"
X-Original-To: stable@vger.kernel.org
Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23827400E18;
	Fri, 29 May 2026 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081751; cv=none; b=speZTBCxiZdwjmcAY+sd8Ll1bHKhohfApNeHUD6ICDTO6b+UdRFBNpWebDQtUF2+t+t/6/5QDz9vIU/qFIHoJr4aTbwkDHGIXY6I0EEn6q5jnguqcrTQPiLtIUudfGlBOnkKLGLWPMlXzGih2XIdL/VeMyWIohtMttIzO/7G8y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081751; c=relaxed/simple;
	bh=opC0gMwPEsmTM2N/gM3BOfbVqzREKn0u2JT22bLSV04=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pNCgLsCgip1RpnAEdAaA79NlgOuHKkuea5KDdnXy6wJhC/JPyK3u5Ho5M74K4xz9qrSej+hCp2hqktZ160MAMggaL1y+CVcwlabMBU9vJpLAnPea2gQLaGgUV4i9pD2BzdmwUsz38/1q1l9/dIAE3+RMPi/Gr+g6iG518qmf1R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YeUUfS4V; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780081738; x=1780340938;
	bh=3hr3qdcBGYK554CDsE4HYFcczeAv8NQeKv6MfOl7sJg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=YeUUfS4VVRdIZObyYUAzls8wiXinlXroLcHfek6uXFlB4eQPVwc5KKMy3NblZLD4x
	 XODkPrBWQ8HjxLWuh0qRPll5wmrRoOpPvB22G1bOVmInrNfjvtMqrWrRFjqOG3Fxvd
	 CEkdBYqNtLX/0fwNd4UCEg5iN2wtL/mweRsrZEbQdTqp02K25Q8ku6Z3g+5Wt6U/IZ
	 62I/DkI+memMb3qFISKchPfuL3pLk2xeh8SpD+0OjbPSSuf+jCwxD71qkudK1uNtVd
	 cifCRRG02hg2to+LVe5WZSCVx6+VV7t7CPv/EziyUF4pf6kd8mKKz7DwCTeLV+1Px6
	 HLLNfixC4xQ+A==
Date: Fri, 29 May 2026 19:08:54 +0000
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
From: hexlabsecurity@proton.me
Cc: Justin Suess <utilityemal77@gmail.com>, "gnoack@google.com" <gnoack@google.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 2/2] selftests/landlock: test SCOPE_SIGNAL on the SIGIO/fowner pgid path
Message-ID: <rkLwwfwoJDv5kWjZc3IsAe8jp10yDh_yxWl4ryf_D6t47XsW4lKPdGQ8osUdvdu-Z2Dmd9AIMaxGt4hNApk2Ls6V4yej_Be9KA_qkvanaHo=@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: a407fec85fbebfd6c96dbd7b3da15d8e3171fe24
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-256727-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[proton.me:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:email,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: 0787F607BA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From 06174d6988915949342c86fe4d1ee210571a2321 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Fri, 29 May 2026 12:51:27 -0500
Subject: [PATCH v3 2/2] selftests/landlock: test SCOPE_SIGNAL on the
 SIGIO/fowner pgid path

Add a regression test for the LANDLOCK_SCOPE_SIGNAL bypass on the
asynchronous SIGIO delivery path.  A sandboxed task that owns a file via
fcntl(F_SETOWN, -pgrp) while sitting at the head of its process group's
PID hlist (the default position after fork()) used to have its Landlock
subject capture skipped, letting the SIGIO fan-out reach non-sandboxed
members of the process group.

The test creates a dedicated process group, sandboxes the (hlist-head)
child with LANDLOCK_SCOPE_SIGNAL, arms F_SETSIG(SIGURG) / F_SETOWN(-pgrp)
/ O_ASYNC on a pipe and triggers the fan-out.  The in-domain child must
receive the signal (proving the trigger fired); the non-sandboxed parent,
which is outside the child's domain, must not.  Without the fix the parent
is signaled and the test fails.

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 .../selftests/landlock/scoped_signal_test.c   | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/=
testing/selftests/landlock/scoped_signal_test.c
index d8bf33417619..05151929c263 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -559,4 +559,101 @@ TEST_F(fown, sigurg_socket)
 =09=09_metadata->exit_code =3D KSFT_FAIL;
 }
=20
+/*
+ * Checks that LANDLOCK_SCOPE_SIGNAL is enforced on the asynchronous SIGIO
+ * delivery path (fcntl(F_SETOWN)) when the file owner is a process group.
+ *
+ * A sandboxed task sitting at the head of its process group's PID hlist (=
the
+ * default position right after fork()) used to escape the
+ * fcntl(F_SETOWN, -pgrp) subject capture: pid_task(pgrp, PIDTYPE_PGID)
+ * resolved to the task itself, so the same-thread-group exemption skipped
+ * recording its Landlock domain.  At SIGIO time the cached subject was th=
en
+ * empty and the signal fanned out to every group member, including
+ * non-sandboxed tasks outside the domain.
+ */
+TEST(sigio_to_pgid_members)
+{
+=09int trigger[2], sync_child[2];
+=09char buf;
+=09pid_t child;
+=09int status, i;
+
+=09drop_caps(_metadata);
+
+=09/*
+=09 * Isolates the test in its own process group so the SIGIO fan-out
+=09 * stays bounded to this parent and the child forked below.
+=09 */
+=09ASSERT_EQ(0, setpgid(0, 0));
+
+=09/* The non-sandboxed parent is the protected (out-of-domain) target. */
+=09ASSERT_EQ(0, setup_signal_handler(SIGURG));
+=09signal_received =3D 0;
+
+=09ASSERT_EQ(0, pipe2(trigger, O_CLOEXEC));
+=09ASSERT_EQ(0, pipe2(sync_child, O_CLOEXEC));
+
+=09child =3D fork();
+=09ASSERT_LE(0, child);
+=09if (child =3D=3D 0) {
+=09=09/*
+=09=09 * The child inherits the parent's new process group and, just
+=09=09 * attached with hlist_add_head_rcu(), is now the head of the
+=09=09 * pgid hlist: this is the case that used to skip the capture.
+=09=09 */
+=09=09EXPECT_EQ(0, close(sync_child[0]));
+
+=09=09/* In-domain positive control: the child must be signaled. */
+=09=09ASSERT_EQ(0, setup_signal_handler(SIGURG));
+=09=09signal_received =3D 0;
+
+=09=09create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+
+=09=09/* Owns the SIGIO source for the whole process group. */
+=09=09ASSERT_EQ(0, fcntl(trigger[0], F_SETSIG, SIGURG));
+=09=09ASSERT_EQ(0, fcntl(trigger[0], F_SETOWN, -getpgrp()));
+=09=09ASSERT_EQ(0, fcntl(trigger[0], F_SETFL, O_ASYNC));
+
+=09=09/* Fans SIGURG out to every member of the process group. */
+=09=09ASSERT_EQ(1, write(trigger[1], ".", 1));
+
+=09=09/*
+=09=09 * The sandboxed child is in its own domain and must always be
+=09=09 * signaled: this proves the SIGIO actually fired.
+=09=09 */
+=09=09for (i =3D 0; i < 1000 && !signal_received; i++)
+=09=09=09usleep(1000);
+=09=09EXPECT_EQ(1, signal_received);
+
+=09=09ASSERT_EQ(1, write(sync_child[1], ".", 1));
+=09=09EXPECT_EQ(0, close(sync_child[1]));
+
+=09=09_exit(_metadata->exit_code);
+=09=09return;
+=09}
+=09EXPECT_EQ(0, close(sync_child[1]));
+=09EXPECT_EQ(0, close(trigger[0]));
+=09EXPECT_EQ(0, close(trigger[1]));
+
+=09/* Waits for the child to generate the SIGIO. */
+=09ASSERT_EQ(1, read(sync_child[0], &buf, 1));
+=09EXPECT_EQ(0, close(sync_child[0]));
+
+=09/* Lets a delivered-but-pending signal run our handler, if any. */
+=09for (i =3D 0; i < 100 && !signal_received; i++)
+=09=09usleep(1000);
+
+=09/*
+=09 * SCOPE_SIGNAL must block the fan-out to this non-sandboxed parent,
+=09 * which is outside the child's Landlock domain.  Before the fix the
+=09 * parent was signaled here.
+=09 */
+=09EXPECT_EQ(0, signal_received);
+
+=09ASSERT_EQ(child, waitpid(child, &status, 0));
+=09if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+=09    WEXITSTATUS(status) !=3D EXIT_SUCCESS)
+=09=09_metadata->exit_code =3D KSFT_FAIL;
+}
+
 TEST_HARNESS_MAIN
--=20
2.43.0


