Return-Path: <stable+bounces-244620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOLFENHU/GlvUQAAu9opvQ
	(envelope-from <stable+bounces-244620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:07:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0C84ED310
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 332953071842
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 18:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F0047885D;
	Thu,  7 May 2026 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9Aon4zs"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF74947799B
	for <stable@vger.kernel.org>; Thu,  7 May 2026 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177129; cv=none; b=d+9+3hsj7c/auhArPlAK1uriG+Q6/Gw49XrC/bQgbt1mwjj/8akvane4tEEfj0SZQ+OS1xfRhfNJqzz51ICZKBAe+XGJlEuV4XukFOh5CooBXZsef9SjqO0IJFpdnYjHLtBRQ1S1wUEI1IUt9MHGXUrLppAfjeRRfecfjpomVBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177129; c=relaxed/simple;
	bh=NlwwelYA8uSHgqW88Xvl+l0Vc3NtEotDqvYvC1ZDl1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iczz7MYPpOiKUXKtpPEqDLWDxHjseuWWwSBwq4JGgae2aL1u5Rh7cxi7f+vayIxurLwuRt/SNb3aZYDmlgFgaTNiq+q/E9UQdwDz9jyhdOnWcDnHx8yeXLYvfzFo0KGCa5HXI2ij3v4WedGBiVSO51U8KJthfC9bVGZzm+vJuSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9Aon4zs; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-130c653cce4so3227050c88.1
        for <stable@vger.kernel.org>; Thu, 07 May 2026 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778177127; x=1778781927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LD0U2JI3+b32qBu6y4JGUu0pIw+boTDqwL9bnMsDgY=;
        b=H9Aon4zsayzzgHkCSp+c2talcKOMl7cpNnKXFJoYoywEbMXnCTINJ7Z6EWhibseHKK
         EC0iG24VUt6jlyDGvCWS4tdqsG/EYszn6aJj7N/KxnZOFoJZ19r072ahlc9A04kzCgvR
         lqQW2vUfsdRhcPWW/kcqYgf7VzDwpYbzowmnmdRD6WpAI0UzJ2VQ/C975TxfR/iBSqzq
         cKFHNxLSIkkFpLpteB/gWVauApQA3LbJv5h3huSUccdlJ4Lmbegicmj/ZpvZ97CgIt3K
         I0rU0g+m1AZamLfAqY8hEXtKfpu+LfiYoGW8Mcnkx2EwoAH5yZk5NKrdJXqoAjnnL683
         6EJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778177127; x=1778781927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2LD0U2JI3+b32qBu6y4JGUu0pIw+boTDqwL9bnMsDgY=;
        b=guH60FPOKxBaRroMW///vh+kbSYytwjZb2aypd8ifqyAaQm1lJQogximWRe1f33Y20
         CrFuogXenegp65/yAqlHrAlh32n665LHiioFAbtTaAsCBguGbE3QsBRRwo1BrEm4StZ5
         aiz9cG3pflBaHRdJvTStF62hLoiGYBKHzoArqW9Et0gfy1+zaF+iCXRwnNdHN8kc9O5x
         Xy3BZwddfecM91qlJhPRwuWzWuYDN2YsaPZkMEYPjte7VhOkBGsqTCRqt0XuIQSkXnft
         nLxKDT6hiUJ3bB0QgLKfdW1X/uOKnalRR+pEeoIgWTzreKzQvPpkr4MmO6+l0pUA1IhL
         Jlbg==
X-Forwarded-Encrypted: i=1; AFNElJ8UzZZ8jLRd1MTpI1Rb/pwAss2xSzAunw5+28LtW3jXEhvrjWzgTwLc2aof/QOTH6yX3LmHVrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2XfbFACO7/OKkw09VcmFlY82A9MT9NgajOOWMRCWdV+RQidfI
	n8d3YNPnAgzvPF4/xviiwyYlAiwVrsJPse1186QgVfNwhtVUsdSmEcmH
X-Gm-Gg: Acq92OHtAIIbFS+5AowerZxfvPyd1/0JbB5gHpXqswSsntPAKltKXfhSkvMiVznQ9Ut
	OyvTTQzcSFYnc+gomjp27p9CUFwQIQaN8I+uOH03EgXu2S33j0wyYsYnqkiov+pzbH8jSzqiUHv
	y7SCF0YM6rm6H+7zGZH1xzPWOtP8o/y7xpGTeFAiCvuC7fQ/VqS14hi+FBhK8cFT/d2QRyqs9Er
	SXnODutJQqgvnljFtNAmA+LIK7hKWfGQi4e4kInkKD4yDw3mOQ88CmwNa0GVzsrFPSs29DNzeV5
	N7MrS47PAx0VnwnHhcb3/xMAWwhg53I4/7wb0AtF+7yTwoBJMLB1i/SqLj3VFcIw2IMjAtn+OIe
	+rpS545b28u2TKYL9cAuVqZqHlDUcUvGSUOMi5BXC3TL7lwnQ5jWyDGWZx5/Oo+1RuJs8VeBDTy
	iDJIW1LARXXO8VTjMivX1y2fTOL81G9fNfvuQxle8s8RXRG3iIDmwWj4ql31NA8hH/krIzjry2u
	2ex4zrEToGTpRw=
X-Received: by 2002:a05:7300:ac82:b0:2ea:5057:a31d with SMTP id 5a478bee46e88-2f54ad72b1cmr4708213eec.1.1778177125292;
        Thu, 07 May 2026 11:05:25 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f82bd73a64sm44332eec.12.2026.05.07.11.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:05:25 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Rong Zhang <i@rong.moe>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	marshall@shzj.cc,
	hyacinth@shzj.cc,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v11 05/15] platform/x86: lenovo-wmi-other: Fix tunable_attr_01 struct members
Date: Thu,  7 May 2026 18:04:57 +0000
Message-ID: <20260507180507.912966-6-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507180507.912966-1-derekjohn.clark@gmail.com>
References: <20260507180507.912966-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EA0C84ED310
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244620-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[squebb.ca:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rong.moe:email]
X-Rspamd-Action: no action

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


