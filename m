Return-Path: <stable+bounces-233494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNbGCfWY1GmkvgcAu9opvQ
	(envelope-from <stable+bounces-233494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 07:41:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F0F3AA065
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 07:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC9773081289
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 05:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4413324679C;
	Tue,  7 Apr 2026 05:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqL4CH2p"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFCF23C4F3
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540368; cv=none; b=lwyX0qo7EiP8kqRJkIsoKkzxV9hyNCcjy+YSrthTTMMHWbuhQViaWuXbz6C7RtX7sktM0HqUFAfShr2O9XuQfnVuaVW9Dyz47F7xxLkPxO9XqBv+rYI/ehqAsRId1D4wF2aCTbuWJJXgSHJkbJS/QLhrANb4Nqbzh0ed1CB5Kv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540368; c=relaxed/simple;
	bh=nLB2b5wL4mUgyVxryiliny0HR6ogqociCTBoN0V010U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdr1+Vs+ySv5aq+lpEntR6eAmAOM7VKb1NAm3LBIID5HlPXUN9TZ+XQIitxOjJi3mO1Hpk85HqFz257/ikT5cQEa1QcT6Hkrh3kIhwhTmWP3iH7X4ggvHi3A1qXJwauCWDckNt4tBibniy4D2Y/GlK5Gz2P6ZrS/TMKb53+IrhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqL4CH2p; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65003f40a22so1924939d50.2
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 22:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775540366; x=1776145166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LWa++mcPY3R4bD8/yjfZwPnWZrMl/x1vqxM1wZ12zs=;
        b=hqL4CH2pqnCj/wA7RD2V/y4nSQgxlnZZBfokaxVr7FFmEYcIEn+4k34tMQDTMmj9LY
         m3msBbvp5wjZjmyv23+fUWC/kAUCaYvLfF/jQpZxQj84tz+oKV48eWly6e8oPWK/afZn
         CReBGBZmCppaquHkOR/lOB3z3VY659zMb+uqhTv7klHGOWpR+ffv7J/wti1uwWJKo6cW
         3GKtneTFpuMDLNTpCEg89wDPk9EayHIuEW24CMKHt8QgwiP9GmOa/XVD56vjobpTBRz/
         FqLBmFhgvfDItJ+31rx5kat1RiqIZv28yDXHdiYmKTTZ3c6Ujx/YBTVhFBRvxknAIucs
         OSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775540366; x=1776145166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6LWa++mcPY3R4bD8/yjfZwPnWZrMl/x1vqxM1wZ12zs=;
        b=r3MAakUrSK4SFStmxsAtsSprd6QHCTIDOMjp4lSY89VgOo9FKiZfvrcljHiyW6oAd4
         F5hyk5CFXCpGMtNqBzMppHL3Ff7PPkpZ7okMKv8D71dWyk5p/mX/v8v6EKnEf4V/Vr6j
         gb9iWF6ooNBWKvQqOioOCAdrxFn+sNiKW+1iAGq+cg1dzF7CBM+jtYuzZDn1LatZ/kXw
         OuGqzwY2nIVFy/0ppuJKlnH2obaOpjxs4C6dZfz1fkliYgSvKcxrRMPQqbnTZcWLEavc
         SRTEs/7Kecz0ZqT2nJamxCShmk7+wSULGjP128N6HSrLADiN6ZSsa0OT8DsFpG/26x3R
         WB4A==
X-Forwarded-Encrypted: i=1; AJvYcCVmRRfj0cb+sF0Y1ryQ3IDYDLIBn1pR+QV+LrC4zuAaUeFok4ARXXVhGYo83oQqjdOi0vFwxQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxB1eLd4fqOi7VkvJQ+JsmsIpKl1e33tTIdr0vrLg0/BmOY2Oo
	8pdV6rKcREAMvDuDKdFwZBBSl29cjMJ1KqxyWwMv74kGQsEr16GpYsPLLC+//2fa
X-Gm-Gg: AeBDiesGfHf2NV8/Wel8CS5wCMM43EgIWZn4qZydkK/ovt2f6q4y+QXRZV4uGj7ysaE
	HRKz0gxS8/fcAJaJHWW8h2jTXs4Su3inI4+Wvk4p4xFUM+C9ln3yiU6Nscc0AxhVESNeM77G1up
	QH24Sbhy0ndZ971qYoBEh3Jlr+sHK403g49w7CBiz9gHYSTNyfCaxbfgc9MV541lFAkFwimjD4z
	GOqhjs9XSY8Ll46IwTVFepCrOgSvjlVMA9rXN78aTSwb4qgwhPd89p7di36uYoD1y++zz38y11M
	h4SNx04hzHfeNEt60xVa6l8JLUFRiQfzT1V8VC1oihkGg3WmibxX/uIHHC+8+qKPoPXR2XU3gcK
	klIop2atsp4S5jR0vOR2e1H0CZuYjFqfSRZHo+CfznOXpqjks+0o2cmXERQ/HBi1PrBUzRlDMx3
	VaDQzIyDZBfDRMNy1iC7a7kVWWAypRUxoiyq/6CtJR6E3UG+peCg78ad+ltslb
X-Received: by 2002:a05:690e:43c2:b0:650:311d:55cf with SMTP id 956f58d0204a3-650486c0668mr12455032d50.15.1775540365813;
        Mon, 06 Apr 2026 22:39:25 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a978b7csm7217468d50.11.2026.04.06.22.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:39:25 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v3 3/3] wifi: mt76: mt7996: clear cipher state on key removal for WED offload
Date: Tue,  7 Apr 2026 01:39:17 -0400
Message-ID: <20260407053917.75898-4-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407053917.75898-1-joshuaklinesmith@gmail.com>
References: <20260407053917.75898-1-joshuaklinesmith@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-233494-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79F0F3AA065
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Same issue as mt7915: link->mt76.cipher is set on key installation
but never cleared on removal. The WA firmware retains the stale
cipher in BSS_INFO, sets the protection bit on WED-offloaded
frames, and drops all plaintext traffic when encryption is
switched to open/none.

Reset link->mt76.cipher to zero and call mt7996_mcu_add_bss_info()
when the last group key is removed. The clearing is guarded by
checking that both hw_key_idx and hw_key_idx2 are unset (-1) so
that GTK rotation and BIGTK removal while another group key is
active do not trigger a premature zero-cipher BSS update.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f16135f0b7f9..8b1bc3237527 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -244,10 +244,27 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 					&link->mt76, msta_link, true);
 	}
 
-	if (cmd == SET_KEY)
+	if (cmd == SET_KEY) {
 		*wcid_keyidx = idx;
-	else if (idx == *wcid_keyidx)
-		*wcid_keyidx = -1;
+	} else {
+		if (idx == *wcid_keyidx)
+			*wcid_keyidx = -1;
+
+		/* Clear BSS cipher only when the last group key is removed;
+		 * during GTK rotation the new key is installed before the old
+		 * one is removed, so hw_key_idx still points at the new key
+		 * and this condition stays false.
+		 */
+		if (!sta && link->mt76.cipher &&
+		    msta_link->wcid.hw_key_idx == (u8)-1 &&
+		    msta_link->wcid.hw_key_idx2 == (u8)-1) {
+			link->mt76.cipher = 0;
+			if (link->phy)
+				mt7996_mcu_add_bss_info(link->phy, vif,
+							link_conf, &link->mt76,
+							msta_link, true);
+		}
+	}
 
 	/* only do remove key for BIGTK */
 	if (cmd != SET_KEY && !is_bigtk)
-- 
2.43.0


