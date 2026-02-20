Return-Path: <stable+bounces-217554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOsNKToxmGkzCQMAu9opvQ
	(envelope-from <stable+bounces-217554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:02:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 450E916699D
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8B1530090AF
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 10:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CB73164D4;
	Fri, 20 Feb 2026 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrG/VvCO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3093115A2
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581751; cv=none; b=ZcMhYG0ubER92nxMaa/pXjnT4y9N1N2snwIAhlJoYRLa/GwFIqhCHUsuszfhUFo3DlIhZAyn72bYKR2JGcA96Hqc081lJzRlECOErhZVpAg6CujLRS6aRYI5r7UuLZgvExZvV23SCQ8PlSelNel7Byn6cH+wVtsTMwGMdD42YHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581751; c=relaxed/simple;
	bh=6eGWr3H780PQ4tTMZavzMacgOr0bw9BFvOMyrG343WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bskq1z5p1TtCNDEG/U4MLUp1nWRKwbdqAzLShutkX3vmgRxaZpXbkDAAqIMDbsrQIiaRblLiBwVB8XQf4m04pFIpymQL582C5LHOlNT+eb9yUkj5T630lYcTAsD4GslTIk/q7ComSy/x09Y4iwsB32k9lnRo4KcD4As+l63YTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrG/VvCO; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94a231b285dso985596241.1
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 02:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771581749; x=1772186549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuB9Y2YaYrSJOMH0MnZVGF4L2Pbe5s6knowQ2Ay53LQ=;
        b=jrG/VvCOig0cprj4431o0rqbmLXZ1kJ4H80q39OjdLT0NPsfo53AEDzybXr8Y/aSE4
         B0WqkhGdfZO2v7WV4m9HpAvX847XYxaB9oB98Ce2ti/TA2C4GhZ98X8qj6FhbUjl8UZT
         MSFyk3g3WXrV2sv9zPFxkLjFk8VK3FRhMrShzbTkn4K7cGV7zBirUl74lbIJvCIsFEdL
         DkzdpMFcoSGzjxSG6MELv7wAzdPVaQOLhkEt7ew4+wSJL7rVzODghkg63FXuqRvWXFwS
         Dvj9r8PLV1WZrfh9kCzE5GGWJgNdwBVH7GgDEQqoGcoR2Hb4LxA8aFHsAUGeO9OxUIiO
         czsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771581749; x=1772186549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zuB9Y2YaYrSJOMH0MnZVGF4L2Pbe5s6knowQ2Ay53LQ=;
        b=GTnBW1Klhf0bTJG0RXQxkl1ri3NTWowpX0od9NxQNpqM4x6pJhDyxdO3Juz+jvyVkC
         MO1AJj0YrtoyUuhRb/Q1LS9/QgLc3vi81WFSWlJcLbar0EFFX+OYvNMbSN6ARHrryr0x
         LlXoWR3YfyGqB7LTIyeOpR0M13FjNF9q/Sni4d6conU3ofIfUspuy2N1y3c5pj48LaE9
         B/MxbGfkqDZvlePFcC8AgOdQAS+ItoxwfdHvwYO1M6ykn9cihgPKofRPVBF5u7uyOXzu
         nALdjUZPbTVMo5XksKwXshUI1l0Qbm/9ZRtMy8W6WFLkmOg3puN6RBTGHO1M30IVJh5b
         pG7g==
X-Forwarded-Encrypted: i=1; AJvYcCWA3+Byc+dbREA16Zxrj5pzYer/GcBlo8d5YT6+cw1P54amdFK0RK0fWxXrSz1hM+AUhIMIy9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAk54rr0rjiln7Ikzii0lBk9JF7ZpPzkCx6bWCdcbF70GTzDpU
	uDl+ycNUgH/Cwctu9zJyTyxybHfMm19Q+nxMo3QlMKh6Et5H4Pni064o
X-Gm-Gg: AZuq6aLIF+V0zU57oYfsHPP7xDaV8LTNkHzzp6osfgje9oRH0eZ7SLJ3ur2Ue08KsQ8
	yNDmlz1QL3zlnRuO7Su6oRr/rL0K6DtcLS0cnYYk2Bzqb0eHq+3zQneM948Im0C2HYS/TYjLU8J
	3BDYRL95+h+u2Swc3dfbwRPDbs7lRE/J54p7waykczTyHSh7toARIgLXiCL+MWUdHFnaNQMTaJH
	b0w8eeGhEYbbFXokPcoU9kIn2QcC62H4qr9dw/pI2p+Kp+NbEWqDJFnT0vMySGqkwwr8vkHHyj7
	PzdCeUTvuTRIfLVjV1lwxPuH0+NT2O3RRndb9IdygGipR0WJV8YW2KTo21Q/SBd1jjSakJ1o1eU
	NjX3HAWLh4ss3gk8hnsAhhZd7v6LRrC1K4g8Se1S6l3+4rWhrDCOkNiDmKte2DFCwyEPJmz3a7f
	BGBTYyFS02FVB/DLtmWbz8/LIuCXxRnFpSsfZHXRwgQnt7yz2dLO9qm7mvM2ZGoh1ONo82qJ+DQ
	5W3eOKTvRw=
X-Received: by 2002:a05:6102:1627:b0:5f8:e4c1:7bd2 with SMTP id ada2fe7eead31-5fe7fc59367mr4742996137.16.1771581749104;
        Fri, 20 Feb 2026 02:02:29 -0800 (PST)
Received: from vm-ubuntu-ariels.. (250.54.231.35.bc.googleusercontent.com. [35.231.54.250])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5fde87fc73esm15826809137.1.2026.02.20.02.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 02:02:28 -0800 (PST)
From: cr-ArielSilver <arielsilver77@gmail.com>
X-Google-Original-From: cr-ArielSilver <Ariel.Silver@cybereason.com>
To: arielsilver88@gmail.com
Cc: monte.silver@gmail.com,
	Ariel Silver <arielsilver77@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: bounds-check link_id in ieee80211_ml_reconfiguration
Date: Fri, 20 Feb 2026 10:02:21 +0000
Message-ID: <20260220100221.1200241-1-Ariel.Silver@cybereason.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABTQugqJwFHMY0QjvQsvugc=J292M3MB29VMZ7iv12dSchp1ew@mail.gmail.com>
References: <CABTQugqJwFHMY0QjvQsvugc=J292M3MB29VMZ7iv12dSchp1ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217554-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arielsilver77@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 450E916699D
X-Rspamd-Action: no action

From: Ariel Silver <arielsilver77@gmail.com>

link_id is taken from the ML Reconfiguration element (control & 0x000f),
so it can be 0..15. link_removal_timeout[] has IEEE80211_MLD_MAX_NUM_LINKS
(15) elements, so index 15 is out-of-bounds. Skip subelements with
link_id >= IEEE80211_MLD_MAX_NUM_LINKS to avoid a stack out-of-bounds
write.

Fixes: 8eb8dd2ffbbb ("wifi: mac80211: Support link removal using Reconfiguration ML element")
Reported-by: Ariel Silver <arielsilver77@gmail.com>
Signed-off-by: Ariel Silver <arielsilver77@gmail.com>
Cc: stable@vger.kernel.org
---
 net/mac80211/mlme.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7073,6 +7073,10 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 		control = le16_to_cpu(prof->control);
 		link_id = control & IEEE80211_MLE_STA_RECONF_CONTROL_LINK_ID;
 
+		if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+			continue;
+
 		removed_links |= BIT(link_id);
 
 		/* the MAC address should not be included, but handle it */

