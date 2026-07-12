Return-Path: <stable+bounces-273496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XRi6NyuVU2okcAMAu9opvQ
	(envelope-from <stable+bounces-273496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 15:22:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A946744C75
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 15:22:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lwGd66Lo;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273496-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273496-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8E4C30041EA
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 13:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8372E56A;
	Sun, 12 Jul 2026 13:22:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227B41A6807
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 13:22:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783862569; cv=none; b=C2Sl0VlL2pT3NvnAdZCmzeGBKKy3MU1AW9BYWBg4TuxYeeonuSChVJGxlNUEXNJ0ztWuRG47CiJHRAL/1AkBKiVqiFIX+ZGX1MaC+O+s8ypXZ19TPMRCy+ZXpKsWaUjbhR7QPZI15ijNAt0P2zuV3FaA2TfwvGpV2LzLzeTgvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783862569; c=relaxed/simple;
	bh=xAwWrn135mVWGuRJMRuBayOCkroezRocDlu6CZpN8Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipNsiswRD1xbTrzq8GxjDS/fKloSNEimSYzN1kDKn/PxfTZbSwXLTqNvnQXoJXWRnb1ED8xnqqcTemdLf1k192561dKP6GZXholJoIWVm3mK3QucbT6scaX51oLXshn1NuiHOSCKUWbxuvxJs4bXo7ZetEPofX25kUYExDpwWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwGd66Lo; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493f0ae9572so8584345e9.3
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783862566; x=1784467366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f+YFzVviG3DzxMqpa6xeKwhT6SuFAN+/OdOMSnwiZgU=;
        b=lwGd66LoMamqnIsdxcCBSbsxNB6gIYf3m3vmJmXe/TYUwBmVoTkA1QZ6iD/LTm6BS9
         9gM/tmdCkjAHHHlskU3IKfeMCIrvuQ9m1oeqWN25I4G+6oPUw3Y1BUOPgD0EUX790wbK
         eqAxQVrjbNaUIopyCcrBK2vi46BeBuSaBLCEJpkBSbMXQVE9iJDOPUt1+V4SBfuMZX4o
         wQgDBdsE7OE9mrQCxt0S6f7kA47bhI6UU2tzxtNa6e0solnlmWpjRWk9urmamJVgPDOt
         PdFtLOu9YVjSPYnlcZ0GJKUJ4U0zHxLQvyjTvpMUOwPD5D3H/eKTXSEe6qKstRkHuCrJ
         kAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783862566; x=1784467366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+YFzVviG3DzxMqpa6xeKwhT6SuFAN+/OdOMSnwiZgU=;
        b=qqcI9CHTqKz5qCXcTks2lBz1x1gHS/1J5MO3FZ05CByjGFrzfmqrD9SbiVkXTAPgde
         3386Rxi3UCl9V2/JAN96AQnCepAQ2uq6jZ+9JHznfbSFzwvkjZeabwg7vo2mXRAZLs8l
         USOSTXnmAs5HXtNOklekDLdoSVWRHdyJqAswKeacXnVhyt4vl2yt+mLo2W+zgn39wsJH
         2EJ+01L4Y4RiOaJoO+s9QJUU27wCwkpVjsuAe4ts4mikMtSYjor8olX7eDVouIfQqpcb
         4upkw2RS2Zj0Zk7i9xa85VrSVMpicl+G0H6Wioz+lZaPCbB52x5VhvMBpvZops//0xPv
         wcuw==
X-Forwarded-Encrypted: i=1; AHgh+RrPB4aPhhTsRF5IdDDGSGObcxIkE5X3MnUNxYwbryevDnRGBruMnbiVN1j+dJUmRTX0egeOQL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1rRP8hAWzQjyMySvxIgVrKxia/3MePhqxNMzXIKHTm6MFh7Va
	70yIxQThlfbkYE+e3DhBt1YLmYmgqPZQoUQPGnaGgu17OzfhfGx98V5o
X-Gm-Gg: AfdE7ckW9wX8KpwAyNdJdOaaD5o5Ie1EQ5CzZuwMjDMEasLZcvNwir6A7ZCK/VVDeIY
	3iTjnsqd1FX/prFuELNE6UshczWrdYaa74WfXpj4HBgRKX5T6B082MHnQ/HLCeXrr5oMmcCVf+6
	Kx+30BJnuSBWcH2uPyUd2a7fi6tyf4RTnqAm3uXkzyDsV+ubwcl8P2PIPlVIcHjKaVCFe0PujwF
	z54Quse6QrpvyvnHenWXB01t1vSfyP+RQa5ipKEGP7ITN8aHc08sbMTWabXZxV/SJxtnVQ2pYAb
	uErzN7G1q6b6h399vvs2JuLZp2YzT5/cnwhIKupPVRxlCPQDgDLQJd2EXcn3zxo9KeN1j8C0lZf
	pfv4SFYL6kp2Ua5k9jPM7nXzfb5tsLSsEyWJVwqrYvynjHHUHFkRwpP+v0naxnLpP+euN35cnRs
	5oz8/Io/wUUryuKGASbCGOOHkAGZhhQHcocy9br6hTU9M8iF4gdj7Gc8eE/xQJTc1Hv3qTMb58
X-Received: by 2002:a05:600c:8b52:b0:492:53e8:3bc1 with SMTP id 5b1f17b1804b1-493f87f3cffmr58484955e9.17.1783862566268;
        Sun, 12 Jul 2026 06:22:46 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm180883955e9.13.2026.07.12.06.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 06:22:45 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	aleksandr.loktionov@intel.com,
	advoretsky@gmail.com,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net] igc: remove napi_synchronize() in igc_down()
Date: Sun, 12 Jul 2026 14:22:42 +0100
Message-ID: <20260712132242.223254-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273496-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:maciej.fijalkowski@intel.com,m:aleksandr.loktionov@intel.com,m:advoretsky@gmail.com,m:stable@vger.kernel.org,m:devnexen@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A946744C75

When an AF_XDP zero-copy application is killed abruptly, the XSK pool is
torn down but NAPI keeps polling. igc_clean_rx_irq_zc() then returns the
full budget on every poll, so napi_complete_done() never clears
NAPI_STATE_SCHED.

igc_down() calls napi_synchronize() before napi_disable(), so it spins
forever waiting for that bit and the interface never goes down. Drop the
napi_synchronize() and let napi_disable() do the job -- it sets
NAPI_STATE_DISABLE, which forces the stuck poll to complete. Reorder it
ahead of igc_set_queue_napi() so the NAPI mapping is cleared only after
polling has stopped, matching the recent igb fix b1e067240379.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2c9e2dfd8499..b3883a5a7d7a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5352,9 +5352,8 @@ void igc_down(struct igc_adapter *adapter)
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
-			napi_synchronize(&adapter->q_vector[i]->napi);
-			igc_set_queue_napi(adapter, i, NULL);
 			napi_disable(&adapter->q_vector[i]->napi);
+			igc_set_queue_napi(adapter, i, NULL);
 		}
 	}
 
-- 
2.53.0


