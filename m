Return-Path: <stable+bounces-254204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPJiHiuwFGrRPQcAu9opvQ
	(envelope-from <stable+bounces-254204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:25:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C51F5CE54B
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C104E301CA67
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 20:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6BC3955E6;
	Mon, 25 May 2026 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc+4PkNi"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32F23947AE
	for <stable@vger.kernel.org>; Mon, 25 May 2026 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740664; cv=none; b=Xl0xvhcbX1FXKXI2NUrbrq712ek/NBa0fzqtia07dMt2uo9NTtn+nL2cm7PQMd8njdxG3hMY/TyexHnfee5cry3rYErRHlElD7P5dGuskC8vJBre+C8gKLVNxSQh9Q7PbmvCC57n9JhAkU061OH0fYhNwMaMvnP/EyRC9NOtHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740664; c=relaxed/simple;
	bh=2z3nyKEVA3fX4RWIlRXG+J+3x5NijVYYAa2uEK6YBRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLLvy8njpkeCPkJvRMvsMPXlSSRPQ+wnlhFI72GDgK9ziI4A6ojLUbmFF3YRizm3RwFmrsWH959RpfPKJUSxfaCwUM1nCclklEvFuoXStAMTnbC6FVVnh/4NqBJ+5logeUECgytyuqq32xzqTY5L0zNHrrF19g+fFPhyyTUIcxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uc+4PkNi; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479ef2b78f3so9092515b6e.2
        for <stable@vger.kernel.org>; Mon, 25 May 2026 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779740662; x=1780345462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r8RhsQYE6qApYlJu+dL8K8TLlcMeAFqJPIZDrl2xNw=;
        b=Uc+4PkNi3v7AjIGdDgRI6KJ29n4N1Ic8z0g3jkNQP6o2Ni+VPhi8C54dYlU1uY0xj9
         H3ApOhpI+AmKNthC2If1Rja6D1/8QAKaD0zbtV06CCBuw0qULrtTO1XU26RJ+n27SPPl
         K8PfTELUsQ5nb7Me0wLY9XJsDeP2NvAB/iHoH4P95NkwfjhPgKjWjsX43qhSXxeatD72
         NnDzQ08Mq2oRc/2KKkJ9hQ+XjTuZhjL+H3BwHA+Zrtj0Yf7mBYG6QG9J3FVgU7ZuUNf0
         McZw4uBmKcK+ZIsJD67hmD8Nc6Qf5nvndYMFRwjMqXkRvh2KSZbv5rp7lAEmZ0DHvvXI
         X5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740662; x=1780345462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7r8RhsQYE6qApYlJu+dL8K8TLlcMeAFqJPIZDrl2xNw=;
        b=KLkFl7IH7/xXYx2poG8eeS/E+5WjTbefEMJXKWx2aCu2YsLF4BbdkekXvc7tGlgGRC
         iURcxAJd/wb5Hu3khdZKhvlSzYae5MgnBKvCm2mm+wz4gas74aGnBdSD4HG2rDeJLWmQ
         IGoT5IAikj5ADlGxAKkoVwV6MTpkLteYdnt3aA6vPpIucSOekQm4bHshPk/zoodywWNQ
         p4GZdplvuT9AMYTqXSr6cB4fDYgMwp0LOHcs+E6ik8/iYI3XWwWl3aBEpA4rILmL1kzC
         lQw/7r67sP6+bdj0ZjK9mfEsbDxS2aIeNzkIXr04P66GPcKCR9Sg97azNCDQBs75pt4I
         9jYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+RkWdqaSEDBj9e82oVejE/+g/2z5uT/REBnYtzzVc9hHSNruRqBGAoEjK9jUiqbK2NILGeKls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCiFtDSA37lYFCR8MJAG+flRE1xyAJnMcMjzu3MwbRCAyGw6t
	kTwfrp9YbjHnwlUbn2YccWpGYEVi3Hd28vc3An6Xc4vMcisGhsl+lP95
X-Gm-Gg: Acq92OGGWEL2PL03Vq/pq5u0PSbSStiJ8nVmOWwqaVnX2wcfKWFWFU4HN+OraQ16vEa
	P+WpidOtv3RFJIsW/eNxdeBJbVRnU7QaaQ/1fW9z6dfEQTowLucNRaWvjj6NHUKyRaXX2VJ6N7B
	AMHgsyv2mGuml8ZeiClOWKgnJJ0w1l6vKIyixgK2rb4f72K0RfmM4t25ndlAh+zWThB6xtPWutq
	7SI4U8polQY6Pb8TUjeNEmNjN9FgF5VK5WftreYWHvgS19GauW2mnTGw5eJtwjgteWFpu3qsWd2
	nTUn8PsAMnOOPlm3ke8uHppC8cbPm7YejPHpiOw4wL7d3sWev/5uZCVV9ryYLJ0fvwHbOHkdfMA
	5+ppLarCiEsWuH6/msXNUroU18RFWeNtUJ0uNqkoSpkcp5DlHSpcDbHoxn7Luqj5yQWI3IR3oZb
	lUpykmlz71shsjC0+WOVgNlDdXTwnYdSrU4XGGBBPnE8UnlGXNtjrQd8dftIQWAbY4tsjBBtLHw
	6nYgpk15kAYjaK0wQU4AQcOSag6E0Y74umJrBje9Ixh2pQ=
X-Received: by 2002:a05:6808:3086:b0:479:db65:8dbc with SMTP id 5614622812f47-4854a24dcdfmr9401296b6e.30.1779740662009;
        Mon, 25 May 2026 13:24:22 -0700 (PDT)
Received: from DESKTOP-J47FREO.mynetworksettings.com (171.sub-75-196-24.myvzw.com. [75.196.24.171])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48554757d5dsm5204305b6e.15.2026.05.25.13.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:24:21 -0700 (PDT)
From: Adrian Korwel <adriank20047@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	heikki.krogerus@linux.intel.com,
	Adrian Korwel <adriank20047@gmail.com>
Subject: [PATCH 4/4] usb: gadget: f_uac1_legacy: cancel work in f_audio_disable()
Date: Mon, 25 May 2026 15:24:13 -0500
Message-ID: <20260525202414.602-7-adriank20047@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525202414.602-1-adriank20047@gmail.com>
References: <2026052517-undergrad-reformat-44bc@gregkh>
 <20260525202414.602-1-adriank20047@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,linux.intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-254204-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1C51F5CE54B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

f_audio_disable() was an empty stub that simply returned without
cancelling the pending playback work item. The work function
f_audio_playback_work() accesses audio->lock, audio->play_queue and
audio->card which reside in the audio struct that is freed by
f_audio_free() after disable returns.

Fix by adding cancel_work_sync() to ensure the playback work item is
not in flight when the audio struct is freed.

Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1 implementation legacy")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/gadget/function/f_uac1_legacy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 6ad4b16769b7..798fbb8550bc 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -697,7 +697,9 @@ static int f_audio_get_alt(struct usb_function *f, unsigned intf)
 
 static void f_audio_disable(struct usb_function *f)
 {
-	return;
+	struct f_audio *audio = func_to_audio(f);
+
+	cancel_work_sync(&audio->playback_work);
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.43.0


