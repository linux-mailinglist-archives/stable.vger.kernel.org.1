Return-Path: <stable+bounces-246658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDngD3mKA2pN7AEAu9opvQ
	(envelope-from <stable+bounces-246658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:15:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF71752903D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4DDE304201A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62333AE1B8;
	Tue, 12 May 2026 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZmC/t8d"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75770235BE2
	for <stable@vger.kernel.org>; Tue, 12 May 2026 20:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616948; cv=none; b=HDBBaUDMLtVklGvw3vi9JxNRZhp5AoDNQ2h2VcazWIBAfxxthhy86eh9YvLDhz5f5aybrlRbTAn5AKWwYptmW6sEFdV3g/2b5A0ef9GuYU7ghDMTg9X4l4GP4w6X3jhBQZW0RMaX7uc3VYyfduw/DLmaSWUAf8NOihV93mvuPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616948; c=relaxed/simple;
	bh=WNm8KtkMynSXJn8zMi3evEVkOyq9VdKE4QPBfYRIxPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lH0GPWSnAYRw+maRNy7h/SMmr/cWuDQpU8+jgVB++6dyJoAR27ZzyPXgbYPbqpGWqqF0EL6qB11yePhwZzuf64sINFTpU/Pqnh/uYYzlZ8Ua+A9enjuNezJ7PkbTKDeVoFvJZ+CATBrO2nNgf1gOu11Gmp7NLtEJgmj4dQmEkHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZmC/t8d; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so325e9.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 13:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778616946; x=1779221746; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CIupbo51IGhN60EFnqfQU2Ebmv8B4YfVP5HZZ1GR0CI=;
        b=GZmC/t8dWLjNF6GyGgg2zeoCrSC53OGVbKi06XXkxtjRG/AeYkKJmo3CNtHArcrSfO
         p6urN9homQOJBjJQ/KI5x3Rdfe0XydaO64ldZH3C3MB4WJeVqjqmnVZtr3T3fc1Ns1Oi
         LLwjPtfCnPeel0tmiuUEGpAlT9NSJjLWH26tk3AUy73gPTMpOmDmPujD5th4yVrHtjit
         Lvnekz2awCs3il+RgUQtnkowyiVda1LCO67MINb/mWNBFK0+y3PnwkxNJcvSCpaiX4rc
         6fEn6t/IG0m/Wza0Lj6hJvBw23L5pUcH0fhSbYj7DjEyq3IEyfepsVEwDkAVtPQSZ7MY
         dGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616946; x=1779221746;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIupbo51IGhN60EFnqfQU2Ebmv8B4YfVP5HZZ1GR0CI=;
        b=dHk4i8DqKQ4PanJJV9RXdS4NdGXmS2uJWeaqYevRZvP7fGL3P2GsHbTNQ+Utd4QP4r
         lL8K7n4K0suGt+Q2MitbQWCugpkODbhQq/0+lZ+nKgEqOlICRkW1yV6K/tsFvuj7voGw
         rVIYFMMq2J5hUsgA+jQuivluA1lvLMf/sGIRc2ggjR6zJwtRLwTdCOKB7AUKGmbVOoTB
         xfgKAyjK8LROP0rfSpkgIqGMZnTH0t+tzgVQh0uhdpeVGKO2jIc7LrmtUwubwkmcgvwc
         ky0mZa5Qt/ZE226v1Vy2vY9Dl8AW6Jwla+dpbGhhSAghzVGkrtDOrmQNiGmqv8VUnItu
         5SNA==
X-Forwarded-Encrypted: i=1; AFNElJ+vPFEFdXWzTEwPbUpo2SXMCWr3b9KjtMyuXzcIq3hQVYxfBOXAIqx6VNy8zVu7wFBT89+bmQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF754dimCq8NHXvh154IUrGLp0sPfionWPZM6xuEvmTo0OH11u
	fyL0cHDxb9jeU2ObvJ4w6gdLRkV0qAnD609TSrkA70IrgBbSc2JvWlFkGeoXYtvjyQ==
X-Gm-Gg: Acq92OHAxYod8+Xz4zCspv4b9UhjZlgmO5wGuecuFDTgjqs/fgXOpmwyAwlE3ITiK9H
	ZvL2bc/Wo4oLu40L56Tq5PXGHEhhp/nMbCFc/GOmNmw0eH7+EI49ADeHqtdMPbnU89ebiFJ8DW0
	Xo1FRiqBvx6PTRnP2Sv9o2b0pBkdHiTOrx9OU1rwVVz17fkjHVnq+wPNtFXqnsfy80osSsXdBMN
	2P7GWOE0QSAHtAYhSCp8Eb88tdLqsEL3XDeOSIGW1Tm4U8dA5b89Ssymrbp9VyUZjmq8LiqdXUq
	9iGfS3zbSLL1ULPnFlFi3M4TzsEeaUKbMGvnLlElwOahm8thUQiTW/kJH4XxpSE5S2BGihu9uDq
	3h+cIdpit9+iBnuY32LMsZ3dZIvje1SZK+vA2gc7lYyRoHpAQwrp1cq4np7vvcketQ6Hlm7XStX
	tFsiTjTrzqAQKdf2vatP+TvjA96NHeotuGtL+++7lhHPTdcWC9d2KXhYqnd8et3g==
X-Received: by 2002:a05:600c:8a16:10b0:48a:5618:b4d4 with SMTP id 5b1f17b1804b1-48fcacd0d81mr18565e9.1.1778616945526;
        Tue, 12 May 2026 13:15:45 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:118e:a0ac:896b:9240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ba2aaec3asm5188055f8f.15.2026.05.12.13.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:15:45 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 12 May 2026 22:15:39 +0200
Subject: [PATCH] Bluetooth: bnep: Fix UAF read of dev->name
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-bnep-add-uaf-v1-1-f62ff8f61d50@google.com>
X-B4-Tracking: v=1; b=H4sIAGqKA2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0Mj3aS81ALdxJQU3dLENN00c2OD5MTUZOMkQ2MloJaCotS0zAqwcdG
 xtbUA1+dPl14AAAA=
X-Change-ID: 20260512-bnep-add-uaf-f730caec3b13
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778616941; l=1405;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=WNm8KtkMynSXJn8zMi3evEVkOyq9VdKE4QPBfYRIxPk=;
 b=Jk+CHIi3IXpkUb4fRpkzyOJnaHT7yYuW9WvfKSNUKNat/oU/e1mPsxtYD1CVoNJuGFauAaVW0
 f8489CrDfHvBKBN9Jsm+t63TuTAoKdbnarT7plEbvuKkViiSu/k559/
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Rspamd-Queue-Id: AF71752903D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246658-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

bnep_add_connection() needs to keep holding the bnep_session_sem while
reading dev->name (just like bnep_get_connlist() does); otherwise the
bnep_session() thread can concurrently free the net_device, which can for
example be triggered by a concurrent bnep_del_connection().

(This UAF is fairly uninteresting from a security perspective;
calling bnep_add_connection() requires passing a capable(CAP_NET_ADMIN)
check. It also requires completely tearing down a netdev during a fairly
tight race window.)

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jann Horn <jannh@google.com>
---
I have tested that this bug can lead to UAF by using KASAN and
introducing an artificial delay with mdelay().
---
 net/bluetooth/bnep/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 853c8d7644b5..0de5df690bd0 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -645,8 +645,8 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 		goto failed;
 	}
 
-	up_write(&bnep_session_sem);
 	strcpy(req->device, dev->name);
+	up_write(&bnep_session_sem);
 	return 0;
 
 failed:

---
base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524
change-id: 20260512-bnep-add-uaf-f730caec3b13

--  
Jann Horn <jannh@google.com>


