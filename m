Return-Path: <stable+bounces-241925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD6+IUtG8mmApQEAu9opvQ
	(envelope-from <stable+bounces-241925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:56:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7005E4985E9
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABB8130067A2
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A9741B347;
	Wed, 29 Apr 2026 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUoc0w6z"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7984538CFF6
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485378; cv=none; b=AtMHQIEJxFpb/rrrCEteBEHXvCafsYjoy9dVEBMTpz4finekBQYxIIxhUbsPHZGDpBP0UGwHBEfkjqiYXk5XqPnHB6ZHNggI4qKw0s2T9YR9+wSjTve1YXot9MP4QmJTBImxGj10XcYmzlqr71DLTM2hvpe1lV2qsv7USU5dQLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485378; c=relaxed/simple;
	bh=3OxTu4QNmh4FcfaWOckhLbkPnokTjOz1m2MKBETIPtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHxxu8Ei9iFZLeNxC52SgcsU67KHla1kiZHFCw6ozaGc7UnQZZSnzBT3K3FpoKC/uW2MehtNsCcxxPbJRM7kaaYZGuyIfTzi2Q1udTY7csWIm8f5HMP/dk/oWNyu7wHa+8GIVHIXLBdtgU2huntJh57znh/yE6wxgd5cD7Ao+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUoc0w6z; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d70b3e159so50313f8f.0
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777485375; x=1778090175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4NsrOL1q9Am89S8Z+OaW8+HqXPWLvbAymgwFLwuQBI=;
        b=TUoc0w6z/793eup5Y2+Wx9TN1zDZbPFz7ps9hUwk1FFnuKRsVcFPeL+2Gq8TFj89xb
         7Skqkqp11WXWfyvxwc5pt52RHGC0dZLWcwch9vNGyG4875Z+B/wyt9li1PAtEMgabhX2
         NAZURJLcsimuTEDpkjqf4u+CE231mnvJGzJBVSK6Lg9KcJck9Il4jsOXaFuZ9LInqSCe
         zJWqpPTf6ZIbfuCglXtkTCD2xaLMo3D+gOFzvPhMhx6XwGIJjDlNbJDFyu4yG1fGYpm1
         /AUJxiXGWdnk2TS1xCTzSN9l5Lk0i9gSlOZbQHCgZzLJ6292xcU5CEItS1RBXWvh3iwc
         HJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777485375; x=1778090175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4NsrOL1q9Am89S8Z+OaW8+HqXPWLvbAymgwFLwuQBI=;
        b=WHx2y/BMD6PA5iU4jnd15hB1Vi7NA/IQYzKc5gxC2sDlXRSf5zrTciIo6zznDF43dL
         eIwiqH3zevH+xGFWU4s9KaKfk+Axzh8tkJqLpektWvTQ4BghIcateQynfATNzHBbv32k
         n9aN+sMqJGlCs+YfkMpjEZKR40OggtnbQAjUm795pyav/YxabPZf7t1/rmhh/MItiPjq
         fB5hNi6OGuh2Ad8lTQbyxC+Zpcdghohvw+nIsITcU4EpZ3yEYwsgMrpKTW0fgmhidjNy
         HDfv3iBHdw3Xb1BrYVUW0CKLLRl4Gk00EucMMeIkmdZIQRtQnY+gQ4oRB6cpbyxd8mj7
         r/Zw==
X-Forwarded-Encrypted: i=1; AFNElJ8Ux09Ydsjg3D2stvlzaN42xAoajgTu+PgSk2ubwQ6aBwkjYFN5zYMLMZsqDAND7SiqSNzM5jY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx48umoxBi6Lg70YTtt7OunXN2tij78bMwlJkSRdq7Id1n0xAxi
	9AcoIHCVvd94e36R5Dz3AeOmXne2pLaseaPQ+lAkyWiVB5vTIXpEqRLtFMop
X-Gm-Gg: AeBDiesxzyprRI46Nq38DV7pBeRTqQtlinbYwVIwNy2k8/dY07GE+zHfZ+nrpTGsmja
	i5FIHVevXW7ufJSbQMFk2deRHIUom5G0RTRz0ZR5JAQ4BgIeom9SB7I8aYZguVkvRusAHP32XFd
	2hSpBjiUAlPX/Nf133Ohb/xqNZ3AHFawpHC+fSVwCGeb7YUuBssgSKfhDLFGzsS4Lm9863NoK1s
	JtuCEkrDuqLGLjv57p+sm5sWWmKDO+7kBoea6y8uc+WcMRElwP+t5wgnn5AjyQrCmMWvPW2cSIy
	jC8z4F0/SEl58IEgo4BKa/Hl0eKG5H4F5KOj9yemQlbMLtW9r9hUfl14ZqORASgZYBuelNPbtOK
	TPotKvpC0qCnYOYxvhg8Dg67yj3a9vzat9ib6f9tlZeLcpM5vWEsvcCamgZDGrj6xvXW+APvXbn
	ZccvU=
X-Received: by 2002:a05:6000:2305:b0:441:3144:efc5 with SMTP id ffacd0b85a97d-4464a1682b5mr16117702f8f.42.1777485374554;
        Wed, 29 Apr 2026 10:56:14 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm6183750f8f.5.2026.04.29.10.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:56:13 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 0/2] netfilter: fix NULL ops race in iptable lazy init
Date: Wed, 29 Apr 2026 17:56:10 +0000
Message-ID: <20260429175613.1459342-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7005E4985E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241925-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Tristan Madani <tristan@talencesecurity.com>

ipt_register_table() and ip6t_register_table() call xt_register_table()
which adds the new table to the per-netns list, making it visible to
other code paths.  Only afterwards do they allocate the per-net copy of
hook ops via kmemdup_array().  This leaves a window where the table is
findable via xt_find_table() but has ops=NULL.

If cleanup_net runs during this window (racing namespace teardown against
lazy table init), ipt_unregister_table_pre_exit() /
ip6t_unregister_table_pre_exit() finds the table and passes the NULL ops
pointer to nf_unregister_net_hooks(), causing a general protection fault.

Fix both ip_tables.c and ip6_tables.c by moving the ops allocation
before xt_register_table(), so the table is never in the list with a
NULL ops pointer.

Tristan Madani (2):
  netfilter: ip_tables: allocate hook ops before making table visible
  netfilter: ip6_tables: allocate hook ops before making table visible

 net/ipv4/netfilter/ip_tables.c  | 31 ++++++++++++++++---------------
 net/ipv6/netfilter/ip6_tables.c | 28 ++++++++++++++++------------
 2 files changed, 32 insertions(+), 27 deletions(-)

-- 
2.47.3

