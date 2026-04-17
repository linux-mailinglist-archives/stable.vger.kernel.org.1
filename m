Return-Path: <stable+bounces-238478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGulE5gV4mnZ1QAAu9opvQ
	(envelope-from <stable+bounces-238478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:12:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E17A41ABD5
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED2E5303B5EA
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A99322B88;
	Fri, 17 Apr 2026 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="le3gwoOF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3FC37F735
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776424310; cv=none; b=j1JO/wMjZFnoem/S9V7U5g9jWguVuvneAN7/iLTNRE4d7M63CFVUycu4x56Ob+cowl2dH25QjZhAm8e8+WtDPcMl5I95zVEXNKiU2wD3KysBz38BCqIwmMts7X39NystxL98I4C1tQErW+o1eP9RDnVqk9upE/vMpDyUI2IlutU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776424310; c=relaxed/simple;
	bh=oXxvYp7mSxvDjDiF1oqhXSRgzy+AMfLNV5vfZJKXa88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4MhFGAOVSVqRhdlJXg58lo0XLNMz2hG5Mtdss/++UCfUbxrPlHlllEYFDPk7FBMEANCVPdR2S0VQqS0AhtyJOTpNDBZY9pBpspW8NKt68yHUQ80xutYdAEKFvjd7NPz4Y59oXrJZBlKkZedjqj9ECPAq/jgACh0SzqkCAGXM6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=le3gwoOF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so8791955e9.2
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 04:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776424307; x=1777029107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZN3gfZee7R57N4dlGIBXrBPV0sAI+/BLIAVKZCa0Ck=;
        b=le3gwoOFGrVmtZNbTdJ1VkbmPjsqOfNHvO+n8KQkE2K8eAz7EgILbr5F861XgYhqNq
         ZlMu94WLVvTldkth3TAqrmFNwMBn+Feh/DVeRLlPopFQ7BU2QlyhBYopgj5ZLwxt8Tbv
         F/hGX3u5qCs/At765ADqStaBXk6xEiBrJaIp7rgXWpW+MBbE7f8QJOLep6eUJWMCJ60l
         nBVPryZdKy3XUuK5eD7Puvlhwil3zwdiyVeUenqj4BunNHIIrIlU5T9gs5ZHN/IWd7N9
         QwY/SBpZnbQRjoxvCfTmJjalbmjr3UXMyKnCtPgKXWT8nUTh9VvbYgfMFyHenYJOgV/+
         2ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776424307; x=1777029107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZN3gfZee7R57N4dlGIBXrBPV0sAI+/BLIAVKZCa0Ck=;
        b=WVZfjarzb97qv87+uyrnEiAUIELnKTNGzFxBGWrx9fmsgG2qoyoY45Cw2gPLiUojG5
         6CqyGOsrLJj2qOf3DPtGqax18glb2gBBNQlMGzuWM06Tu6jaVqDPWl5ZF6wAOGfSNSKz
         P8iBb17W7jqj9m9sk6JOkP3Ho1DOsL5Tv1MUqGA5JgtbVrNQrGsC9J6aVt41nDce1fPZ
         TgPFb++vtZix0ktUjm3WKMejfjrlMvWndg2VUrHcG0/PsBSywnypnLx3GFVS7Q6hcoMt
         zTawhkZxFtIOsi8U8JlvBDZZ/blHpaE0aMohRst4+v2mYRh97w7aa4WMGKy+Sz5wgVsj
         ovOA==
X-Forwarded-Encrypted: i=1; AFNElJ/xvpdg+XuN5rxLs42LTc3hWVLZIEW4bn7TK6uOijkvuNve0qlYQdSS7c4K0bBw4nIsv35T8CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDnHcfGHPkR8STEqA4B+o/8n5bxXsbwvvVYe9JqeyXdYJsJpvW
	q4Koh1SPuOpsnGU332APUAklxUJF1m2/33vZJcCwZDsdkDeoREeIdHM=
X-Gm-Gg: AeBDietxIYp9DZfFZlFovSDgr1ct+RUJWVX0xx4CcxXcIOTFAb56qdIMdI//oqoEI0G
	9aLVdTZGkHHTCjap7kw7//LoI0XwIO/gsDQ8P6Ze38CGMYwbrFHAN2SHT4Ys2xjyyqzND8CyE46
	lKfQCvUch/1Yju6/OsT1V3mANhJ25t437+WQO6l4Xfw6h+Qtorp6G5+CTDS9dQpqzxI6EhkC3Zu
	Jcx+X5wCCBoKaILmLI7ac5j1zlNXeDhujbPpxQfCaM+fuMlkRC2jKo8LbdP99z6sCeDieWcrz6r
	MhIf53SuhC3T4TTFFDcLozOQJwpJwR2mRdrh4G+Nt08jVGCAsO1E94/KlirtVIMWUGhf8CDF+wM
	uLhk20aQdDJ1Lpz5Ip6vxJn75yggYSDOzz9k7do48XWBRUZYuGyH8t3X7mTp+qVq4yG42pqElQC
	xEP5c=
X-Received: by 2002:a05:600d:8408:b0:488:be58:bb5b with SMTP id 5b1f17b1804b1-488fb773f0cmr25674465e9.24.1776424307402;
        Fri, 17 Apr 2026 04:11:47 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm62121235e9.3.2026.04.17.04.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 04:11:46 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	jonas.gorski@gmail.com,
	m@bues.ch,
	b43-dev@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] wifi: b43legacy: enforce bounds check on firmware key index in RX path
Date: Fri, 17 Apr 2026 11:11:45 +0000
Message-ID: <20260417111145.2694196-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417111145.2694196-1-tristmd@gmail.com>
References: <20260417111145.2694196-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com,bues.ch,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238478-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E17A41ABD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

Same fix as b43: the firmware-controlled key index in b43legacy_rx()
can exceed dev->max_nr_keys. The existing B43legacy_WARN_ON is
non-enforcing in production builds, allowing an out-of-bounds read of
dev->key[].

Make the check enforcing by dropping the frame for invalid indices.

Fixes: 75388acd0cd8 ("[B43LEGACY]: add mac80211-based driver for legacy BCM43xx devices")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/broadcom/b43legacy/xmit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/xmit.c b/drivers/net/wireless/broadcom/b43legacy/xmit.c
index efd63f4ce..ee199d4ea 100644
--- a/drivers/net/wireless/broadcom/b43legacy/xmit.c
+++ b/drivers/net/wireless/broadcom/b43legacy/xmit.c
@@ -476,7 +476,8 @@ void b43legacy_rx(struct b43legacy_wldev *dev,
 		 * key index, but the ucode passed it slightly different.
 		 */
 		keyidx = b43legacy_kidx_to_raw(dev, keyidx);
-		B43legacy_WARN_ON(keyidx >= dev->max_nr_keys);
+		if (B43legacy_WARN_ON(keyidx >= dev->max_nr_keys))
+			goto drop;
 
 		if (dev->key[keyidx].algorithm != B43legacy_SEC_ALGO_NONE) {
 			/* Remove PROTECTED flag to mark it as decrypted. */
-- 
2.47.3


