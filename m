Return-Path: <stable+bounces-124081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F263A5CE48
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA0D179684
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD90263C79;
	Tue, 11 Mar 2025 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kubD5nRZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAFE263C69
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719315; cv=none; b=d5ctVEOq84/bNk8vAeM0w0fsuR2fy8z8m6CUfpW+RJCJ3VJPaqSgNxpWqX+gt2lr1utLma5zFUXvCUn0untDP3FbC6CaXtJOzPNnCxmgkl1uuam3pF54k7AmkxqDGyXkhr6YVYTxndUjxAcTIS7BiYQFALVUtJGjoCSo0KWrI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719315; c=relaxed/simple;
	bh=hH0ee5wbqB1Ql2cElc+4ijxcD3Qzx1Nf/JVKFUQnpso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dMtsv3kGl5GF2J0nyhAdOD8/opYyE9pa1pS3Sxmb9R333kiL2p2KHQ2QwP+ZcCZ7P3FbZZbRhCdw9sCa9KQFp2Ac3brmPO6OeMkrfcCJH+y5uCi2oEfONfh02C9CgX4rEbeuhcBSYJoIOJ+PFw9JKTeH/9VIQMX4bZCmdWwYakc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kubD5nRZ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 61BA53F2C1
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 18:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741719305;
	bh=2ARliC+Ff9a9MSMkzX8rMbRuGOy49OG0u3bVqj28omY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=kubD5nRZ3g++081ktkjcqvLtU990mJRQ+GjSVkbtcCxEETVnA0ElKeuXYkixL6Yfk
	 dSAuwIrwMUF4fSzPfgo80ESFYYoNzCxrQB2tuu8xj2WkmV4QL81s2p7ijQhRzuooK4
	 JQrAC+kE9v1D3zVgz27LFpguMhrk6lVkNV7NSJQHq7oewnI+80qC/OZByGiz0UeOjl
	 9gFq+xG8/MJ8IUYXLxqfc3HZ/Az3TfVb3vpwOZUI7xxCBuQW3J2YvBfLHEcpDjyjUQ
	 CSGokUmj5lw4LzTREwMb2p7/FpKQlU4yEi/uCkpA8yrZ2GKjrtp3+LkZ+KaFMwWFbf
	 YaNxgPiJ5AMTg==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-223477ba158so151285995ad.0
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 11:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719302; x=1742324102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ARliC+Ff9a9MSMkzX8rMbRuGOy49OG0u3bVqj28omY=;
        b=TLkaeAom5gkklzSdOSwFFg/ZrmeQlzuJRcbWe8U0M494DMPsLyoXgfiF78oK9eid0h
         pc+2dUCvIkcMJvWUaqAWztg38xKrFhuKTQJijI7lY3y7IotKb/Nwp8YqM3mNHNkCU80m
         PlA+g3tg8HXABuc3WptfLNVJfB/Zq4h0JyJSBC5D4dd1coBy+9HNOgNd+wNmsIchDN8+
         AE1tdVJoWBQC6+QhH+lSXDlSiGLWmWC8T4sYCOyJJysFX/PRDT7g940PcKLAxThPrcoy
         XJ76tCJjnKAMQTetq6+0ZUTmQEo4Eqcx3G3YAG5fwSiv2i2memBWk2VnSaqyw+lgbSqo
         qr8A==
X-Forwarded-Encrypted: i=1; AJvYcCVKQoO18ImD8KNntrnipt3EcppBYAeQH+gIncY5GwyJbrdz4n+3rUPph5Lp05AX73JKRuq4gko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWqnats5CkEiplHvQyi/ELtmD8uhDdpOZk8KR13CefztW7Iif
	23opM1IPPRQnaF7fp7jw0GO+oaNUpIhqfWY5QPmRtyTDXPWtri/d8YtQe4IpvxAs2E6yqT0CVy5
	UiZlSJb2zfx+I+TlogU80j0458OiyYdHeNM0izunVkigxzNuaGeJRrjBJmlqyevvGkfbECRue86
	tudw==
X-Gm-Gg: ASbGncsee3iCnfmHTP4CrJDQlhI1qbsmRLXth+6353Io/Gr19XBpEuuaQ329EHKCfz1
	mQfD+k/G0AZ8benRw//Fq0xT4V1llNdigc+tjaIWOuVNP2C+J6vMJlPbsJthtxHtVTXuCx7jAln
	4MaohsP942Rbd8Lhjqfk08IeOqmOSs7ufFkH2VCeaKB2GfLvsNciXELE0+S2fW9IkgcCvwGdgP9
	sUeUs1vlZefb0Q1IrC+WYkunZL4tdLLxePSVD+Vo8MTlUSz0MkOQA5S2sJNZt4aFJ7imlYI9R1g
	H/BaKLI67oVpBCY1UtHrZbYEapmVH/0RQn+6DDg=
X-Received: by 2002:a17:903:22c8:b0:220:f449:7419 with SMTP id d9443c01a7336-22428880305mr257209315ad.7.1741719302694;
        Tue, 11 Mar 2025 11:55:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3BTPhQgIU+2jBPjJ24l+jfBjGsGPHiMrU4Zh8LpxiWYH5uHTGqZ6rKD6E+0Fv5BDfDZnWfw==
X-Received: by 2002:a17:903:22c8:b0:220:f449:7419 with SMTP id d9443c01a7336-22428880305mr257209115ad.7.1741719302390;
        Tue, 11 Mar 2025 11:55:02 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:14a:818e:75a2:81f6:e60e:e8f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f77esm101765875ad.139.2025.03.11.11.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 11:55:01 -0700 (PDT)
From: Magali Lemes <magali.lemes@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.4 2/4] Revert "sctp: sysctl: auth_enable: avoid using current->nsproxy"
Date: Tue, 11 Mar 2025 15:54:25 -0300
Message-Id: <20250311185427.1070104-3-magali.lemes@canonical.com>
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

This reverts commit 10c869a52f266e40f548cc3c565d14930a5edafc as it
was backported incorrectly.
A subsequent commit will re-backport the original patch.

Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
---
 net/sctp/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 3fc2fa57424b..4ecd3857204d 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -326,7 +326,7 @@ static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
 				void __user *buffer, size_t *lenp,
 				loff_t *ppos)
 {
-	struct net *net = container_of(ctl->data, struct net, sctp.auth_enable);
+	struct net *net = current->nsproxy->net_ns;
 	struct ctl_table tbl;
 	bool changed = false;
 	char *none = "none";
-- 
2.48.1


