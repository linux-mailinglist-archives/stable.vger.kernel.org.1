Return-Path: <stable+bounces-233438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK//LCYU1GksqwcAu9opvQ
	(envelope-from <stable+bounces-233438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 22:14:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5443A6EB7
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 22:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C678C301EC62
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA03E39C635;
	Mon,  6 Apr 2026 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYqpV1Z0"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C739C63C
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506447; cv=none; b=J9okWQL2qJ6iiYK8X2tuXvU/jWHGo4z+FzASmgf7fI72pQNPfZtW0Lz5uWR32VHE4OXpKvuGoHHnTHIUfX3Ma2lIe/3nw+0mVGbd/C8i5w9QmFxBuecoNw2LtC089JkOExzbGE/tOWfIIGsI7OAPPAfM18YucrgQ/RBr8dH42dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506447; c=relaxed/simple;
	bh=A5nBMBkWkafHNY7USWwQbGA1Gg3Rjn8l3CkT7z4RWhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPVwICMvL6rNmftqVURSN/mk1ISTvOXapHqsv4mU9HB+iE+r5jsXbD0SBewpXdjC1lxkMes/kr0Z9tycujOPnx+MJV0Nyn8fQTMzYbqIJUj3Y29lv9inx7Yacxmramn4fA3P8D/0C1K7FYWAU9PnctV4p3pJs6T2dkJlSM0l55U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYqpV1Z0; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12776bebe9fso9870793c88.1
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 13:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775506445; x=1776111245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2sfsoM3eXXD/i3TYQHRzXUhUiniPGPfrTop9I4lCjo=;
        b=NYqpV1Z0VZog+MsPIJfogi+iN5OKCVUNF08wCZjx3SuwuKNIfPPI4CJjj87jt1yMY1
         RIUXB6gg+2y8/MMVxHZgegsWDN4y2i0kpzGABhzTWwzltiUIOOyNCZav3dwizLpQNTPh
         wzL5U2NstNyM7UHZNp4I8K1k/02RNq+SJY2unl/louZrW8RpHSRyY6dtU5YvUWqIpZeF
         LEPCRuUbYduWe7fvWViPdg6FoKNwSA6OGiMf7s6E5JPs0GnzRWeiwmeUCrFMPysLnrly
         lrgunZVPn4CXszLNqvKoH/L8Wwze7f6oRpEwMbFfgnQk+glcqhwqPoLgN8K+kWgcVxSb
         wgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775506445; x=1776111245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2sfsoM3eXXD/i3TYQHRzXUhUiniPGPfrTop9I4lCjo=;
        b=cKTWluT1j1pN+5QxsB0QqvQZo/9YUXb4MAO5uX29Y2PVosZoS4Cm+e0/W91btsvZZp
         61sturDbXsD8v3rfd379rjBj9vxCnzqdXD/kRQzUmQrtWHDSZyKvfeyuYwOa23Xjf30t
         4n11jvBSigcA6tJSv90LNY71ADsFr4LmRyYqgkk/bXp3YH/mXhalMLI+jhi/ljP4XtjT
         Q0ZnFPiUQJbGOgGhpwzpEKHqWuu/WGJEu9mZE4jaxfYkmpXtgAPvT6Cw+XEek6zl89fl
         WzKJTr50YUXS7TXoRR4gBAmk440moYZ/DDy3cfkMSdyBnq22tP9VE/3XfFUhQ0/IELAp
         kUEw==
X-Forwarded-Encrypted: i=1; AJvYcCX2hjnxo3ATXFFx7xDGX3ErLgjqoWf6LLZZHiBAjR0/YVxl4uSvjMibMC0Lmnx9qVqDfTx3bXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxmcXqlsBXtEIGBcc61iL311NFPopVqjPPM3XPNxN+TO/OdUCv
	TbRELmOFyphAJUzKnEwg2qQ2wLILjrZriH1IsqUdq/GLLZXn/IgVkBrw
X-Gm-Gg: AeBDievdli20ATE48TW4BDWhh75iOORIDVY1NQPCz5LwpgOlLvEizEErqZN/K0U6a2C
	s3N2YKgih+0zkgiK4o3/voJhPwP8MabEcnsWUttPqTGVBBgTO3kkeVeKhcDna7UnkC5mKtt9Rkq
	bBxmzE6sEnvirGtkNTnR3AR9ADgTqwQqogJYJZhWWGuREoIFb4kSAzfDmT+E1W47wA7YuZSg0lv
	j7k/gG+0XpSczlkP+gGNYNkqfpY4eaTjNEzkLTuQE8h+JKzJfoZfCnQF4VmlmYaPeWTAF37Copk
	yEmwmduCH/BuGzIqP4UEAWqIqs4+bltdVO3FijsegFqtwd5rNINKGWScMnAIjq8GpnqqplXr0HW
	Up+w7k0DGbOT4a5UI9AAsSTSw8KNm8addcRhXSxdszOq9VUH79eM3B0V33/JzWB+FxRlToTWcZl
	wHdMRyfZZJhchqasyt4JdKWxtXTCw964kNP1QgAnLeMszWW4CmQVXnbVWLRgyPOryiMSHuK/yvw
	8jH
X-Received: by 2002:a05:7022:1603:b0:12b:ec96:c936 with SMTP id a92af1059eb24-12bfb70bfe6mr6740371c88.14.1775506444895;
        Mon, 06 Apr 2026 13:14:04 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm17022333c88.0.2026.04.06.13.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:14:04 -0700 (PDT)
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
Subject: [PATCH v8 03/16] platform/x86: lenovo-wmi-other: Balance component bind and unbind
Date: Mon,  6 Apr 2026 20:13:47 +0000
Message-ID: <20260406201400.438221-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406201400.438221-1-derekjohn.clark@gmail.com>
References: <20260406201400.438221-1-derekjohn.clark@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233438-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.985];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,rong.moe:email]
X-Rspamd-Queue-Id: 6A5443A6EB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rong Zhang <i@rong.moe>

When lwmi_om_master_bind() fails, the master device's components are
left bound, with the aggregate device destroyed due to the failure
(found by sashiko.dev [1]).

Balance calls to component_bind_all() and component_unbind_all() when an
error is propagated to the component framework.

No functional change intended.

Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/lenovo/wmi-other.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index b47418df099f..4b47b5886e33 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -1068,8 +1068,11 @@ static int lwmi_om_master_bind(struct device *dev)
 
 	priv->cd00_list = binder.cd00_list;
 	priv->cd01_list = binder.cd01_list;
-	if (!priv->cd00_list || !priv->cd01_list)
+	if (!priv->cd00_list || !priv->cd01_list) {
+		component_unbind_all(dev, NULL);
+
 		return -ENODEV;
+	}
 
 	lwmi_om_fan_info_collect_cd00(priv);
 
-- 
2.53.0


