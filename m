Return-Path: <stable+bounces-214408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOonM+5KhGm82QMAu9opvQ
	(envelope-from <stable+bounces-214408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 08:46:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03088EF8F1
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 08:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AC9030069B3
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 07:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F90635F8AC;
	Thu,  5 Feb 2026 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g6VclQ92"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ABC35F8A0
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277604; cv=none; b=PUaaFIoQp41x09yaS23HKotX2YWHB7tzrbdmnUk48HBtAYusqwOsakOQwfK9DZB6B0fxLInWVCZn348ncuNszX1C0aqxHVaYHGhvnzM/Biu8raIKmYIA+5cXbf0BA4agh7tOARbYT8qkr3Worbc2ZzO18EqH4qy3d/FugUyHRj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277604; c=relaxed/simple;
	bh=BZAm3zfS+K8re01D7iQcVFbiBjsf6a3DLCN+hVqBjSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4j5oafAw5kM35kZ2rx2+waVF1I8WeTuCFHdM04GsnBoqEbVuDOVr5tKjlZkvikDjZ7+FzJhJOiKNinChh4oD+sC3d7On+vxntDkkMH+X3oTR31+mF5QydE56BSR6cqLKEj6gUi77HgOhR+Ynf6Sc7/S2R6A/H2Uk48HF8lBUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g6VclQ92; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a8980c848eso1007345ad.2
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 23:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770277603; x=1770882403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSevupTzEHu0sF+WJcXaAghgvNkaKInyzTJ6cRAu8bA=;
        b=raqUPoMC8KZWTGjb0qIb59ib8cUzc0aUH4rs6kRJZ81wc18qLE6zLUFoZ1zTMyGG6X
         KNuP9i6mM3jHljgzh4EzXO7SHNLZTsxqKXorR0i1NeVaC2E3MA+AUI/PHpTrFfNTtgtC
         RN2iV8KKmKtvqH013O6egRYjmIP53hJuBui3kO7/n/5EZu8iAcWEdZzpEqdTO85cCcVi
         lWLZdpWX0FUgZgKI9fSrLP7pL0NI20NunZdnd6nqGsf49xYIA5o+2/CxxWm+SikReMCW
         /s+7Zef+4tCFu3ZkjyroAS0ZLd4JKVrCneO/f4KFF47B6k0IFDaq4me4bXO57MdloU1X
         AC6A==
X-Gm-Message-State: AOJu0YzKRpdQ+3sC85T2B964rQx0+SGnrX7GBQTnhOTkauJq7JPspRY1
	ouIOZb39+8qpEwq6KAgVf0/MpEaOAl54aJ0VdOqEICzdtQ8CYAZyqSvF0lueGiLUVtCVY6fEQ48
	S0jh1uDpe78sKaCNDHR2I0SQvW+3vQMUmpEgcxmQgQNXGHD2q11qVrZ3pQGWl6ZaQ5oR7+4WHK+
	KaG+ceTM83egPN7wUMB/DXypGCtLSUHwv5HWFsgyuMm+GmWT46aGRFyk7bTXjmMdZ348Ztfwyw+
	b9Lt5efTWwRqltweIIgTaIfVsMy
X-Gm-Gg: AZuq6aJMgyKK+s5+5PsXQtI8xdidyLa5q8bFLuPgUSxPX77tPC2wBdrK2KOr+c0Uf2C
	uonVNRkeIjPhOlEr3gKJ8UJwF8q/30ulTKVhzJ0Ha61yNcS++isJR2Wyfuy+Wh934OFNJ9b9Iw1
	tfApDm2KC7JtuPRAXbNAmfF8qJ+lQ52UbNERBo7/QkQQBfjMOQl3jyi9OIJtSHb3qyv5AaPU4O2
	hbKv8nWCJgIKX8kPaSPLpWqJvvf/u9gjU8++Q3S35KqIwESLr8O7XSCisLCTInwYcUpEE/Wx4/W
	48ZrXN2dZTF4Tcc6cF4HOvBBCeyo8lqI68yaBZfy83PG/nYaDZXs2svhjddFsuDLLAFId+wQCYC
	rSxLLq7n+ndXYD+N0XJBbB1b9OGZhOv9euvqIWQXsup9znm+iEQVWGtLyks2ry66Qzgwg7CYyfA
	f/UPb5tfpfKSqrN9O1Q9w4PqWq88SuH60BRRFI0uOU/AZvTy4Dgt4Is9NalqE=
X-Received: by 2002:a17:903:b47:b0:2a0:b7cd:d9c6 with SMTP id d9443c01a7336-2a933fd75dbmr40091355ad.6.1770277603239;
        Wed, 04 Feb 2026 23:46:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a933907700sm6844885ad.33.2026.02.04.23.46.42
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 23:46:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b70a6e1e28so17890eec.2
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 23:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770277601; x=1770882401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSevupTzEHu0sF+WJcXaAghgvNkaKInyzTJ6cRAu8bA=;
        b=g6VclQ920khstvNzbqEsq35iaC7EMJ3prUBNYO69sVFticXEKV3Pf2da901GF5qFjB
         kLeb/fwjwsfc/oqpm4s2XWGXkD9mZ8aA9sGqFy02VvSMdGr9d+mLXr9oQlz8XegsGYZC
         wm6G6tVXOjZmUGzDbnEARPOjnF4CDLO70RVQU=
X-Received: by 2002:a05:7300:c29:b0:2b7:b88d:b75d with SMTP id 5a478bee46e88-2b832743f4dmr1306046eec.0.1770277600635;
        Wed, 04 Feb 2026 23:46:40 -0800 (PST)
X-Received: by 2002:a05:7300:c29:b0:2b7:b88d:b75d with SMTP id 5a478bee46e88-2b832743f4dmr1306025eec.0.1770277599982;
        Wed, 04 Feb 2026 23:46:39 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f503ecf4sm3840166c88.15.2026.02.04.23.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:46:39 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	kuba@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Stefano Brivio <sbrivio@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10-v6.6 ] netfilter: nft_set_pipapo: clamp maximum map bucket size to INT_MAX
