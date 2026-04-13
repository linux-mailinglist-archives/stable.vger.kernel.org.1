Return-Path: <stable+bounces-235925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPgBJIeR3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FA23E7E74
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 958E03007298
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DE6366057;
	Mon, 13 Apr 2026 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="HazMq7Es"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAD436492D
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062846; cv=none; b=K2eXIt6hfgW1GoBDRZiUCZoI+aHLMYQKcWgDRmwGaxU67oeyFRS3AWJd83JXvqaLBkFHsKiGK0zJ9qeQ66Neo+kdaestJRO2/T3cXWLuqFvxiwRMmPe9DmEsO/hZzsigTw7F42aebd2mq2NCqeogbkQ4Z4Ew3Mue1DFdImQKDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062846; c=relaxed/simple;
	bh=OAToHhqMjCKAl9NMLXaEr+7gk8+90jKHRqsYQERTtic=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CG5ProsV3AmvUuavco/1Pbr3oVt8u2cqpWqk7fa8jw1F3sBAS1Dpy93DVhZxaCgq6eblRMeWF88VqXNfncUtswVtZzJFUkt1/1yb3hlvLXJdNvl9iKrfQAQrxfrehU32xT2pbRJSI2ynwlwy/++ekseKZ5OjIlk2IUl17b3Gkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=HazMq7Es; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D92913F1C0
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062843;
	bh=V/U1NC1FKQPC7+VdFxMDVzhagkqyohcvO63wH9YsdHw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=HazMq7EsmyciE5dLs1BJn1kJmQx+GB9BwJyX5W/SUCChHdBEXtn86VtIhjV9dRk8x
	 3c1Rqb4uESur3gEToW5nYB827v2dL6TPHpQmB+Nwq1px4h4uj9mGdfHulPaxQhlktk
	 sDuzACXMifmaEfaBlNF+/TyLWhQdldKHrGlpeEycuwYZ0I0tEMoVqGhZqMtZnnaSZX
	 0BubwqFuJrixXArGdx41rFw6TVuPm8+CfpU9kPRSZ9C0edsCfPW3saEQWC+WSMdx0/
	 LlRIPSSmrrUCauvCCskpTsU1QKo6nwWkubVWjlBDRSpBqjGGvbRS7jbrmfMhIb599M
	 ErWBs1c4mKnLay6/+//HEjSWdFTPRj2m0qZQFdtxj7zpeZJOLCcVGyBcv8TupnWmya
	 DHMfjgPDuQGEjDOheDWDZC3z8arHBJ2ONNXNw4fY0mWBTKn5nPqaIeXx5WcZhtl+d1
	 C2uLLGG++n3rnm9guxgfzVDHMw8ZnDqCB02hiVrryUTKH8pD9hKTEvEiyLOIVbKet3
	 zCEkpsiXmsvk508fohDfpikQxA/pwePWcArtEjTvPlPVbtDYjAwqDvEjPfECMhUlXK
	 IEuRmBNe0IlLhKw762j0uESmbN0pcIoVzR7aF4iilAvUBidifHU/k05u8SCGe2m9vW
	 wqWCJFIJxJKWuOHEO1Bji2LI=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b461b36990so5192605ad.3
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062842; x=1776667642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V/U1NC1FKQPC7+VdFxMDVzhagkqyohcvO63wH9YsdHw=;
        b=AghiocvpcBuCJTPd41JPwfxqlcfdnJSsxEVHjeuktMKpPN655lmcWxqRfIT/5dSQWY
         8POfJ49dnSeVuxociII7xchKOdnYeFHqoV5bk/5ypMDbNYwYUZgHNo57c6bLPLgcTjg4
         UBAh8MzKcVcI9o0V5w9fqLFIKUe7JIxXks1eBzErwLDrjqh/tJ9rXH8NsM0n813QNSkf
         E0TqR4gkIlvxA7mpA9xMuC8DIlFxUkBKKSNEa4HYihHSk7KoI8zNmmbKfWlfSvBQEbwZ
         CEKFd4iqeUW4LhmVTFyl6BwB45hmCKOK4zZrh4N8EsTm++09VdvCfbDsf3qog4uXip2T
         sRJA==
