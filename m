Return-Path: <stable+bounces-223456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLh9CMOnrWmE5gEAu9opvQ
	(envelope-from <stable+bounces-223456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 17:45:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9402311D2
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 17:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E253301A433
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCC8340A79;
	Sun,  8 Mar 2026 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQXnUwLc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158CC33290B
	for <stable@vger.kernel.org>; Sun,  8 Mar 2026 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772988331; cv=none; b=Rcto7sneUrFjU9nGZ32pq0M372q4/xVTpmpae1ZArT0wTobXQzMYM6jURKfNswQ3ghFGXnZopMv46h+kErFTv4NC/gB496xlRlGqptlrqe/Z1Dc7pIQpibwedAAtNwZ9mJMd3vJPmQaIKsrvf3wb/RgxMQHwrmw+CSmnCPP3mnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772988331; c=relaxed/simple;
	bh=3ZsMukaIBQF8clZEQgBlk3fbZVydnmjSCHhfvXHBBzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sRnog+zgLzsviH4xk1hW1UyOq0zrqMBWxqYV908BqTnkhcgpKUmRaHgaGSSHCKx/uIjbSWimtMTxLKJ5EF0fbtFrwKtKwCj3b+rdFx46vobAnEwJQTiZlInpqBLFHEm6/kqT2zzT52X167mz0h6ppZoXzXumcEtjMwCP7NV8v5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQXnUwLc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35994d84c6dso2957187a91.2
        for <stable@vger.kernel.org>; Sun, 08 Mar 2026 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772988328; x=1773593128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSyQyBckY6yDa/40OyCVuQtNFVPo/rjnkS7c5eUMd0A=;
        b=XQXnUwLcXtFFLjB0wWxakDStpKOxANW9DbvQcHZzvoaNSUAOUMhkYARqEVVQ1Gma3v
         lzewxp6tjuCi67IQg9TqoDDZuhxdH3MQWEQuxttStwP1ZrXeg+YRoGwot92Wr++vWwip
         N7ORC0m7ds2Jd2eZLjSUthSVng60Bf64Btg6loOZnDxUQ83r9PeoD5z4vRrnnKWYOgEH
         X/elOQlfsstgKhOmMYCAzV1UY3PH4XnwtZADj1AN8QbGZU+ZzHWpc4K4kNVyDEISoQwQ
         AC2sMpuH3p7bcHZAI3M+1IOdnfZtlstgjCjfDoPWI5S9jAbaOdnUxCugtQtSAY4syV7H
         TUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772988328; x=1773593128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSyQyBckY6yDa/40OyCVuQtNFVPo/rjnkS7c5eUMd0A=;
        b=TMUITCN/1vUgyrwHU5jc6TEBq5AXz5dc4NUI5wdd/xlB6jJivvRwCNi2pKbJASMnTk
         9w0b4twobYoIG+/zRbPIgG5y+RfEPch0ELX1pONMZrhRz4ydxGwg+66V2j9/fFnhlRty
         NBKN5XPORMkMHAupXUmPVR/pCG2l9OFUVaUYPy/55/lBTb1W6Qm0MAercwPH3e6ncU1M
         HLe6pdDfjP6oET84V9BDcC4QIQ0FtsBmbXwfgmXpILjUP8RZExkSzdbqQ73kSqeiCaLc
         BzN5y23++pBcEuPcwN1hGBJOglTZs5oUJL++PxQeciw1PtWcAVVtrDCBiLbEaTWyCL7W
         qOmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1Zt3T713q5qt7+OSWGxMvzl9pd8cNF27opMzBMIKod2Tp7SvsQYQbNTKOgoHLWc9djSJrIZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzWX9EkJwQ5kxNXZzIoJsct8AFoN52NXMxo2nvouDQpHfAszmo
	JEjKck+rRKJCpOrk4EyVeUOSw7bjF01UONkS+16bTXZoTDxwZ2Q8q37c
X-Gm-Gg: ATEYQzywZ+eyJ2VDYflbuJ1ahS1eMDywdNT0C53aCBnEJ0ldZW+xJm+QCQPZYxzrhN0
	R+FII5kuNzKoC/g0dqvXzfO1AQes74jQ3YsDkhpa2mDsfMisaANV5U9gnDIjtuarj6ocAfrXXY1
	mNiuIC62ZHEVL1e70NrzaOqgHpu4+iuFLSPBq+dELamJ0P3lyyo6s/3BKWlKeNKe0VZ/yxBfl6f
	3TitqlJYiBm/hyZswbrVroTla8FiTBiBQyr00EXeF13nLFq5xqb2BP3WdWZwSCIgwZt/kk49Obw
	wgGSs8ibleKYqSLVBNUdV4Rgv2OTovlz5A5Ec5f/thwCKS2YXwvG7qOLouoJzZlVHlPZI0B5Ccv
	9XhjxcQg9E1bPY9d9Uv/zY+nWQfhRCqHCrAgoVSyfo68h2amsxR76SWGXcS05O6MIYFdIETsTWs
	yR/W7s+TirMUkQosZrWe4fgtHSfbO78bwFWGyxhunwFezumxWE
X-Received: by 2002:a17:90b:2b4e:b0:359:95c2:b3e with SMTP id 98e67ed59e1d1-359be390472mr7284097a91.30.1772988326156;
        Sun, 08 Mar 2026 09:45:26 -0700 (PDT)
Received: from localhost.localdomain ([112.10.226.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c0179a67sm8032737a91.13.2026.03.08.09.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 09:45:24 -0700 (PDT)
From: =?UTF-8?q?=E5=82=85=E7=BB=A7=E6=99=97?= <fjhhz1997@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?=E5=82=85=E7=BB=A7=E6=99=97?= <fjhhz1997@gmail.com>
Subject: [PATCH] wifi: mac80211: fix monitor mode frame capture for real chanctx drivers
Date: Sun,  8 Mar 2026 16:45:10 +0000
Message-ID: <20260308164510.5927-1-fjhhz1997@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AE9402311D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223456-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fjhhz1997@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.949];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Commit 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
removed the fallback path in ieee80211_monitor_start_xmit() for when
the monitor interface has no channel context assigned. This broke frame
capture and injection for drivers that implement real channel context
ops (as opposed to the ieee80211_emulate_* helpers), such as the mt76
family, when a monitor interface runs alongside another interface
(e.g. managed mode).

In that scenario the (virtual) monitor sdata does not get a chanctx of
its own, even though there is an active one from the other interface.
Before the simplification the code fell back to local->_oper_chandef;
after it, the code goes straight to fail_rcu and silently drops every
injected frame.

Commit d594cc6f2c58 ("wifi: mac80211: restore non-chanctx injection
behaviour") restored the fallback for drivers using emulate_chanctx,
but explicitly left real chanctx drivers unfixed.

Fix this by falling back to the first entry in local->chanctx_list
when the monitor vif has no chanctx and the driver uses real channel
contexts. This is analogous to how ieee80211_hw_conf_chan() already
uses the same pattern.

Tested on MT7921AU (mt76) USB adapter:
  - v6.13: managed + monitor coexistence restored (0 -> 37 frames/5s)
  - v6.19: managed + monitor coexistence restored (0 -> 39 frames/5s)
  - v7.0-rc2: managed + monitor coexistence restored (0 -> 33 frames/5s)

Cc: stable@vger.kernel.org
Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
Link: https://github.com/morrownr/USB-WiFi/issues/682
Signed-off-by: 傅继晗 <fjhhz1997@gmail.com>
---
 net/mac80211/tx.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8cdbd41..56eaf9a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2396,12 +2396,28 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 				rcu_dereference(tmp_sdata->vif.bss_conf.chanctx_conf);
 	}
 
-	if (chanctx_conf)
+	if (chanctx_conf) {
 		chandef = &chanctx_conf->def;
-	else if (local->emulate_chanctx)
+	} else if (local->emulate_chanctx) {
 		chandef = &local->hw.conf.chandef;
-	else
-		goto fail_rcu;
+	} else {
+		/*
+		 * For real chanctx drivers (e.g. mt76), the monitor
+		 * interface may not have a chanctx assigned when running
+		 * concurrently with another interface. Fall back to any
+		 * active chanctx so that injection can still work on the
+		 * operating channel.
+		 */
+		struct ieee80211_chanctx *ctx;
+
+		ctx = list_first_entry_or_null(&local->chanctx_list,
+					       struct ieee80211_chanctx,
+					       list);
+		if (ctx)
+			chandef = &ctx->conf.def;
+		else
+			goto fail_rcu;
+	}
 
 	/*
 	 * If driver/HW supports IEEE80211_CHAN_CAN_MONITOR we still
-- 
2.43.0


