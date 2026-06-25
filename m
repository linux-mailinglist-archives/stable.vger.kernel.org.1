Return-Path: <stable+bounces-268602-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pjBrFqNLPWrC0wgAu9opvQ
	(envelope-from <stable+bounces-268602-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:39:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C15BC6C71F6
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:39:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NwRAVRXu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hqJZSBG+;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SaBVehSy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="0rYclu/v";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268602-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268602-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6435030500C9
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1382E11B9;
	Thu, 25 Jun 2026 15:39:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD427BF93
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 15:39:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401949; cv=none; b=NOdqkyh3BCKQHLNRof0F8Nj9wy2I3UKMOew5BJsqSkvOTEsXkG/yJTjoqk39GUb6KtI11BoyIUxoryltLZz3PxJxJdNp/gMyDSZo0/e+1T2nIfaJzsyUbIrM/FkOorvH11ROrf8MoYrd6xPqaoZHpmdD9+Tk7RpZR/gOqiFh2Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401949; c=relaxed/simple;
	bh=Il2Z951BIj1Z1wnEe9obnBo56KkEtI50ZIXhEclw4WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KcVrJTDWcSND7fuplw0I9SHUmPs1NXbPsOjs7SnPoaGJ53adEbWuRnCdVgu5aDCT1b3Xhtsdea1wYFY4IIEfhmjEvK1v+SyIqqUgv0MW0zR0O/Dym1pfbsrhP1zu0HIq00ypoFfviGScqcMy2Pr8Vmz2yZ+cJ5VhhfGzVAFDpOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NwRAVRXu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hqJZSBG+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SaBVehSy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0rYclu/v; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8EE0D71C28;
	Thu, 25 Jun 2026 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782401945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3DH1IpOREXh9R036qQ3fgOrNp9Y/tCMMtgQvXveSOHQ=;
	b=NwRAVRXutpXL/pdBgzbmyaYn4uUz1RhaPMZl2P2XObe0JzP7opZP48clrsGBdO/sQLMmwm
	9dOmMalIjTzOa8I/ci3wKXhKZmiqN9tljD0OfuEOAEzPm1th8LZlHkWU+PIB7yVoT4HKRv
	Pvkq3Oc8qU2sLrynhJ2AKMbM99eq028=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782401945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3DH1IpOREXh9R036qQ3fgOrNp9Y/tCMMtgQvXveSOHQ=;
	b=hqJZSBG+e8rDq7//e/0MGt3NNk9o0QiRh0VCPaH5bOMkmTSIKAZHMSseJkjU472br+6XLr
	ghNqhbvDKt02GpAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782401944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3DH1IpOREXh9R036qQ3fgOrNp9Y/tCMMtgQvXveSOHQ=;
	b=SaBVehSysMnqbJJQlnJuef9R/gjK3tLrl64AB6Tb25BC9SWcTMFTVCXaDuI1vqObtLswb+
	s79GV8xJLTDKMvhvMhD+J544aMGzE6JQF35qpbvutr8GiWjyDAF2tdVAB0TRqHZAthqQOI
	ucjmzUFsI6w9CZxa+W/6o7gWzT+giXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782401944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3DH1IpOREXh9R036qQ3fgOrNp9Y/tCMMtgQvXveSOHQ=;
	b=0rYclu/vu2zoQTYtbYtT/46cwy08fQTH5uJ0FqbiMoyPwr7w1ZwPIvdpKRF9Y9L9hLbk49
	CBKS986j/lCshnDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 984D6779A8;
	Thu, 25 Jun 2026 15:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dJWvIZdLPWqvWAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 25 Jun 2026 15:39:03 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH] mm: do file ownership checks with the proper mount idmap
Date: Thu, 25 Jun 2026 16:38:53 +0100
Message-ID: <20260625153853.913949-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268602-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[pfalcato@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:willy@infradead.org,m:akpm@linux-foundation.org,m:liam@infradead.org,m:david@kernel.org,m:jack@suse.cz,m:vbabka@kernel.org,m:jannh@google.com,m:linux-fsdevel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:pfalcato@suse.de,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C15BC6C71F6

Ever since idmapped mounts were introduced, inode ownership checks
(for side-channel protection) in mincore() and madvise(MADV_PAGEOUT) were
done against the nop_mnt_idmap, which completely ignores the file's mount's
idmap. This results in odd edgecases like:

1) mount/bind-mount with an idmap userA:userB:1
2) userB runs an owner_or_capable() check on file that is owned by userA
on-disk/in-memory, but owned by userB after idmap translation
3) owner_or_capable() mysteriously fails as the correct idmap wasn't supplied

In the case of mincore/madvise MADV_PAGEOUT, this is usually benign, because
file_permission(file, MAY_WRITE) will probably succeed, as it uses the proper
idmap internally, but it does not need to be the case on e.g a 0444 file
where even the owner itself doesn't have permissions to write to it.

Since this is clearly not trivial to get right, introduce a
file_owner_or_capable() that can carry the correct semantics, and switch
the various users in mm to it.

The issue was found by manual code inspection & an off-list discussion with
Jan Kara.

Fixes: 9caccd41541a ("fs: introduce MOUNT_ATTR_IDMAP")
Cc: stable@vger.kernel.org
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---

I noticed there are a couple of call sites in fs/ that could perhaps be
cleaned up with the added helper, but I'm skipping that for now for brevity's
sake.

 include/linux/fs.h | 5 +++++
 mm/filemap.c       | 2 +-
 mm/madvise.c       | 3 +--
 mm/mincore.c       | 3 +--
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d10897b3a1e3..50ce731a2b78 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2444,6 +2444,11 @@ static inline struct mnt_idmap *file_mnt_idmap(const struct file *file)
 	return mnt_idmap(file->f_path.mnt);
 }
 
+static inline bool file_owner_or_capable(const struct file *file)
+{
+	return inode_owner_or_capable(file_mnt_idmap(file), file_inode(file));
+}
+
 /**
  * is_idmapped_mnt - check whether a mount is mapped
  * @mnt: the mount to check
diff --git a/mm/filemap.c b/mm/filemap.c
index 5af62e6abca5..58eb9d240643 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4704,7 +4704,7 @@ static inline bool can_do_cachestat(struct file *f)
 {
 	if (f->f_mode & FMODE_WRITE)
 		return true;
-	if (inode_owner_or_capable(file_mnt_idmap(f), file_inode(f)))
+	if (file_owner_or_capable(f))
 		return true;
 	return file_permission(f, MAY_WRITE) == 0;
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index cd9bb077072c..77552b03d318 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -336,8 +336,7 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 	 * otherwise we'd be including shared non-exclusive mappings, which
 	 * opens a side channel.
 	 */
-	return inode_owner_or_capable(&nop_mnt_idmap,
-				      file_inode(vma->vm_file)) ||
+	return file_owner_or_capable(vma->vm_file) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
diff --git a/mm/mincore.c b/mm/mincore.c
index 296f2e3922b5..c8757c5085bf 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -227,8 +227,7 @@ static inline bool can_do_mincore(struct vm_area_struct *vma)
 	 * for writing; otherwise we'd be including shared non-exclusive
 	 * mappings, which opens a side channel.
 	 */
-	return inode_owner_or_capable(&nop_mnt_idmap,
-				      file_inode(vma->vm_file)) ||
+	return file_owner_or_capable(vma->vm_file) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
-- 
2.54.0


