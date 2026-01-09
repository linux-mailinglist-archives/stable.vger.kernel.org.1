Return-Path: <stable+bounces-206447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0786BD08CA1
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 12:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8310D3014DF9
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 10:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6A33B6CB;
	Fri,  9 Jan 2026 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBEd2Nh1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C233ADAB
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956343; cv=none; b=eFuv2og1+v+0E8UDK3FcWHl0R+X3Rf9zCcrU8UB67muhr1rVdm3hqAmmDHCbHd1BJNHa+mJwYsS6mxEndIKVBsnNVTasjqfW1nULledvT7LohS4bVo6XBaB9d62z0ymEf5WERleakNDDr2/AS1+Idw3GEaf4/ik7t6FqDKlSCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956343; c=relaxed/simple;
	bh=FsB/UShQenj2IHUWQWTEz5tm6M0LQG9gXNTm4Gzpoe0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kXEl6RS+5Wheq8bsi3sDcJtqSwBEpUxJR1seFgST/7AEhpjNtMAoC4kVISTK1g8kVlalyyXj7dHGYWAdt29p9ra5fIWUV5EczSFxJkZ3G/yLLRB8eqMmX69ZOfv3PoS95sU3+c7mf1joSkoTJYR9Ky8AVYJI6OMGQFPa1Dk0Paw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBEd2Nh1; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-432a9ef3d86so2157627f8f.2
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 02:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767956339; x=1768561139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YPfvCSrnVo5Qo9I5d2+17ibegJrSwKckNw0me69pYEM=;
        b=fBEd2Nh1apJLI/RaI4uX0QYOAc7Ec9a21ZiPVGp6FKR0KFzklQ4IRDz8PeDxWzVHE0
         LQSKelZiqVPnf2TN+KfWhp5Q3oYyMl1a8VR0Hsa57vv+LRrSCCSUeQxYjgRpnCrXTslS
         +ZeyGoVFJbwq0CJ+Ya/1pZhg7MS06Xf6kD6PWCgm3CQGuHVCu0vWrkR67kwPI81nbaXK
         0Ogg3dquBLy40d47SUGZ2aFfuLrzsjbNzWzvvNMUPPL+hpUn4Xwdra4WvDfTf663jgrH
         l1fvyu66HG7O87C+gMXcj+xpRdxRFZqCjr7XHelIB8ckYO/5ExlfiRxqtdO9QzmWuffw
         gqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767956339; x=1768561139;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPfvCSrnVo5Qo9I5d2+17ibegJrSwKckNw0me69pYEM=;
        b=nRk8vVtLpC3bVJM/KWclDlbg/NPon/xpaWx4WnK5lY7D0/jlunaPDNNvmjlQkUWAVT
         +RLQNptBl4x0i0VxpR1t+PQ/d13mV+CRbyRxSPzEzS9NUCFuxBejG55tJPQ4UL9kvy16
         ksJkds/M9OuTNXAIAFafbr+izV5XuxcADJYOc9UXf/dCmmmNksonwy+IGpY+tlz2ZBkQ
         NRa812tqCoAhyCPRRLxDUASbE1dUxOQn+gURft33cDnDdfRFNdJjLGoxkMf6NaxcTxwW
         d0LaJDJC6jUAsq4PRbIMM7Nwbzkf1FnGIxH7yM8TVKOOH12CPSlAmSRfeSUpu/8B0+SB
         smbA==
X-Forwarded-Encrypted: i=1; AJvYcCXEN3scQt7DPq0t4+lyJ3L5JS6MnHphutPRckVvQaZDjH30/h3RZyo0HxFiH0yJS3shMc5vmLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySWS0uD8R3wrx1LaYdbDwy+xx1oJcsGU4ZXcNCPILeuTtVMplm
	rpu8yQ17/hHkMHaMEJ/b1EgAMEblnNG8Ex24RlwMcXYkQEGVRXMkH4rYaJGH0AVs0hAryz23cUZ
	ApYBADw==
X-Google-Smtp-Source: AGHT+IGSYpvKO504qucf1dr1WtcYvp93s7OznpFe+3OdHebT+0JCTByeUwx/tII4lBfL6OEG2ecsRR+hu7E=
X-Received: from wrbew8.prod.google.com ([2002:a05:6000:2408:b0:432:db31:e53c])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c4a5:b0:477:1ae1:fa5d
 with SMTP id 5b1f17b1804b1-47d84b32f5amr96596325e9.20.1767956339253; Fri, 09
 Jan 2026 02:58:59 -0800 (PST)
Date: Fri,  9 Jan 2026 11:58:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260109105807.3141618-2-gnoack@google.com>
Subject: [PATCH] HID: prodikeys: Check presence of pm->input_ep82
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, stable@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fake USB devices can send their own report descriptors for which the
input_mapping() hook does not get called.  In this case, pm->input_ep82 sta=
ys
NULL, which leads to a crash later.

This does not happen with the real device, but can be provoked by imposing =
as
one.

Cc: stable@vger.kernel.org
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 drivers/hid/hid-prodikeys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 74bddb2c3e82..6e413df38358 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -378,6 +378,10 @@ static int pcmidi_handle_report4(struct pcmidi_snd *pm=
, u8 *data)
 	bit_mask =3D (bit_mask << 8) | data[2];
 	bit_mask =3D (bit_mask << 8) | data[3];
=20
+	/* robustness in case input_mapping hook does not get called */
+	if (!pm->input_ep82)
+		return 0;
+
 	/* break keys */
 	for (bit_index =3D 0; bit_index < 24; bit_index++) {
 		if (!((0x01 << bit_index) & bit_mask)) {
--=20
2.52.0.457.g6b5491de43-goog


