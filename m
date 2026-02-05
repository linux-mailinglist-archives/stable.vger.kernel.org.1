Return-Path: <stable+bounces-214528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAY/AxbShGk45QMAu9opvQ
	(envelope-from <stable+bounces-214528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:23:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75840F5DC4
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62238301C959
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 17:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336BE43D4E8;
	Thu,  5 Feb 2026 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZW++YAA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97D43CEE9
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312211; cv=none; b=GLeEiOe8ytKLVsBvQYijuU+8yoI6GVZ/MiA5Mj5RXZ4kCx3fIf1ebdVmT+ONqbfB5wWLl6SEjWWQpHNA3oqxSNvpT2gfokta6vz79oPttmhSBvZnPbxyx52lNAZlugi7CSNdcV1ZpiEt/eppxbYmhcgg38bERhOoSOv1dzvhhmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312211; c=relaxed/simple;
	bh=IIn3uaeCxcPp/5+0kpXP9/e64YESCdwAQ/3PXIdDHVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HviSAwhZKW7bZc5dAZrBerv1q4DyZwaysBJp1sYPSLGTmYCFUWol3ob9fF/bsAgXGrwFpoZpFLQ96VJTKoIE7tlqPomt8wtY0eHfJW+cYgGWGo9NK7oPwIDCz0sFGwAIHERX4OukOk/BEGxlBl9diYUAHBUUZsGFr4zf4L4NhVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZW++YAA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82318702afbso1022375b3a.1
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 09:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770312210; x=1770917010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yuBsGZrwpORrmTJvhOPX4f7OMrH7yvsvWogFITeQFU=;
        b=KZW++YAAXx6E539ie9dkvNUAl3uHnAxxJNsEpUkKn2hxl8hBGdGxnEel7lwl2cTk6J
         oBlC/zfpKHRVll7cOr4RGDCF1lRfI92zfSt6Ytyx53qutste+NIDltqzbDPTcNRRDTeR
         OdNfRIHrvwocg9qzjhgiRsBaj/S1l96Yhpeu6s8m4P3+IiCQh+R2fLwNb0ivdm2metS/
         IPGP8OBiboGZHTtvaPUq+BzXf0UrHKMa+/P0u2KzGaGyMpqgSIM2osmsf2Ui7tMcQOsK
         jwS2fbCmPZ7qkQjJM7i/aDaY8XTOMI6m2UREIfcSYJjr/ngLv62z6Qva9VMRK087qgS1
         Gbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770312210; x=1770917010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yuBsGZrwpORrmTJvhOPX4f7OMrH7yvsvWogFITeQFU=;
        b=O75oRWJtfmQJfi+5r6O6ChLAWKNC5VtHAQwmuB1+eMtgUAdef/jB+XBl6cKjEMJt/I
         f6Qd5DBHcha39xyaCxcl4IYGTnE/8ChtjWf6uRW490XM5ohikDiVw4QSlrgtKR4hFwhe
         vPVyxQyzPUjC7qi7zKNA18gYgis0DuGMtNf+N9crO3WBv73cYzjIX3GNEJKgWl5KhKKe
         PeNH4mbPtrDruWurUBnU16JqmjSXq0Mrz+fjVzJcEJstUFJhoWw43DU9htC8TYdfpIms
         1aEjn7tCqrqqmV28KTB/KhSbSVW7lkwGs44kKWgFYP+kkS+LZ206D1BI4ZRPZvgOR5el
         qcjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQjGLo4iEKl0ACBn3LktTVG8aIQbRQgOglIun0/gya4BNYVM2YTa6E/eTxEQxAGJ81UUEyYcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSySpR+nTH+UbzD3Vrh4xEkUsAm4hwFr4nkLmYklGTiVheiZhE
	Es+J4bwBPKOafpfxnUcqX/saJO/jMSPJdF9niYj+jtUlKd4lFz3/Wtvm
X-Gm-Gg: AZuq6aLeXvtuCZmATZUVV2fs2sy3LafairdnMcsXlJQEHp23h6Jy5nqWMk0nH+/qtZC
	RyQ9L53o1avnYmiwC5ieDGLxVsFnc8gIouMsusYSQptYorHf+xvP2SKtKAKI0ubEglXpWL+hT2k
	eoJSIle/omBV4r7uJSBo+zu6K2m1wU6Jpnt23j/ecuZn7SANiEDpTByHRSH5/xIAatdhJJlhwfI
	ck53VxFBPBeHKNXjVutLEy+w1bC8fDXZUVIjXGlcC2YvVMJ30yAfC6tcYwRMi0/O77Tv3WPtJjk
	VYPQB0++qdXNNCaZGRAUL6jgzq7bFwA8NMglkrkX5RMdy71DrJzSJg4Ql7woH/yjOXzn1R0PEGY
	0NQhJG/n/8OXVwavHFwwHzfwCL6k6ByHnlrPJcvLGHocTS+tS6jRwvZFDiDhN+B+FsZgn54Hclk
	czXEgt+rDUaKO4U1Jrs+aqvA==
X-Received: by 2002:a05:6a21:a8d:b0:38e:9cc5:217e with SMTP id adf61e73a8af0-393ad005985mr117777637.32.1770312210076;
        Thu, 05 Feb 2026 09:23:30 -0800 (PST)
Received: from mint.. ([106.205.245.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5e5f98sm29117a12.17.2026.02.05.09.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:23:29 -0800 (PST)
From: Dhyan K Prajapati <dhyan19022009@gmail.com>
X-Google-Original-From: Dhyan K Prajapati <dhyaan19022009@gmail.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	dhyaan19022009-hue <dhyaan19022009@gmail.com>
Subject: [PATCH v3 wireless] mac80211: fix NULL pointer dereference in monitor mode
Date: Thu,  5 Feb 2026 22:53:12 +0530
Message-ID: <20260205172313.16652-1-dhyaan19022009@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214528-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhyan19022009@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75840F5DC4
X-Rspamd-Action: no action

From: dhyaan19022009-hue <dhyaan19022009@gmail.com>

Signed-off-by: dhyaan19022009-hue <dhyaan19022009@gmail.com>
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


