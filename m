Return-Path: <stable+bounces-117985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3267A3B930
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1175B188BBD4
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BC01DE2D7;
	Wed, 19 Feb 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XjR15i9i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CF18FC86;
	Wed, 19 Feb 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956910; cv=none; b=uvAjmpEA15dTHLisNpZABPmCbYTUyjML/K3gtu7CwHi2lg6e2Bw3juh48ytZ8E+3JMQVkTt9+dQbRlyOne+pAv2js6Vgz9kc+fJLFnQloN3VfPy/OAY8jLcqqaOR4GE3/b6ETxKf3zgDNhZ+3cf9xNBWbjxdr16lgop2LeE4b7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956910; c=relaxed/simple;
	bh=lB1LV431Ceuvw8bV2qmYTAqBZSeYi1Uy9+/ly4v45HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dT8yw+4ysjUU5xwaefuVsVNSv6zIHXoeXRoFNj0u+rRuQulLV3Q22u8wJDGTbXA4kCVKN2RDx2Uv6OoLN1F5odtzOOBRS32kd7heuNed33M9qiK4gOKAfYi3Ru/QmEVtGK0F4hU5Ur6rkH1smFbsaKKrsdJ+i5eIumcjGhdF7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XjR15i9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0D5C4CED1;
	Wed, 19 Feb 2025 09:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739956910;
	bh=lB1LV431Ceuvw8bV2qmYTAqBZSeYi1Uy9+/ly4v45HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XjR15i9ieA4QcpqgSKGaoEf3K22o+WehP/JpRrmhhpY+umyQQBr+1N/I8WDm1gAFg
	 4XqXKlFakQuE859ifdLwYA2mijWuMhNb9Soz3qi4450XXl4sL30HyfdSTidaLpPdID
	 yFWyGRrhwbytO1Lnl4Y97skib6rAxy7dnP781Hrg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.1 342/578] fs/proc: do_task_stat: Fix ESP not readable during coredump
Date: Wed, 19 Feb 2025 09:25:46 +0100
Message-ID: <20250219082706.469633010@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Nam Cao <namcao@linutronix.de>

commit ab251dacfbae28772c897f068a4184f478189ff2 upstream.

The field "eip" (instruction pointer) and "esp" (stack pointer) of a task
can be read from /proc/PID/stat. These fields can be interesting for
coredump.

However, these fields were disabled by commit 0a1eb2d474ed ("fs/proc: Stop
reporting eip and esp in /proc/PID/stat"), because it is generally unsafe
to do so. But it is safe for a coredumping process, and therefore
exceptions were made:

  - for a coredumping thread by commit fd7d56270b52 ("fs/proc: Report
    eip/esp in /prod/PID/stat for coredumping").

  - for all other threads in a coredumping process by commit cb8f381f1613
    ("fs/proc/array.c: allow reporting eip/esp for all coredumping
    threads").

The above two commits check the PF_DUMPCORE flag to determine a coredump thread
and the PF_EXITING flag for the other threads.

Unfortunately, commit 92307383082d ("coredump:  Don't perform any cleanups
before dumping core") moved coredump to happen earlier and before PF_EXITING is
set. Thus, checking PF_EXITING is no longer the correct way to determine
threads in a coredumping process.

Instead of PF_EXITING, use PF_POSTCOREDUMP to determine the other threads.

Checking of PF_EXITING was added for coredumping, so it probably can now be
removed. But it doesn't hurt to keep.

Fixes: 92307383082d ("coredump:  Don't perform any cleanups before dumping core")
Cc: stable@vger.kernel.org
Cc: Eric W. Biederman <ebiederm@xmission.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Kees Cook <kees@kernel.org>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Link: https://lore.kernel.org/r/d89af63d478d6c64cc46a01420b46fd6eb147d6f.1735805772.git.namcao@linutronix.de
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/array.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -490,7 +490,7 @@ static int do_task_stat(struct seq_file
 		 * a program is not able to use ptrace(2) in that case. It is
 		 * safe because the task has stopped executing permanently.
 		 */
-		if (permitted && (task->flags & (PF_EXITING|PF_DUMPCORE))) {
+		if (permitted && (task->flags & (PF_EXITING|PF_DUMPCORE|PF_POSTCOREDUMP))) {
 			if (try_get_task_stack(task)) {
 				eip = KSTK_EIP(task);
 				esp = KSTK_ESP(task);