Date: Thu,  5 Feb 2026 07:42:29 +0000
Message-ID: <20260205074229.2091135-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214408-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 03088EF8F1
X-Rspamd-Action: no action

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit b85e3367a5716ed3662a4fe266525190d2af76df ]

Otherwise, it is possible to hit WARN_ON_ONCE in __kvmalloc_node_noprof()
when resizing hashtable because __GFP_NOWARN is unset.

Similar to:

  b541ba7d1f5a ("netfilter: conntrack: clamp maximum hashtable size to INT_MAX")

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Keerthana: Handle freeing new_lt ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/netfilter/nft_set_pipapo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 6813ff660b72..484ca8cf2e80 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -665,6 +665,11 @@ static int pipapo_resize(struct nft_pipapo_field *f, int old_rules, int rules)
 	}
 
 mt:
+	if (rules > (INT_MAX / sizeof(*new_mt))) {
+		kvfree(new_lt);
+		return -ENOMEM;
+	}
+
 	new_mt = kvmalloc(rules * sizeof(*new_mt), GFP_KERNEL);
 	if (!new_mt) {
 		kvfree(new_lt);
@@ -1358,6 +1361,9 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		       src->bsize * sizeof(*dst->lt) *
 		       src->groups * NFT_PIPAPO_BUCKETS(src->bb));
 
+		if (src->rules > (INT_MAX / sizeof(*src->mt)))
+			goto out_mt;
+
 		dst->mt = kvmalloc(src->rules * sizeof(*src->mt), GFP_KERNEL);
 		if (!dst->mt)
 			goto out_mt;
-- 
2.43.7


