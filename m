Return-Path: <stable+bounces-241708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFdJNbHj8GmoagEAu9opvQ
	(envelope-from <stable+bounces-241708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:43:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D4920489337
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF307306BFA0
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C853BAD90;
	Tue, 28 Apr 2026 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVdewnI+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4172B44B662
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392502; cv=none; b=Adfw3mT77FmIw8juCwteZiKjyDD+qkUzaMocS0fDx0NFjFCVmRaKfirvVcx1QTSn9eJ68UBNL4LAYtPXlfCmiNxpgaoeFRW6xTMMgp24cJ3vR3odytzFNeh4yfgrHerEnwmJ87DYfyumkQ8kgPiVmGv0eFQJq5vn2gaousr7BT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392502; c=relaxed/simple;
	bh=eG9ghrqyHv+FTgYWiTsJuJFnXKn0gQTXBQyL1yWQTYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OgiX600xL91iK9POgGqBbDWEJahsh9+Flye+V8kT97b2XZ54M8SClJLFDS/ZdqBbkmnY33bI8CUGaOgf3udxElaywH6H8QgMU/ygl1qaixRMzXjbQwYHgfX3khikXvTRl7xpnAtqrDW5VOxMwbkBq7CKBLtPTsIN7XzfjyVlmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVdewnI+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so5577649a91.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777392501; x=1777997301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k085XqsDoPGBdb9RzNl+RVKDoAd53m9lIegek7QU+Yc=;
        b=jVdewnI+emo4vuLxuv0R0wNaG70YNoIyCaqSlsWYXMqK06tq1A8BNQjU/JhbJNDaHs
         oNdgYlZnueHN8PcP8VU8/M6SyNPNfqMsrByxnfySxmVmFaJDepUfzJUjodUZSLDfH2H2
         JzPW+Cgqs+9y9vprTiUs86esSpS/mBZ6tW9iq8Ks0VcQMIhx/Hc0J/4tPTyxulI2Hqz6
         Q/rqQXerJE3L3y7i/Oc3EBdAMLagFcgtf93qnw7WMKoHKwNf8/ekad5jt8GhQpwsa4nY
         wlBPBJn3zCFTiB+D6uiaCjdeBdTjDNcYzmqq0k8GwqVpxnY6HKe34Gi0rH9uGP8sOTjy
         er6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777392501; x=1777997301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k085XqsDoPGBdb9RzNl+RVKDoAd53m9lIegek7QU+Yc=;
        b=qckXzWbHQ9bmwNdKue1+nsOah69/fYT5En0e4jNmwQ1lvOiB3evRFY9KsUsZjTk9x0
         D+QzzDGN/O18p5ysYxl/XxLKt21HPGmOfV9exXWtn826ta2IDWXtCxt6a+X+8AjmqEiE
         nNAY7OQ+QKdjEZLGiCD2P6WoyhhUPrBmWcAFOgiitBU0JGbO/KEJl/YHOpqu8XPAf1XB
         c78U5IBrzbp+FkEXsFqnpqdM3QgvM7bd7HXhtmvOUCa8RwuGUD+NZihJp7mIiSPfDmAk
         mcNzMvn2aV6bvRk0UOMZi+HP3BLD43MouxSLzkQJDM/Ycr5fA56wZzbWg51NXcFtT4pL
         NJSw==
X-Forwarded-Encrypted: i=1; AFNElJ8Vs+ZKeGIjh7OtcAhwfVi4hI/n2jCSyeXLOz5lZ4l8aaar6fMG8hSc2CtZHEWMyii+ZJXDvUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6r4gsSDG4ZGMgl6TkQUm27310W36JYwTIEncwSXYhJKbjTn+G
	bjUbP3rdhs0ilVjyAcbvlG1Gy0VpBlMF5Qfvsr8UF5xqx3B3cdg5EFPj
X-Gm-Gg: AeBDiesSqp0c3UKmtyA3nGAdv39mQAYAmdH0E5RqvKyD65RsNR24tyPCLltbDvT0EPz
	te7vIJ7CEO6aZy9iMG+NYHX2DWQnNIIED7NOXt54eDR1psv0yHBIFgQk0zxSzpkOXzF9/k/6QTI
	+mlGx4p6NP1htnVHOtGh80lSJPN+00c6qAgwHISKXt5M4X4KiewbuyrIFEHorMmQKGh2aE9AJsC
	iFmCZHmfgRDB8PBFs7xoUcMZ9yhSE33pN2xKalQOSD/IuvW4yVMNNEChHEqM4qV2zyjTIzsM1nR
	0MRZI8UqOEs3Ur0/nUdVyYP6Jt6NP/5m68jNeE6MYwxJTGovl3sjmQWe0c3EYamPX+LjW8/rh5P
	wsTINu5UYPcMLOCYig/DLs6hzejiyCVY28VO/iM6deA5UDXlS0dGNYDtlbonJFC44UaqmqfmvKw
	q5KvkkTL13aHKUTC3JXhFLI9YCoDq2mddBkXjP2n0AjupJ6kI7VsjGqB1kni3lz8+O
X-Received: by 2002:a17:90b:48c5:b0:35b:e4d4:8290 with SMTP id 98e67ed59e1d1-36491abd42emr3672699a91.9.1777392500390;
        Tue, 28 Apr 2026 09:08:20 -0700 (PDT)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97ac7894csm30864465ad.50.2026.04.28.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:08:19 -0700 (PDT)
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
Subject: [PATCH v3 01/19] cifs: change_conf needs to be called for session setup
Date: Tue, 28 Apr 2026 21:37:46 +0530
Message-ID: <20260428160804.281745-1-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D4920489337
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241708-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.org,microsoft.com,redhat.com,suse.com,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Shyam Prasad N <sprasad@microsoft.com>

Today we skip calling change_conf for negotiates and session setup
requests. This can be a problem for mchan as the immediate next call
after session setup could be due to an I/O that is made on the
mount point. For single channel, this is not a problem as
there will be several calls after setting up session.

This change enforces calling change_conf when the total credits contain
enough for reservations for echoes and oplocks. We expect this to happen
during the last session setup response. This way, echoes and oplocks are
not disabled before the first request to the server. So if that first
request is an open, it does not need to disable requesting leases.

Cc: <stable@vger.kernel.org>
Reviewed-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/smb/client/smb2ops.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 509fcea28a429..a9d68e5fcea91 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -111,10 +111,21 @@ smb2_add_credits(struct TCP_Server_Info *server,
 				      cifs_trace_rw_credits_zero_in_flight);
 	}
 	server->in_flight--;
+
+	/*
+	 * Rebalance credits when an op drains in_flight. For session setup,
+	 * do this only when the total accumulated credits are high enough (>2)
+	 * so that a newly established secondary channel can reserve credits for
+	 * echoes and oplocks. We expect this to happen at the end of the final
+	 * session setup response.
+	 */
 	if (server->in_flight == 0 &&
 	   ((optype & CIFS_OP_MASK) != CIFS_NEG_OP) &&
 	   ((optype & CIFS_OP_MASK) != CIFS_SESS_OP))
 		rc = change_conf(server);
+	else if (server->in_flight == 0 &&
+		 ((optype & CIFS_OP_MASK) == CIFS_SESS_OP) && *val > 2)
+		rc = change_conf(server);
 	/*
 	 * Sometimes server returns 0 credits on oplock break ack - we need to
 	 * rebalance credits in this case.
-- 
2.43.0


