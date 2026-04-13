Return-Path: <stable+bounces-235914-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id J7caDIyQ3Gl/TAkAu9opvQ
	(envelope-from <stable+bounces-235914-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:43:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B83E7DDB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DAD93006D61
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857491CEADB;
	Mon, 13 Apr 2026 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="euDZ5Mal"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758838AC72
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062593; cv=none; b=nkoxsUNudUkzj6vQt4WvPSjr86jm0IhHN2DZ9qGw8DSpLGr+y4ufJLZHHg+dpAHTIriQHDLZBj2DWLaxzGxzR5UjLrC5v39pfu22Uiy9ilbBxuIKNIQUFbGzhSXFVZ8m/1J7iQZkcfuRQu+KPcb006kDTekGl24k+k583yYZFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062593; c=relaxed/simple;
	bh=JiFPEZ+7PYVlYTXcCsZVk13kxuS+PQlaz/GlTkDPDRM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diG+rd2Y+FLG6xUxJmAZcyinkF46BEeKwf4DA4JNoDfrTcsKdaQG2QPOxB9ojlGnakl8E/kdkildJomuDRrmTsUYT9jiCVWtoAPceDwzln6dXrHDFtHqU6mbPQ6S793j2ulRg0qeKR6FFUs8PF8soAuaNkFNj1RP7Yn5G+GO5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=euDZ5Mal; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5F8583F223
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062590;
	bh=UX0q9ETCn9Cdn/+g3/pyQxtAHnkabe0dZAeF0DgfgFk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=euDZ5Malp2+eBE93QrWxrde+VkGhCNMftZvWj0OafQGVt96R9ZI8BzksiSofAfG5f
	 zJxWbzBJqh7f6Ecbe9tzguw8Z46LTGF8CvpzaLTEwDeyMc5EK5fE1n41CT0uhzF/Mp
	 w5LDMsff+/mWgztPm6N5Ndg434KrKTwXyTgfU1KKwO9gqiy7WlK02/Mu4zvTQI2a7a
	 4CumL/Ieg5O1XdLEkPFHe9N0NUEyqUxeo1JxEIpnNkvuc0SX4cUhphOD8CIuX4KC1O
	 AXOwiVpaUE+Y21VHWHudSdk/SXSi4WuCS4+aRUtUcs9fSE6VSw95qnYLLoC+n0H/9A
	 BIItC1P/Xw+sFz/7MD0vsuCDS7we7guIhbpbY+OMZlR/4Fgcu65VNvhDxBAxdxAjdt
	 Kq6T/6EJHHr5dC0LvFY0d7X5O70MfihC4I3BpHYDgmpmxDPWyawhlfI3qbhjjvIt2t
	 SozFJwrlj3Nn+o438CFQzzLNyPhLe/MtJboMsl3V64k9qh88xWcSNwxfWJ2cXwOd8w
	 L+tRrFQqRLmo3pj5VgvWoK8K77EYBhbtYqWDfXuModKbTWiDmdgRkNK5Vipl5E+KtE
	 szUPPgWdX9xEsAEYiF1Y6rpYZdG7JhUJQ+K6ygdlOik1Waoxkry0ESiJOHktsjumwI
	 4CodUJ+o5qULOFs6lm7c+Ipo=
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c741c4cebf3so2218323a12.2
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062589; x=1776667389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UX0q9ETCn9Cdn/+g3/pyQxtAHnkabe0dZAeF0DgfgFk=;
        b=spMkbjpLgE5WRKSbU1pzGnaEL9kIipDvk2a/UlpGjHVl8lfeWalrMyGjmNJm5vW3M1
         GiQ51MPE10vc30BzVMgcYkfL8NZKiS9iA0DSgGCNKDGS6zyIRo+Z/u6jurU9tr7idBav
         XDvgUWsnaj6aJ7bamYsSblzXy6B8vA82EGWVUCJAOPkDaxtP5uc53+Qf3o5pjwpMLRKx
         OLFuo3rA+lvvS28fsJkqo4fLaL6aUEcBt5IbSXRGMGO/qonH1OqpwAcupiNa+ri+ORYx
         d5dS7jEPzKcNZbtNUkD4Vo96iInG2FygCpXXJ42t4aq7DrRiiKJgAwQTIPM7/PBjB7e+
         YoCw==
X-Gm-Message-State: AOJu0Yzzbn3lpBiF/WsR2cVx/86egeAePmcGzro+/KChAabyjqoLc5Uz
	7qUua+97Qhlq/Ks2hY6BuuNxbU+VTGCs19omKV5VMP0QBYgU9pSPbBaiGmjYuSqAVkUUe7iiLW0
	/La46epHASaG/Q7ME9w8hFCbd6FqOjSQk15AscNHfj404H2hRTpsDxPSPLWdJgt/puvtWlxiHUp
	vO+MFmlw==
X-Gm-Gg: AeBDievy9E0CG9iND9moBzlmZqfbD9wAjeuqFhk1w1utVe6Y+5szQoZXurW1pUWHgUs
	yK0p1Q1KBCXuc+mmYIXuPJ0R6fTwXQG4UPpUb5D5CxyNUXfmH6aHidWdo8wtb/rGbW9wbyuOEMR
	hckILb8lRByoxZiqtzFXizyIp9XrZu0l+7ZUW9VhMVrl0JTogQJkptZXUVER+gOOlno9f1CkJi4
	Pj50iKm364V9Ud44eLhmmpXn4ER71jIAUkztTvLOi2WEOv5hzuCdgTUnqi3eaJf0af1gehRIHjU
	RAUkybmYURSFsRKAKJRoqvjfK/hAJALoog5BEZNzD78Ado7M/7z8kjWOTz6Tp+JezMfHqIxfL7G
	8Agf5I6XiE4RJrmSgElbQa6myiAc=
X-Received: by 2002:a05:6a00:2da6:b0:82f:316:31f6 with SMTP id d2e1a72fcca58-82f0c21d246mr13220506b3a.26.1776062589047;
        Sun, 12 Apr 2026 23:43:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:2da6:b0:82f:316:31f6 with SMTP id d2e1a72fcca58-82f0c21d246mr13220489b3a.26.1776062588665;
        Sun, 12 Apr 2026 23:43:08 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id d2e1a72fcca58-82f0c30ee32sm10598729b3a.7.2026.04.12.23.43.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:43:08 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 07/11] apparmor: Fix double free of ns_name in aa_replace_profiles()
Date: Sun, 12 Apr 2026 23:39:16 -0700
Message-ID: <20260413064256.1578919-8-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064256.1578919-1-john.johansen@canonical.com>
References: <20260413064256.1578919-1-john.johansen@canonical.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235914-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 795B83E7DDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 5df0c44e8f5f619d3beb871207aded7c78414502 upstream.

if ns_name is NULL after
1071         error = aa_unpack(udata, &lh, &ns_name);

and if ent->ns_name contains an ns_name in
1089                 } else if (ent->ns_name) {

then ns_name is assigned the ent->ns_name
1095                         ns_name = ent->ns_name;

however ent->ns_name is freed at
1262                 aa_load_ent_free(ent);

and then again when freeing ns_name at
1270         kfree(ns_name);

Fix this by NULLing out ent->ns_name after it is transferred to ns_name

Fixes: 145a0ef21c8e9 ("apparmor: fix blob compression when ns is forced on a policy load
")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index a4406a7f753c..fa8cdcb3a356 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -958,6 +958,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 				goto fail;
 			}
 			ns_name = ent->ns_name;
+			ent->ns_name = NULL;
 		} else
 			count++;
 	}
-- 
2.51.0


