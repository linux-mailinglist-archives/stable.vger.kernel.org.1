Return-Path: <stable+bounces-242326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEjTOfCM9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:22:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A61004ABF58
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F063B300D1F2
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4203A75A2;
	Fri,  1 May 2026 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyAE3tWa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D33A5E92
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634435; cv=none; b=Cqz4o5exAx90pR0S2+2JrQmPGIJN8bGGnEmpdumiuZG9KINr4KCI5XhZNOr0b2gRMjuDVvXNOks3+3QMWUK8juLzaufq4N4G8itzHOaX96NaIIjl5LapjTuRcg9SgJdcT7ugTnuGGe2QD//0ugqUpTI2TnzXjJ5BVINCqoWpS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634435; c=relaxed/simple;
	bh=8qx2DRUX1B48lgDcMV0H/JoKZ5REdvkIb7aId73YRXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBG2egKmk1zSnXSY+uR4dRj2Vy4VeRufifrff8Gf5tIiD8eX0I9WPQ7Me59ayeIix3P39Bse/tO0efEI/5xNIMa/b1fCzIfMbEnzyz359FSMVM8i8HkO1p481MDOtRN11REYsTnsPGVXMazKYmJ9VfL0J51hfxxhfU75FR+Hk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyAE3tWa; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8296d553142so1244069b3a.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777634432; x=1778239232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMpfJfDPYLUjScq5XH3LfedUkhoimyWrZal8ssI+6ww=;
        b=pyAE3tWa4H76IrY1V5zhrKlgEPf8fz7lqrhU+L4fmmOWgQHbT2J6YCMlBW77Ma68oG
         cnQ8KnPJcUHKoY+RWeuMBlODBnV3yR/P19x4DCepwcVIk31/NaSyZUd4QHSk22DhOmBH
         PcIEYvHIxV0PN7rTgFB/JNdEi92kp4pna5lmD1rf/jKAIIGe0pMBlKgKeHDNBTQ4YIHC
         dFLbA04gpZFGh5Dw9pr5j3ghDiOjXSDMDuR0ws6mJy89ziIsFyV1R+dEKSvA2wmNhS5v
         rJ5D39oiwZ5PV0tTG52+0x2ew3WYp4HnaT+m4j9Ay4M23tXPfsWvKeUFzRUyajMunSMK
         xolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634432; x=1778239232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tMpfJfDPYLUjScq5XH3LfedUkhoimyWrZal8ssI+6ww=;
        b=n8dMmaHeIvEM66V6ZZnznVe6BatZ5OnyMquSDCB7UdBrDG4gidlRrLgZH6xxZj2UDI
         iVmqZMWG6yeZJmtFuywe0+7ytvSGvrwRbHe91GwRmK6TCz7/7+/1BrfGjpr+aG9cmSBY
         ieP460H26Tf1i8PMg56L0IIbnYW/aeXn4SNcNxpAplSlnpaQZW18jtYhV5Z8g+CdujfN
         E7LmjphVyZkMWKSs3BM1LcvB8QFF/HNpnDRaCfPvPZ08KaaCllzY4fq/436kI2Bz7FiO
         lJmzdJooOBfWtHoV3nStpx4zb1n8ijgtfO7XIpUBmjucwF7EUqRf4II6hhmp9cux+yQm
         FbNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8d+AnkehV1EHj32+3QK7imXd27bjUUa0WrD9akA7VbCgaibsiJ4R67cnwIMs3pmUr74xZAVWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kByoa7Jc1d6MwnnEey7u4r7RSoGW4JzliOWZrSVI+Zyn882E
	+JXuH9GxUwPjbw88p3E7LLU+yE0edM7PJ2XW33Wf2tE4uYBAl//U1Lph
X-Gm-Gg: AeBDievbFwwN4rFQFgqXQh6ZOzkZgC8EJbuG6kQ7IPXCLkVXjJ8JwmTxtpvsVzhstRn
	tIPbld2auQmxbTHmI0K/6hTURJhOly4M3oBnJsrjC19RDOHng8KyX/7ShBVXGvdxqbDIaSkFnXG
	PJn4JfcDI106OOXXixIl59nWDtCwn+/cBV6cU90YDmxvkSDruL2qo3ReK2scvsjTWeST1yzIfsX
	as+WvSFBLGSBNqDrrXaMxooXXds7cWr3wED5LmU9/9KrP/EzLrTWlksKNjng5O9FxyUzTzNdvnu
	4n3af9ElA59pyACrnnVa9AQRtHo2brp69aatOtJv7IEcx1Y0wtlq+fM5XiMbZ9a9KbfZNqedQ6u
	x3g3zonzbWly2OK+cNtNtEIwpC+4XuA2IbfFvmPlDcU7OKPG0LaRIytMnLPUpxYrAsqS1hs7sqz
	YtlN9pd6CS4sc1lL40HDUwz13quLKfk4XYDS97Glrbf8q7cK6v+fTk7XU5WJubSqMl
X-Received: by 2002:a05:6a00:3d51:b0:82f:8a29:e3de with SMTP id d2e1a72fcca58-834fdcbcd85mr7927940b3a.40.1777634432321;
        Fri, 01 May 2026 04:20:32 -0700 (PDT)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351587db67sm2331922b3a.13.2026.05.01.04.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:20:31 -0700 (PDT)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.org,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	henrique.carvalho@suse.com,
	ematsumiya@suse.de
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 02/19] cifs: abort open_cached_dir if we don't request leases
Date: Fri,  1 May 2026 16:50:05 +0530
Message-ID: <20260501112023.338005-2-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501112023.338005-1-sprasad@microsoft.com>
References: <20260501112023.338005-1-sprasad@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A61004ABF58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242326-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.org,microsoft.com,redhat.com,suse.com,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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
 fs/smb/client/cached_dir.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 04bb95091f498..64e22c064fa0a 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -286,6 +286,14 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 			    &rqst[0], &oplock, &oparms, utf16_path);
 	if (rc)
 		goto oshr_free;
+
+	if (oplock != SMB2_OPLOCK_LEVEL_II) {
+		rc = -EINVAL;
+		cifs_dbg(FYI, "%s: Oplock level %d not suitable for cached directory\n",
+			 __func__, oplock);
+		goto oshr_free;
+	}
+
 	smb2_set_next_command(tcon, &rqst[0]);
 
 	memset(&qi_iov, 0, sizeof(qi_iov));
-- 
2.43.0


