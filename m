Return-Path: <stable+bounces-244290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FcQLgGc+mkMQQMAu9opvQ
	(envelope-from <stable+bounces-244290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:40:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3803A4D5572
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 547963054B91
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 01:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CBD2750FB;
	Wed,  6 May 2026 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGY96J3g"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A38257423
	for <stable@vger.kernel.org>; Wed,  6 May 2026 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031600; cv=none; b=iFF1wYk5GOXSN+NrL8VGVcBwCmTD4oq+je1+9Qz9irAN9gGd+tx3h6RNbt/nsGBkyGs4d7ZtFHeeZ8qfL6fSC7lvrd5f8Jjc+n6Blai0uZ1YSU/NPIhstE7n93xQKQNHBlYzScvMrhnDHilCCmfA9GEFneNFIter9EKE1gWYZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031600; c=relaxed/simple;
	bh=XR+QR8Bfz1SKiot7jHliEJvocZwK2smxEIxpKgP5K6U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T45Duqfzf/+EbNaJ5BNYIOo2hGe20stTjqaiz7jutQ4RtZsxriSvkf6aIZN/uhYZmuLwm4faDX8B/ZuVMFUEfPBDz8MS/DK8jUIbM8LXMoKCCjPmL+OOBQbMcOtTtpfe1v3fLkWXIXR6AbcNW2h8z5EzJ65BWH1a6dvrnx2P6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGY96J3g; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67b7c71c165so7265099a12.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 18:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778031598; x=1778636398; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wR2Thhm3Jq6hlQLmRsOOuFA0pevOR+HEZ2FYTK0h4IE=;
        b=XGY96J3gzWUS9QFqJlxiS35b4zNgQTOVFv1cg3BZ3gZXmAw7obv59ahhQjW4BV3VC0
         PToGtxbaSFUixI56S+in9T/vTULDDQ9u9zIddzM7fpLxvC5JU85ixLJ/xw2LXCXXA4Cd
         Fty5P2P1haUAkQmNhdDGIIDFETG8Tbk2uIUDAJ6YHiMCyZJLb+aTP/xAaq7N/b+mAuf7
         EPWNeJ9ZWisxGLxbhwnL7ZNZXZMtLZVRqq9Tjs8ruXT42lPYJVVlRWuzdbufDJ7jj6Mv
         aLuGd5a4xsF7PrGY/pfBx80NF5UNFsyfXPyEcKhdUW/a+jnxGHWf4M9bgyRUj6Fu7VIF
         N59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778031598; x=1778636398;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wR2Thhm3Jq6hlQLmRsOOuFA0pevOR+HEZ2FYTK0h4IE=;
        b=ahtz6HXdG2X1qJjtyjlQa3NtmnTrk/0pCKr4C0/+76PayEMKx50of+90dKS3gtvN70
         QF0k+oCRgGKmEuBPdnidLhO4UPXPwTlvQOcBcsDuUjdz92JlgPNXShAGC1aS68REKCDg
         lkCyAbTGYFof025dgdIAzmyVkMgvERGGI9sx5hvHEkvI1eeG6vagxdpaGa8gTQa2W0wM
         CoWnm1uYqtK1bDEfgx+2VQcQ6sxb9nyb9U4fQjfhihOelUx3/aLZJYgONfPFVfpehw4K
         Og/TNCN7VFHhg9C1x/MuLS6IQ4+VNZTJkEkQbBDnuGjDouBnMwwNffyGKu9ilZU9A/Pw
         MiEg==
X-Forwarded-Encrypted: i=1; AFNElJ9khrX33k6kvkOU0rDP2HL7rI0HigHMR5hHoNAfpPdDlWDPUvzo9Hjzah6oNo5wHEyeyyQ2uTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeGbSdUPUwsuFMPkm+RC7OXNgcBaFKdLs3SHDdcUMhX1/XM4HF
	h4JHzGjDqezVn+HpQy0C/rhZOgMQ52IbarQzEcHTYjkTLs+RdVILQWJj
X-Gm-Gg: AeBDiesbNcSjGMhr6NMvtbHQYl/3Fb0sCUSyTX7Oya7x7Sc5sO4GjYYRtm/gVANm6oq
	Lvq2J4j2vPhsRGD+2Gf+AzKOAV1GdUkrb0c3RXxWF61B8yNqWyPGmwmeZpwM2vrodbRT+/XPS/i
	z8u91UaZyasRg+woS+56OI67UwuaZqvnm7cYxTkMuMxmM1YAzw9JKz9oiJwdLrpxHd+JpH9QV5z
	peCdaanXMohCJ846N7fWQioR71bSsn0LTZX6G7KnFpP/MInouGtue9xn7hffnF7UA1YRo/rN+S/
	WyV+I3/2p1XnVZBtOsSM+RyPT9zZYamLQmZ/MI4gqEZvPmunGMhvlqtHe7fPgcD5ulw0JZgbDCH
	Wgo0LBs+ZzTX2dXTosAhTD/0Ef6YCBKLdM9xRpDmb+arWP8q/rO8GFHFJEyfPJagfov1fdJu1PT
	Bk9Co5O9+e6mqY+HpOvPVplfP4mdXY6ToNkCD8jUvnKJspNg3pJDFPwyjsJlvL859ajbbPQtB/7
	FMgUKazHrzoFEGQbZEsmj6zyXkv51yW9CZwOAg9DFXB
X-Received: by 2002:a05:6402:2420:b0:672:2995:be37 with SMTP id 4fb4d7f45d1cf-67d63a9e9f4mr429366a12.1.1778031597549;
        Tue, 05 May 2026 18:39:57 -0700 (PDT)
Received: from KURWA.angora-ide.ts.net (mm-195-107-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.107.195])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd904fe68sm849388a12.0.2026.05.05.18.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 18:39:57 -0700 (PDT)
From: ElXreno <elxreno@gmail.com>
Subject: [PATCH v2 0/2] wifi: mt76: fix TDLS direct-link on MediaTek MT7925
Date: Wed, 06 May 2026 04:39:14 +0300
Message-Id: <20260506-mt7925-tdls-fixes-v2-0-46aa826ba8bb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMKb+mkC/yXM0Q6CMAyF4VchvbZJKSCZr2K4EFa1RtGsk5Ase
 3eGXn45+U8Ck6BicKoSBFnU9D0X8KGC6X6Zb4Lqi4GJj9RRg6/YO+4w+qfhVVcxrH3duL5lckR
 Quk+Q31Cy8/C3fceHTHE/gpw3hQekznUAAAA=
