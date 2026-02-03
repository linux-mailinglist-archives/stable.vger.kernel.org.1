Return-Path: <stable+bounces-213266-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDI0GKEOgmkKOwMAu9opvQ
	(envelope-from <stable+bounces-213266-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 16:05:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A3FDB025
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 16:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3FB230929F8
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087663ACEF8;
	Tue,  3 Feb 2026 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="o46FXCM+";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="8xz6fSp9"
X-Original-To: stable@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045CE3ACF11;
	Tue,  3 Feb 2026 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130622; cv=none; b=Af6vibqqu1LxghSfmuffQrLE7UroSsxQNC0TXhDbuIwge2zvTIhTL6tZm9yfkRue3HdvZ4Oif1Yv1ra4fu5kqLfRjjpREpP4t6d5jjv5ERgSkLSJ7tmOIIwAexU/9lYVyBeQbZdqLaqxIvmAp7E++DDlYis8j/houFri0o46CQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130622; c=relaxed/simple;
	bh=XG3DmAImWxGqudTSK41j5aKLlSqqwI/FPGYAG/KtiXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4b65v0cJcj6WQk2TpNgrj+7qeivMmwS9CCIvL9RsXaCOWYyj5xxhZL0QRA8aKgjCACbvHeYSa5nWcKgS8xcyUTaHorXRrotMp068pVnBKO8mUqmuWf9oI/yHPJXZBDcsd9mgwuIzf2uIsHrZ/TKWteWN2x/fxyRrpQhJ3W2YUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=o46FXCM+; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=8xz6fSp9; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770130581; bh=szecMzJ3VZvPskBtJKybsa8
	umXRli7olty54yeUND7Y=; b=o46FXCM+5TCKFh2AaiuomWmR926yIG3ne1dYJuH+8xX+ImCo2l
	Ae3r3L8nLW+lp7p+NBHrNy/yqQmVXkMPJFGdvcgrRpWPUqYseTTd72X43c4899Cqg/elhrK9ARq
	e+dVtCjCNghoa1heI7j+jjZ4lUxSQlyPdEkD27NXQsgwhv9+gjJYsJX2vfyZ60V3bp0vukzVFTa
	R9C0sAlbS2EGTOlSa5LjA04seheP+AjpviVSdX8+lKiBKqVTpmZFkZPrPWALF8Y7G95YxmbvAna
	VkuI0Ca9+xIozNUODG9jchmIy+X21eqlBrPAlUZcL4neInezwixUi9K/GIm/Tc/JTmg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770130581; bh=szecMzJ3VZvPskBtJKybsa8
	umXRli7olty54yeUND7Y=; b=8xz6fSp9la1nQGJstSiVVZZr+PvKJ69wqcnkIu59/zd73wUShw
	sKh+T0ML2jwcU17/OR/wIThorzz2s11hJuBw==;
From: Daniel Hodges <git@danielhodges.dev>
To: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	ying.xue@windriver.com,
	tuong.t.lien@dektech.com.au,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Daniel Hodges <hodgesd@meta.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] tipc: fix RCU dereference race in tipc_aead_users_dec()
Date: Tue,  3 Feb 2026 09:56:21 -0500
Message-ID: <20260203145621.17399-1-git@danielhodges.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[danielhodges.dev,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213266-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@danielhodges.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[danielhodges.dev:mid,danielhodges.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: B7A3FDB025
X-Rspamd-Action: no action

From: Daniel Hodges <hodgesd@meta.com>

tipc_aead_users_dec() calls rcu_dereference(aead) twice: once to store
in 'tmp' for the NULL check, and again inside the atomic_add_unless()
call.

Use the already-dereferenced 'tmp' pointer consistently, matching the
correct pattern used in tipc_aead_users_inc() and tipc_aead_users_set().

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Cc: stable@vger.kernel.org
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Daniel Hodges <hodgesd@meta.com>
---
 net/tipc/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 970db62bd029..a3f9ca28c3d5 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -460,7 +460,7 @@ static void tipc_aead_users_dec(struct tipc_aead __rcu *aead, int lim)
 	rcu_read_lock();
 	tmp = rcu_dereference(aead);
 	if (tmp)
-		atomic_add_unless(&rcu_dereference(aead)->users, -1, lim);
+		atomic_add_unless(&tmp->users, -1, lim);
 	rcu_read_unlock();
 }
 
-- 
2.52.0


