Return-Path: <stable+bounces-241948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHAWJ6B28mkHrgEAu9opvQ
	(envelope-from <stable+bounces-241948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 23:22:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6175E49A8B4
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 23:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C26B301DEEE
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ECB3B27F3;
	Wed, 29 Apr 2026 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZtcKP18"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ACA3939AE
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497749; cv=none; b=PlUCa65PZh8T9xxg3zNZCE2T5GS8TloAUolGGc4/FGGs6tHqX8VzL7oVuJlCvyyovHMdtlrQUSYoRhNsyEcJiwXFW/ZdzD4bXrGsIqzdR+XYilvi/1iPHqFPNLSxpru29JqhYr8tNLsZjfwvJrsJiCut0bkaHg+nEdtrG37Z4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497749; c=relaxed/simple;
	bh=zBgK5lAHHmNxsjZxkT8f6JwiAcb8h6UPnxmKjQ0s8rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bD5BKaWwfwU5WoYHzhkkOpSKRVLYD4wqllivBQBhpYbrfNAf14nJcILJ6AId9wV/U04aA81fAaOPoWWL+8ydIc9ZbZtp9uNOWfU4Goqd7qdELrfbRhT86VV8Pg90tBGKBoleOqueJnlBLeOTKvlxuZ1SfVI74yT2d4tMaSu+Rv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZtcKP18; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so1127455e9.1
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 14:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777497747; x=1778102547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxqYhYsj7HU7oN1/TsDhDPzLzeP41V18doSZqNDu2iE=;
        b=FZtcKP18Fi0qhyPOJoyUblOMa/0lQHOMVwUc0GP15Wdc0WMXkKcrEomtdmjzqdiVQc
         6XVKFTbO7XpRFn93CTQsES9bItrQ0Qb9NYIIEPgQt2U5Ox7fmU/MCQFck6BSLO2yQliv
         PEiwC831qRFuSWUE0ZCY5O/Ybi6VAs7XHpTFetONLwkK3EjR4FezA2TpiqDoggCB8vni
         +frNN4UnM/Y0984lNapm6A88olDdMMrfvamTOZdxOi5o0iZyoklWI/NbxdYCMDsyUOS5
         np1WxYtjr9WcAVJ66hG/Kh2JL/vTi3F+737MSHHnFF/gG/MaU7Ro0jQh5zgw7+44RJ/y
         w46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497747; x=1778102547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pxqYhYsj7HU7oN1/TsDhDPzLzeP41V18doSZqNDu2iE=;
        b=a+M8NClteY3Ye5iG/TwBb1AU67I8k9hhI1Og5M3vl1tzgxKziz7s3zHQbYkLbwFPTB
         bvRtmOqwWZqXIoBrUrQAadT2ZzOhU9CRwzQSXpPT0D70+aAAGrr5ACJ9Bu42MJCNyLM/
         MvRymC+eACbpOWJPyjn6uQqFCSldV0aRdA4fy7QulwDY8H9I8NT6bQ5XIDhhQfxg3iqV
         R72kLYwrwL9EFnWhfMMvQR8zDhpxfRtvsN8Ilp+Epaile9Pr9PGkl4+hZ8w6LurZNee2
         IErW+38+hfE/IgmerjBvtlotnk+R9dUWkDkxzwY1ZuGWlRxcDlGD4yi7dw1CJwufd8eh
         mYbg==
X-Forwarded-Encrypted: i=1; AFNElJ+MP7wAKpgsPfcU+3H4hi6GBklYky3f+CyOua2AvTTZOosrluFklr8q7DqWpOKgQdSYw8bLWjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrwlh0iVTP+kDym5BBtujE28Ho2DuuNYRUImZMfdEilXklbc26
	O3zHdEMZpoEqMPvyb2np8OLNe8rPrtWGfhhC5hCB6n6t8Ws0fQ4PHGKn7qjVFw==
X-Gm-Gg: AeBDievlWZkwJpnwXymUOuhkV+mDma1wtGnV5aIV1nYmD1hxYNCEblwSSCxma4heL79
	EppfVrVWi7RtFF4qbojj1zN2N3snL+dJDiy77rL61G6ZCSqmc68gfMPghrv3CToXGJr5N8A9n8o
	dWDCB4IAzyX58YH419so2vYNnbOlf/yj6LTG8xMgPBSsCGqh8An6iTnvcDY321T/Zg2nebjy4P6
	HTQkiq4vsWtzA/MNSzlhLJYkvNBpZHf5hyLa1A1eMBSozetaZeZkUlJLPAffKt6HbbbsL/5QWw5
	IdT/g5jxWMnnTUZe4LgOgV5PpOIXy2J8YkbDhnhnIinTwK8M8qNDZ1UlNwkzG0hIgBxbKieMizy
	dP0T5Um2qQIQRVz9SJ7BcosxnIUNLzE4MFSZI0IDJe8+E29GyeihsiMLvYu1e/AHwJqgVePsHI8
	SCiDcY8Wzu2InmUngGwToy71cz+urpjXxe3Lt1F8k=
X-Received: by 2002:a05:600c:1f8e:b0:488:a824:fe04 with SMTP id 5b1f17b1804b1-48a8447f466mr3197815e9.26.1777497746519;
        Wed, 29 Apr 2026 14:22:26 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:8fc7:44bf:8aca:ebae])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a822d4b57sm45356905e9.15.2026.04.29.14.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:22:26 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v11 1/4] liveupdate: reject LIVEUPDATE_IOCTL_CREATE_SESSION with invalid name length
Date: Wed, 29 Apr 2026 22:21:14 +0100
Message-ID: <20260429212221.814107-2-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429212221.814107-1-luca.boccassi@gmail.com>
References: <20260429212221.814107-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6175E49A8B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241948-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,soleen.com,vger.kernel.org,gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lucaboccassi@gmail.com,stable@vger.kernel.org]

From: Luca Boccassi <luca.boccassi@gmail.com>

A session name must not be an empty string, and must not exceed the
maximum size define in the uapi header, including null termination.

Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
Cc: stable@vger.kernel.org

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/liveupdate/luo_session.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index a3327a28fc1f..24b4f381d3c8 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -382,9 +382,13 @@ static int luo_session_getfile(struct luo_session *session, struct file **filep)
 
 int luo_session_create(const char *name, struct file **filep)
 {
+	size_t len = strnlen(name, LIVEUPDATE_SESSION_NAME_LENGTH);
 	struct luo_session *session;
 	int err;
 
+	if (len == 0 || len > LIVEUPDATE_SESSION_NAME_LENGTH - 1)
+		return -EINVAL;
+
 	session = luo_session_alloc(name);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.47.3