X-Change-ID: 20260503-mt7925-tdls-fixes-1d1397420900
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, 
 Deren Wu <deren.wu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 ElXreno <elxreno@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4575; i=elxreno@gmail.com;
 h=from:subject:message-id; bh=XR+QR8Bfz1SKiot7jHliEJvocZwK2smxEIxpKgP5K6U=;
 b=owJ4nJvAy8zAJXa0WDmKX5v/EeNptSSGzF+z3/TIRVV/nXhHZNeznBKJjw5v36sYMax8sqzuw
 ra9l4WsZ8V0lLIwiHExyIopsvCc21ubs6xuyeR6rgyYOaxMIEMYuDgFYCJmPxn+KSXZZR+a2WN1
 7c2RjcIm4pVCSZstn+Zc/f764WkTRp1VSxgZHnfOVE15kHVT/eyfT3nnnr6+59bYFTq7d+/yasF
 Ig+f7GAHIeU2p
X-Developer-Key: i=elxreno@gmail.com; a=openpgp;
 fpr=0CCEBD7D6CA67EA4937F0A68C573235A0F2B0FE2
X-Rspamd-Queue-Id: 3803A4D5572
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244290-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elxreno@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This series fixes two TDLS direct-link issues on the MediaTek mt76
driver, observed reproducibly with Samsung phones and other peers
that auto-initiate TDLS direct links on a shared BSS.

