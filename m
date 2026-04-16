Return-Path: <stable+bounces-238367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN9zGAlS4Wl5rwAAu9opvQ
	(envelope-from <stable+bounces-238367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 23:18:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D1414DAA
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 23:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90473307C757
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 21:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926813750CC;
	Thu, 16 Apr 2026 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q70FK54Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5347B372EE0
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776374266; cv=none; b=Xcrqq2YnW3HTkx9WdyXvkYhbsVNlyD1pu2Kcot/XPh6nj3elrBz5oqurpgzTpbqExRaSp70OelBYMZSYOXu84w6GhuJ7FYNbSHqGHzTUPNcinMk3eP3kgmkV+XsO61xclWNCg9O5ECEeeRPofzBPyBZqoeNsAKgRwg2Az4SHTmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776374266; c=relaxed/simple;
	bh=ygvlKmBj9cpYvhipO2GVwDfNG6msc7IzLgEFKCeFaeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgJzB6nJt4DkPO0jdKCngLZV2CberbfSgrkPpfor5PpoBEzkTEWI5z5unVZ+a6MrYkwaqX+mvsYFw3TdvhqO9hSvQ+kFDynhhVAAqCLK0u+9G/nc9c738tUeUvqsad/2QadJZzRIac5GAp6jkwobE3yHTh3Qw8qZR8gDlI+oIu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q70FK54Y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f1f03754bso4490b3a.3
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 14:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776374264; x=1776979064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ird1RbhcLmo1n1pSfDlmYxFmBRF3j4BNyuXGOX68NCU=;
        b=q70FK54YViXIXpJuaikoZYxg2xKb2W0PEU3gTf7E9f4UcF2I+nBTCHkJVIwmznLZvz
         k9qKpgYN2rfZMb/eowl0luvVUNeFc3c2wv/YGpFx/IGPEH93MTo/gRgklJUZ4RWuiMEG
         OT4I1BufWDpQEX/kT7CA9+i3sjHtoHtI61YOFgtdWuDkgni4JM+pOhY3ntAqCop2uoSA
         Hp9FIie8sVxBWE6ACoXxeBIL5H/5CTypV4ULIfKdTWtbooKcRxidYxZuGE0B0O6+mcpG
         I2ze6Pa4Ckpvx+b8FY9il9Z+Cd6xOdmLAd1oPguVwwaXJD0+PJM3kdV36ShlPxDkY7Jv
         mHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776374264; x=1776979064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ird1RbhcLmo1n1pSfDlmYxFmBRF3j4BNyuXGOX68NCU=;
        b=ptfchzI0moMFzqaDFBne6CGFvAPJtsLDJo4OjlG5k7d8H0h/GOc+hiha809ImiJmGm
         84PFhYP0jVtsCHmRzdNRIFTN/FxMPRI1Vr1fZCVC+p/Cm61F1kcJz+ZxnVWevU7XZQ/q
         tq4gsEJlJDoJW1nqOJnXH3+BV2N3koiJrY+MUqxRdSIbO2T9Y/cUb8mx/L5aOyuFEqme
         +24ldbd+bepIRkWPcqCtIG+lSzg/NcRjwPvm3JY5mjCNuq0b10krxf8rZFwzTvtvovRS
         MeW8DC3BSJ8TFMEN5lCRW6aICkQ0m/7QXzE9kHUoybmjU3xqmfxiSXJHV/TwmFL/cp3l
         o2Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+3cicoQTKuuw49mgRhahw3ibzYDl9zgOIDjt5PSqIy7M10H9fqZQ3zfe6rErPcmytz+J0MAAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFcIVB0ICR6F+k23OAL7HAYI3VO5X4/JqVQjKyUB/rQtr5dsH
	+AuD8iOXqVs1f1mGRnlb23ayKKdCMi4Nt8YJOK9W4Hlaa0ukPwb9FpmP
X-Gm-Gg: AeBDiestnBJpMbagTifmn86aTZUVuebYPfmU7Uvjkcn7Dgl6dr4uwodfGyLon3pCXes
	chUvCmDTkyQKfwtYISCELpUNfrm+InhAb81lZryk7IR5JTf3kS4mGHX/e3KoNePjJK5VMjfn8aS
	2ntSrDsCTamTTjCdZY+dV3K5T9xPnpSUKQ5WuP+efC6zPmd0hWwZFKCqqfYTeQPhyDCDFsQ6l1Y
	mEz33QRKujSSl4P5ZXnHbobdIR/LZXLTb4T98Xc77cxPGTBv8p8hBwaUlTTPbLLecxR3rRz3XdD
	g4+EHCpAFVwLtCbUgmtb1rDLXZiS9P6Leami/7BNdS4gIBSZRiia9nEmgS916+9dYr3u8b4HdZt
	u0CnfDlzYwGG7moGMUIyBZ8U4reOYr3ouqfvHnXnlXcezwQywXhIoHbTij5U1pMv+qGowoDeotk
	DUDlcFQGHqMA3aCLXlkjX1vB2Je7w=
X-Received: by 2002:a05:6a00:1994:b0:82c:24a9:d5e5 with SMTP id d2e1a72fcca58-82f88563412mr472762b3a.2.1776374263639;
        Thu, 16 Apr 2026 14:17:43 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f674140d3sm6134414b3a.44.2026.04.16.14.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 14:17:43 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH] smb: server: fix max_connections off-by-one in tcp accept path
Date: Fri, 17 Apr 2026 06:17:35 +0900
Message-ID: <20260416211735.3558718-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[chromium.org,talpey.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-238367-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charsyam@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 179D1414DAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The global max_connections check in ksmbd's TCP accept path counts
the newly accepted connection with atomic_inc_return(), but then
rejects the connection when the result is greater than or equal to
server_conf.max_connections.

That makes the effective limit one smaller than configured. For
example:

- max_connections=1 rejects the first connection
- max_connections=2 allows only one connection

The per-IP limit in the same function uses <= correctly because it
counts only pre-existing connections. The global limit instead checks
the post-increment total, so it should reject only when that total
exceeds the configured maximum.

Fix this by changing the comparison from >= to >, so exactly
max_connections simultaneous connections are allowed and the next one
is rejected. This matches the documented meaning of max_connections
in fs/smb/server/ksmbd_netlink.h as the "Number of maximum simultaneous
connections".

Fixes: 0d0d4680db22 ("ksmbd: add max connections parameter")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/smb/server/transport_tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 7e29b06820e2..5e85341698c7 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -279,7 +279,7 @@ static int ksmbd_kthread_fn(void *p)
 
 skip_max_ip_conns_limit:
 		if (server_conf.max_connections &&
-		    atomic_inc_return(&active_num_conn) >= server_conf.max_connections) {
+		    atomic_inc_return(&active_num_conn) > server_conf.max_connections) {
 			pr_info_ratelimited("Limit the maximum number of connections(%u)\n",
 					    atomic_read(&active_num_conn));
 			atomic_dec(&active_num_conn);
-- 
2.43.0

