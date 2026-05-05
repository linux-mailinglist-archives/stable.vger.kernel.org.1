Return-Path: <stable+bounces-243948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEtWDIhZ+Wk68AIAu9opvQ
	(envelope-from <stable+bounces-243948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 04:44:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED924C6104
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 04:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 263CE30074EE
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 02:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368CF392C28;
	Tue,  5 May 2026 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOt6secU"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23954654
	for <stable@vger.kernel.org>; Tue,  5 May 2026 02:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777949059; cv=none; b=LyjsoadGxIQ2pkOndmQjUf53NX6vJVXCPbkt27JHdXlAjZgLTa4NFM7KFfFnKYEN+0Nt1D8zfHOhtUMlGzNdIWb945aDwl15OSvZduw2MBzyWP7BoXRj6px1nTDpDYH/rAwpjQ120s0sXKIu/JWKGW/lRnUQOqg2luowvs1eBO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777949059; c=relaxed/simple;
	bh=+ijqfV2M+nUWmrZ01hUk8qlmqmFkkygkO48bqXlWhKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQUxwyXBZvRU18airbZhAmuo1lgyNmoWf34OEEjciOu6yXBIJhhaa6gWR0VXlszwK/AZXZa0cvsn19n0HS2ZoZQ/ICM/JZU05HE9ITult4PZ3p3Ob2rKh+jSeFDMbCunnYKj2Zg1NIZoQ41b1YcwrYvzE8ykbDqR8n6enzwrjRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOt6secU; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-12e332315a8so6755244c88.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 19:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777949056; x=1778553856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Mtg/2Y1Yctt44dTC7tgSUAiz3kq2xes5Jal3lx1c8I=;
        b=bOt6secUqjKrg6zJdgj5syGnSQWbI9FRkwUR6VO2jnTMYxGMTgCUmoyE4stkDArtbE
         eyX/T0Xcbk31SSPKvjzYHavrv7+EM+UnbQH3NCUl+hD5LGOJ2hyqOjd/Pi8Tiz/7dS+M
         ZB4J2tXV1AtAqszPanNuERFqhkSX6NQJ/8HXDpph33ZVV2B6vAPX5T4oipvgr8/aKb+2
         /5I9D2UrJFhdGzzYU64ofUJtFPL6s8ixkI9PAlHFVRrNBpjNAFAGXGaUggbfTQgKazAp
         Cr6Dh108KZcfawtVwmbS+CxdVWxQKFKMA3+WfYrJjO56N0MRWghLRssxYRZCW6rq3Fah
         fheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777949056; x=1778553856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Mtg/2Y1Yctt44dTC7tgSUAiz3kq2xes5Jal3lx1c8I=;
        b=WJkHqufOTsZ8L9DWc3pmy8XEm3EIH08K+2VyP/ZxkG9CShvrqGY26dTeXYJRMMkEwG
         Ct2DSkDrYHHDJb9xN0j1fzVwkqqjBLRzUbcvLVlyJ+L7Ehn7HrLx5aA/XG0QEDdWhfH4
         /Xb1RJrlWyACt8zzd5NMDs5zLZhTxcwII7moBRx73TvO0r+MfIMAkcKkAb/8kYQqt1hF
         LQStkd9OGACkXj+reqMu9SJh9X9z6cBVLYWH7ym0icP0+KpxSHt4t2rvbZtGigPeKOAN
         k8yAD7RMDG2aNuIHX1OvTec+Jc/cPRL3c5Isgk5+GXAOpoGzo6I+XChTY80G6V2W9EZR
         7cLg==
X-Forwarded-Encrypted: i=1; AFNElJ+o5lxDGWQ/QLe2cXA2Xbbe1tCaEcnGf9q0b7nQPB5r9jJlv2PTPXWFgKfrZ+JteNh7OsNOX5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvuVDmL7XV4KEnyx0v2Qiw0xBQbWWUuooZDD+dL+X7v0h6Q4TA
	0E7yH7db6SjPeln/o/Ey1Wqz6i5UAW8SNlK56nhq/saBgi8j+3D9Ucvt
X-Gm-Gg: AeBDietYgvgaPqo24bDjxeUgfxBuVIquAgH+mVewkB6VDo/SzNVb73sIx9unShYnK+0
	4Qqrk8OK7B919yjnFncyvgog9Up8fD4nQki+gtbQCOBgaxoU7XwnExqhiTwbfM09oDeiADLGal5
	GHn74gAwqRGFkVlA5QGNFVtXaakC7pdyCXml8h+qGUftc5MKPoDVEtPKkL17LkxiaNJZcQHRJYT
	iXaiyXZy6azdR/3PtZiUJAlHCOP43TxSjbuoxey8cDX0wrKN6TQ+7sJQGJditIc5ti3GWzPpQYk
	+k2snqBb49Lav54NfZPkYT6sVq0vjXgnfNJ6KEQto6w13Am1/m3EfmTV/JS9BV8WprbD9FRxwud
	mz69+sXjRLSp14YDsKKcKVaJ25bMyxpW5zPix3EKvWZRo7tNmuYPSpQKMrGKsF6nrHDLeyF3pEJ
	G+Qppbdpd0ztGNjRilY+Zgs8aXBRHmAEsx2G0xwgAozclqpZzFrrpFouvavkhLcBqhVWhb3gvuo
	jR0YxPna/N98r4N2pod88OKyXWC8RuC6oysJ2JzxSAJZWE/kNlFX5uHpKyAsqGlC5dc03ORYwXm
	lAaVbQasiHnwarnaMzDAqpnWbxxO
X-Received: by 2002:a05:7022:43a3:b0:12d:b7e5:a691 with SMTP id a92af1059eb24-12dfd7a0e78mr5809301c88.7.1777949055822;
        Mon, 04 May 2026 19:44:15 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df82a141asm21094589c88.8.2026.05.04.19.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 19:44:15 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH] watchdog: s32g_wdt: remove incorrect options in watchdog_info struct
Date: Mon,  4 May 2026 19:44:09 -0700
Message-ID: <20260505024409.60301-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2ED924C6104
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linux-watchdog.org,roeck-us.net,kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-243948-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

The s32g_wdt driver uses two incorrect constants in the options field
of its watchdog_info struct. This bit mask should contain WDIOF_*
constants, but the driver uses two WDIOC_* ioctl constants (in addition
to correct WDIOF_* constants). This causes many incorrect bits to be
set in the bit mask. The functionality indicated by these ioctl
constants is supported by all drivers using the watchdog framework, so
this patch simply removes them.

Fixes: bd3f54ec559b ("watchdog: Add the Watchdog Timer for the NXP S32 platform")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/watchdog/s32g_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/s32g_wdt.c b/drivers/watchdog/s32g_wdt.c
index ad55063060af..6422a694fc65 100644
--- a/drivers/watchdog/s32g_wdt.c
+++ b/drivers/watchdog/s32g_wdt.c
@@ -56,8 +56,7 @@ MODULE_PARM_DESC(early_enable,
 
 static const struct watchdog_info s32g_wdt_info = {
 	.identity = "s32g watchdog",
-	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE |
-	WDIOC_GETTIMEOUT | WDIOC_GETTIMELEFT,
+	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 };
 
 static struct s32g_wdt_device *wdd_to_s32g_wdt(struct watchdog_device *wdd)
-- 
2.43.0


