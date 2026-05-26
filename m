Return-Path: <stable+bounces-254368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJmDMdmoFWqJXAcAu9opvQ
	(envelope-from <stable+bounces-254368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:06:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0797E5D70AB
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC42D306194B
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE453FAE15;
	Tue, 26 May 2026 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrMTZ3A8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE93B2FE6
	for <stable@vger.kernel.org>; Tue, 26 May 2026 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803979; cv=none; b=dYnb8id7bRA6WWd1j/M2zi5Cabryc3O3woxBLwZHyOgtWbkgv522jBm1XvH/Ke3RXgEvQQCh+iZijtpu2+QAjUIoUYsNlJVvUpd5Wvc3LACPNlbIwrTIsP0gn0aof5Ms8HLaruw6Joi3QBgGzQ/+bSw1gbXd3ilp5mGScPnkKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803979; c=relaxed/simple;
	bh=oi8CEqX0uFevmntGh4NJtsQPvPMPp25lfU15JLRia6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k88XcVmQF1fLv7bDvoRezUh9ARsxNujar3SiC1h+jBwzAy+3cB1DKF26LVId2gBPu9r8wv5jLzU4P0vxuAHfwlvpaeAqjgRnvLWKYNhBsXs5f6Hwt4lGYy4k037fU2+ogx1SPVw1Y1fd+kvHxw13lEm6bZwARkbMH2j5DUTSB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrMTZ3A8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso7692055a91.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779803976; x=1780408776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBdZkb2RwHxx+FNg+ugjHpoi6ESbhLEgzYBxG/HNPgA=;
        b=qrMTZ3A8evZF+7BV4IPOIP59QEHmnbm0pAtdDJTCbf0LLp6PYMHq1epHgJyaf/Jcrc
         lm3V+doo+2JNISEwGF4ALhNXKoFzb2T7GOiBsXRoAJV8+s7Hk++zrjv2jw/iP21JvSGr
         Dy0SlgX7VC9oSgYrfObYpmJ1V4W3Poq6vfePE2L7WuBe+dV51YkXp4aJBL9lcwZ/LcXY
         LwC5R+S1wf9uneTBjK61FWiFMHyRWM2r1efOsG9RUlP9MidBc4AfDXLCEfRkOW58K/jz
         u4Jx5pr9iriVcFOBl5Emft9q03ehfsIXEbJP/ZD7TxFHq1ohoXk0/2NVlx4EvrIBiCRG
         xQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779803976; x=1780408776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBdZkb2RwHxx+FNg+ugjHpoi6ESbhLEgzYBxG/HNPgA=;
        b=mzowhTYDX4NKbjpvS31Sgr6uBrgd3XmD4bR5PcSFV5cqPF/iIld3c1qgQyVN08LuXm
         /Ru5yNr7qFUXXPtOB9V6sySH+197wbtCThxigLhIF0R5GVfgLCycoYRayqFplQqpBSzb
         bn8pwmbG9x+yv0wDb8c25+WtikT8nWDbo/crwFMjkXPs3ZREiMLoB1Seg0QHE0yjbcFx
         Uq7SR21ZwN2vqfkMwWGvPq5jgDUNaVsof+SMaPSQu5/TnrdbdVpFqtmIMXcAyyDO/Xk8
         XbxfpmDOpRT4DLywfr29U+PkHjHQ/D5+RQtNLcTU0dMOPNDtyfUY8a7CCUQSGqnfbTu+
         s8ig==
X-Gm-Message-State: AOJu0YzvUAyo5BXzh0nmNowH7+GQy+Xm1+bRrYugi6IJe00qbYmzavWB
	ssUTiBPpeGNdrUTraQUI46rDy89f83gnz/xTa8RJHGsiCEGZLBwaJPlCUpJ31mcWf0eBnw==
X-Gm-Gg: Acq92OEqQzj5qX9utabxg8TozzCakcLbo+oZrKaMR2LQYTquiddx5Kh5dKFMTSNvoLh
	dtn9GKlGAdGQa+KByc9IushTFJyn5VWEiNAk6OCDQUQB2Solc2aUiXF7upBLrHu4K3Khr/uN82U
	6yK68Stgd08Qn1AZFCYqhAbYbcyzk4NEwT7vRnczpbB6y0MEsQhvfiiMx83YxOXL7ITolEA89mH
	NssNAXOBD45amCmXBNF9VxAKOF+Fa5j2PXiYQaPHieOYoA9Zs07bb1OVuu4JRiQlkobrKsMpPVq
	UHTqX2iwoArtDnrUAZIlofAOCrMsF+0Lbf+qbksR4RkTv1swWTkMcNd2Q6P0SC7jP2NVNJFAxMP
	xX4U2WeXBVh1mcgZrlNgwcN2HmBUokulFc8iU9p8L46ZBCm9iexQ0ObIdaVm+LLIdhENUdkd9qj
	FthQBWoQb56HN1WCqcpGbA1NLmsDElMOU9Y4g=
X-Received: by 2002:a17:90b:3eca:b0:368:864:62ad with SMTP id 98e67ed59e1d1-36a473cf321mr19356488a91.3.1779803976361;
        Tue, 26 May 2026 06:59:36 -0700 (PDT)
Received: from ubuntu2204.. ([171.213.255.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a723dfa2dsm12684682a91.16.2026.05.26.06.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:59:35 -0700 (PDT)
From: Liem <liem16213@gmail.com>
To: stable@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Liem <liem16213@gmail.com>
Subject: [PATCH 5.15.y] selinux: enable genfscon labeling for securityfs
Date: Tue, 26 May 2026 21:59:21 +0800
Message-Id: <20260526135921.17453-1-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[paul-moore.com,gmail.com,parisplace.org,vger.kernel.org,googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254368-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liem16213@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,paul-moore.com:email]
X-Rspamd-Queue-Id: 0797E5D70AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Christian Göttsche <cgzones@googlemail.com>

commit 8a764ef1bd43 ("selinux: enable genfscon labeling for securityfs")

Add support for genfscon per-file labeling of securityfs files.
This allows for separate labels and thereby access control for
different files. For example a genfscon statement

    genfscon securityfs /integrity/ima/policy \
	system_u:object_r:ima_policy_t:s0

will set a private label to the IMA policy file and thus allow to
control the ability to set the IMA policy. Setting labels directly
with setxattr(2), e.g. by chcon(1) or setfiles(8), is still not
supported.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
[PM: line width fixes in the commit description]
Signed-off-by: Paul Moore <paul@paul-moore.com>
(cherry picked from commit 8a764ef1bd43fb2bb4ff3290746e5c820a3a9716)
Signed-off-by: Liem <liem16213@gmail.com>
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 69143a216a3c..1c0f8209f130 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -741,7 +741,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	    !strcmp(sb->s_type->name, "tracefs") ||
 	    !strcmp(sb->s_type->name, "binder") ||
 	    !strcmp(sb->s_type->name, "bpf") ||
-	    !strcmp(sb->s_type->name, "pstore"))
+	    !strcmp(sb->s_type->name, "pstore") ||
+	    !strcmp(sb->s_type->name, "securityfs"))
 		sbsec->flags |= SE_SBGENFS;
 
 	if (!strcmp(sb->s_type->name, "sysfs") ||
-- 
2.34.1


