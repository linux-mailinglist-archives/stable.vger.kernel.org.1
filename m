Return-Path: <stable+bounces-217590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIPRMIe3mGkjLQMAu9opvQ
	(envelope-from <stable+bounces-217590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 20:35:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D51916A619
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 20:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D833044159
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46367311C3D;
	Fri, 20 Feb 2026 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PI2+27SB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660312D7DEF
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616132; cv=none; b=Qhr2lW5Rd9or9o/nrcga5cJl+UlwBLdHT8fTDFrwjZ3HxvBkLSkIBo2/cpNIKp84S7hEzP5Px6vjqjRHXqkw6OdXzSDPFOD6ajBwsRciWlcR2h8r25UKhdxCu2+UYyl8HNb+vN51YvzyDAfrfIRPwOEjYQiZsQctcEOmWR4Ic1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616132; c=relaxed/simple;
	bh=LYZloxUJSzRdHctVm4Y6mMvZoA7OLACBbBSl/9SMfqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NOXKTLn7gOiFRgXAS0Cf11/MSbNNJzLozyamPooRQ9sESqFqpbk5TBnXmyeU5vMH+AMvXx+Z6BFyyTZc+PBE417oKg6WxpGqgeRHEF3q3Wa5vWoEDgiFLaaVlhd6Kj/UycHo0U4Qf7SWVGxNVpdFmbQ1VljZp1AYGa/vLAzS7kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PI2+27SB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48069a48629so24154575e9.0
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 11:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771616128; x=1772220928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AwRHp70gE2bWaz2xP2c3oHH9CidSSykG+nY7Zt3zE1Q=;
        b=PI2+27SBF2NwUELq3geAXrZM1DPPibP29GSKuoGpEo75zXRYLkhKWukheHNsNZFV7A
         KGa3vUL5PFRDLWOB0tJ1EVEUlXy5lio1q2sUCVght3Ma/CWJGszzaO08Oe32wcqbSiLb
         i39OGBvrEDcZIp+ozQ5cgR5zw8DjrnTQQMkq2s8GMpjBr0K/GjFv1OzAjoNqxHZ/0uiC
         wCP1o3l0X3KllSQ6R/t12lzLKVi0kB/8r1FvUumIXvKprXUHn4pxVm+xPpE+UsHt5AS5
         NP+qt8EFbSW5/pN0pwlRjknCABjwedgnuAQCQwVbwNYWs7bvWYUmCfh5+R4mqfScijFs
         BdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771616128; x=1772220928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwRHp70gE2bWaz2xP2c3oHH9CidSSykG+nY7Zt3zE1Q=;
        b=kYoY7qsxRfXmAbNJ158F/hkGoIBUrxSOKX1ggq4PXnpIyziAuKlQfNUiGXroNNKSC2
         tx6Je7H0kO5Wy1lNHQSrgU6QF5Mfz/ZzvXMQE3bP/S2vvhYvEmjrmG+GmC2J07ZEys9F
         oURAHNyUwSyQpXuU9z4I1RTo+OzCNlk00OB4QtwPYb0i0YVpj/m8AKx77Mhc1Oau0c2w
         NEQkHeIuL0a6d1JSWsxSQX8uASY7Ff//OJfCS4FBR89BbWe3Rz5Ge4gq11w9Unmh/sHG
         ZWqrMTXZxnfkieOPiPDa1nOzFpvG/izpbhCuE8DvoD5xrwOHuyRUUD5IA3XiAD07yo56
         lc0g==
X-Forwarded-Encrypted: i=1; AJvYcCVMHCYFxdzdoPti8kvYanwvGLimgZrC6sNeZEQ5o6SDt1JpLOB3s+1wPULcb+KI742ZVH2LgUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyabicTBYcnl/0vHLfrejE8fr/p1wzpbntSazDw/w4FGVsVpERL
	mk1quhqNRBHfb5k/MR8iv1+ye1AQrXudPfdGM+PKTjEo9dgoNGH3DbqSaTb9ykm4Gz8=
X-Gm-Gg: AZuq6aKH9a+AjrWxiEly/+pNSvJq8zHPJpOHoFPFrM1awfR9nCoLL4vQqfMu8pHGi/P
	U4qRMPjlBOOaEQhhlVkJIZ+AejHNuigLuZQ55u87Q9+AlHmeYiKALdefG6W43tbswKIxSzRklBl
	smZIRDRMRyT8BAmn1O9x7gB2HgKfFRlNrLGfhIZ/qjsKA6gNfdYAUZBuBuWYtq9ljh7jKKrfgs9
	Eg++4bO1ZAIgmr1id4sL+vZccrpQmV0cb+kV1AMW7lHPWth54eziPA8KI3S9wQ3b2bRvDe2SuXF
	CgZqG1166htxZ3PheEOlJXL4OVuYsJbRAcpSxNmTRfeHv4NRE1lyf/vRHly6uFpYp2DJvrPYsmh
	ydGhRdj1uBX9DjNlnEWm+WsolGT9yljeaovWstn5i1srWw8iv65V63feRRGU4NKmoWI7ZA+jwoH
	Q/X1s/eBvbNaUDTHYtY6nDnz3oR5sKjxCnfhXYuinQ
X-Received: by 2002:a05:600c:8b02:b0:47d:5e02:14e5 with SMTP id 5b1f17b1804b1-483a95a86eamr11854985e9.5.1771616127398;
        Fri, 20 Feb 2026 11:35:27 -0800 (PST)
Received: from precision ([179.82.226.246])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5feb6204a47sm245149137.2.2026.02.20.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:35:26 -0800 (PST)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: sfrench@samba.org
Cc: pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	ematsumiya@suse.de,
	linux-cifs@vger.kernel.org,
	Meetakshi Setiya <msetiya@microsoft.com>,
	stable@vger.kernel.org,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH v2] smb: client: fix cifs_pick_channel when channels are equally loaded
