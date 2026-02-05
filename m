Return-Path: <stable+bounces-214540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAixM/bYhGlo5gMAu9opvQ
	(envelope-from <stable+bounces-214540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:52:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB26F6375
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A93F23003722
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB57F3016E0;
	Thu,  5 Feb 2026 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD/ao6iz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CECC19E968
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313949; cv=none; b=WdwncmaD7mQmwKsFsYZCItT2YOq0Fl5csD7tFa/4/nfxqkjM+qPohW7va6qHd4VhE54I1b+wcnyamVs0iCFnvnHlE/yvtPWgUzlTV1cyqKLbTbEG6XEqT5AB5uXcVp+6O4nfHGPmxM/bXSZc+bjSzbsA7vEUc7dSPZfKywlSaA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313949; c=relaxed/simple;
	bh=vxYkDrFAaTZJWu3rKXPogOp6rpdMDeIlZCzD1sWmeUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFAE0GhcMWjhuWYmNAE3blJNHe+JZgwEOu9r13tTjdTQj2BTmBBWv7pdLyplBi7P8X49yKQilcBV0MWT9Mcv/PcHtiyzMWlimcWqeyQJK8dCB9cstCQ2qARThrA5T7YIfoBbRjbVR4Cp7pD/aReRTDqaUHj+ksRilRLvNXKWIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD/ao6iz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so701618a12.0
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 09:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770313949; x=1770918749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=207A8puoH0ftYtzBLpugjXhMAo56KEvTEcSjW91zf/4=;
        b=LD/ao6izV3NXLFgJxVrWNjeG+u0nciLAq56jiu5cMnIAEO+3LYEDEeqXJU0c3c9vAL
         X9s/AD0UAMFSC+xd23vwJfkfeg0julH+jFgX5BPKLKWSc26yV6Cd0HGLLujf45bm6ypK
         gFMksGL3u4+aGq7BoVFTgGabrgtlLGz1QUI9sRnnlkVsM9o/BKoyfaHr5Z/fKujUy/KD
         GgOGb2n9OJycE5+x9QPm4HfO0Ttz4U5lsFhJAa1ojFgewZ6vJtY4CI/nn/S61WaZqcpo
         UEH5jWhr/WXfokf+fOtd4aGWVZwiW6hTh6cvLimVrRtN/2tadOUhLsh4duckIvu/p4Z6
         Z+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770313949; x=1770918749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=207A8puoH0ftYtzBLpugjXhMAo56KEvTEcSjW91zf/4=;
        b=CWEdGIPRpUxLa0aCAz5N7TN1ZGLn2LseV6mYdy3QAk0hkogUL8nAM/B6GQjCGOtW3G
         A5fhu6YGjRQE/pxTPwPpReMI8TYo9ymfwXXKuwxEPuKYzVttk4nq2cpNuUGuXfBbNMra
         8jenCu4Flex9eEa3BonMT5/rMwV4LxdsIhHyweNr7gmzhxOI/RsTuhvdmHasAgiOMM2s
         1RPlY641q8D/2kt9e/LPkZoNf4/kGE7M2L+86MWriNiiY3psrgVvejor1+oOXfjE0pt3
         9hV6eGpdJTY/mOzGqEDfCw+CVPhmk3zPH61CWpdNEnKNSen6Ouq0D5YbHKy41sMaC++6
         K0FA==
X-Forwarded-Encrypted: i=1; AJvYcCUl7hBuV/2l2/uKvubsUlOA/4hFlfr/td98v4KtR0O91KRJS1y/NwWmdrI8kGEeSGdh6XtXbaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhyfoZcIrJX0/3l2h4rLhnI074kdh2p0cmhxWbhMRN+MBv1Z4J
	C/n6E/KvArYVyaI6YvnnGCBUVNbCTVrrGG0OfRppudfGB6nZ6gmsvdT/
X-Gm-Gg: AZuq6aJIQ3M215SGPzIxgqtiDDykxh0Jcf3k8YIgbyGSHo2HUwH6Y89WgEKLU4o2Vif
	Q1Mw7qpo9VBlN3pTnm7OO74rxdETJzLvD305CIyI51HUwV8aPUbDXUvs9V41DW0o0NuygTB2H56
	JuLSzRIBWKtNTZAgz1IXKBkW2PFbBXGrRv2DzqtRvURMUuq1QWHgrnqfRpqZ+WzUuoZJ95JyjKe
	7DcPq0TZU2EmWJvm3djVxMvAWWMbL7FTo3nwDlHqi7QgjLfwhx1Wus/tkv0osbu1wP9ULRSnH/5
	J9ufHUUx9WX4KTtFm6xzthh4g7Gny8XjJWZUtxWsuHROohU8aR614uiimpm3uESnSGKaArc8Kkp
	uaic91dACl9le8IxocH0YZPs6MzDia9jjlmRg9GuEtIJvlQYMg8IF4ghXJSNeE3HMsdphE3TAHC
	GgQsM9s6DQ/EBf
X-Received: by 2002:a17:902:da8c:b0:2a9:db7:4467 with SMTP id d9443c01a7336-2a951643444mr862845ad.6.1770313948803;
        Thu, 05 Feb 2026 09:52:28 -0800 (PST)
Received: from mint.. ([2401:4900:53f5:8722:5847:8ba8:5649:5c92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a6443csm136005ad.16.2026.02.05.09.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:52:28 -0800 (PST)
From: Dhyan K Prajapati <dhyan19022009@gmail.com>
X-Google-Original-From: Dhyan K Prajapati <dhyaan19022009@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Dhyan K Prajapati <dhyaan19022009@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v6 wireless] mac80211: fix NULL pointer dereference in monitor mode
Date: Thu,  5 Feb 2026 23:22:13 +0530
Message-ID: <20260205175213.5005-1-dhyaan19022009@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,sipsolutions.net];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214540-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhyan19022009@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:email]
X-Rspamd-Queue-Id: 2BB26F6375
X-Rspamd-Action: no action

Crash trace:
  RIP: iwlagn_bss_info_changed+0x19d/0x640 [iwldvm]
  Code: 49 8b 46 10 <8b> 10
  RAX: 0000000000000000 (NULL link->conf->bss)
wifi: mac80211: fix NULL pointer deref regression in link notify
Commit c57e5b974514 ("wifi: mac80211: fix WARN_ON for monitor mode on
some devices") reorganized link change notifications. This caused a
regression for hardware using IEEE80211_HW_WANT_MONITOR_VIF. In monitor
mode, link->conf->bss is uninitialized, but current logic allows these
notifications to reach driver callbacks, causing a deterministic NULL
dereference in drivers like iwldvm. Fix this by validating the BSS
context before driver notification.
Device: Intel Centrino Advanced-n 6205
Fixes: c57e5b974514 ("wifi: mac80211: fix WARN_ON for monitor mode on some devices")
Cc: stable@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Dhyan K Prajapati <dhyaan19022009@gmail.com>
---
 net/mac80211/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b05e313c7..190222c26 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -416,6 +416,8 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_MONITOR:
 		if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
 			return;
+		if (!link->conf->bss)
+			return;
 		break;
 	default:
 		break;
-- 
2.43.0


