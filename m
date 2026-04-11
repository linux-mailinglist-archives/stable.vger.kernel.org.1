Return-Path: <stable+bounces-235767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFKEIc6Z2mkC4QgAu9opvQ
	(envelope-from <stable+bounces-235767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 20:58:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 329D93E160B
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 20:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1B62305C8F2
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217083B9D95;
	Sat, 11 Apr 2026 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYeH1gIm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829883AA1AF
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775933847; cv=none; b=n3h6ufu0vH1RmxLaWEWBqSR0yeRxa0yVAlXV2jHuelvmq8lLPl6VFs+ZX3vShDmpjO2g39t1CHM11SMryWQruHTn1tJqRu/ce7xgUReRkaktUIw52WbJo6ZhTLpRiBbj7Aoux7UaMCRD8ZcoTMoiqn+vK9YjjVvdWY2XKsJamlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775933847; c=relaxed/simple;
	bh=s8DvPKpa7mA+qHyXVl0NHzUIBYxwCvFo6gHuWEJk5ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thcH6ocWccFzakWTmoFz4OiQDNKAp6JuFALBEsVBDlF9MNMClQhXrbZYTyhYtOV9JLR/DJNT94k21L2yotkhMdmT5iNOZHIpf2YxTjjuBW7Dyvm5VxvYrnAK7tDZ3Iah4ihNG3vsZjhtYJBDlzQcLZ1f+1ZupsvE/ACJu5izc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYeH1gIm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so29457965e9.0
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775933845; x=1776538645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=asmRMjtAdynfNNM/fvaGPOkC+0FMwoOWdK0OJmKnM5g=;
        b=hYeH1gImvN7NJBo9KDzRBfBCU34VMqRUt3zcgO3EWYAsUqIY5OTjRLykxui8j5YE+L
         XOfSgf5Ktids1LRZsNLletkNN9fgWzWM/0YSYo/l5NiRTt6XKsttoOnDhLty1t4+Bw7z
         /pSrJZ1CAMvWigIzzRCz6oBAPrxKYkN/4Ml7zKuVJGLsl3kmUWJy9lX/xJWy28H5irfm
         IQUUXCSxLLeWFulg0mLsBmgj5JwH1PxeAAObMroxcbsQHLFDn5/cf3wUC5PlZEVxXo6w
         SCffgYGNqdPVFQGYyn4nd9Woq3OiPmOxpFv/4EL5o6aVzXJZosgZ/1KY1CCl8L3XLk21
         py9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775933845; x=1776538645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asmRMjtAdynfNNM/fvaGPOkC+0FMwoOWdK0OJmKnM5g=;
        b=InLvy9lt05yh7WxBbdg5mKylCCKESTVgzX/itF69boRpPygV8oGpWorKlUWVzdZJOf
         8ZJPBRXa1HAwS4aZPOudOizd1HDkLQxfCaE5xf5KtwFm+WLfrP0sKSRlOmghdrJSF0H3
         wYoTZo+eHB1G8H1SjMhU8ade6i7Vhji+2rBP6JwPuwhiaAeQfW/JRkXXRuA3Rt6UGjaV
         /0qwCOSFC9ek5cKV3G8CwWoSJ95BGDXtzxfimYKAikY3V3t4zLbg+7DAGq5Ojf8iGfOk
         tcV27w3Dyl5n1iOk++G7QgZqxfAKt40j+I0M6nyL1SQ2lZipOqdKTH2o2jbIkNLf4UmJ
         xtyA==
X-Forwarded-Encrypted: i=1; AJvYcCUeBSgsCUVI8OcWFDjp3A3/2qjFcPMm9ndHyBBextB3BHmJBXOPDhvbIWcjbxheQvalzqzRmUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlVznhAJV/pCc68XU2McoiHWaGQ7UH2AGZPpB4q3F+1aRLJ6ye
	bXejdB3uqCZ0WszVO8/P6jy57dLbLCXPvc5Rd6EHJxVwEi1NTtACMxoG
X-Gm-Gg: AeBDiesvF56B8pyiWx8g5nqLcqknHNfMICEWEE8ugu7WQuh2Vcvvprrp524tG54O4Vu
	t656Xtnb/A9o6tqBC/ZdtYkIFrZPS3KtXZNY3kJWmQ57hpBzo2df7cw4AJoNBu8Qc8XetgSQAlZ
	spViKJYns1YfthrzinNZmuqbAI1FaveIuYLycQk7iVpp5Cq5PKYoOcpGjBFrFex50yO9we2HSxL
	wpS0Wu6Un2jBwgxauW3UF4tHCKePIu/RPb3t8NqAkXoHbN7iFO+EykazQyhscWilxxwjf4rfWXm
	EdzI/ITWXfa4VZOgBB185Y5ZexCrCTSCkJX51HywAIWHwq5Psr69aeBQBfh5wwKnT9WC4Cf5HV/
	C0CNU4568NAmt/zdJlrvj4QwhyaddJkVO2z9ZKdAS/71VnyiwXdcz+J6EtqPcXB3BN3rfK08Cwh
	eBFxJhHCNB9a7FoBRbYodo8dRVKsDal7qA0eFCZ3Iq8aItlOG/n7g9LqMhpuCqGa3eWc4WUDXCI
	MgmB7Zz2WT8
X-Received: by 2002:a05:600c:350c:b0:488:9661:2570 with SMTP id 5b1f17b1804b1-488d67ce8c2mr100910025e9.8.1775933844696;
        Sat, 11 Apr 2026 11:57:24 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d703c1sm52012375e9.3.2026.04.11.11.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 11:57:24 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: pablo@netfilter.org
Cc: fw@strlen.de,
	phil@nwl.cc,
	kadlec@netfilter.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] netfilter: nfnl_cthelper: apply per-class values when updating policies
Date: Sat, 11 Apr 2026 19:57:21 +0100
Message-ID: <20260411185721.234936-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[strlen.de,nwl.cc,netfilter.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-235767-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 329D93E160B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a userspace conntrack helper with multiple expectation classes is
updated via nfnetlink, every class ends up with the first class's
max_expected and timeout values.

nfnl_cthelper_update_policy_all() validates each new policy into the
corresponding slot of the temporary new_policy array, but the second
loop that commits the values into the live helper dereferences
new_policy as a pointer instead of indexing it, so every iteration
reads new_policy[0] regardless of i.  An update that changes per-class
values is silently collapsed onto class 0's values with no error
returned to userspace.

Index the temporary array by i in the commit loop so each class gets
its own validated values.

Fixes: 2c422257550f ("netfilter: nfnl_cthelper: fix runtime expectation policy updates")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/netfilter/nfnetlink_cthelper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nfnetlink_cthelper.c b/net/netfilter/nfnetlink_cthelper.c
index 0d16ad82d70c..34af6840803e 100644
--- a/net/netfilter/nfnetlink_cthelper.c
+++ b/net/netfilter/nfnetlink_cthelper.c
@@ -346,8 +346,8 @@ static int nfnl_cthelper_update_policy_all(struct nlattr *tb[],
 	for (i = 0; i < helper->expect_class_max + 1; i++) {
 		policy = (struct nf_conntrack_expect_policy *)
 				&helper->expect_policy[i];
-		policy->max_expected = new_policy->max_expected;
-		policy->timeout	= new_policy->timeout;
+		policy->max_expected = new_policy[i].max_expected;
+		policy->timeout	= new_policy[i].timeout;
 	}
 
 err:
-- 
2.53.0


