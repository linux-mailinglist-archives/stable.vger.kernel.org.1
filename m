Return-Path: <stable+bounces-254326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKHIGSiJFWqGWQcAu9opvQ
	(envelope-from <stable+bounces-254326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:51:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A415D528D
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17EED304E6C6
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2534E3E9F95;
	Tue, 26 May 2026 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="dxnQ5SlF"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F422C331A66
	for <stable@vger.kernel.org>; Tue, 26 May 2026 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795914; cv=none; b=Ul2FTttLXRC74+KVv8Ujg06FeL/4Pzqn2Z4u++qYRXI5GQdOIPFhkHBenf7stv24qdFAZbvXWlT6KZbtNxqPOa8eyPr2x0MnFpZr50Ny91oISG3U0HgIciuaa4FESf4E+ccw/YZ1v2uLr9JsjvBfyZcwXWmM37K77DPN7rTZbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795914; c=relaxed/simple;
	bh=4ZbcUAOtbSRlzIGLbKqkguTaFBH8Lzl0mxQc3CKk920=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZ4YHvemeI60b7pCN92Hr0HbhPOv/GqFIZw3JRC/k9pEPgO9qAyrI2ultMRYfPghmUl+L0y3nUWPLkzU/OgMx5lI34oKQaGSEkDm+wXRUnefm9MtfdX+8jJS4R6MNDshmomfr6OLATRaF/r9ep3SCvzfKaRjlLWqIYYXEvtxP/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=dxnQ5SlF; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from hwang4-g16.. (unknown [120.244.199.213])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2A2FB3F83E;
	Tue, 26 May 2026 11:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1779795515;
	bh=4GdQPoNzrwihLEfvx3BYpzWDBscKHYn7iQ3om5+0sa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=dxnQ5SlFCVD0iWw7Sm7OIDPQoxjwn6c7mC/ZXylhfi0PJc2g+8FXcj4kvAyoSmmu1
	 ouUeYfyTlHrM7urZ/J+SSiVTLnYHbicmo7NG/9C7ppcktDczDVQQkce7w+dDpX9ZRZ
	 FRUyVJa/inF2+9dyZjeyQNuYKQzj3wsidvJTXZv2qpypqEzkIAdHWHEELsldzd36zO
	 KkttMeQG3lzKhDjCxmvMfiJ9EX4TlCln1Tlh9ALkqtkM7a6V+bVi9vUxWy7cKBo858
	 HEjbKuKhx9f4UGJS86WATogHE6oaW4prSK3wttnFJWiDxtTHBuJmmClz8LRUqlsmqb
	 R6+V3C5Dkz/Y4MKmTYHBn820byBoO1b9sHuGJqKaGF9HrI4tQzpvDKr6kgipkpH+q2
	 +AQBsKVs6cH++f0nMFeEZt6VB06C66Usv42zehGYWQU7lb0BBC9FUCHC50FRMV39Mx
	 eiT3vKYuuGdtmo3bsoS1vyld2iJjvV0y8GaU1NdaDhK/bOb6PMqaCqno6+g51OdUhe
	 ol8bEMn9BbxCqRIdXPMVPwItT931S7mgQV7dFmNpyyEIlx9GG18lNsx1oPRsHwGmMp
	 WQX+vQv60tT2opJ+AWbKndHA0hJ3vUCRW17ngp+fu3J2O8CVbvUGGDjqeOGcM/GAvR
	 cCFtBjkjOzJhobha47wS1/pk=
From: Hui Wang <hui.wang@canonical.com>
To: linux-riscv@lists.infradead.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	vincent.chen@sifive.com,
	stable@vger.kernel.org
Cc: hui.wang@canonical.com
Subject: [PATCH] riscv: kgdb: Fix a missing irq restore issue on an early-return path
Date: Tue, 26 May 2026 19:38:29 +0800
Message-ID: <20260526113829.115007-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.wang@canonical.com,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254326-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C7A415D528D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If kgdb_handle_exception() fails, the local_irq_restore() is not
called and the function returns to the caller with interrupts still
disabled. To fix it, add the missing irq restore here.

Fixes: fe89bd2be866 ("riscv: Add KGDB support")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 arch/riscv/kernel/kgdb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
index 0bf629204c76..1956e4840a30 100644
--- a/arch/riscv/kernel/kgdb.c
+++ b/arch/riscv/kernel/kgdb.c
@@ -337,8 +337,10 @@ static int kgdb_riscv_notify(struct notifier_block *self, unsigned long cmd,
 	local_irq_save(flags);
 
 	if (kgdb_handle_exception(type == KGDB_SW_SINGLE_STEP ? 0 : 1,
-				  args->signr, cmd, regs))
+				  args->signr, cmd, regs)) {
+		local_irq_restore(flags);
 		return NOTIFY_DONE;
+	}
 
 	if (type == KGDB_COMPILED_BREAK)
 		regs->epc += 4;
-- 
2.43.0