X-Gm-Message-State: AOJu0Yx3gFeytT/VP4yRpUbHH+t5MaVMLqMAC3x+jnOhdEj8b05tvEaG
	gBRp1fJYbbFcCOIAsF2Nq7SWmIdtvMMuF7v4SJ5RXhI+uw+PHs+HbxmwdGqSYQKdwRVYWS1YtL4
	qTlRlMhZiz4ROWVsI0WUefmOJttX1jrocmNwcsvR4z09NUDqIpmcHblZ1BQV091gV9inexLcm/5
	gMYs+5Qg==
X-Gm-Gg: AeBDies+fcXB8E0d11D++ycLLg78BZjHf7IQqfu7GmTeRm/y4fUZ1FzGRwpDsDb9jy7
	YktJomP+0pHDL3RB1LN9Z7yzngos83jfIhDLbwxLZXRsLOr75CwXgljHOEjp0/1osxBk6ryQDhy
	mytsQbnVVJaB4gRAm6yvifBNmnyoLx2ydj0HhSmu+v3ueZCfFb5SKdNl+B4R96iXAl+p2SDK87U
	hIdKibSMtCr85gY5LsslAOogJUOoOOdIROF3i+YszLmGzdtq6Ynshe4KeIJ6q6kJ0mDhLTG+nFS
	UU21Nn3xcqQEGorlCTV5kiO9SW9Z4H7uR1PwCgz6enwOZjZUTkqknldp/wNEEXpVUrPG7afRebV
	1VI2Ga4oAKIzIWrYMQeHHd9SXIyE=
X-Received: by 2002:a17:903:1b2f:b0:2b2:ebed:7afc with SMTP id d9443c01a7336-2b2ebed7f9amr48445615ad.27.1776062842617;
        Sun, 12 Apr 2026 23:47:22 -0700 (PDT)
X-Received: by 2002:a17:903:1b2f:b0:2b2:ebed:7afc with SMTP id d9443c01a7336-2b2ebed7f9amr48445395ad.27.1776062842309;
        Sun, 12 Apr 2026 23:47:22 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id d9443c01a7336-2b2d4f3ab3dsm111142915ad.74.2026.04.12.23.47.21
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:47:21 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 04/11] apparmor: fix: limit the number of levels of policy namespaces
Date: Sun, 12 Apr 2026 23:46:29 -0700
Message-ID: <20260413064712.1581137-5-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064712.1581137-1-john.johansen@canonical.com>
References: <20260413064712.1581137-1-john.johansen@canonical.com>
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
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235925-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[john.johansen@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,canonical.com:dkim,canonical.com:email,canonical.com:mid]
X-Rspamd-Queue-Id: D8FA23E7E74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 306039414932c80f8420695a24d4fe10c84ccfb2 upstream.

Currently the number of policy namespaces is not bounded relying on
the user namespace limit. However policy namespaces aren't strictly
tied to user namespaces and it is possible to create them and nest
them arbitrarily deep which can be used to exhaust system resource.

Hard cap policy namespaces to the same depth as user namespaces.

Fixes: c88d4c7b049e8 ("AppArmor: core policy routines")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Reviewed-by: Ryan Lee <ryan.lee@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/include/policy_ns.h | 2 ++
 security/apparmor/policy_ns.c         | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/security/apparmor/include/policy_ns.h b/security/apparmor/include/policy_ns.h
index 3df6f804922d..e5704947e86e 100644
--- a/security/apparmor/include/policy_ns.h
+++ b/security/apparmor/include/policy_ns.h
@@ -18,6 +18,8 @@
 #include "label.h"
 #include "policy.h"
 
+/* Match max depth of user namespaces */
+#define MAX_NS_DEPTH 32
 
 /* struct aa_ns_acct - accounting of profiles in namespace
  * @max_size: maximum space allowed for all profiles in namespace
diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index 53d24cf63893..5d342ef078e9 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -249,6 +249,8 @@ static struct aa_ns *__aa_create_ns(struct aa_ns *parent, const char *name,
 	AA_BUG(!name);
 	AA_BUG(!mutex_is_locked(&parent->lock));
 
+	if (parent->level > MAX_NS_DEPTH)
+		return ERR_PTR(-ENOSPC);
 	ns = alloc_ns(parent->base.hname, name);
 	if (!ns)
 		return ERR_PTR(-ENOMEM);
-- 
2.51.0


