Return-Path: <stable+bounces-227897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOzeDN7rwGmROgQAu9opvQ
	(envelope-from <stable+bounces-227897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:29:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCAE2ED9F6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52770300D0F8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4844035F5E6;
	Mon, 23 Mar 2026 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHbLkvav"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0233C53F
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774250842; cv=none; b=lLLcOemGpmbglqsFEoIK/OOVyjM33ZK/tOqT/xU2zmBFfAWgXpdL6Tcf4wYBKkVvVq3QtfzCIJNYym9PXVwajf3i4Q4Kig/4uDlfmt190C/jsCDSy/1lz6SnMFqUCibsKy0VV2udizHuDr4Ckzd6nh6RmzmI3ZEabvn7gDaK4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774250842; c=relaxed/simple;
	bh=7WPWs1Sp1g3Vl1AoHyo6/B00u7Vy9BnNDHYKrKY47ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=apr71PTc3SiJ9/vlLa5l1BoufQy/on5e1OSwJmAhS4c14a8Q5aIVcIL1Ln7ySWoSJirv1KzOp//ijMIWZy+kqZaW8R5QQWs+CUDnuxmFbUrGDQkwfmQoey4lOHX3CUTBHNEtbEb5WFWCMFRKuVHCZpePAEtlNGhL6l5xUlgHQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHbLkvav; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82c20b9fb16so869596b3a.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 00:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774250839; x=1774855639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HyN15G+MEDzt2QKd8l7H0bzTezImqr3C5TjJ8HaJLCg=;
        b=dHbLkvavK8hiB0mZq62JFtDHaaCwcZTq2ar5ujnBjh8qfQ1yAoOn+RZhXM/hEYGWEr
         KtTq7RizxKxt56I8rCXaiBbbPj+MeISlutNH478JKy9M9phykRjdnDii+2VQcK2lFEUf
         VBGjtCKOX96Sgh9DKFwRuaXKzHcLuRfnuh89NcxYlip6rnDit2PNxRGaRnz2GMTxVyRm
         rcwqk8wiXK7eEZcOlUxfnKwfaC/k9VEysxhmOxyMj5xYhVfkepb5Dr1dTwDA3rhMIYqq
         wnd+KX/7R+OWSzpe3v8Uoc87xBTdECrZdE90p86BkzOgWUgyzBEnyG4rACVfpQMsa4sP
         M9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774250839; x=1774855639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyN15G+MEDzt2QKd8l7H0bzTezImqr3C5TjJ8HaJLCg=;
        b=Taj+RqDjqFxHlf349q/+sLaBdPPcemWtTE15U+3ih9KiaBPKsdTu0xig/muLKmPd4G
         wGDOsO1m4IWbD/0inIhJO0HvnInmlJ922Lws1FDw7x7gfNWyO4yPjJZRJE9b7a+IhAEm
         htikjmToAsUdkGcOwxu2cIsmgkjsFkAN7cLeRuQ0rzpnWuvw++LM/jA42Q7ACLgBJt4H
         KgH1GJ+AMEWrCk7qzZ40v8MEKhGEWuZQEDu6GZoek/MNPFQ1SPzYbcwuAPlD46Uu/HMX
         lBUA7SOJDkShKMvJPSwOpkFNjNYDJqp0KsbjEneR/mggnPc7zu+QbK8yx/EXuT0EscP+
         Y0yA==
X-Forwarded-Encrypted: i=1; AJvYcCVf6xNQUQl5u3RsqqxYf8Cpj9tEV0V5kDEUQBaAW55CWW6YVvtADpgMTYSYg56YOfH2WWoiy6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYFlPIZR+oMC0ZZu/x7Yf8hz6vJUMLyg7vqgyoXFaMAeNbJKbh
	7yeDdqz9Gvoiz8+4BuOXtwuDPZcRu8TMxFV1g3PhDStX6s93MEMqWBvI
X-Gm-Gg: ATEYQzxz9TKMHD4ddSOGGS+8b6dohMfmW1ng68wIAjANBo9w1Tw10KzE4UUA71DRqhv
	JTZyURSOHLGfwJbes+t21j44K8TL28R6sh39S6dF5tBHLnvVYRxUo2ez2CMutYV5+SYZ7Eu1mBw
	K+p8D/C0A6S/I044GV53PhmmqEDuz28qmTWvsb1GftCB1Zhg4PIBSwpmwt2VJ2/y3p1Dluaykn8
	3CCxibQ4l8tCZWh5kcP6teHbiY0c9NqpFVrzVxesL3wM7zUiCFpDWMJyWM6igBtQGxSVT8pvNLp
	00TWrx7hGuKwoBH0JeDIPnKcQklTmTkh5c9BhGcasj9srKaKrd7+VvWgNWRNkzZZgtF0kw70i6w
	S5evcMMWITkUXlPWa7EIROXzV8rLW4Tl9WurLAC3GwbJz5qiJpprkizhJ1qRWA6wBKnghrO67rJ
	1/E4wKts3P631tjqNnPw==
X-Received: by 2002:a05:6a00:2349:b0:824:4a22:ec02 with SMTP id d2e1a72fcca58-82a8c3878camr9366286b3a.42.1774250839210;
        Mon, 23 Mar 2026 00:27:19 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa5aa7sm8476962b3a.1.2026.03.23.00.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 00:27:18 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: cem@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] xfs: use xfs_trans_ail_copy_lsn for lockless li_lsn read in CIL formatting
Date: Mon, 23 Mar 2026 15:09:49 +0800
Message-Id: <20260323070949.3769170-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227897-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1FCAE2ED9F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xfs_inode_item_format_core() reads lip->li_lsn without holding any lock
to embed the last on-disk LSN into the log dinode during CIL commit:

    xfs_inode_to_log_dinode(ip, dic, ip->i_itemp->ili_item.li_lsn);

Concurrently, xfs_trans_ail_update_bulk() writes lip->li_lsn under
ail_lock when inserting items into the AIL after log IO completion:

    lip->li_lsn = lsn;

The CIL context lock (xc_ctx_lock) and the AIL lock (ail_lock) are
independent and provide no mutual exclusion between these paths.

On 64-bit architectures this is benign since li_lsn monotonically
increases and both old/new values are valid checkpoint LSNs.  On 32-bit
architectures the 64-bit xfs_lsn_t can be torn into two 32-bit loads,
producing a bogus LSN that could cause log recovery to make incorrect
replay decisions.

Use xfs_trans_ail_copy_lsn() to safely snapshot li_lsn, which takes
ail_lock on 32-bit architectures to prevent torn reads.

Fixes: 93f958f9c41f ("xfs: cull unnecessary icdinode fields")
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/xfs/xfs_inode_item.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 8913036b8024..0171f4527f40 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -622,9 +622,12 @@ xfs_inode_item_format_core(
 	struct xlog_format_buf	*lfb)
 {
 	struct xfs_log_dinode	*dic;
+	xfs_lsn_t		lsn;
 
+	xfs_trans_ail_copy_lsn(ip->i_mount->m_ail, &lsn,
+				&ip->i_itemp->ili_item.li_lsn);
 	dic = xlog_format_start(lfb, XLOG_REG_TYPE_ICORE);
-	xfs_inode_to_log_dinode(ip, dic, ip->i_itemp->ili_item.li_lsn);
+	xfs_inode_to_log_dinode(ip, dic, lsn);
 	xlog_format_commit(lfb, xfs_log_dinode_size(ip->i_mount));
 }
 
-- 
2.34.1