Patch 1 fixes silent loss of TDLS-peer data on mt76 chips with HW
TX encap offload. The HDR_TRANS TLV defaults to ToDS=1 for STATION
vifs, which makes the firmware build A1=BSSID for every WCID under
that vif -- including TDLS-peer WCIDs. Frames bound for a TDLS
peer therefore go on air to the AP, the AP silently discards them
per IEEE 802.11z, and no user data flows over the TDLS direct
link. v2 adds an MT_WCID_FLAG_TDLS_PEER flag (set in sta-add when
sta->tdls is true) and overrides the HDR_TRANS TLV to ToDS=0/
FromDS=0 (3-addr non-DS, per 802.11z) only for those peers. HW
encap stays on for AP and non-TDLS traffic. The override is
applied in three HDR_TRANS helpers:
  - mt76_connac_mcu_wtbl_hdr_trans_tlv() for mt7915/mt7921/mt7922
  - mt7925_mcu_sta_hdr_trans_tlv() for mt7925
  - mt7996_mcu_sta_hdr_trans_tlv() for mt7996
Verified on mt7925e + a Samsung phone over 5 GHz HE 80 MHz:
iperf3 -t 30 transferred 2.90 GBytes at 830 Mbit/s with 0 TCP
retransmits. The other chips are not regression-tested for lack
of hardware; their HDR_TRANS handling mirrors the verified
mt7925 change.

Patch 2 fixes a regression introduced by the MLO refactor in
commit 3878b4333602 ("wifi: mt76: mt7925: update
mt7925_mac_link_sta_[add, assoc, remove] for MLO"): the cleanup
loop in mt7925_mac_sta_remove_links() unconditionally calls
mt7925_mcu_add_bss_info(..., enable=false) for every link of the
station being removed, including TDLS peers on a STATION vif which
share the AP's bss_conf -- wiping the AP-side rate-control context
on every TDLS teardown and collapsing rx bitrate to 6 Mbit/s for
tens of seconds.

v2 design notes:

I tried adding the TDLS-aware firmware-facing peer setup that
v1's commit message identified as missing first -- defining
CONNECTION_TDLS = (STA_TYPE_STA | NETWORK_INFRA | BIT(3)) and
setting it in mt76_connac_mcu_sta_basic_tlv() for sta->tdls peers
hung the MCU on STA_REC_UPDATE within ~5 seconds of iperf3
traffic, requiring a chip reset. The proprietary out-of-tree
mt_wifi driver also defines CONNECTION_TDLS in mt_cmd.h but never
assigns it; TDLS there is implemented purely as an 802.11
action-frame state machine on top of CONNECTION_INFRA_STA, with
no TDLS-specific MCU command, and is gated to Connac1-era chips
only -- no firmware-facing TDLS peer setup to align to. The
HDR_TRANS ToDS override is the simplest per-peer correction that
works.

A note on the methodology behind the misroute observation: my
v1 captures used an RTL8821AU USB monitor which is single-stream
and cannot decode mt7925's 2-stream HE data frames. The
misroute-to-AP pattern only became visible after swapping to a
2x2 Intel AC 7265 in monitor mode on a separate host -- frames
go on air with A1=BSSID to the AP, the AP MAC-ACKs and discards
per 802.11z, which matches the iw counters (tx_packets++ but no
TCP ACKs returning).

v2:
  - patch 1 rewritten per Sean Wang's v1 NACK: per-TDLS-peer
    HDR_TRANS override instead of global SUPPORTS_TX_ENCAP_OFFLOAD
    removal in mt792x_init_wiphy(). Coverage extended to mt7915
    and mt7996.
  - patch 1 dropped Fixes: 5c14a5f944b9 and Cc: stable -- the new
    fix introduces a flag plus three helper overrides; not
    realistic for a clean cherry-pick into older stables.
  - patch 2 unchanged in logic; inline comment trimmed.

v1: https://lore.kernel.org/linux-wireless/20260503-mt7925-tdls-fixes-v1-0-dde847e21081@gmail.com/

Signed-off-by: ElXreno <elxreno@gmail.com>
---
ElXreno (2):
      wifi: mt76: route TDLS-peer frames as 3-addr non-DS in HW encap
      wifi: mt76: mt7925: don't disable AP BSS when removing TDLS peer

 drivers/net/wireless/mediatek/mt76/mt76.h            | 1 +
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7915/main.c     | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c     | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c     | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7996/main.c     | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      | 5 +++++
 8 files changed, 31 insertions(+)
---
base-commit: d2ffdadd4aca41d120e25f6a675dd6a4d77ce360
change-id: 20260503-mt7925-tdls-fixes-1d1397420900

Best regards,
--  
ElXreno <elxreno@gmail.com>


