Return-Path: <stable+bounces-110447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835D2A1C75C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 11:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466451885695
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 10:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200AE7FBAC;
	Sun, 26 Jan 2025 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="caf7arX1"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F3F18A6C0
	for <stable@vger.kernel.org>; Sun, 26 Jan 2025 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737886746; cv=none; b=pHUUurvp7sWK4uxyGvPQa/m4tM7r5tGwvN4Dwg+EPQB2eSBseJJEfldCN18O0igm6aKmAlpkWxeBa+FDT6DnSq1f+Jc9MLpk3wpNchYEEdkaVbXd+fkdOgLKK7FWyuOx6yJgs99DfasUiJVKmKb+SHkTx5CyjafcpHxQRyLsTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737886746; c=relaxed/simple;
	bh=scK5uZJeCukheXVeSQLJv4paF/hGr7MlavJuyTzXK6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FdJoqTC+22qUzw+l5mFoUyeomUFLdSQEdR6iQNNJlSpzg2lOtfhTbERkOE8OBj5eEFg5b1cZIi2rVdGQUMv92wyN1Vfp0xoBjEH8TM8xYl1UtHTUbcVD0eHI5c+xyx2KltzLY9wS76MNMQAr+nqUrWVSOqTJka6oeXxC9LpavA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=caf7arX1; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 2357E1C2423
	for <stable@vger.kernel.org>; Sun, 26 Jan 2025 13:10:08 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1737886207; x=
	1738750208; bh=scK5uZJeCukheXVeSQLJv4paF/hGr7MlavJuyTzXK6M=; b=c
	af7arX10uelASHRvbfJuM7nVsHH0Z+cqdsrjvjBXwMy+2ZyUVLh6dzho0EcT2EUf
	psiQZlyCQG6PdLXdxQCAxTRQiqswz8RwR9DSp9i08j2kDAUbAcY45De29ck8FIOq
	BkbhnRmQ8Zp5ywej8iHVK9WH2+wfLqt6JYFRPjwF3U=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LZ__qJNP2sSX for <stable@vger.kernel.org>;
	Sun, 26 Jan 2025 13:10:07 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 510B21C2418;
	Sun, 26 Jan 2025 13:10:03 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Juergen Gross <jgross@suse.com>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] static_call: Replace pointless WARN_ON() in static_call_module_notify()
Date: Sun, 26 Jan 2025 10:09:24 +0000
Message-ID: <20250126100925.1573102-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

commit fe513c2ef0a172a58f158e2e70465c4317f0a9a2 upstream.

static_call_module_notify() triggers a WARN_ON(), when memory allocation
fails in __static_call_add_module().

That's not really justified, because the failure case must be correctly
handled by the well known call chain and the error code is passed
through to the initiating userspace application.

A memory allocation fail is not a fatal problem, but the WARN_ON() takes
the machine out when panic_on_warn is set.

Replace it with a pr_warn().

Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/8734mf7pmb.ffs@tglx
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
Backport to fix CVE-2024-49954
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-49954
---
 kernel/static_call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index e9408409eb46..a008250e2533 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -431,7 +431,7 @@ static int static_call_module_notify(struct notifier_block *nb,
 	case MODULE_STATE_COMING:
 		ret = static_call_add_module(mod);
 		if (ret) {
-			WARN(1, "Failed to allocate memory for static calls");
+			pr_warn("Failed to allocate memory for static calls\n");
 			static_call_del_module(mod);
 		}
 		break;
-- 
2.43.0


