Return-Path: <stable+bounces-86893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA819A4B52
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 07:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCBF1C2186E
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 05:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634061D3588;
	Sat, 19 Oct 2024 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="Cb1qTBbq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B81EA73
	for <stable@vger.kernel.org>; Sat, 19 Oct 2024 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729316221; cv=none; b=bBQsl/ttVhI8pIaQ8PUPUX+6F7BE2FEi9RcRNsysDjmoBU425PqnDNsHAf5+dg4DuGq5c4NtIZANWGsKKLKJeulAqS6RiCu9E9oJA36SEatxuIM+pL9nFXm22U97M04Tmhaowzg/wYSWa6YwEqTYin+DIOvBsM8LRrHGCEWxzpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729316221; c=relaxed/simple;
	bh=S1PxwZrn7qHGDRfhZS3BcE39HVJJf/8ayElZRXlYghc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XlulTAN82Jwpk5QqD8ewXEyksKnswZ/ACUAOgzrNTitYAJSPOJcMtMMz1dMKotkPJC5BDPLmHYLJ4VSJMzfiarmoMpcDMRsS+z9vi4SqrtCNA7xt0SaQSMTc/6v6cbTJv38Af+pSQ6DN3FnqoUmrSYsGFL7yjYsNaAUSoEHE/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=Cb1qTBbq; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7c1324be8easo2880248a12.1
        for <stable@vger.kernel.org>; Fri, 18 Oct 2024 22:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1729316218; x=1729921018; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvyeG0sMGLIPDJGO5fTlUoNdyS3Nb/+jzs6l/Ql3K1U=;
        b=Cb1qTBbqH/+9XOpmMgLL02WuOQo9Bm9/9ITcBRDoE1LD/5twSfVO1r4M/ei8MD0cpS
         6YSlndXLXysp0nDVKkEIsm/ygIA142wniM2286hLQv82YWBIpIsDPcNhftWO19f7BEaG
         sp1+8/6yw9HMjcW5hUlpowOcOK7PNQFzkv5zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729316218; x=1729921018;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvyeG0sMGLIPDJGO5fTlUoNdyS3Nb/+jzs6l/Ql3K1U=;
        b=W7iAnGTauCBJkFFRiCmmN785AWAdUGLIvnj0xCNx6C0dwu6tMTRlLIpUOthvdXipJe
         GDEe0AzyWO1KdM8mqZ62qOJrbIGDeIIb4HPyCi2hKmV/++yn1ktBUTdBzJPY1O81YVnv
         gqo6NesMFJsz50FtUpNRepstdSa43vOguPFks/Xkxp1yySEeWNhyCppVK0/w7t3oGIj5
         sXx9Svd/02YSyFir2MqnESYQa6fsZTMt/5ojtssHF8WeGgcWMQEJeSVtH5isIxP/4Z/D
         AMIW01of9m1Kx6yEtN8nkDnC4gSXjwwUdM2SMjxIDulCoh//C1TLBtiTqAwghBCUftQ/
         Ccww==
X-Gm-Message-State: AOJu0YyTqwRqAs0FJzq6i/ADRP+xVYF6GJUs3j+0mUT38ywsP16j1E91
	4WIcW7tiGWDvPr4kyMxUmqJXn0AjaTapzEceA/TtibafCE1gm00xo/B5YI7MUXxlY1pn73IRU+U
	xm14=
X-Google-Smtp-Source: AGHT+IEt5HjmxdM79D9u6pDGmB8BmmjITVgsn3cTA5mvnMfSA50vSYGZj4YkEv3qeaDep5emWIB4bg==
X-Received: by 2002:a05:6300:668c:b0:1d9:dc8:b80d with SMTP id adf61e73a8af0-1d92cb56801mr6034991637.20.1729316218163;
        Fri, 18 Oct 2024 22:36:58 -0700 (PDT)
Received: from jupiter.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311f51sm2395825b3a.36.2024.10.18.22.36.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2024 22:36:57 -0700 (PDT)
From: Hardik Gohil <hgohil@mvista.com>
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Kenton Groombridge <concord@gentoo.org>,
	Kees Cook <kees@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Xiangyu Chen <xiangyu.chen@windriver.com>,
	Sasha Levin <sashal@kernel.org>,
	Hardik Gohil <hgohil@mvista.com>
Subject: [PATCH v5.10.277] wifi: mac80211: Avoid address calculations via out of bounds array indexing
Date: Sat, 19 Oct 2024 11:06:40 +0530
Message-Id: <1729316200-15234-1-git-send-email-hgohil@mvista.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Kenton Groombridge <concord@gentoo.org>

[ Upstream commit 2663d0462eb32ae7c9b035300ab6b1523886c718 ]

req->n_channels must be set before req->channels[] can be used.

This patch fixes one of the issues encountered in [1].

[   83.964255] UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:364:4
[   83.964258] index 0 is out of range for type 'struct ieee80211_channel *[]'
[...]
[   83.964264] Call Trace:
[   83.964267]  <TASK>
[   83.964269]  dump_stack_lvl+0x3f/0xc0
[   83.964274]  __ubsan_handle_out_of_bounds+0xec/0x110
[   83.964278]  ieee80211_prep_hw_scan+0x2db/0x4b0
[   83.964281]  __ieee80211_start_scan+0x601/0x990
[   83.964291]  nl80211_trigger_scan+0x874/0x980
[   83.964295]  genl_family_rcv_msg_doit+0xe8/0x160
[   83.964298]  genl_rcv_msg+0x240/0x270
[...]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218810

Co-authored-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Kenton Groombridge <concord@gentoo.org>
Link: https://msgid.link/20240605152218.236061-1-concord@gentoo.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[Xiangyu: Modified to apply on 6.1.y and 6.6.y]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Hardik Gohil <hgohil@mvista.com>
---
 net/mac80211/scan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index be5d02c..bcbbb9f 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -351,7 +351,8 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 	struct cfg80211_scan_request *req;
 	struct cfg80211_chan_def chandef;
 	u8 bands_used = 0;
-	int i, ielen, n_chans;
+	int i, ielen;
+	u32 *n_chans;
 	u32 flags = 0;
 
 	req = rcu_dereference_protected(local->scan_req,
@@ -361,34 +362,34 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 		return false;
 
 	if (ieee80211_hw_check(&local->hw, SINGLE_SCAN_ON_ALL_BANDS)) {
+		local->hw_scan_req->req.n_channels = req->n_channels;
+
 		for (i = 0; i < req->n_channels; i++) {
 			local->hw_scan_req->req.channels[i] = req->channels[i];
 			bands_used |= BIT(req->channels[i]->band);
 		}
-
-		n_chans = req->n_channels;
 	} else {
 		do {
 			if (local->hw_scan_band == NUM_NL80211_BANDS)
 				return false;
 
-			n_chans = 0;
+			n_chans = &local->hw_scan_req->req.n_channels;
+			*n_chans = 0;
 
 			for (i = 0; i < req->n_channels; i++) {
 				if (req->channels[i]->band !=
 				    local->hw_scan_band)
 					continue;
-				local->hw_scan_req->req.channels[n_chans] =
+				local->hw_scan_req->req.channels[(*n_chans)++] =
 							req->channels[i];
-				n_chans++;
+
 				bands_used |= BIT(req->channels[i]->band);
 			}
 
 			local->hw_scan_band++;
-		} while (!n_chans);
+		} while (!*n_chans);
 	}
 
-	local->hw_scan_req->req.n_channels = n_chans;
 	ieee80211_prepare_scan_chandef(&chandef, req->scan_width);
 
 	if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
-- 
2.7.4


