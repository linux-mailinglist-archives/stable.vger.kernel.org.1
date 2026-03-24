Return-Path: <stable+bounces-230041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMLIIffrwWkgYAQAu9opvQ
	(envelope-from <stable+bounces-230041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 02:42:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2044300A46
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 02:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91925302350D
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21130372EE3;
	Tue, 24 Mar 2026 01:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCIZXT/R"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F540DFBC
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316306; cv=none; b=TEvH2LEirBayYBx0EnIeTT+gANcyBvTr8kFBR/vqs0KABvYMF3raOiKB19zgcqbxjzWlpvoYC/PAdJddG1DcbRcXrSv2w1C3ubMAkc+QSUAWDGy0erOrQN0lqJB1JbN9YDpEWnhS1w+e0nVfkBqF/d99uytgj8UmLHrEtVqlzRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316306; c=relaxed/simple;
	bh=wmlnVGh79dj21yiyeZHZ4DBJkXFrqKrjGjcWsje7c5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMpTVX2kjwv5H216xy//SGMcj5u2oSX4jXexM7Zp7iyjBBy01iSIsTgIjiQMpgpGxxCk5oFg/xqyw5lOu/Z3jFNgXZC7DgUJyMxoX0fEAAK8r6p+58ZuuQm958MmFOIq49OqIXBmBtVgXAHOagV4pqcBe3KsmO65bm+YcFas64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCIZXT/R; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8296dabef74so4086486b3a.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 18:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774316305; x=1774921105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmsfLC1kFsbxmPW2aQul9mBcQdNDbnf2m49KLC9+wKA=;
        b=LCIZXT/ROIrHyfkTYRwOaYfUeDvPjRlRWEdUC9thVJQSMiGvpwvDlQybujNa07CSMs
         FwOl3xoJApVZ/ObkgiEcqsr/HbOcb+nTi60Xu6CnFH+htYwQbPM5cwkvPF4HVijYfoWA
         r0Dt04HnJK05sqquVOIr8WHoCBNcJSS92h+98/MjkquEBSqaF5k76bMQSx/T+nbwyM91
         elpVQ7GE8SxY7x4m3DL6rUKtWn/1KCsAjaNHYLBY/4HuWofvPrs6pzZHqp80QEn5DJ4D
         lZEMtPyGBLjFPIrVokvI95OQ7aZUxvYMApWID1r0h6Mlw3hxKFB8Qc9hKVXfVfRfitla
         uMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316305; x=1774921105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GmsfLC1kFsbxmPW2aQul9mBcQdNDbnf2m49KLC9+wKA=;
        b=X0e6iNfvNoq2IFiBXUHRZSDDulZioIVR4PNIfDXVdtafsE+zS+9RgYSFASkTE2uEy+
         66Tf6j/pPr6roRX0VvoA+iF0PK922vIQwZtRJTjZARRaeLbYRXLuKW6SukzIYDQniAMN
         FWuOzShUWffDqFBw7MtcE5UgLAg+fGNUIYcUCFvE5MEdnYO6XPYLd99uqYaBgfBMvt+S
         UvVE/wtyqDJobjmcw6qErFJQJHr4jvhFGxQxoRm+6x/RgPBXa4ZtcxSQ2vGkLI77fUnJ
         yfQP/A8VWbnpQTzqyXV3ntUX8kBghSBG3QoHGQd/qruxq5wjFxyFj3yyy0g84o+JdwqR
         igDw==
X-Forwarded-Encrypted: i=1; AJvYcCUAmFpdg/aetE+g/hIGcFwtT2Gf4Sx/H3z65o0WtzE+Eh6zZz3ypD+C6eA/WQSSiOtEyqYaSck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5J9gKouzbt8xRhRk+2wQQcaNo+4SWxE+SqCQsj34q2xsIl+7
	WpOlS6VTo3sJQS+V1NsjXKlQ10blEr/3rayreRmIaNG6gt1Uq0pGnmPZXOCJnDonpms=
X-Gm-Gg: ATEYQzwbjSePYB43+cJjj/614af7BPfGn8vuTHcZ7N1gdho+dxTU3F8EQZq+BMiFHGy
	fOTLGCxLkgbKcieT12rpV9/2GrXmU1fZC5lGsnrUIIB/YD/9vvyqfGjGnhn8ipgz2zWePRz1n5P
	Fia2e6NyM3MxcW/nLsDQ6g+PGeCxgO9kxGSIztgGDWOSvJBR5WCMDSxdOQPYtQlf8UhSXZpBR8d
	D5F++p+8LPYMtRoIZiwCWizu0H+RDdv39Jfve6qeziuQtogHDHAUxjAZhsdzfBnT594EedVeZlq
	1lr4uG+GcKVzysaznJPNcW4RQS/Lf+biAiNJcuMgdcslaS+x+h+MRb3XxpwyEMKemMkQOig/Pzy
	u6oFPS+S06LLbJsfysj28/0xmUi72nL2FFU6zeiMOB1Vxu/RZf7c6j1YD6Wy+dJiqpnZCJ+BUWA
	AB/zhY4K3ywowxdZZsYEZSjB1VLk2PU+YnTbVfX6N4GBrFGdETjaK1RRlRKw==
X-Received: by 2002:a05:6a00:4148:b0:829:8942:2c85 with SMTP id d2e1a72fcca58-82a8c22d29cmr11162422b3a.17.1774316304785;
        Mon, 23 Mar 2026 18:38:24 -0700 (PDT)
Received: from nixos (om126208151001.22.openmobile.ne.jp. [126.208.151.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0410a3c9sm12788696b3a.56.2026.03.23.18.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 18:38:24 -0700 (PDT)
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Subject: [PATCH v2] xfrm: clear trailing padding in build_polexpire()
Date: Tue, 24 Mar 2026 10:37:42 +0900
Message-ID: <20260324013742.939533-1-yasuakitorimaru@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260321210421.2504711-1-yasuakitorimaru@gmail.com>
References: <20260321210421.2504711-1-yasuakitorimaru@gmail.com>
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
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-230041-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yasuakitorimaru@gmail.com,stable@vger.kernel.org];
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
X-Rspamd-Queue-Id: E2044300A46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

build_expire() clears the trailing padding bytes of struct
xfrm_user_expire after setting the hard field via memset_after(),
but the analogous function build_polexpire() does not do this for
struct xfrm_user_polexpire.

The padding bytes after the __u8 hard field are left
uninitialized from the heap allocation, and are then sent to
userspace via netlink multicast to XFRMNLGRP_EXPIRE listeners,
leaking kernel heap memory contents.

Add the missing memset_after() call, matching build_expire().

Fixes: e3e5fc1698ae ("xfrm_user: fix info leak in build_expire()")
Cc: stable@vger.kernel.org
Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
---
Verified with pahole (struct xfrm_user_polexpire):
- x86_64:       sizeof=176, padding=7
- i386:         sizeof=168, padding=3
- aarch64:      sizeof=176, padding=7
- armv7l (hf):  sizeof=176, padding=7
 net/xfrm/xfrm_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 403b5ecac2c5..ee31ef482be4 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3948,6 +3948,8 @@ static int build_polexpire(struct sk_buff *skb, struct xfrm_policy *xp,
 		return err;
 	}
 	upe->hard = !!hard;
+	/* clear the padding bytes */
+	memset_after(upe, 0, hard);
 
 	nlmsg_end(skb, nlh);
 	return 0;
-- 
2.50.1


