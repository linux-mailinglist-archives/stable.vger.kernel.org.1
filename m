Return-Path: <stable+bounces-188134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B9FBF2089
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8C84631EC
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAE3253944;
	Mon, 20 Oct 2025 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="x91YQ3nW"
X-Original-To: stable@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A47A23E320;
	Mon, 20 Oct 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973190; cv=none; b=hlAkFxO6VKKtHlwjIy+T9lsbaqavMAVldzTLsxRXMGCEx9YILrpyj8ioTT4WalMHpfmpB3DMgII2XKXiaDZKOdo+GWIMljrOsK/AzpN+NFq+FH/BlJzLIuRIn0qOHCATgt7UCVgTVdGAQVXVC6XDQBCb3ue98Wclf60O1mBpYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973190; c=relaxed/simple;
	bh=3S4lO56CG9tohgwwGHC5szTZOdS41z1QUng2VGAXfBU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WkzBXG2dpK7jvOTlq4pIy3NSJw7U+gI2vRIq0z11zjvVN5wk/lReq19hbUKjD6p/fO7C3tmeyTgjQxy1VILLMcxoIIH41p+1iI8AaYukxPL5enQL7uCOOzBarZDJzyTBlGNLM0YEvmV4i+W0FlAusfgD257PK3E+tfKG2uVR8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=x91YQ3nW; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 4676F1044BEA;
	Mon, 20 Oct 2025 18:12:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 4676F1044BEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1760973176; bh=f6TnMnECCIqPoKuiS/BRSEBi2i3eEB1O/9qu6G5dZu4=;
	h=From:To:CC:Subject:Date:From;
	b=x91YQ3nWV7IHAWwSezpwHA3IdAsfvg2mFPSc6/DqfSXHjDjuA8oYfdNOvUHE1ZJc4
	 F2QZGdklPbeKphT0MOn0hOug7Mxy34yMHV7+5yaoA+sXojYMWR9yjXpMgY0aGdDpbu
	 358FtgGrCtfdR5GqWI7NvdhsJHStQJMCocRLq4Iw=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 437E530CD6E3;
	Mon, 20 Oct 2025 18:12:56 +0300 (MSK)
From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH net] Bluetooth: MGMT: Fix OOB access in
 parse_adv_monitor_pattern()
Thread-Topic: [PATCH net] Bluetooth: MGMT: Fix OOB access in
 parse_adv_monitor_pattern()
Thread-Index: AQHcQdQDH+4einvhvkqzls1fGNBfVA==
Date: Mon, 20 Oct 2025 15:12:55 +0000
Message-ID: <20251020151255.1807712-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2025/10/20 14:26:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/10/20 14:44:00 #27798716
X-KLMS-AntiVirus-Status: Clean, skipped

In the parse_adv_monitor_pattern() function, the value of
the 'length' variable is currently limited to HCI_MAX_EXT_AD_LENGTH(251).
The size of the 'value' array in the mgmt_adv_pattern structure is 31.
If the value of 'pattern[i].length' is set in the user space
and exceeds 31, the 'patterns[i].value' array can be accessed
out of bound when copied.

Increasing the size of the 'value' array in
the 'mgmt_adv_pattern' structure will break the userspace.
Considering this, and to avoid OOB access revert the limits for 'offset'
and 'length' back to the value of HCI_MAX_AD_LENGTH.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Fixes: db08722fc7d4 ("Bluetooth: hci_core: Fix missing instances using HCI_=
MAX_AD_LENGTH")
Cc: stable@vger.kernel.org
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
 include/net/bluetooth/mgmt.h | 2 +-
 net/bluetooth/mgmt.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 74edea06985b..4b07ce6dfd69 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -780,7 +780,7 @@ struct mgmt_adv_pattern {
 	__u8 ad_type;
 	__u8 offset;
 	__u8 length;
-	__u8 value[31];
+	__u8 value[HCI_MAX_AD_LENGTH];
 } __packed;
=20
 #define MGMT_OP_ADD_ADV_PATTERNS_MONITOR	0x0052
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a3d16eece0d2..500033b70a96 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5391,9 +5391,9 @@ static u8 parse_adv_monitor_pattern(struct adv_monito=
r *m, u8 pattern_count,
 	for (i =3D 0; i < pattern_count; i++) {
 		offset =3D patterns[i].offset;
 		length =3D patterns[i].length;
-		if (offset >=3D HCI_MAX_EXT_AD_LENGTH ||
-		    length > HCI_MAX_EXT_AD_LENGTH ||
-		    (offset + length) > HCI_MAX_EXT_AD_LENGTH)
+		if (offset >=3D HCI_MAX_AD_LENGTH ||
+		    length > HCI_MAX_AD_LENGTH ||
+		    (offset + length) > HCI_MAX_AD_LENGTH)
 			return MGMT_STATUS_INVALID_PARAMS;
=20
 		p =3D kmalloc(sizeof(*p), GFP_KERNEL);
--=20
2.39.5

