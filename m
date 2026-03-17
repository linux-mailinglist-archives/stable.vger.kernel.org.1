Return-Path: <stable+bounces-226012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD3zAEBWuWnYAgIAu9opvQ
	(envelope-from <stable+bounces-226012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:25:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7871F2AACEC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18FC3306E842
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F51D3CB2DB;
	Tue, 17 Mar 2026 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOOPImTM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FDD3CA4AD
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773753844; cv=none; b=AJGEvr3rYVPxdSQNm4eIOobmzdXN9H4gDiy68aXvmZp39M65ti0Mv5asBS1oz3ui39DCcQvshTEbV5ZA9GYZdaSaIcPEEocCoVVaICA/bOw+Gu454eBBY+Z0JWEXO60TPYYPEnr5+jxRBxpVszW3k6SXR9qAId+BUPhwBnqpbXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773753844; c=relaxed/simple;
	bh=z8G1n5vQc2o04ixmgah5UrTtAJ1uhTrusHN/zYpP0/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fm5mOiLvcHwTCnn/zCUNON6rB7yTVqjCU439pFot8UjHyEVkTMGEjf/xFWatKZOwudAztbR0Dn6vmAd8BDHlVn6yS9DAwa8KKCs4JMX01itwsAiut+PplLIQXsjSrLpiDrr2DwqY1v+QTtDEuUZPrv+OV61AnnU31P7AwkTWU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOOPImTM; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c73f12fe254so92967a12.1
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773753843; x=1774358643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDkHRlFyBw3AqbHZfo12ncQp76Cu27YWrL4/LonMVsI=;
        b=EOOPImTMA9lgBOd5D+hv9oIDHL4RQv5tiW82djR/g8R9iVFjnSSB5sL4jxCV4ABLu4
         W4hWAtG85RN3V7uk56hfYP+Uk+cKVOKUNV1fnByGdA3+HTMHCUcEy7rf88Md04EqztSg
         MLICQlgjUDNXDZjMrqW7zt9ilmBhisc+TwrIel3V6FQkr7r4dZOT32OJV9prLLVi8Giq
         COoY+jPfsuJNjCa+GsLSleKE4XJDqPWod91aEwRBkH/ZY696xVfMz+ZAq8a6oRXQRkFz
         50AhPhu77bB51w3+yojIvUnmlHYpH9bMw4fUiLvCDwpzNsyC5x6vBWS1Z9NXC/vbowXn
         38XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773753843; x=1774358643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDkHRlFyBw3AqbHZfo12ncQp76Cu27YWrL4/LonMVsI=;
        b=blKKJXm1ZOh0KLmAEXFBlgbrjKly1l5EHHa4Gf9Z/Gkmy5BtEFkEGQ7S7JNIzLQI0H
         iZTrO5yKqsR17P1jXWMpkv5cbYbA8b3V3IZxqbIjfNm4puaU4+XziE1sMHPzpbzf3OIF
         g3qG4Ccy5FoB4Lm3wMv/F62WrdieftbMY6NQaFMQGDesuuVO/ZsldZ6PwMCe4QVBJU5H
         MGBnZwDxCznTCS/XCkfZSXMbGYVDnk4PW54P/dnL/Ensf2nHrzc31yPYWBOuI0fSrePz
         rmHz9j490UOvyhF6YMC+VzVAreuATbgiH29SG/VPLjkMPa3tnkpwpA+1RCQyughv0Dq/
         zCCA==
X-Forwarded-Encrypted: i=1; AJvYcCXsSJJ5b5fWivGPb4mbVKS2ErjZitkPjpugwo6uVeicW/T+Q42h+eUs8XZ1VMXnuK28+Z/YR8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq5bMHgJPCRKtAjTC4mhHWQFAKoverLDAGyLwHGVgzzgoJm1ph
	R02c2BxTlazbNE8luIN7mCHlt7l8Jk4LJLZ/6mWmtfVSMUnjUnxcWCVD
X-Gm-Gg: ATEYQzxFgRvPRxcAQDNj9Tqqpgi3CWtSgNACyiMDUwIz/J4kaNiuoIHeMA1O0z9a/D6
	W+J1fhcoWB6F/ElGD4+YTXQa4dysBGKdshLUYM+twB75nwMOzg2RT+Di02+rU0Cz5hq6hgbnZKv
	r3EJQRJoehbC5epecB+5/BpowS5pTUNFtkKyhoCKrnamiLQZqqpH7K5n0SFsHbSPb77oC/VR/qD
	GuTqXw+YmngV63ajmdk07lyMWdW6FaNnzY5AUhJDU6WmE1Mx5ff1U4uXrSazOFQvCxJeoEd2XfM
	F7JZy7VeufIogZxojiTS+qlacj8Q5YOkwnJzWVKm9/lDhXbJTUDCJmHhdSzKE4xZPZTy3v8/96k
	v9srNz+AJVYwVtC1Kzc/FDWl3cIwD9dnCZs2GOnHG50M1czzGiGXMAjtiAZkWmSeaf/TIdycqoo
	7X9+wmGnatXdS4QC893C8pWzgMHKVr+mQX7N/bOCceZi43zy4kpYIG8zn+s1Y3UzUp6M7TWJc+2
	MoqyfWjn5Ev13DaGM4Z49iQDobJMmAsHK2sIl+s6zDMHU9G
X-Received: by 2002:a05:6a00:ae09:b0:82a:1589:311b with SMTP id d2e1a72fcca58-82a196bb525mr8149373b3a.1.1773753842708;
        Tue, 17 Mar 2026 06:24:02 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072422desm17215042b3a.1.2026.03.17.06.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:24:02 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	yifan.yfzhao@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	singhutkal015@gmail.com
Subject: [PATCH] erofs: harden h_shared_count in erofs_init_inode_xattrs()
Date: Tue, 17 Mar 2026 13:23:56 +0000
Message-ID: <20260317132356.15341-1-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226012-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7871F2AACEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`u8 h_shared_count` indicates the shared xattr count of an inode. It is
read from the on-disk xattr ibody header, which should be corrupted if
the size of the shared xattr array exceeds the space available in
`xattr_isize`.

It does not cause harmful consequence (e.g. crashes), since the image is
already considered corrupted, it indeed results in the silent processing
of garbage metadata.

Let's harden it to report -EFSCORRUPTED earlier.

Fixes: 47e4937a4a7c ("erofs: move erofs out of staging")
Cc: stable@vger.kernel.org
Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 fs/erofs/xattr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index c411df5d9dfc..aaac37c6bb78 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -85,6 +85,14 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	}
 	vi->xattr_name_filter = le32_to_cpu(ih->h_name_filter);
 	vi->xattr_shared_count = ih->h_shared_count;
+	if ((u32)vi->xattr_shared_count * sizeof(__le32) >
+	    vi->xattr_isize - sizeof(struct erofs_xattr_ibody_header)) {
+		erofs_err(sb, "invalid h_shared_count %u in nid %llu",
+			  vi->xattr_shared_count, vi->nid);
+		erofs_put_metabuf(&buf);
+		ret = -EFSCORRUPTED;
+		goto out_unlock;
+	}
 	vi->xattr_shared_xattrs = kmalloc_objs(uint, vi->xattr_shared_count);
 	if (!vi->xattr_shared_xattrs) {
 		erofs_put_metabuf(&buf);
-- 
2.43.0


