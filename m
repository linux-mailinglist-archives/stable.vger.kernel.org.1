Return-Path: <stable+bounces-269426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lt57Dq1oQGqafQkAu9opvQ
	(envelope-from <stable+bounces-269426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 02:19:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF486D2DC5
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 02:19:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hXYZqS+I;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269426-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269426-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF8753008263
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 00:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6816823DE;
	Sun, 28 Jun 2026 00:19:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4FE2AD03
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 00:19:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782605991; cv=none; b=eUQlThNyvnnZgHqlug489UCFJENCELVVsOiDS1+5E8iBm6oRWKPJpqaWsA+fqtbipBBAtlOPMW225uDs+mwYVLU/Nbmb6Zenp1Ca8LGcBM/M8AqBHhNwXwFuNyVayeZl5QF+X0NCuU2iVZUxxb/NzHXOOiRk/V1qZnLCKDCEqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782605991; c=relaxed/simple;
	bh=BZES6Vu+87PSEiXIou4+9wu7I0xf5hQoKPcuveWQTos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHthNRCbxliMjFv/AOicmKtM+92qJt/UG/RRzpfEltpYEx4Ruzr4fMMUJrR2/8ma04aTFK/EPHJeIUfqSyG3ZPGKNJZxgX2F/nbrgyMSogh0XgrcHWnC31sWOZuQEDsbGaJRfOj1/uQ5G4+R+pMW/AOjfw74cHOa/zLAj588+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXYZqS+I; arc=none smtp.client-ip=74.125.224.49
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664b3831a20so1181502d50.3
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 17:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782605989; x=1783210789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QCBjOduh7mJd8MUykpzCDwwBD7x40iz6urrs4/3NtAg=;
        b=hXYZqS+ICN/W+sHQawHWVfU2kEmozNEmiSRQxCWWwseiOLJeejyVipW8mEb1yfxIy4
         GKVU50epLopb2VqrlNACF89rcHiwJcdPO40Pq1PIDkvs/3fNyiU0TgF+o2Ewl8+qV9dh
         mSvTSB3qGgMIyTKV0t9iRSfKHFr3wzYVY5HSloGnpNjJIv6CX5u4DF2Gd7dO/D7zp5QW
         XxgdZW+sPc/bzsQ0aG7IGUj5fwksYOepy+dEjV2FNSWGB3aA4namp2RHBWzem3NrTj3j
         XamNvuEV8bOmNAjgpzBpRN4K7r2w2Ght+7mJT8pVVmYcYIF6aCT0i3gfjqT249eB8IbA
         ThSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782605989; x=1783210789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCBjOduh7mJd8MUykpzCDwwBD7x40iz6urrs4/3NtAg=;
        b=c2pzzflfMjTNn4TPwvqRF/HnJyMcHlVCpe/RdzlsqNrBQqe0SBSnsHo+Tq+coiFAqN
         x91ZdgSJqSHVgbEkHFwFk5JskIFIXwbtUGqnxxtXdkOk433da35AI3Wh/Obg89hpTkjB
         BJT3i4HgVzBJrunQk3kkkgm3ZI0U46f/am+C3Wy46u5ZGCGGON6/7v+MSp82rDozt84R
         dopL6zITKFlyjn9fvQBXmf8h+H966o/SajhoEHDYMyzR/D82tvEhTs2hIa90UlHpNJBA
         dR8XDKSAjZu1JyOma8LJoUnQD20OWtDfFlNn4FZXmkNQx9txJgvUY3ZelEx1/kyo6ahe
         H9lw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2mkdmMs/15L+6nrmQMH05QgoNE0Et2LnZDaWg99l+OHskal4hztm/6ukid6ckP0Tv7rWu+Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4YBdRuALrh78TcdqtdQotlnW1BHFYRxDbP528GjJApmYetNM
	GwZtjdE+UtxSlkZMEJx6OHc2/hBXVuBcqedIme2woVA5rKd8+KAouYz9
X-Gm-Gg: AfdE7cmq5UvvxOEaYV2V9/lJdUxNsdMt40uOObZAMbqHBRIF65fqEw599q/PCOO7KbE
	d4TbOR0F1UQBLatikxMUI0O1nhwFnZkAwPfKNR0NP0VTW13Se5aM1YsstX2CW4Vj1CG4krRayZU
	LREd7FbS//6D/rmRXaQYfYaLYfbARXvcFpwZ9KYOLC0sLQexythBxkOgqFOQ83KZJ1pAws+QSlv
	oe1DxYYAvw0y/4QprxkuIwFmPtkxuvoflyRHaEni+hA75Rfdy6dhnXHzPJSSN34Ye9AZ17c4IW5
	IQD5OPam4+xG51uD0AJ3Nd7MIKlj9Dc7p5oELHHpohQKLTakacAz0HApyBcYSxcFBYstXh5ndBZ
	8ayFwzlpUeVq4O+spkD0YcpmcC0TnaJXWAGM3L39qvZPgFa5wQ08DIGvOnMyALCo+Y3cV2y8QXW
	ArayEihekXwu1a7U9YY3ozbEd8QKbuJZUV1rQU
X-Received: by 2002:a05:690c:e36c:b0:7fe:1413:f6b7 with SMTP id 00721157ae682-80a6b4a3649mr113536277b3.48.1782605989094;
        Sat, 27 Jun 2026 17:19:49 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80d0f574c7bsm11589827b3.40.2026.06.27.17.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:19:48 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+33e764e33338f7b46952@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] ntfs3: serialize readdir against MFT record updates
Date: Sun, 28 Jun 2026 02:19:31 +0200
Message-ID: <20260628001931.21861-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269426-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:almaz.alexandrovich@paragon-software.com,m:ntfs3@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+33e764e33338f7b46952@syzkaller.appspotmail.com,m:alhouseenyousef@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,33e764e33338f7b46952];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEF486D2DC5

ntfs_readdir() walks the directory index root and resident bitmap directly
from the inode MFT record without holding ni_lock. Writeback takes ni_lock
but may remove the attribute list and replace or free that record while the
directory walk is using pointers into it.

In particular, ntfs_dir_emit() can pass an MFT_REF from the resident index
to iget5_locked(), which may sleep before its set callback dereferences the
reference. This leaves a use-after-free window against writeback.

Hold ni_lock across the directory walk so resident record pointers remain
stable. The index run semaphore is already designed to nest below ni_lock.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Reported-by: syzbot+33e764e33338f7b46952@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=33e764e33338f7b46952
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 fs/ntfs3/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index d99ab086ef6f..a6861f1b1b99 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -472,19 +472,18 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 	if (!name)
 		return -ENOMEM;
 
+	ni_lock(ni);
+
 	if (!ni->mi_loaded && ni->attr_list.size) {
 		/*
-		 * Directory inode is locked for read.
 		 * Load all subrecords to avoid 'write' access to 'ni' during
 		 * directory reading.
 		 */
-		ni_lock(ni);
 		if (!ni->mi_loaded && ni->attr_list.size) {
 			err = ni_load_all_mi(ni);
 			if (!err)
 				ni->mi_loaded = true;
 		}
-		ni_unlock(ni);
 		if (err)
 			goto out;
 	}
@@ -543,6 +542,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 	}
 
 out:
+	ni_unlock(ni);
 	kfree(name);
 	put_indx_node(node);
 
-- 
2.54.0


