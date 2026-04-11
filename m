Return-Path: <stable+bounces-235744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qADWISF22mn82ggAu9opvQ
	(envelope-from <stable+bounces-235744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:26:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD983E0D21
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08A713063564
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF7E3B8D78;
	Sat, 11 Apr 2026 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXsOSalR"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640783B8D79
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775924624; cv=none; b=NO/Jh/0LJpBqIo6JgLGt1Rfxtz9F/JAiO+n11Uz0sMjQMhOy9hhqV4k00ABR0u3Nufkw9qQ69nA0Gvo4jkpK2NKYhmCsbBjwVIVehYr7jcusfZe29E0ZWDubMaEn3Asa1NbxUXRmIKDdza2mfxwGdBvXhC9xBIqGlknp8zncNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775924624; c=relaxed/simple;
	bh=NlwwelYA8uSHgqW88Xvl+l0Vc3NtEotDqvYvC1ZDl1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgP/B+gKwE+ES5BbgWvNbxebUChleTeMEIijSpFvOe3MM+Z7jD7vymBjhsV1IapPeRz/wRGa9pTgDuR7GR58Zl8ipYUxZIJHFV1fFpZJbShiSedTfXW3equTiiLm+EuR2ygamCZjGE7flc9ebOib1S3lZSrJSnsBLXukoRWJmO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXsOSalR; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c156c4a9efso4348206eec.1
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775924622; x=1776529422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LD0U2JI3+b32qBu6y4JGUu0pIw+boTDqwL9bnMsDgY=;
        b=cXsOSalR/AtZARKLCtogxlzY9wPrC4paojkBgAO03RvRgMgHfqKmcfM5X7pz1elX8r
         J1w0LLATrKa9OuP1VudKHingH2xdbQKEXqNCeOV4UgRi7ClUI+ldfxRQzSHMLgvPSYj9
         Feh9SyJI60es/WLQbr3PHzKJVGbQcVwm+DOI15e53QUuz8hlvamRumrhXgt4vr1zPs5m
         uugBq4BLlY1XkBq1oUWu+UpK0uqbsBWZZ9yfiZ6J6jrfCF0qgyd8djD+XDzqc6IZxokj
         lbJRwu/VSwkAOtmDqNh0I+LEMj1wASiD5qL5JuO9VhSJ3Ge5C5rLvPXHeMLspEhWm0HZ
         sY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775924622; x=1776529422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2LD0U2JI3+b32qBu6y4JGUu0pIw+boTDqwL9bnMsDgY=;
        b=LiEK6J7noJBLfZYEWBIXi5YFDyFaSzJXhg2Yq/zpuGZOCsT3z/j0pP9ft29wsU2lCp
         ZR5tV+Ws2Ev2bHHLk3065GKAWerVNV5mlZDxxG18q9m4J9ZIhOrwYUjQ2TYIvt3gA52p
         SP8VEv0qTTWmPYfXrvl8biSsuNWTGxH/C+KdWU6vGUEBK4c4t9ty0cG8+dPfU+zgoV9J
         B251Qge8ZPC3hh04e/VsfJhH6Ctw/Ad+MZ4bknplDhAVpFKsaq5gsN0bqeRdqZZBIQ59
         tHPnc9l9vdQ30+1QI4hy7qQtnkn/Q16kC5XoxId40h7FLk2b5O4TMFFIQG/sTPBqxylY
         1a5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXW/cqvW1+iRvlXyX4e8o6j8vhFuASnSqGG0oSSs923IEGK/D8wekcMB07eEgCcGyHVwXQQK+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRyUuKLRIN2N1Y0ecVKWn25r5SkoadfwgP51KYTTGlZdAN4ihY
	JWHU425JrrnN2f6HjWYaotl/OJCGM1jG1n0qt5nZ0NkIIS9vDWJ6Uw4JH4CdpQ==
X-Gm-Gg: AeBDievO/6H/2EJ40MirCEyAumzwcYieg2MfWHdNKjVs2hsI+6HoVWKO+mgsW6bL5IS
	qP0s4L6pcsRYZ7SHeQERtKl+ngwDXKbsps3JrOigP30cYc5z+BgWxVMS65Zwa5nSN0PgXYx1cpS
	jxFYAE6a9i1n4Nid7NijKOvn6eRtXKaJTFhU5AKnFTK+vollZFB65SeMNIOED7rjqsJTzr7DFdX
	i8u3dbI2WjNDzj8VTXTEAM3YurhAA5f9qP3HqhDCGCEt2DnA+dxxJye9Mg8gVSQZyoLQVlsxtVX
	DpgivyKVHElCXU3ku2nHo6vGjCKEz7MZ1nuwgLfSl+DrxJ9xy1I2rTLrKWZrV/I+d3ybJ90e0O0
	qlJBYHNqH3Xl+C301g8CZusirgpTohY6O/eEMPWmVG9k2jguVIMgb4Qq2t5LFC6X3E/zNWw22uz
	3pHWe70L55ZfwtLBzVfK5bkROQuukg5QoXqFJTSGab41olzEOUeb+zwYE8gSy9J2/Q8w066erBB
	vkK
X-Received: by 2002:a05:7300:d704:b0:2b7:fdb6:ccf6 with SMTP id 5a478bee46e88-2d5890795cfmr4238650eec.14.1775924621592;
        Sat, 11 Apr 2026 09:23:41 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55ce46a65sm9358907eec.0.2026.04.11.09.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 09:23:41 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Rong Zhang <i@rong.moe>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v9 05/16] platform/x86: lenovo-wmi-other: Fix tunable_attr_01 struct members
Date: Sat, 11 Apr 2026 16:23:23 +0000
Message-ID: <20260411162334.25682-6-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411162334.25682-1-derekjohn.clark@gmail.com>
References: <20260411162334.25682-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235744-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,squebb.ca:email,rong.moe:email]
X-Rspamd-Queue-Id: CBD983E0D21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In struct tunable_attr_01 the capdata pointer is unused and the size of
the id members is u32 when it should be u8. Fix these prior to adding
additional members.

No functional change intended.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Fixes: e1a5fe662b59 ("platform/x86: Add Lenovo Capability Data 01 WMI Driver")
Cc: stable@vger.kernel.org
Reviewed-by: Rong Zhang <i@rong.moe>
Tested-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/platform/x86/lenovo/wmi-other.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index 1e06b894cfcc..50a03f5fd6ab 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -546,11 +546,10 @@ static void lwmi_om_fan_info_collect_cd_fan(struct device *dev, struct cd_list *
 /* ======== fw_attributes (component: lenovo-wmi-capdata 01) ======== */
 
 struct tunable_attr_01 {
-	struct capdata01 *capdata;
 	struct device *dev;
-	u32 feature_id;
-	u32 device_id;
-	u32 type_id;
+	u8 feature_id;
+	u8 device_id;
+	u8 type_id;
 };
 
 static struct tunable_attr_01 ppt_pl1_spl = {
-- 
2.53.0


