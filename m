Return-Path: <stable+bounces-233469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CouC7ZM1GnvsgcAu9opvQ
	(envelope-from <stable+bounces-233469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:15:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7243A8624
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 859B73028651
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 00:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C16126BF7;
	Tue,  7 Apr 2026 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSVgy9ik"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259A5126C17
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775520945; cv=none; b=tCEK8RckWe/nyNWqSwFejRRy7GRl+lkX03tqZG8qzI5DfID11SV+K0fQK0ZXJt1QZ7XZldfZtC5/DcvRXbYqlSavP+xwKt/syXBUQNIPJlVinsjqMI3gfXfDJA7xXVZoWRhLv2VzPdBJCdA9ZslEEX6Y2Djo15J7raMV/QU4ekY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775520945; c=relaxed/simple;
	bh=p+heu8oqAJ8mKuDQBckMkIu9ukpFg/92WpoiU5ZTiKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hroXKr4zU2Uf0AfnXwiPx4987AhX5jFbhsV8OYPv5sS/IYRxXhym8lje0mdkxAFARF0EpmqnT47SoU10YRoN8UZOjZTfmdi2eJHQjhVm9/Ou0APACRJss6y1WWZRmcVIEVK8QA17p69KUCJduEMlARvOklYh7GLhgHAVICAceA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSVgy9ik; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79ab3e26cceso38475177b3.3
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775520943; x=1776125743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2OqRI8ckw+xa4yxPr5+ydqFc4r4rT0slahm2J/yIYk=;
        b=HSVgy9ikS/fW8GP3UzWesGj5h/RwEV3N0thLFIC27fDEU9/bzH/CwcxuonG2VT54uG
         9umgMDaXpjqR1QIeIsjy+T+dRisnNLAUO8GxEhZvZH47IciC1Df3l2jfy5iLACHg+vGH
         Ntze/COBQ+m93OubWNNPfUK3gkyGOHVq8T0Xdbv5zMeB4cQv3yxKb3ZWhwkWoPduMvvY
         vkzH636mTKenm9FBKZocCRpWX2INSdBZpYi2xi0tqYaqPJnYYgwh3PdQshtNeNWngl8x
         OMRs00d65suGDKKxlsF9+T2j/LYAYlvb7mrJArq+xOgu6X00bELlr8KqsGXVjOKnOZCj
         Y66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775520943; x=1776125743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B2OqRI8ckw+xa4yxPr5+ydqFc4r4rT0slahm2J/yIYk=;
        b=N8z142L7BudmLti3haF9iyVg3gQSG6g/t1m7y6xaOtyXAr2bZH2U+48GrlnuGiBu7e
         m2UkUuOwuFn7rV2ziWl8v84sJmLcG41pZ/y3fVzcGzVpyAPIjgUstzk31EZWlwR+o2wU
         NIq/DWtjmCmeWVwlH5NwI3Kh95V0PK8HLxSxsGeaXZaOTSB71uLg72DPMS2sD65UoiG0
         MrZZhdUVhjRUzSCAeRXI0mxGjUoki8FXOK0w8w7L+6aPlTf2Ro48wqu3CuM4mVG6v4Ta
         NWXGHK4owyLUryNK0s8zQDmBcMEsU89wfH4moKIH+uRP5wmbeqKtjQBEBuWjvo1OF8mH
         Ognw==
X-Forwarded-Encrypted: i=1; AJvYcCW+c+Yyfd4KCrXJUxr7khYwp64AT5djfLKVMYy+LrqyKcJ5gS1QMOwBhfvSBS3+4PVtiCZZvqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+5TztD+Z0FM5TwgLZtWUmt6/+/gXZajjIWk8S/PGTxtTCI0oE
	fQMP44psmwm5bkpcaET8OQHzV1DTeGdZmvjnynj1WseGOvLDedpTZwLz
X-Gm-Gg: AeBDiet1WerVEjygT2f3k83WZStyHQsd256tvdhL4b2WSaSSz0X/FXfkGRY6+brMAsG
	MiLVPV9Wn/xWVLZNPiql/+URFFvi75eDYGx6i0TzcDcbB1gOVIU5ek5Es4LMHMUrm0dM+Zx4A7G
	Ri3BmbqUj0i/evHb8diOiKTuDhqzF0otBRt+IvmPoCtLfVjmajnJ9w7/wE7reFm7mOpqVhl/3LP
	JIwuw3NNenolq2h02/mTswUe1s/X06eFjJjixma85jA1GpN8FrdQA3TDPB0GyYwyR3kQ3ViKbJy
	rTRU/rDIBoPtJLHI4U9h6txc3LuEb+zr6FuJ7on/yjBoj4WXL/ZGziKHNgkZ/kt9l6KvSaBNZcf
	OOaXgG5n3ejz3tjnxM6OcSpQQBYW6nqDEV7QvlPFeApDBksJSdmTWDScxliYvdvm0YCGC5XW4By
	bZVd3M+FZROatqBBoFhgW0c9qAW3aJyYPO/nMonYi2rcAttVA9cVnQeWU/cYqI
X-Received: by 2002:a05:690c:488a:b0:798:ff2f:267a with SMTP id 00721157ae682-7a4d6546abcmr154271267b3.52.1775520943192;
        Mon, 06 Apr 2026 17:15:43 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e320670sm59858877b3.2.2026.04.06.17.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:15:43 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v2 1/2] wifi: mt76: mt7915: clear cipher state on key removal for WED offload
Date: Mon,  6 Apr 2026 20:15:30 -0400
Message-ID: <20260407001531.31207-2-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407001531.31207-1-joshuaklinesmith@gmail.com>
References: <20260407001531.31207-1-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233469-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D7243A8624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When switching from WPA-PSK/SAE to open/no encryption, the
DISABLE_KEY path never resets mvif->mt76.cipher back to zero.
The stale cipher value is sent to the WA firmware via BSS_INFO
updates, causing the firmware to keep the protection bit set on
WED-offloaded packets. The hardware then drops all plaintext
frames, resulting in zero throughput.

Reset mvif->mt76.cipher to zero and notify the firmware via
mt7915_mcu_add_bss_info() when the last group key is removed.

Fixes: 3fd2dbd6a1d3 ("mt76: mt7915: update bss_info with cipher after setting the group key")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 90d5e79fbf..6e7442cac4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -414,6 +414,12 @@ static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	} else {
 		if (idx == *wcid_keyidx)
 			*wcid_keyidx = -1;
+
+		if (!sta && mvif->mt76.cipher) {
+			mvif->mt76.cipher = 0;
+			mt7915_mcu_add_bss_info(phy, vif, true);
+		}
+
 		goto out;
 	}
 
-- 
2.43.0


