Return-Path: <stable+bounces-230590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFtED9Maxml/GgUAu9opvQ
	(envelope-from <stable+bounces-230590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 06:51:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE5B33F506
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 06:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25ABD3022FB3
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 05:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4202D46B2;
	Fri, 27 Mar 2026 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChYwy7+/"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB4223DD6
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 05:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774590652; cv=none; b=ASUVDZHbYvzRUFAHLy548zILlC9Cu3CNJ1G0fdch1ZLRhL9pGHIiGOiE40igEabTEvF26a0qKS/EsZ2cra0mZWApjvaaV1RzP4zWJkD/fauB6IxKqSDIUPgDy+YEUNVWBOv17Wc0z9q0XMaEMzWhIckUGXegqQ0QNCo2NbfzU/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774590652; c=relaxed/simple;
	bh=N+7Tp4p8L0/ygPCZTSIJtPoeEEy8WuNCT5GxnmBre8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbLO4XYxHWaAGb8Q76nTST7INsEorZyn8lX5CT6fK50LFoJtNLNEO74ZWBv+gljWM5PYSC+LuVGHG5mSxUmeTz8zAkVP/J5guMLtTagaBCUMUX6P+RXZYMRuXuwN6bFlZfeRGEXrf237WlH8CquIZe4YAI4Hd64ClFxyV3y1Kzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChYwy7+/; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c11c43aca0so1214380eec.1
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 22:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774590650; x=1775195450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgT27hTFjI7iP0xWY3qluKjtmwi9mzjCCAJfSwRGG8M=;
        b=ChYwy7+/KUgXzRW8XF3z1IOIJ64dd9fRFeX8DuduerxWVvS1MoKgLcTlRQ2BhzPYqh
         eoGw+VCjC3pWxkDmFJVjQyj8hxtGHJj3tT0IulzTUTOPUJXShF7GvRIJKPzZyvODmcQN
         YrQH0lkVs5E9y3E+TCIQ71d8fIUhXGi0VhRlz0ONYDxjlALfSVs/d+UEjbYHfO1FZpM4
         O4Aa4tqNdRKZJtQPsJmQ/7/jXtxGR8Zf2telOdQoZ7VtFpEc0YZDBVP3XaXXsfGT1ty6
         xLH/89XJDoQBEDkxhsvcLJZfhVTnXcwTNJ4ADuSvbZWI9tzmOn0CtlmDRBNnKR+bouhq
         41uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774590650; x=1775195450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UgT27hTFjI7iP0xWY3qluKjtmwi9mzjCCAJfSwRGG8M=;
        b=magkYwUiPKvR3aWTvjX7EqM4BNXJmgzPki8PsA8Ej+MG8Jd9wBkI6rn/Z+364/HW+5
         HkAKVW6xVJPHzDzipbx026svenRt9eOXUw5O7GVwQR7idnWTu+gmGv4YariHLhJXRSxK
         KlsEIHADllHBl60YAmRnmY+ai43tA4gtWRHKHTAEHEfFz5HykS3uVMXgi/BplBac10+B
         jcsrmxWxMtPlIyNnLX/nvmikie6eL+3d8EJ0oWpcM1x5M7of4aHqq8c2maDsFeRodigK
         MUDmfOaOEUHV0339TVfBneuecYJxYt2RmuyoK6eN8RJbWCu6ELEoliMIKTH3p+NKtLu6
         C3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeNZQeEdfk1ZR/kOGoRyVIEsxTrLDGaF55fhKVsgLvPYfrw0zI6a4inHTwWoJjK4yXXMHlDD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT4ifGp0gr+ddxcGksoIg4aW7TEKlPThr2EZpm/EJ6ckkMlq4O
	ZGe8ztmqyt7SS2E9ESRXQwyvGNCz2IqR4pLsnDqEJLWIxmzSIFe2H5Hb
X-Gm-Gg: ATEYQzyWBOzUtHMw36zHkKI1g7zIm6auXMPr8l4fcMSb9fg1jG6z4ESsuWPwn544o/H
	8rqGorqWBtrCVK9ca9haK8UjQzdmOuDp2nroxpKy9Py771UOnajt1YOnKQE7JA5JR3pV7mxceaM
	DAYU1GMVq2Ca01mzeniJ4U7OoeNaN0xu5t+lSYYYPe4pKELZMAx96khJENqJryASZbxth8YYP6/
	CvxKVakb7LDDLzAVRJxiV3JKF9FbZuHd6jZk9/o0UaP9zKnJCSQ4I6q1i3wpeiidFZkNKOBsAig
	t1rZVSGZ2qLqDVersrDAkP2txGsziYofLVkGqtaZrL+RHwkiN56hViCrTTlFvyEmphs7ukx06Ic
	2h4bslKFwsUxs2lgSLBZxv08HPYf02L3um7Uy8HDalkVDy2mZIT2J/GJ5v+9ZZeDBIeDfxBCG8e
	huA38v+jYVuwdqoTvTUPjn4av+kWU=
X-Received: by 2002:a05:7300:2315:b0:2c1:67e1:61a9 with SMTP id 5a478bee46e88-2c186ef3bffmr417092eec.13.1774590650011;
        Thu, 26 Mar 2026 22:50:50 -0700 (PDT)
Received: from homebox ([66.75.253.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ed9f75csm4127815eec.15.2026.03.26.22.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 22:50:49 -0700 (PDT)
From: Yuan Tan <yuantan098@gmail.com>
X-Google-Original-From: Yuan Tan <tanyuan98@outlook.com>
To: security@kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	zhen.ni@easystack.cn,
	kadlec@netfilter.org,
	kees@kernel.org,
	tomapufckgml@gmail.com,
	dstsmallbird@foxmail.com,
	yifanwucs@gmail.com,
	yuantan098@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 1/1] netfilter: ipset: drop logically empty buckets in mtype_del
Date: Thu, 26 Mar 2026 22:50:38 -0700
Message-ID: <d3d1e38f2001ec225344f24e59727299f6a39a7a.1774578045.git.yifanwucs@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774578045.git.yifanwucs@gmail.com>
References: <cover.1774578045.git.yifanwucs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230590-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,easystack.cn,gmail.com,foxmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EE5B33F506
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yifan Wu <yifanwucs@gmail.com>

mtype_del() counts empty slots below n->pos in k, but it only drops the
bucket when both n->pos and k are zero. This misses buckets whose live
entries have all been removed while n->pos still points past deleted slots.

Treat a bucket as empty when all positions below n->pos are unused and
release it directly instead of shrinking it further.

Fixes: 8af1c6fbd923 ("netfilter: ipset: Fix forceadd evaluation path")
Cc: stable@vger.kernel.org
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <dstsmallbird@foxmail.com>
Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 181daa9c2019..b79e5dd2af03 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -1098,7 +1098,7 @@ mtype_del(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 			if (!test_bit(i, n->used))
 				k++;
 		}
-		if (n->pos == 0 && k == 0) {
+		if (k == n->pos) {
 			t->hregion[r].ext_size -= ext_size(n->size, dsize);
 			rcu_assign_pointer(hbucket(t, key), NULL);
 			kfree_rcu(n, rcu);
-- 
2.43.0


