Return-Path: <stable+bounces-35738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0B4897501
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 18:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED9FDB307C7
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0219A14D454;
	Wed,  3 Apr 2024 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fq6tgGkv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F914E2DC
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160507; cv=none; b=TOqLMeaWGmEW5AfWayAigL+O8trAivjPLB1uYdDwqZM6nTwSB+2VWWx7AdRvq6PmrtkXazjkVzESjmuzq9UuZ0p9oWLRFE3AkQFZpwkKRRLRvipiGQhRfc5DiYHU6vbFqjFHQU0IH32+KOLMSQsu6VSMi2z7Agr8TanyTW0rDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160507; c=relaxed/simple;
	bh=FajZfl0KjgODRGM7GN0HMfQfNuAgERi+yoJIS0EQlNI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pjkvDCO88G46V9PKATnOk+2GczNz2W0CDsZWfE2JDltH11rbW4YF9/54eHRS8Q9kVDB1tMnEct48ZsbmuGyOHJQ970RsVtF6iDyadBcreaoSWgvDjnmc1fmcNLnzj7PQMUtp1YkhCMdtBMOWEWcWG7BecOKylPOWdHV4gaKYMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fq6tgGkv; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a28b11db68so842545a91.2
        for <stable@vger.kernel.org>; Wed, 03 Apr 2024 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712160504; x=1712765304; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBqv5u0GbtYo/annq6oOuXcriRbRNViauNseFUVUoJ0=;
        b=fq6tgGkvqq7RaT0YN7zS/Vjk/qMu+pV13xumkyxlWs9xpyHPcuoL3xIOR9g09PGoL8
         I3AQziU/ReKYZo4wy9dh+q0LZbWhXEYyAnz0uUPe9Jn2f3wF4YhTJCBUUxxF2drRyLk4
         ZI/eMhdwtIlW+ubXmCvtPQQOIqaBUMUfBBhaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160504; x=1712765304;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBqv5u0GbtYo/annq6oOuXcriRbRNViauNseFUVUoJ0=;
        b=bj+6x/UgugO4CXkLBg+S4cGMOYVhseil0y5BVgPGw+6dzNrhBaAMcte6SqhyMcQ0qk
         AGo50jbYAq1dczZP0UFSLXa5d+lw7U3mcSNrOhKd4KbKasZpGcSUoJPspfNuaxGgLwAs
         VhuyIj+z7J98Jc1YrHPzr8PYhNK0T3pnnthvQsQmzp0ciVl/iB+XvBVuOozcCye246jL
         9BHXI1GnXSHELQm3SXokSYjGO38P6KyejrG+RxRn4cbrNyDie5CdD/xSacPQfUD74d+U
         8T/foJlmI3cuckrJ2u/vhpX3nQy3zENRT3RePBWzzlPoeUcqbuB3lcxjdTxXuT80mgIg
         DV1g==
X-Gm-Message-State: AOJu0YwgZvUjTRbVzdw+DbdBTqqrosBR+FLtrhhzfp6ITH7KosDha04u
	Crq67dBSBfVby8Wi4l6i2HOKGQ/76ilXfFxRt28QODbbd9VJFpq5JUX6TSLv9Qu0aD8CeKze0s0
	Cs5ANKLYA1q2uROrNtZQHPBrX2IJYa82ZT8QuXsByh78zkWBD6dOtYUC+BvegptY3/HlpRt2trQ
	64OzGEcIh9579tg8LLj9bTvcnZWk93MN/CVNq5+c3fQYtr+cdVI5crrrHEYOFvygc=
X-Google-Smtp-Source: AGHT+IFxg1+arBQ3sk4HbwOAUA1xb3YpZ82uFjblkSme22H0ddrKHcvnVZWXdSwt34YuBjn4MnP2Yw==
X-Received: by 2002:a17:90a:5505:b0:29f:ac52:9ae2 with SMTP id b5-20020a17090a550500b0029fac529ae2mr12839489pji.42.1712160504208;
        Wed, 03 Apr 2024 09:08:24 -0700 (PDT)
Received: from keerthanak-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id h38-20020a63f926000000b005f072084432sm11611536pgi.38.2024.04.03.09.08.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2024 09:08:23 -0700 (PDT)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
X-Google-Original-From: Keerthana K <keerthanak@vmware.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	kuba@kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v4.19-v5.10] netfilter: nf_tables: disallow timeout for anonymous sets
Date: Wed,  3 Apr 2024 21:38:13 +0530
Message-Id: <1712160493-52479-1-git-send-email-keerthanak@vmware.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit e26d3009efda338f19016df4175f354a9bd0a4ab upstream.

Never used from userspace, disallow these parameters.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[Keerthana: code surrounding the patch is different
because nft_set_desc is not present in v4.19-v5.10]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/netfilter/nf_tables_api.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 44cfc8c3f..d98ea5cb7 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3604,6 +3604,9 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 		if (!(flags & NFT_SET_TIMEOUT))
 			return -EINVAL;
 
+		if (flags & NFT_SET_ANONYMOUS)
+			return -EOPNOTSUPP;
+
 		err = nf_msecs_to_jiffies64(nla[NFTA_SET_TIMEOUT], &timeout);
 		if (err)
 			return err;
@@ -3612,6 +3615,10 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	if (nla[NFTA_SET_GC_INTERVAL] != NULL) {
 		if (!(flags & NFT_SET_TIMEOUT))
 			return -EINVAL;
+
+		if (flags & NFT_SET_ANONYMOUS)
+			return -EOPNOTSUPP;
+
 		gc_int = ntohl(nla_get_be32(nla[NFTA_SET_GC_INTERVAL]));
 	}
 
-- 
2.19.0


