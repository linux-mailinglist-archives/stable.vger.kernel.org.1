Return-Path: <stable+bounces-81490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C63993B75
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 01:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77CD284160
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 23:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3D01925B1;
	Mon,  7 Oct 2024 23:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PfdoAor7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/iEfLY9L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PfdoAor7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/iEfLY9L"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30918DF65
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345410; cv=none; b=q4CWTxpVqyqbIqz0Oh1RpcUsOPGVTNG3g08T/CnwzxA6dC1Gdxsggg21C+8RfrqNZoCmKqkoTt07V0k/NA+TmX268qS6wcrzb7HEjIe7fDGfNpqMCAtrereFuiamlkVch3LJKiSKbFkmgD/GEpPNqxbCBIcfS94ncn+AREV84Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345410; c=relaxed/simple;
	bh=sGef4p4hPrpJgP9PjVJq7xMOjCG8MN4nsGdAQEqt7bI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=H/jce+N8NXU2X1UAagBZpsHSE6HuNT66taivWGi1+t4ML+tJyeFf3W1e8IYNfc3Cuv082VEJKPWeHudDT1JQm8F32gxQalBBv576+SFTqmM/DP5HwDrQPbLNo89rwMKEqk30/Gf2ZjCgs/Ml6WZS49XdAkMuL8SUfUihBtiR5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PfdoAor7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/iEfLY9L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PfdoAor7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/iEfLY9L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B50FB21C79;
	Mon,  7 Oct 2024 23:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728345406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fps74rDVAfhly/m/ZgjdKaVWwHmLLKhBirsh9hmxmSI=;
	b=PfdoAor7Zk7x/9fziZAuJqYxQ131Iq8bfx1KML4Dj77SMmemEs9C16MejgT00q9HZoz4uh
	NnPW+55KwZW+3HJYvke7VUVugOBECtAe2nI4RRkHEcldlz5FKqxkxmAO4avCjzdbKzekhh
	kRWyd8H5f/h+0N5MWdG9i92McNg13r0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728345406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fps74rDVAfhly/m/ZgjdKaVWwHmLLKhBirsh9hmxmSI=;
	b=/iEfLY9LVoHPaVAAR/Sc1HQW4MvjYmVAY+9faX7a9t2VXhPeS9+DV+HYCb+NwOqbAP29y+
	miDO1WNosjj5DtDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728345406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fps74rDVAfhly/m/ZgjdKaVWwHmLLKhBirsh9hmxmSI=;
	b=PfdoAor7Zk7x/9fziZAuJqYxQ131Iq8bfx1KML4Dj77SMmemEs9C16MejgT00q9HZoz4uh
	NnPW+55KwZW+3HJYvke7VUVugOBECtAe2nI4RRkHEcldlz5FKqxkxmAO4avCjzdbKzekhh
	kRWyd8H5f/h+0N5MWdG9i92McNg13r0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728345406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fps74rDVAfhly/m/ZgjdKaVWwHmLLKhBirsh9hmxmSI=;
	b=/iEfLY9LVoHPaVAAR/Sc1HQW4MvjYmVAY+9faX7a9t2VXhPeS9+DV+HYCb+NwOqbAP29y+
	miDO1WNosjj5DtDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACA9313885;
	Mon,  7 Oct 2024 23:56:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0XQDGTx1BGe+GwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 07 Oct 2024 23:56:44 +0000
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
Subject: [PATCH stable 4.12] nfsd: fix delegation_blocked() to block correctly
 for at least 30 seconds
Date: Tue, 08 Oct 2024 10:56:40 +1100
Message-id: <172834540098.3184596.16262317375953167566@noble.neil.brown.name>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 


commit 45bb63ed20e02ae146336412889fe5450316a84f

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
---
 fs/nfsd/nfs4state.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7ac644d64ab1..d45487d82d44 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -743,7 +743,8 @@ static void nfs4_free_deleg(struct nfs4_stid *stid)
  * When a delegation is recalled, the filehandle is stored in the "new"
  * filter.
  * Every 30 seconds we swap the filters and clear the "new" one,
- * unless both are empty of course.
+ * unless both are empty of course.  This results in delegations for a
+ * given filehandle being blocked for between 30 and 60 seconds.
  *
  * Each filter is 256 bits.  We hash the filehandle to 32bit and use the
  * low 3 bytes as hash-table indices.
@@ -772,9 +773,9 @@ static int delegation_blocked(struct knfsd_fh *fh)
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

base-commit: de2cffe297563c815c840cfa14b77a0868b61e53
--=20
2.46.0


