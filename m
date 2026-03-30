Return-Path: <stable+bounces-231159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKQDJmxZymn27gUAu9opvQ
	(envelope-from <stable+bounces-231159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:07:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 300F4359F06
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74807304DA4E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E137130EF75;
	Mon, 30 Mar 2026 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITrspjta"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0693B47CF
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868435; cv=none; b=M3wBSTyuU826wiVvO/9rWu+iteJ+fZHSEx1Djq099ljgslXx8HSQxBHKpmiGGiUahD4fNfPH26iPEFDUzy5vCck1jZW+zskkBVNJddwIn59KGR2MK94/ot8zJ69rTn5U0A8h5Cq4f7PkOB6gF2dU27LkDY0LxJgCPXO8K6qKEak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868435; c=relaxed/simple;
	bh=i8gED9P8Kgd2ATIuuHTh5vvZ8gM/y5KyicV5ISs3Sus=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3Y7xKJwqa7wQbLjQ202PHcimQLuIH3UsIM3gfb+oepewQYLsxMyj0ncd9kdwmPJWpPt83HQt3S/QcUJYiF1/izpi7nUA5ZRdZi57KRTGfOZRwTKPzuPlrQlVO1upw+7BzFnxtg41PdwKD+xx/0SZ7UFXkRMco6kdsMpJsjmtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITrspjta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA08BC2BCB2
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 11:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774868435;
	bh=i8gED9P8Kgd2ATIuuHTh5vvZ8gM/y5KyicV5ISs3Sus=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ITrspjtalo5rKir3hGMYEzgpgGcDMd5Uab/BfrGUYeR9uuNcKBgqF33FPqPZOumI0
	 PWMEuU4mZ3LfdgwDABq7VbpxEih+npaOwlKgYV0Nwg2T+s/+XHGNX37XAPKgXOg6rE
	 vgJwPgxmUaX3W4HgKEJ5V0OZ/WlBTMlshQB8en3SFTjUlR/AMzlRKCnkzBgP8pOBUj
	 jvovaIBDOvsQ/gWj81L30v+UVMko1KNnWg3suzt+uSAYugVKPCPP8ZUS/jATnZve7e
	 5RFjNzII+D5oVBe5ZlANWA1knzhJv9SakkMoZzv31jzsHtMzDeZMP8tyi9O4InDE1M
	 CE+GewIZhFJiQ==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y] mm/mseal: update VMA end correctly on merge
Date: Mon, 30 Mar 2026 12:00:21 +0100
Message-ID: <20260330110021.56330-1-ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033044-debug-embargo-40fb@gregkh>
References: <2026033044-debug-embargo-40fb@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231159-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 300F4359F06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Previously we stored the end of the current VMA in curr_end, and then upon
iterating to the next VMA updated curr_start to curr_end to advance to the
next VMA.

However, this doesn't take into account the fact that a VMA might be
updated due to a merge by vma_modify_flags(), which can result in curr_end
being stale and thus, upon setting curr_start to curr_end, ending up with
an incorrect curr_start on the next iteration.

Resolve the issue by setting curr_end to vma->vm_end unconditionally to
ensure this value remains updated should this occur.

While we're here, eliminate this entire class of bug by simply setting
const curr_[start/end] to be clamped to the input range and VMAs, which
also happens to simplify the logic.

Reported-by: Antonius <antonius@bluedragonsec.com>
Closes: https://lore.kernel.org/linux-mm/CAK8a0jwWGj9-SgFk0yKFh7i8jMkwKm5b0ao9=kmXWjO54veX2g@mail.gmail.com/
Suggested-by: David Hildenbrand (ARM) <david@kernel.org>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Fixes: 6c2da14ae1e0 ("mm/mseal: rework mseal apply logic")
Cc: <stable@vger.kernel.org>
(cherry picked from commit 88995f43fdc2045ff0b030ca054898483004de36)
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 mm/mseal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index e5b205562d2e..c561f0ea93e8 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -56,7 +56,6 @@ static int mseal_apply(struct mm_struct *mm,
 		unsigned long start, unsigned long end)
 {
 	struct vm_area_struct *vma, *prev;
-	unsigned long curr_start = start;
 	VMA_ITERATOR(vmi, mm, start);
 
 	/* We know there are no gaps so this will be non-NULL. */
@@ -66,7 +65,8 @@ static int mseal_apply(struct mm_struct *mm,
 		prev = vma;
 
 	for_each_vma_range(vmi, vma, end) {
-		unsigned long curr_end = MIN(vma->vm_end, end);
+		const unsigned long curr_start = MAX(vma->vm_start, start);
+		const unsigned long curr_end = MIN(vma->vm_end, end);
 
 		if (!(vma->vm_flags & VM_SEALED)) {
 			vma = vma_modify_flags(&vmi, prev, vma,
@@ -78,7 +78,6 @@ static int mseal_apply(struct mm_struct *mm,
 		}
 
 		prev = vma;
-		curr_start = curr_end;
 	}
 
 	return 0;
-- 
2.53.0


