Return-Path: <stable+bounces-237887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IzcDkZI3mn+pwkAu9opvQ
	(envelope-from <stable+bounces-237887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:59:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C803FACEF
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBA513025A4E
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6991C3E63A2;
	Tue, 14 Apr 2026 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzNxhYC+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C59344031
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175172; cv=none; b=dxkuTKqt0PSWbf1NeceRy/q0CMW+Q5X+0Z+kB6UdzQdtapBTDKwYnHaf5R1eB7CNwg4mwQtVR6USK+JlaZWB2olwQ0Og4+J3MYkmRibChdty9MuRhNV1f/NHRqkPka/CYmlDjGIE6B7hf5unGKsdIrGjxhZhMFAD87eW/h9nhx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175172; c=relaxed/simple;
	bh=0HL5ZEFnxyEbq7XV4UUOrpynXy9ORh0SIFW4oCxfPLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ab+O1dAne39AiXo/3WBLW5Q4Fw2XX0GiH8d//yybobTDAxCWA8Idid2tq719yZagUJ8UL1Wpp2YlVLN2HdWCwVV2uMuZWG4YJm7wEWrUUTnLOj0EQMkZFIkdibtPdeTRGtan/NsDOd0fuz20cp/I32q3/nNTDxW3r2D4aHhckXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzNxhYC+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b299b3c739so23988165ad.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776175170; x=1776779970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPwOpTfrLZUEPYuYw9st6aLdCBfwnzGfzeTwyPnHP84=;
        b=JzNxhYC+nJ1DGmjQCh8UvcRuS33G/s/dDNb0eIECWrcuRWLEL5y+8h7DBHDwnTv8ly
         IDfoVCExlGrCUeSwMWihBIaYF+x+P4TPvQow4F2VL17dwd9jLCflMCMXEN66FUOEcyjA
         JlgEEO60ut2XwNXiCq+qPnamV/PTly7StkqmzTUYpsRawTyxkGdrdgy+2hSBkUvIl0He
         h24/Qz06a0giTm8PG5wC/8nMqjTkRhoTlszN+AoHAHsFtXC/SQvXDpYtjCzzKi9LVJfU
         XVoiiObBa36mFFDt+1EBefyQL4pErpRetzaKYhkA7EVbpEdfH87Ia1N6cZ0UNRmVNlN/
         zmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175170; x=1776779970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KPwOpTfrLZUEPYuYw9st6aLdCBfwnzGfzeTwyPnHP84=;
        b=M/GL7IRQSZ5eOpyiawP32muk0qjWs6TojWSYwNQddPNKY4A89D6VjNivQ4KD6AiuKh
         c5BEgEr2aiZY80Xv4cz9z8yYTJ7ZMgK0WBR/KqRlAsa5D57jQFIxvH6xdY3LypZWjCNk
         nwu7xFQD7MUr5zmcY7dzB1kd9iEewn6R+LAKIe1dPMOiC3lj+RAVc0QucDIXU3zQHnBa
         ZmwAZh+sCXJDn0S5QiZ9sXDX9Yjt5LuC1HSwnXS7xoJLGhMrz2Xu4ofQJm2z8biQEtLQ
         v0jfxQ1MaY91prlg9LnbFtOfw7bdmoNeB/0jz7xoKrGxpuxWsZ/65R58nvVAkM6xAZhk
         uo2A==
X-Forwarded-Encrypted: i=1; AFNElJ/80wNx5F5+1IZgaMNtkCb4jkOPlZqN5atsFQscQy1/ssr5J0mEphCowSlr873cHhGQxKSKjiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKIM5i3ihLITrcDMUY2pjpJQG9WroY0vnCWd28rVPKTNo4Bfxh
	nz9fQ+r+j+ojVFnx/lWOoN2qov/J6756aR34yjWmu31GyZ1ua1K6BDbm
X-Gm-Gg: AeBDiet2yIzRCp+3IKu1IyzcqO8jcJz7fDUBhvHsIe7BHoA8FlSrlIi+Liz/RW45cri
	pExzZylZvrTEME77w66n54arf2UGP2PJaMm8sATLHazxKepPcULbKGMhiBeYK0vDDAUXCfpdxse
	92fJ2/0afRaqNLVRTcbBp0Yx7w4Ny5xbE1S6oWgMGV8uuHz2EYHtauJwnfKWWZKMxBAKoUoBxeo
	4+4uwIGRow58ZDWZ6Yj1eqg5CeJ/GuQLfIOnoBgk3Beeuj0rk5z6hyVqtT/ckXibaEi093fbGnM
	sQTcqj3X3Tn0UlUqUzRnK8dRl3p4wzKPbqBa+DTipdg8iaNmTd89M8+FM8w6ra/8jI2scRun6H6
	4oGGnRmzipt7SowoGPbKQhQyJRTBR//I15yTWkqy3e2uWmujSC4chhsAzKQnsQ4Zx89xnCJfNAD
	MOTGl0ICO+yjZvnWCNXVULUR+PK02hcVvAER8oLuFF4SfDWrgNf5la
X-Received: by 2002:a17:903:943:b0:2b4:5f83:a9d6 with SMTP id d9443c01a7336-2b45f83adecmr84289345ad.34.1776175170450;
        Tue, 14 Apr 2026 06:59:30 -0700 (PDT)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4612e60dasm59779895ad.38.2026.04.14.06.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 06:59:29 -0700 (PDT)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.com,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	henrique.carvalho@suse.com,
	ematsumiya@suse.de
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/7] cifs: abort open_cached_dir if we don't request leases
Date: Tue, 14 Apr 2026 19:29:13 +0530
Message-ID: <20260414135918.279802-2-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414135918.279802-1-sprasad@microsoft.com>
References: <20260414135918.279802-1-sprasad@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237887-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.com,microsoft.com,redhat.com,suse.com,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2C803FACEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shyam Prasad N <sprasad@microsoft.com>

It is possible that SMB2_open_init may not set lease context based
on the requested oplock level. This can happen when leases have been
temporarily or permanently disabled. When this happens, we will have
open_cached_dir making an open without lease context and the response
will anyway be rejected by open_cached_dir (thereby forcing a close to
discard this open). That's unnecessary two round-trips to the server.

This change adds a check before making the open request to the server
to make sure that SMB2_open_init did add the expected lease context
to the open in open_cached_dir.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/smb/client/cached_dir.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 04bb95091f498..e9917e5204b00 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -286,6 +286,13 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 			    &rqst[0], &oplock, &oparms, utf16_path);
 	if (rc)
 		goto oshr_free;
+
+	if (oplock != SMB2_OPLOCK_LEVEL_II) {
+		rc = -EINVAL;
+		cifs_dbg(FYI, "unexpected oplock level %d for cached directory\n", oplock);
+		goto oshr_free;
+	}
+
 	smb2_set_next_command(tcon, &rqst[0]);
 
 	memset(&qi_iov, 0, sizeof(qi_iov));
-- 
2.43.0


