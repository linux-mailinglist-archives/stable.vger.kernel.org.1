Return-Path: <stable+bounces-81491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AEC993B7D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 01:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C61B21690
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 23:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C631925A5;
	Mon,  7 Oct 2024 23:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kX5bu8C9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+Wn2bPS0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pm2qeL0O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iN67xaOY"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36B18DF65
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345592; cv=none; b=uPU1iVxntfJFVzMjWN1E8OS1ZOneNi3YEnK1//3dpYb7ypH1aVN6+Q119nNNuvR8pXkqU5T+bFj4Oyh5rmnB5mM9eP5PD2M1v/kfmSOQdyDKcy4xVHQqh1v77Sb0RTn82LSuwFCkj7q/3nc3EGFLA8FWZlGXZ3SUt2MFdj+fwz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345592; c=relaxed/simple;
	bh=2iXSzq8dE3YR+XgHGE+3QByUbzmQjRoecGUYGegT7R4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=l9boTFPT2j5aHIsNoqn18n5WolqgBuLoVY3ZxSP2vxvIC8cdwft0hOF1L2VaM/58aOvc4OAjc/cUG2rBSXuswnHCO4kO13unAZ23M5lGllIF3b/9D3vSpUiWIYI6akx6Cazq3dnin4xYje5/6PRclBgraDugHHA4OpZSdtt5O0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kX5bu8C9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+Wn2bPS0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pm2qeL0O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iN67xaOY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B664D1F848;
	Mon,  7 Oct 2024 23:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728345588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kUK7tz0CiHM7vBplclQiONo7Ovskc1Q/qth8f2n/4Y=;
	b=kX5bu8C9vhfQX3jTkaqOeGgIfXi33VSFnyIViev8HB/Pxawh+6WQFofmWomCaF6W2CbWOZ
	1zqIWHdGgZKSRfzM9M18mUWV/lRErij7AUWEBvFd5JshiJQgp6ak2FqQPw6oLFnouam0Tc
	BhIyKOKXkC1td1zufyoaueL0WA8ilgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728345588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kUK7tz0CiHM7vBplclQiONo7Ovskc1Q/qth8f2n/4Y=;
	b=+Wn2bPS0bxRVMGZJqu5EMq1h/XcxGUxwlNy+CGultr00pMioKQ2Tjvu6NPrKCc+5MfIFMN
	z6STEHu4jSNS0JAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728345587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kUK7tz0CiHM7vBplclQiONo7Ovskc1Q/qth8f2n/4Y=;
	b=pm2qeL0O40dEd7D47rr8DtdhPcaMeHjHCA5CqB9JkGM1fY5HjSHa1B9rkWWQwANxax/8Pa
	ct7vx+apYxZbE/22rwTGmvXNPvWto8eYy2AE44zm20rQ/Uutr+4ixiPe2NzkaJKqc55w4J
	I64hefOoUsKuVOI7BU1Z+S8CIgGOAOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728345587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kUK7tz0CiHM7vBplclQiONo7Ovskc1Q/qth8f2n/4Y=;
	b=iN67xaOYS7EVZ+0RCGstk4Ei7MFCwqO7e+krPax6/JZMxTwpkrvUapbosyHGOImvtKx6/U
	iPRU0epDGDchifAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A736013885;
	Mon,  7 Oct 2024 23:59:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xGBHF/F1BGeSHAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 07 Oct 2024 23:59:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: bcodding@redhat.com, chuck.lever@oracle.com, jlayton@kernel.org,
 okorniev@redhat.com
Subject: [PATCH 5.4.y] nfsd: fix delegation_blocked() to block correctly for
 at least 30 seconds
In-reply-to: <2024100728-graves-septic-4380@gregkh>
References: <2024100728-graves-septic-4380@gregkh>
Date: Tue, 08 Oct 2024 10:59:38 +1100
Message-id: <172834557878.3184596.740888095598271167@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 


The pair of bloom filtered used by delegation_blocked() was intended to
block delegations on given filehandles for between 30 and 60 seconds.  A
new filehandle would be recorded in the "new" bit set.  That would then
be switch to the "old" bit set between 0 and 30 seconds later, and it
would remain as the "old" bit set for 30 seconds.

Unfortunately the code intended to clear the old bit set once it reached
30 seconds old, preparing it to be the next new bit set, instead cleared
the *new* bit set before switching it to be the old bit set.  This means
that the "old" bit set is always empty and delegations are blocked
between 0 and 30 seconds.

This patch updates bd->new before clearing the set with that index,
instead of afterwards.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 6282cd565553 ("NFSD: Don't hand out delegations for 30 seconds after r=
ecalling them.")
Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
(cherry picked from commit 45bb63ed20e02ae146336412889fe5450316a84f)
---
 fs/nfsd/nfs4state.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a0aa7e63739d..378639f04a7b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -820,7 +820,8 @@ static void nfs4_free_deleg(struct nfs4_stid *stid)
  * When a delegation is recalled, the filehandle is stored in the "new"
  * filter.
  * Every 30 seconds we swap the filters and clear the "new" one,
- * unless both are empty of course.
+ * unless both are empty of course.  This results in delegations for a
+ * given filehandle being blocked for between 30 and 60 seconds.
  *
  * Each filter is 256 bits.  We hash the filehandle to 32bit and use the
  * low 3 bytes as hash-table indices.
@@ -849,9 +850,9 @@ static int delegation_blocked(struct knfsd_fh *fh)
 		if (seconds_since_boot() - bd->swap_time > 30) {
 			bd->entries -=3D bd->old_entries;
 			bd->old_entries =3D bd->entries;
+			bd->new =3D 1-bd->new;
 			memset(bd->set[bd->new], 0,
 			       sizeof(bd->set[0]));
-			bd->new =3D 1-bd->new;
 			bd->swap_time =3D seconds_since_boot();
 		}
 		spin_unlock(&blocked_delegations_lock);

base-commit: 661f109c057497c8baf507a2562ceb9f9fb3cbc2
--=20
2.46.0


