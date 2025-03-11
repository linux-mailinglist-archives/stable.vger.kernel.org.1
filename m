Return-Path: <stable+bounces-124083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B388A5CE4A
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F7E189F5BD
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7015A263F3A;
	Tue, 11 Mar 2025 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BoLWsxcU"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CEB263F23
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719319; cv=none; b=clqhimAV/iSEpFY+NY6c8YH+aLSUwRTvwikQ1z55jzjf6iSZiprT8COJgfSEgy6nFH9Mo+cJinsYT72LrtjJhbJD9l5ousjYxzv9vpqeDm4EpxKIKs2GhbC6OuAM/YmHmqIeo7wWrUXa/9pw3atXWQPotvmubyhfHLFfO6pX770=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719319; c=relaxed/simple;
	bh=OQx+O8UKbhRf3HQUy23qR8ldleojXVjrGRAOg+o0SM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3lV+lo9kV2egE3ktgO8tDXrugnn9FeorMWKlhBB4tYqBFVWDeWBl5Ja6ympgFzcPG3HUcegBTOKz5+ukzsg2QjfX/pw8bOgiGzZz3P44gTcR5kpfeVEHipB7wwlBktYQLksRiNMG8M+kfHputhdCsl6eds5JCK+UGFj9Ohq2nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BoLWsxcU; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5B2E43F861
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 18:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741719307;
	bh=W6ZfHEq8HTmqtTKzZ0cXu5Z9dCO1DS8l72JUOuXJWEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=BoLWsxcUkUTEOVL3ZfP8OrSZ/KStDpmOgqAJpJveh7jaREoZ0OAG3BWEerjGVlKHW
	 zttn7PapHHJdExm/7ZvhO9SSaFeJVWQLCRa938fJs2WWp6B3FJk/atfmYOciZsxOxM
	 Cg5pFWJsQ1iXBCul3KRCX8yCARqPCBW1W+58TgQNDsbXNB2LOlIwYkETt40T1d5+y5
	 ASMlCbKr9M4jriuVEdzf+Asoh7ZJodPyUwVlP060nMJmjELkES7SyHKnQlzgmSsIUw
	 Inn/6vQIbQcWSF14q8I1lB+WVl2EBA1m2LaJMJvlhEzBlHfgRC08zVidmHSVBuZMDh
	 87nOVUt0XXTxg==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2242f3fd213so71298695ad.1
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 11:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719305; x=1742324105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6ZfHEq8HTmqtTKzZ0cXu5Z9dCO1DS8l72JUOuXJWEY=;
        b=xMaRfqPcRjhxglfysjp7xMNo49t/Vq18ZXZke5LS1j/VihKaDEP/O/MEWxjrxS3UpJ
         pZwF7loVLLkoB+8PpMHaEYtmGWwssiwUShOVjH+o7u8D9EYeDsSjJdqDCsclIljR6nrm
         xCPJeGqGbPXhPz2+XYM4J4wK/J1QR6lN/6ekx4T/zai8vKFllreAd7euBkv/oc0ntkZM
         UMsFeVLPzCE17B7EWTRqrQTYi6Pcf/are/8ZMd3WRXYRHap/ornO9ymUAwyoy5Ogb80P
         YzVb/VCziw5RzD1Gqvfkw2S0m7wdB9+R7FKz0eeqPreF8RrF6sRV5KeRoqJ8I1k+HaDF
         KM5A==
X-Forwarded-Encrypted: i=1; AJvYcCXQbMJxtFRqkW68XdGorw6HQ0i7CgxOT+aXBSFZUsk+xGglthZrA+RYs5izHURbP+nDeiNHjDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Iqf0ZkCmpqwWIBAxhBQRUP60WsUzFchrsH/7d9XOTlodQI/V
	PWvBQiyUPWG1dhp8/z68hbVjHmG8eM/BRaJ6QPAWTmCWKOqImiGamSuDzUMbojvdmj9K3MRtkSv
	rUUiRPqkkiZ/X1toJUhTKghZFk8q6khUIiE+eE0sK3FtlnrypGJo1hwYBUpZugIOceTMq+2pCTG
	tnJQ==
X-Gm-Gg: ASbGncve64vjbZdVsQPzt0H7KSaxn58/f0Q3wWovK2wBcPBx+pkqYEzNvB4yCQJRc9+
	y0VaEjF4xQU2ztFj2+WnI19YEFfQPtAApGoQz8eojKqO/MyjJrIqO5p0Vx/D9H1Fv6s6AIjkiiV
	gRJNau6DhYhNujpoSPGKexmbkMgjAjqzttJntwF5OhIL1iShNe2IMNQ40f8YLe8nZ8hIKLPkagM
	T7xXicb/TN04hST2uQGp24I3DkjT2zh9j3MmTzugeuVeM+RfPP6J3WjViHa9hmWqnfV/Rx2f5Ul
	BDS0inBmnLjC0oNNESXXCdlGCjF0RVFL28Axru4=
X-Received: by 2002:a17:903:94b:b0:224:1221:1ab4 with SMTP id d9443c01a7336-22428a9675bmr325339125ad.22.1741719305043;
        Tue, 11 Mar 2025 11:55:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOgk/rGGjwSM4pbJXcgobx/d55mUnZ9MRoYOYYM+xYz62eWiCK1SvLGDPpSRR25mehHeksLA==
X-Received: by 2002:a17:903:94b:b0:224:1221:1ab4 with SMTP id d9443c01a7336-22428a9675bmr325338955ad.22.1741719304734;
        Tue, 11 Mar 2025 11:55:04 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:14a:818e:75a2:81f6:e60e:e8f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f77esm101765875ad.139.2025.03.11.11.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 11:55:04 -0700 (PDT)
From: Magali Lemes <magali.lemes@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.4 3/4] sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
Date: Tue, 11 Mar 2025 15:54:26 -0300
Message-Id: <20250311185427.1070104-4-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311185427.1070104-1-magali.lemes@canonical.com>
References: <20250311185427.1070104-1-magali.lemes@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit ea62dd1383913b5999f3d16ae99d411f41b528d4 upstream.

As mentioned in a previous commit of this series, using the 'net'
structure via 'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The 'net' structure can be obtained from the table->data using
container_of().

Note that table->data could also be used directly, as this is the only
member needed from the 'net' structure, but that would increase the size
of this fix, to use '*data' everywhere 'net->sctp.sctp_hmac_alg' is
used.

Fixes: 3c68198e7511 ("sctp: Make hmac algorithm selection for cookie generation dynamic")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250108-net-sysctl-current-nsproxy-v1-4-5df34b2083e8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
---
 net/sctp/sysctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 4ecd3857204d..4116b3cd83c2 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -326,7 +326,8 @@ static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
 				void __user *buffer, size_t *lenp,
 				loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net,
+				       sctp.sctp_hmac_alg);
 	struct ctl_table tbl;
 	bool changed = false;
 	char *none = "none";
-- 
2.48.1


