Return-Path: <stable+bounces-244223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLymMlYn+mmHKQMAu9opvQ
	(envelope-from <stable+bounces-244223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:22:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC954D1F84
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5C713028EBA
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687C14A2E1D;
	Tue,  5 May 2026 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLwGriAS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904C48BD3C
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001747; cv=none; b=tkTa2qdUMr874Bc5uSWUHepb+bPmldjG0OQdj4eOVp8kXwsRrGjTCqtDSUBNPVLACDMwi7tG1eDBBzPQa8Kmv13hEjzv7opgRkXCCpHLV4V4c7XBPaA/9lHwfopVUeTWt3v/KLqWVrKpiMf7DoU7UL3a9cB6VLRXVduQr9nENQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001747; c=relaxed/simple;
	bh=+8CNpi9Emk9pvFDYp7sMDYqpu9yK+ln5XoO9066B0Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hj1bm6kZbeu3aEsQsTz8/n87PKz3OAEFFOQ06gRDc8n29RERu7lg6Q9vQzvgTLJQgnU0yV+cw07DgMvlPI+1l0zJZbXgrtxoeJSI8fygHT5KNamhvBIpFPKuPW6DbEuTy6M3pSEjMHO0LjMd/uLSoIOIsK0lIid5f2OPQF3uzx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLwGriAS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso2593207f8f.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778001744; x=1778606544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mRnb7VtjjWLO9Am+98zCG8vyA2Azd5IwKeJ7qO7zuQ=;
        b=hLwGriASMVr9tae10bdZbvVF7jCZnxzaxH6rcQ/X9xUcJZvrZO9vHQF5rHICodkGO/
         Dtpqo/8Jr6WauQ0B/OnybWuc2Gr+h66cfQDMK+tSOmHLv3GGcxWvuRCoe7+BJiRfYUQX
         c5By7jMFGBoQ3x6YBp5TknFmIVIGnSuMCGcZicAIJMqvgwFGdhwx8x+3LTB3WXdV/wg0
         uEwNc1Z3V/LanzXk6qAn9pitcdbHHk7bLujgWUBAJMjzxAM/FG9c5eaRaLLLtw/+m6vI
         SPU/7jN7fxk8wjjCXSHes3HyQ4T4hTwnJk6Op6XD9AsoBMdDsGyYR+3hHnMXqb6930XH
         0/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778001744; x=1778606544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+mRnb7VtjjWLO9Am+98zCG8vyA2Azd5IwKeJ7qO7zuQ=;
        b=EKCHbC3hPekWaTxGoT/iPtbhOlWiTyowkkS+/MeTTjPvO+IG4bV8INP3Mf0WPdCThr
         r9W1IW6Heh7ck+yMsmF+9nM9ZQT4jJfyoy79XR7YjqVZsdm847cOFBdj0nF9xdsEGcJX
         j41CtCVwG58i7iwmLoWy3zIeYO6//BZYtedHv0ZN7UqXVvfcA1VopmsQTwPNcghE03vn
         Mw+ScjjE0YU9e2Oob2ZpiCws8aVcG4ziVTqsOyjYAmMQyKHI04O63BY1a1ChzeFaS7C+
         G94c1KEYqEN03l6bdZg+xLyTx67/kqjCx3h6M2uf0HhbQMYZmDvDCTI85+c6hrwn9kTk
         iTVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zG/P/ID0moDhPbFBm5FKnrTmaeVKVssMvaBQ4uDJZ2FqR2iNtJn4aV9IV3ZiDiFWtNirzJcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyswV+bV1mszusD+hl84rxzkpV4oVrcsVbvNcEYlZWvK+UWaEmx
	Ckv08i7o5X0dTLRWsm+vHtDrHDCUE+Hy8D8dTie5XV0KCdGTPROdNhV7
X-Gm-Gg: AeBDietEPPSgiun8GR8fPOiovV6TCz+aCJdznSTIjVF5E0WD1IM1Txcs5oQKn86GvvK
	V9OVVqzSkqxYf9Ki+KQtUQ+qfC20R1QrroHKM9++ffVQiO+xzEUpcnvV97DJHWnQ9G9rKDwYcRg
	OqHWS9iB50qaASGI4UdcGVfGGAXgC7zz2LjYFM94hB1K67f/f8j9B67mhwMD0sxM9iKyrqR5shT
	r04ZKKgiWJEa8wJCqA2ECx2e7/wVff2P2Q/L74AE2x2NXrHmoARKTl54MDL7ejJmuPJuFNkdc9j
	P5/uaNdHvxqH18xDVfAL8S04V7d00/G5a8n57TXdsmwnJ8CLrK4i0kL5tTbpWGiwv4ehkDbpbhZ
	M4i6afHJvRhl9J5rvDappIRYj6fgQ1gnspHbH7b115YIvCMR34Jq+s1kE/wGCq0tJtOnRFadn73
	XFQA6MvicuCYVR7by45T3OClP8n2depuMPQtOnk2tEMqlWr+KMKABFFOeekeH+6cAMyEMGjfGAe
	sByH+rz2aecJOeKYp7nbW6tGzymV3dAHurOT2XaIGicitq3b6ICuU7CtYxReLWDOdJKhp8=
X-Received: by 2002:a05:600c:3b17:b0:48a:568f:ae8a with SMTP id 5b1f17b1804b1-48e51e1a870mr2765905e9.8.1778001744152;
        Tue, 05 May 2026 10:22:24 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960902sm6640747f8f.28.2026.05.05.10.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:22:23 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	luka.gejak@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] staging: rtl8723bs: fix OOB write and read in HT_caps_handler()
