Return-Path: <stable+bounces-221092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I5tAHFdo2lxBQUAu9opvQ
	(envelope-from <stable+bounces-221092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:26:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA9C1C90A2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B451434B242F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A2136DA11;
	Sat, 28 Feb 2026 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ1QhhcJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1232B36DA0B;
	Sat, 28 Feb 2026 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301440; cv=none; b=m/KYEZ+qvnkL0EmsFZxv3/cXxB0zVhUUOBAZT9Zc6UOZpEUfT0KzWLRvVzuG4crAWiQtIgVG5K+wzza+QfqKcYiWDYIPMeXLwzlde6VMy04QcKWm9IwdAEaQslWYcJTbn+Wkrr59cmv4fBmP1MGL5rW4AhgW6PtO37axZnZ0Fgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301440; c=relaxed/simple;
	bh=eka7zON3gX8jz16OwPRfwdNq2KwQ6lxsdlOJPMoc0bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbLlyVJUja8rnpmx58FBaUlmgiUndyjUnEWzb+5tpK23FxVjj9btlbXV9ge3L73t5V5yd84EV/E1rn07S+5n8pY695wYTPUJvl7nu1dnz/ecrqLhrOT4lwOwb58y5naReXn7KAAYyY+MZtBJn4QqR4zUHpFKwiWlCsZhcVzQcgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ1QhhcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BDCC19423;
	Sat, 28 Feb 2026 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301440;
	bh=eka7zON3gX8jz16OwPRfwdNq2KwQ6lxsdlOJPMoc0bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJ1QhhcJo3v9Qhx8cl4M9hz4pOykgDe8rANkywz7jzPsETD6bcFJ/uM1UtSujLovI
	 /BVt96wD0V0ZhoRoDsf9Fbvvv5eLEvGeqqaP2hyLtUVRkYzeqlQ0ElzmZDoicCdeYk
	 DmHbZFJ00m80iMwUSfLoX5gavG2uJxObT5XVaqlA96/JkOExeBlzCnhgietnI47r2y
	 guJ9LrBnCvjHG3fJ8qCqoA0R7D4Q+WNev1lfTFpqAp46EKTBJOXQc5/IAmgJ/34au1
	 5pLrsKYryJZt0pBKnrghQP3vRvkbQJDBIXXQws00xxfPwydBVXQhfBqWFO4g3D5o1+
	 HpSpYcT8N+a+g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Paul Webb <paul.x.webb@oracle.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Alexander Graf <graf@amazon.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Borislav Betkov <bp@alien8.de>,
	guoweikang <guoweikang.kernel@gmail.com>,
	Henry Willard <henry.willard@oracle.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>,
	Joel Granados <joel.granados@kernel.org>,
	Jonathan McDowell <noodles@fb.com>,
	Mike Rapoport <rppt@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Yifei Liu <yifei.l.liu@oracle.com>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 626/752] x86/kexec: add a sanity check on previous kernel's ima kexec buffer
Date: Sat, 28 Feb 2026 12:45:37 -0500
Message-ID: <20260228174750.1542406-626-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221092-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,linux.ibm.com,amazon.com,kernel.org,redhat.com,alien8.de,gmail.com,zytor.com,suse.cz,fb.com,intel.com,linutronix.de,vger.kernel.org,linux-foundation.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DA9C1C90A2
X-Rspamd-Action: no action

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit c5489d04337b47e93c0623e8145fcba3f5739efd ]

When the second-stage kernel is booted via kexec with a limiting command
line such as "mem=<size>", the physical range that contains the carried
over IMA measurement list may fall outside the truncated RAM leading to a
kernel panic.

    BUG: unable to handle page fault for address: ffff97793ff47000
    RIP: ima_restore_measurement_list+0xdc/0x45a
    #PF: error_code(0x0000) – not-present page

Other architectures already validate the range with page_is_ram(), as done
in commit cbf9c4b9617b ("of: check previous kernel's ima-kexec-buffer
against memory bounds") do a similar check on x86.

Without carrying the measurement list across kexec, the attestation
would fail.

Link: https://lkml.kernel.org/r/20251231061609.907170-4-harshit.m.mogalapalli@oracle.com
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
Reported-by: Paul Webb <paul.x.webb@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Betkov <bp@alien8.de>
Cc: guoweikang <guoweikang.kernel@gmail.com>
Cc: Henry Willard <henry.willard@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Joel Granados <joel.granados@kernel.org>
Cc: Jonathan McDowell <noodles@fb.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: Yifei Liu <yifei.l.liu@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1b2edd07a3e17..383d4a4784f5b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -439,9 +439,15 @@ int __init ima_free_kexec_buffer(void)
 
 int __init ima_get_kexec_buffer(void **addr, size_t *size)
 {
+	int ret;
+
 	if (!ima_kexec_buffer_size)
 		return -ENOENT;
 
+	ret = ima_validate_range(ima_kexec_buffer_phys, ima_kexec_buffer_size);
+	if (ret)
+		return ret;
+
 	*addr = __va(ima_kexec_buffer_phys);
 	*size = ima_kexec_buffer_size;
 
-- 
2.51.0


