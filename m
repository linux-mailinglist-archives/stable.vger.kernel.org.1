Return-Path: <stable+bounces-220404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F+TKMQ5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:53:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9561C6619
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D15853132DF3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F3D3AD8AF;
	Sat, 28 Feb 2026 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfLsSW1W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DDC3AD8A4;
	Sat, 28 Feb 2026 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300296; cv=none; b=YHgjRetOxa1GD8OqyETI6drjt9uiHl3UeKq4gshRo6k6tTZHMkUHT0c5KaVlg/ZGfjcQ6uiirVrRQBfWFxnywXcPcPlFgdKC7rO9lChuEOGZOjOo5i76Wuvs5MfO2Ja6D50tn312iv0pGC5PGeQjinmpXrA07XGUdH75kc9Uki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300296; c=relaxed/simple;
	bh=nqBfQ2Y2Nm4bSX0ZnklbWYblVGiOeektzk4kKoB/Oss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFj2CQRR1XT8Q8jI0o1ggc1L5rejrwzGOz43FnDuTWmORHGqLi+Fy6A+iZK9M2waE9rUZ1EsN92IHSH1Sj5+Lo7SA5DCMOd+nSuI7dWEL4zMJvMEgWpPKSujtotXGvGSSTJLEtUtx+eBXo8zgq/M3IoWmhnDvCDItSvTZ16Fqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfLsSW1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125A4C19423;
	Sat, 28 Feb 2026 17:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300295;
	bh=nqBfQ2Y2Nm4bSX0ZnklbWYblVGiOeektzk4kKoB/Oss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KfLsSW1WILuK4vx+h6cjH2w6nq2OX44GlGsnNBk3Yjv+9agD0EA68SzFpgYlAQK/m
	 pag8kmKiOAGWRi/OMVvqqggNJvlzP2mSNhFiE4ya2OJKtSpW4GwTnrEERJ3iCXXB3m
	 RDLZSbKWNFOjNgIMCXICxzjjtu6kfAOdpnyhGi6sXBEj5ZUkLbPKBwwprhk1fHmAEN
	 scvAkYkWIM9RWFNM007PdINBUPHkWfJhTzP8F3Kw7CmobndOxKGASo/jjHFV4CN3Bl
	 Vv7+3d6glwNRg4DrbZFeU68RiSlvqEh+CzCJqYjOtDVRCgmpYU5WmRBgZaGf6icYIz
	 3y98HwpG95W6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 325/844] wifi: ath10k: fix lock protection in ath10k_wmi_event_peer_sta_ps_state_chg()
Date: Sat, 28 Feb 2026 12:23:58 -0500
Message-ID: <20260228173244.1509663-326-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220404-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1E9561C6619
X-Rspamd-Action: no action

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

[ Upstream commit 820ba7dd6859ef8b1eaf6014897e7aa4756fc65d ]

ath10k_wmi_event_peer_sta_ps_state_chg() uses lockdep_assert_held() to
assert that ar->data_lock should be held by the caller, but neither
ath10k_wmi_10_2_op_rx() nor ath10k_wmi_10_4_op_rx() acquire this lock
before calling this function.

The field arsta->peer_ps_state is documented as protected by
ar->data_lock in core.h, and other accessors (ath10k_peer_ps_state_disable,
ath10k_dbg_sta_read_peer_ps_state) properly acquire this lock.

Add spin_lock_bh()/spin_unlock_bh() around the peer_ps_state update,
and remove the lockdep_assert_held() to be aligned with new locking,
following the pattern used by other WMI event handlers in the driver.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Link: https://patch.msgid.link/20260123175611.767731-1-n7l8m4@u.northwestern.edu
[removed excess blank line]
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index b4aad6604d6d9..ce22141e5efd9 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -5289,8 +5289,6 @@ ath10k_wmi_event_peer_sta_ps_state_chg(struct ath10k *ar, struct sk_buff *skb)
 	struct ath10k_sta *arsta;
 	u8 peer_addr[ETH_ALEN];
 
-	lockdep_assert_held(&ar->data_lock);
-
 	ev = (struct wmi_peer_sta_ps_state_chg_event *)skb->data;
 	ether_addr_copy(peer_addr, ev->peer_macaddr.addr);
 
@@ -5305,7 +5303,9 @@ ath10k_wmi_event_peer_sta_ps_state_chg(struct ath10k *ar, struct sk_buff *skb)
 	}
 
 	arsta = (struct ath10k_sta *)sta->drv_priv;
+	spin_lock_bh(&ar->data_lock);
 	arsta->peer_ps_state = __le32_to_cpu(ev->peer_ps_state);
+	spin_unlock_bh(&ar->data_lock);
 
 exit:
 	rcu_read_unlock();
-- 
2.51.0


