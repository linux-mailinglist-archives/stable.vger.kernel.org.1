Return-Path: <stable+bounces-247295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOlgH1xYBmqhiwIAu9opvQ
	(envelope-from <stable+bounces-247295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 01:18:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A3B547B8F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 01:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F182E3019457
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 23:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1314E385D99;
	Thu, 14 May 2026 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DbA82i2m"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6202848BA
	for <stable@vger.kernel.org>; Thu, 14 May 2026 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778800727; cv=none; b=NYfN3ItDT8lCngBJMozrHTrz7MOqDa+vmntO7+DpfpiYVIvU+nlPfYalOWLFkqLM21H//SKg0E6i/XBjcWEndvDOwMmPodbvj6LQLKiQdz1KXjtJ89IqX7hmo8jI492AUyrKFrtEe0hGq98af41mrNIy4w8I4C/a7OV2gNzM0Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778800727; c=relaxed/simple;
	bh=XrMkBdpZfBfrwl18U5Iyv7buDmPxsRiikfLipF72/lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkYpDF5N1PderDcw/nyph7M0Cafw6MhZBCDm0wIGt8bnyhzo9pSbcpj9j1VedMoZkP2fhra4o3iR8o9K1TXVPEfK9+Kbrf00jyw7CSrh0G14k8f+09fUaTDOmvcex2zlOVVmPA1p8MXirpBpHvFv5LxKgBb2EeleLzHBq2bQqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DbA82i2m; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48fde648a71so2369125e9.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 16:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778800725; x=1779405525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CEcjccSetUkCfvsraURt9Kb/3DzTCF6WDljez4BNutw=;
        b=DbA82i2m76lPU415o65a4Wj2eDHXwLy8koNmiLqy6Khr1ZNPAcdiP/nSpL2gcmIiDU
         wqxgYYptZYOkSLJi2Mv5rRBREtZ/Jkcs0hwB+tkU7fJp9WZ1d7oFT80OCtga/Q1OCPvw
         iw0QG6fo3S08CpgSSY+gXqfityvBy9BD0eHIIdCwppvji2XRDQBMA66y1sEj6+BPDESG
         m+IQxo80B40q5NIF0t6acurC7OEOzSS4MtixeJYglmbS0RU2tVqLbQQ084P/ip7Za7sA
         Pr8g4CQxqacIPGLal5UzW3t1MdcvCAVrI/9Zrrw+v+T38eB5LQ6/dkQo9GCj9m8cH/D3
         Sypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778800725; x=1779405525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEcjccSetUkCfvsraURt9Kb/3DzTCF6WDljez4BNutw=;
        b=qFYxNFzXfGS1bbtS0v1fz8WBzztwdxtxtXcqKNirJdmq0alWsJE/iRGK5CIaC5ZO1D
         jVIttRsPM97PNP1Ng+YQsBBO848AuPPA3l6fONsIjTQjpm9qncpfnyOdfgCcyZnLDGKV
         5fqmk86aYwaswro0OKaUBp66bXam0h5kgm78y1LRaZf+veFaEYkG537QObnwciJ9Ijkr
         R9mPHRuYqCwMQYSag+KPOebUtgJbttm1s4ILJWpBxDKXhsNbtqUKz5YjtSiBg09NqqRX
         ceQQSVsKv8KjHSi8g4eZQb8wh9R6TeOM+Ojyad/O+1nYWLCJUARGnhKcj1OnqV07mP2B
         29cw==
X-Forwarded-Encrypted: i=1; AFNElJ92zbRpD8xAgjWpQJHpbbutBZ2thNm6qGTh3z8sFxTlJnB2aPWYV9nR/nasZYnUhCprGfB8iGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwYRAfK+Z/5A5NTa4Ryyj/hDmujD2NCS0tYOtxBw/AILbGfULy
	TweM02A2SMUn7svr5GTbxU8mv5SJ7x7jE26ZpSV3CaKwNxStvnMMQYIex9X4o9ml86Q=
X-Gm-Gg: Acq92OHtfcbPqIGdh6JKnWZ+7r78EJguywUy6NkpsDP0YyruJaH8/spfA/vTW4peE5x
	qkoVOmzx0rs6FAKgRTDgvCCWTkU0CU47Uke9QcZXQTv1iwlcU3lFkeNHT67PATYicqIIWYIn7H4
	OOav8OEAiCucQRU9mIPpdG3DQM6Dh7VRNPUP0HqYuqJFRf3bAAOIyDXWMman/HvcD2JoS7Rg1x6
	LqWV0ygdvMSLAsM63T8E8kbRVWJlKw5Ql/irWdQb8uUEnn6r4Muz8mGlSEkDiBuPWfP2eB8xBYX
	59rOEWHT4FhtjZkoAWGRkIxmWLuelXS3rR9I5fvedu2Y/WcOV94XXL76N+OqZV5Ec0u42Ug6qH5
	5DAhjgSc6KPRL0iU0J2VlAgpoZcqPVu1F1FhJfbv/FREATkft/Qjm4eiC2fAZjMToM+v+XoIZrd
	PLQWg/+udV8q64tcQs3SGA5b65nD6sX1vP6vqe8JZXoxjJbgzxam9tAzAbIAtPWMXsGhzKdnNue
	02t
X-Received: by 2002:a05:600c:a406:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48fe4fa1902mr15869515e9.6.1778800724991;
        Thu, 14 May 2026 16:18:44 -0700 (PDT)
Received: from precision (ppp-88-217-117-152.dynamic.mnet-online.de. [88.217.117.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm39314595e9.1.2026.05.14.16.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 16:18:44 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: sfrench@samba.org
Cc: pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	ematsumiya@suse.de,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: protect tc_count increment in smb2_find_smb_sess_tcon_unlocked()
Date: Thu, 14 May 2026 20:18:25 -0300
Message-ID: <20260514231825.63211-1-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F3A3B547B8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-247295-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Action: no action

Commit 96c4af418586 ("cifs: Fix locking usage for tcon fields")
refactored cifs code to change cifs_tcp_ses_lock for tc_lock around
tc_count changes.

There was missing lock around tc_count increment inside
smb2_find_smb_sess_tcon_unlocked().

Cc: stable@vger.kernel.org
Fixes: 96c4af418586 ("cifs: Fix locking usage for tcon fields")
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/smb2transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index e8eeff9e50d6..1143ee52470a 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -169,7 +169,9 @@ smb2_find_smb_sess_tcon_unlocked(struct cifs_ses *ses, __u32  tid)
 	list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 		if (tcon->tid != tid)
 			continue;
+		spin_lock(&tcon->tc_lock);
 		++tcon->tc_count;
+		spin_unlock(&tcon->tc_lock);
 		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
 				    netfs_trace_tcon_ref_get_find_sess_tcon);
 		return tcon;
-- 
2.54.0