Date: Fri, 20 Feb 2026 16:35:05 -0300
Message-ID: <20260220193505.553838-1-henrique.carvalho@suse.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217590-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D51916A619
X-Rspamd-Action: no action

cifs_pick_channel uses (start % chan_count) when channels are equally
loaded, but that can return a channel that failed the eligibility
checks.

Drop the fallback and return the scan-selected channel instead. If none
is eligible, keep the existing behavior of using the primary channel.

Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Acked-by: Meetakshi Setiya <msetiya@microsoft.com>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
---
v1 -> v2:
- Remove unneeded max_in_flight and associated code

 fs/smb/client/transport.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 75697f6d2566..05f8099047e1 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -807,16 +807,21 @@ cifs_cancelled_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 }
 
 /*
- * Return a channel (master if none) of @ses that can be used to send
- * regular requests.
+ * cifs_pick_channel - pick an eligible channel for network operations
  *
- * If we are currently binding a new channel (negprot/sess.setup),
- * return the new incomplete hannel.
+ * @ses: session reference
+ *
+ * Select an eligible channel (not terminating and not marked as needing
+ * reconnect), preferring the least loaded one. If no eligible channel is
+ * found, fall back to the primary channel (index 0).
+ *
+ * Return: TCP_Server_Info pointer for the chosen channel, or NULL if @ses is
+ * NULL.
  */
 struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses)
 {
 	uint index = 0;
-	unsigned int min_in_flight = UINT_MAX, max_in_flight = 0;
+	unsigned int min_in_flight = UINT_MAX;
 	struct TCP_Server_Info *server = NULL;
 	int i, start, cur;
 
@@ -846,14 +851,8 @@ struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses)
 			min_in_flight = server->in_flight;
 			index = cur;
 		}
-		if (server->in_flight > max_in_flight)
-			max_in_flight = server->in_flight;
 	}
 
-	/* if all channels are equally loaded, fall back to round-robin */
-	if (min_in_flight == max_in_flight)
-		index = (uint)start % ses->chan_count;
-
 	server = ses->chans[index].server;
 	spin_unlock(&ses->chan_lock);
 
-- 
2.52.0


