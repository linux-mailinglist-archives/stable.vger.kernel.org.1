Return-Path: <stable+bounces-215876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJSUH+fbjGm3uAAAu9opvQ
	(envelope-from <stable+bounces-215876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:43:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4541273C6
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8152A3007CA0
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 19:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A982C352F9C;
	Wed, 11 Feb 2026 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZV3+YpQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806126B2CE
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770839012; cv=none; b=X0j4Jx6nLpx/uZtaBN0jwb4xSPMgpHx9z1fXGayv6ju5Cyd9tU/CBGpI52mZr9ohspPsh7aV1kxknNEgaJo1tQmFDGcud1r/A53LRsHnhR32Xn41dl7RtDW6wP7tonaYHt/SPkP26XsNzqvShaBWqMDSaES0Jx2NuSD/7eD89NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770839012; c=relaxed/simple;
	bh=ZWbPqJQii6H8WyeXZM+tCMZQu3W2Yff2gbsayOOGiPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kkrwVZFrUmhuu2TGel1GF1QmBcdUoyKoa+qCy1claheFO370Rmi9rycI+BQbv/OXBxpDu515yLsT0ag5A4KqPmxd+1kUMfsV9a08dtS61rNi+caoPX5qxJRv5WX/PrKqfHbRWNwzsmN9F7driB2ScF+7tXCs2kP7YA9yjiXVmUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZV3+YpQ; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4042cd2a336so1572937fac.0
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 11:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770839010; x=1771443810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0a9gQYVVISPj2gmgBnG3tylapu0SzuOdddpgIvGc12s=;
        b=iZV3+YpQp/V6DKuuOwLiVZJRJlURIwsjjAKm3aid2r3/5/qDfyFdrn8wP+ekZ76kYO
         cJBiVlS6Xe6qPXedhx+PSYC7FiVNwFDTGIXdrGxtDYM8ou0BNoVm3mIrPhDHpyl+VZuZ
         k0hIMmdlACa9IznX3a/CRmjM6YxKMdYiQgX46/2vYMa9Ot5ge9IM+2sUwh1mQGz+PbCT
         PzcIAA5hxlthhqKUCZQuxHrjvnz29lIGwNCcN4oiVl9t/NNyQ+ogMv1p3BHonA/b2dTD
         x/3/k60wKt/SotaXjw88XRmVcZIulqfSZyk3UyL5DjxoKKSj7ij5m+iwAJdZFHvl3xHI
         pdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770839010; x=1771443810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0a9gQYVVISPj2gmgBnG3tylapu0SzuOdddpgIvGc12s=;
        b=ttua22PBLod4RLEZ0ZATSQs/aNoDiihwFXYbsG+qYDPfEubEEP6Zve3DN8ncsHkOPG
         ABlEhFbL/Z9tY+aNcLLd3x9dMJL/yjqzfEU5kS70r5tk2gr2idrfdHVpAUTKwXDGrPZn
         VmBLPk6dcfdpGxAkho5kQQQeEl51dp7iZekRLQeC4pA1sCA3qIMbTi8ZG91Wg3sYU1W5
         XG9NKWk+SmY2W5SqumuIw2nH/HpreFWIONuNG3kJmH517Rt49iA5zwKIzFqaq0eAJUq/
         yXO2CVQEuyJM7cGQqR11G0T7gxOPdC6YLpD15MqndrwPntFaUoR0kbJ62wZSUljgkc8t
         jwpw==
X-Forwarded-Encrypted: i=1; AJvYcCXxyl9JT81JNzWM/UENpXSvG15ar83/ZPD2fEticHaQe4FqOX01YOP81ItqV37ADa3nbXFDp/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSTLgWrI7HCtKftdbLcdQH0/mHYNDN9gZiFqwthlw4RBpeFGeT
	hnKM70Ft9fzoL2iLp78RMHt9u3liH2IMDPVD/K3FyYVv+FkEOhf1KpT8
X-Gm-Gg: AZuq6aKFtYw0q2o7/AG2Ugue0cQwXEC5WWauXfj8Jtz9SgTaIdTysFVb9VdX1V6j2Tb
	GIJwQBlzciiSgC2irskhY0VmjhT5oc+hCY/Z2+wKUVVxs2kUSCyqTssD5c+JNaXloyJRtRTitT4
	PjLxj98KZsZx9LHee2bu5dfbFwlKqWqHLX+Ntn7+aXleRONQ9CB7PDVVKioLBDnwl+E0d24y4KE
	5Ohev7b0la3Z0jlHwxaf6WOx8bAmDtm06Uxttb7lFq1/Fd5Ooa22NZtIZx/fxZkP6aH3Fid5YSe
	4hsNeFgxZa+b1WyYdSEioYUMs4vSbkhvMSKkeGuOpki+TKObN8TVbIrhWIHQuKf/HCSfFpnlLKo
	GbfuDS3he+dKD2YfZZBDxgN/pP0iZFh9qS+ldBkVS52xu8lGqtSrhPU12LfAhPdzo2jbuQJu8el
	aprQpAMe5ATbv+tCcK9iwAl3qlj1MFtZKQx2RYRixXWkxzw7kqgefwxb9PdlJaZL/XZxA1l0Pu
X-Received: by 2002:a05:6870:3342:b0:409:794e:fe9 with SMTP id 586e51a60fabf-40ec74775e9mr153681fac.54.1770839010010;
        Wed, 11 Feb 2026 11:43:30 -0800 (PST)
Received: from ubuntu-BQM5.tailafa00.ts.net (cs244-84-dhcp.cs.colorado.edu. [128.138.244.84])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaf1e858bsm1989412fac.19.2026.02.11.11.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 11:43:28 -0800 (PST)
From: Ruitong Liu <cnitlrt@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Ruitong Liu <cnitlrt@gmail.com>,
	stable@vger.kernel.org,
	Shuyuan Liu <L0x1c3r@gmail.com>
Subject: [PATCH v2] net/sched: act_skbedit: fix divide-by-zero in tcf_skbedit_hash()
Date: Thu, 12 Feb 2026 03:43:25 +0800
Message-Id: <20260211194325.797963-1-cnitlrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211184848.731894-1-cnitlrt@gmail.com>
References: <20260211184848.731894-1-cnitlrt@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-215876-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cnitlrt@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD4541273C6
X-Rspamd-Action: no action

Commit 38a6f0865796 ("net: sched: support hash selecting tx queue")
added SKBEDIT_F_TXQ_SKBHASH support. mapping_mod is computed as:

  mapping_mod = queue_mapping_max - queue_mapping + 1;

mapping_mod is stored as u16, so the calculation can overflow when the
requested range covers 65536 queues (e.g. queue_mapping=0 and
queue_mapping_max=0xffff). In that case mapping_mod wraps to 0 and
tcf_skbedit_hash() triggers a divide-by-zero:

  queue_mapping += skb_get_hash(skb) % params->mapping_mod;

Reject such invalid configuration to prevent mapping_mod from becoming
0 and avoid the crash.

Fixes: 38a6f0865796 ("net: sched: support hash selecting tx queue")
Cc: stable@vger.kernel.org # 6.12+
Reported-by: Ruitong Liu <cnitlrt@gmail.com>
Reported-by: Shuyuan Liu <L0x1c3r@gmail.com>
Signed-off-by: Ruitong Liu <cnitlrt@gmail.com>
---
 net/sched/act_skbedit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 8c1d1554f657..b6f5c21651fc 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -194,6 +194,10 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 			}
 
 			mapping_mod = *queue_mapping_max - *queue_mapping + 1;
+			if (!mapping_mod) {
+				NL_SET_ERR_MSG_MOD(extack, "Invalid queue_mapping range: range too large");
+				return -EINVAL;
+			}
 			flags |= SKBEDIT_F_TXQ_SKBHASH;
 		}
 		if (*pure_flags & SKBEDIT_F_INHERITDSFIELD)
-- 
2.34.1


