Return-Path: <stable+bounces-214535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Lw5BQrXhGlo5gMAu9opvQ
	(envelope-from <stable+bounces-214535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:44:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB80F61B4
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 184C73004F30
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB172FD698;
	Thu,  5 Feb 2026 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzbhP5Iz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC982FA0C6
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313477; cv=none; b=ctm85qcjZMBgtfHlfCIH5OhsWjfHkzEjcXt6qmUScT7UwJfBhOfdnYYxlYnD4HO5yio1Z7WWA4vbO1uVx4Kp/8WtasgLVbgjgcOmEZRwHi0UHTVeKNVh6Sce6yo5DtLUWX97ma9RuTYplEeLndc0gs968KDqDiHikN5PB4FUCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313477; c=relaxed/simple;
	bh=o0rJ/k5zbcMcfwxnVLNQ13kQ9L6527ZRZ0Mbmz8faLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5ks3B4AwBDNWhcRz50RyTg5/rR/v9mvUHGCrpWRC8tUtfbo/o7NDm91NBzuo2GrrA7hK8g0kwrtZA/5vxLoefPcLMJ1JVcCDzl9qWmGN/zkAftBbhA0TiHjwAEfQSTeLOjfYoD5wqpP3slsPgT0Jt1qqHQupxJGvGHXtbLQ/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzbhP5Iz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so505760a12.0
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 09:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770313476; x=1770918276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc0E72oPfM3CH+sOdZznPkkUshYA7l2qkcY6ZqG7/gY=;
        b=kzbhP5IzpXwVVuffRJgA605sEZIj5PdmG+MdfdriZW+7pD7Q4jxzb5KYuE9g4eR2+C
         sC9rYsHWwS/vrkJWv++ka14VGAT4rMX/BFFEZxvqNc8QosRLBKqb3KL7oXg/fikD0oMA
         mWsmadwkC25PbXS3OiW+uNR8gCmlanqAqvkjWMf6wI+wCPhu2cojKKtRh7DXLSDrYVYg
         xfXn7cZtRe6xLsRjYWYA1+itk8DRq3yCeGSdlP8sEKFV5rlCPNNZ2THI8SSrkLdNhpaY
         V/kejQAx5T+1kSJ55bwSVTwesCBU052W0PyF+jUfEYYruF7VJYdAaM9/AdORZqQJZ7es
         gZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770313476; x=1770918276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc0E72oPfM3CH+sOdZznPkkUshYA7l2qkcY6ZqG7/gY=;
        b=sM7hNvRuygwvvlw7XXnwyShODQtOsfKzol0GZbM7aziQ/DpleniAslzZivQfEwpySp
         Xhi4jGAflRECZERHP/FhmRAF9dOL6hjbwdoT1ODfd50fz2naDzLOlDINnZXeS1vr0Qnq
         v1Ixgtabm+mYAi7d5blP/YfnF9WkxrbPBtAx8j+I8AAkWEwtNnMZ/OOhYd7bnYRd3myX
         dDLWHbzGVA4Nf/aGiufgqHhUdcXIcPel6ThLZiFknI/GN9g3K0O+w7gyUBimJ6yPkkf6
         8ScKHWx84DtIGLrktOEM5vbSn8mWTgEWqgeSTSbS+nDlEL+UlLGlkPbkOriQkIQLpaWp
         ANLg==
X-Forwarded-Encrypted: i=1; AJvYcCUt/8ay8ADC+idIzv2gGBzGQZQpn1/lvz0K06AIE9R8MDzZsqSi02AEAJUzjmbETcY4dA53Vo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3pYSAqPDefWvERSpiKKnHHF6lUo37sKOnmQ8MS0bUGHkhC2TN
	ShzMB6f0XnZjtO9sOxnC/VnrUtJIcJ31AMGNdFucKQWzL56JWaHndKqa
X-Gm-Gg: AZuq6aJ3eTqqCrRN4E+L1UdUjyvIXILPGOyhDIw2bqK5kSKsSXuWIdJ089VvPVLrG0+
	h7eFqO56E+PuxmzD/4AGmEBo/uKWIA6FEN3i8HTlFMyMfuFVW4h4FAK+wyMlthwjIDmeY2OeqBp
	QjR49LeefkN6rJB8ucCnhmng34VTGRAP9ylwyuBUg4SC+HTJebgusotMv+rHWBO2XfD9qqG1AJd
	7cLngvVU3sd8+uFOGNsYr37VaLZHwyat+d+W9bqWISwli9D6q3SqD2OZDjEOFOFUyzcYGRNn2O0
	FDnoiB1yQJvOaEuXextWkQWQy0bhyVuI4UoJseJjINuws8oThDnQ7IvjMnDzWgfyWCvWo/QQFtr
	6IxHUcGCSXEWyWJg1GmatNXn9dKZzafmINy2Z01G1+pgwkzDgGv1GuTST92J0k73EPq8vel5div
	B4LhxGTzc3St7H
X-Received: by 2002:a17:902:e5cd:b0:2a9:47d0:12cd with SMTP id d9443c01a7336-2a95164b71emr741655ad.15.1770313476297;
        Thu, 05 Feb 2026 09:44:36 -0800 (PST)
Received: from mint.. ([2401:4900:53f5:8722:5847:8ba8:5649:5c92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93397e9cesm54372875ad.97.2026.02.05.09.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:44:35 -0800 (PST)
From: Dhyan K Prajapati <dhyan19022009@gmail.com>
X-Google-Original-From: Dhyan K Prajapati <dhyaan19022009@gmail.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	dhyaan19022009-hue <dhyaan19022009@gmail.com>
Subject: [PATCH v4 wireless] mac80211: fix NULL pointer dereference in monitor
 mode Crash trace:   RIP: iwlagn_bss_info_changed+0x19d/0x640 [iwldvm]   Code:
 49 8b 46 10 <8b> 10   RAX: 0000000000000000 (NULL link->conf->bss) wifi:
 mac80211: fix NULL pointer deref regression in link notify Commit
 c57e5b974514 ("wifi: mac80211: fix WARN_ON for monitor mode on some devices")
 reorganized link change notifications. This caused a regression for hardware
 using IEEE80211_HW_WANT_MONITOR_VIF. In monitor mode, link->conf->bss is
 uninitialized, but current logic allows these notifications to reach driver
 callbacks, causing a deterministic NULL dereference in drivers like iwldvm.
 Fix this by validating the BSS context before driver notification. Device:
 Intel Centrino Advanced-n 6205 Fixes: c57e5b974514 ("wifi: mac80211: fix
 WARN_ON for monitor mode on some devices") Cc: stable@vger.kernel.org Cc:
 netdev@vger.kernel.org Cc: linux-wireless@vger.kernel.org Cc: Johannes Berg
 <johannes@sipsolutions.net> Signed-off-by: Dhyan K Prajapati <dhyaan19022009@gmail.com>
Date: Thu,  5 Feb 2026 23:14:19 +0530
Message-ID: <20260205174419.4467-1-dhyaan19022009@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	LONG_SUBJ(3.00)[1052];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214535-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhyan19022009@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABB80F61B4
X-Rspamd-Action: no action

From: dhyaan19022009-hue <dhyaan19022009@gmail.com>

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