Date: Tue,  5 May 2026 19:22:13 +0200
Message-ID: <20260505172214.3650398-2-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505172214.3650398-1-hossu.alexandru@gmail.com>
References: <20260428091621.739680-1-hossu.alexandru@gmail.com>
 <20260505172214.3650398-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3DC954D1F84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244223-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

HT_caps_handler() iterates over pIE->length bytes and writes into
HT_caps.u.HT_cap[], a fixed array of sizeof(struct HT_caps_element)
bytes.  pIE->length is a raw u8 from an over-the-air 802.11
Association Response frame and is never validated before the loop.  A
malicious AP can set it to 255, writing up to 229 bytes past the end
of the array into adjacent fields of struct mlme_ext_info.

Additionally, after the loop the function calls three macros that
unconditionally read pIE->data[0] and pIE->data[1]:

  GET_HT_CAPABILITY_ELE_LDPC_CAP(pIE->data)  -- reads data[0], bit 0
  GET_HT_CAPABILITY_ELE_TX_STBC(pIE->data)   -- reads data[0], bit 7
  GET_HT_CAPABILITY_ELE_RX_STBC(pIE->data)   -- reads data[1], bits 0-1

If a malicious AP sends an HT Capabilities IE with pIE->length less
than 2, both bytes the macros need are outside the IE payload,
causing an out-of-bounds read.

Fix both issues:
  - Set HT_caps_enable = 1 first so HT negotiation is not regressed.
  - Return early if pIE->length < 2 to protect the macro reads.
  - Use umin() in the loop to bound the write side.

The parallel HT_info_handler() already guards against oversized IEs.
This patch applies the same discipline to HT_caps_handler().

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v4:
  - Add pIE->length < 2 guard after HT_caps_enable = 1 to prevent OOB
    reads from GET_HT_CAPABILITY_ELE_LDPC_CAP/TX_STBC/RX_STBC macros
    that access pIE->data[0] and pIE->data[1] unconditionally.
    Caught by sashiko review of v3.
  - Use umin() in the loop bound to cap writes at
    sizeof(HT_caps.u.HT_cap) without bypassing HT_caps_enable.

Changes in v3:
  - Switch from min_t() to umin() (Dan Carpenter).
  - Keep truncation approach rather than early return so HT_caps_enable
    is always set before the length check (Luka Gejak, AI review).

Changes in v2:
  - Replace early return before HT_caps_enable = 1 with umin()
    truncation so HT mode is not disabled for APs with oversized IEs.

 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 6a7c09db4cd9..98aa50357e96 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -936,7 +936,11 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 	pmlmeinfo->HT_caps_enable = 1;
 
-	for (i = 0; i < (pIE->length); i++) {
+	if (pIE->length < 2)
+		return;
+
+	for (i = 0; i < umin(pIE->length,
+			     sizeof(pmlmeinfo->HT_caps.u.HT_cap)); i++) {
 		if (i != 2) {
 			/* Commented by Albert 2010/07/12 */
 			/* Got the endian issue here. */
-- 
2.53.0


