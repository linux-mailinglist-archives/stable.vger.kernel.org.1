Return-Path: <stable+bounces-245316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPV3EMslAmqEoQEAu9opvQ
	(envelope-from <stable+bounces-245316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 20:54:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6512514B6F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 20:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C2013031CCD
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530CD4C9546;
	Mon, 11 May 2026 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfIv0eZQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D04C900F
	for <stable@vger.kernel.org>; Mon, 11 May 2026 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525616; cv=none; b=tlviqeLngPxgiaV7y7PeUd0fPrxsIIdr09yCq+fNTiIt+qYX4AUK6x9C69QASoP5NN1UV9XDjNKNfVJzX4ioCdm+ucPTfQYbPhik5ijpwkHBdmw1en+UJUqbH7LaJl3Phbmn1xxt4FiEUsDawCBY/IPi2ATqqgI5dONbmWC7y50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525616; c=relaxed/simple;
	bh=1nRE8JOy2JLcbHw8X50R2pYMpRN0QI4DGUktvzLnKfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKSpmW3V1LT4xf/5fe+8TOzQox6ASVOBbfPimD8Tx+I4zUWxwCq/flgGUDq4JIvfqZsW8O4jLgQ/NrM1Ww5lbYJQSq4PKBdvy83wOSDJXFQ8zutmx5a2emqiJ9U7mo8JjdPCpDr3coPPEjMrxmXq6UXV8nr4WOHgrQwsfH4SeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfIv0eZQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so8463382a12.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 11:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778525613; x=1779130413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDY9dxT2zvqgp8lt00rKuBPK9aYcf3HfzHToSBInp3M=;
        b=EfIv0eZQluP4JXHfurul6SuqEBQjAPGhyghm0hs9Ue5BSJxisDcbuK168uOdpmpOaH
         ePrW6f5rkA0GEFFBuiKQzE2W8287ryluDYe4iXjjmp7CdvhETZ9Kvcb8oa/iSb1UrhZC
         8IEs16qRUgY5oSkAjSlfUGsHBkJ9gdtJxYSXsPYyDn+Lh5t8H3UNeRX48/NQVCZoRukG
         Po4ZEKGYE7nWwS4ZS0NXbymOQ1A2e44XBf332ZQRgEpMCsmQXudkwnj5s1A235pRnSBB
         /ax8L2/wYjikBCeIVGeaO8jEWlgJwswiBHbrXxUx85b2vVXWdYLAYOEYpVpXrmGcaBbT
         4MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525613; x=1779130413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IDY9dxT2zvqgp8lt00rKuBPK9aYcf3HfzHToSBInp3M=;
        b=Z1s4EtxQHZYV6DyOpD61HA8cfrnOklGfqXQHIhb8FXJOJ89Uto1kfLdLzb6+O3Kevs
         NQfY2bUcK0L1hVjycZDG/i8UjHCvpDqT1ZpI4qxgsEkOjOJnyCIKbAWw6vjZyDAzY0eS
         smft14ZX3wtwoK1AFMNMgi4skIhe755a8TRF2jNDOkX2k20zUWY0lTabr16M1ENgFzT4
         727wnGKnxL17esxA0LykvFfq6UaHt9V738bQifwX75k1wmDyvGaM5+CCiBSjDG7zn4sQ
         VQnzXHQn5z4QwPk8i7oOpejhZ0sg9maP016pqu+Tg/otyXd6rrKNo01d1Ug91RnD5IZ6
         09MQ==
X-Forwarded-Encrypted: i=1; AFNElJ+UOezzQpNs3V3gxjVzaLucG5isKdTsoKcqRrtccBxv0MUvHhJxxzFXdPp2DvyncKbaHGfOjuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTcz1SUS+losZztz4Ozhy34FWVHGxu0QKmeIvS4XZjdoyuoQLN
	7YCjL0HpeD44S0RAiLgy0aABLYcl5EMWHZPtQ8IItK5hPda8qTrYT6Tr
X-Gm-Gg: Acq92OEJ7ixkVLvuw0T9eVVyUG9rlYGrfIygS5EPHR1EolbO1RYJgHHM5qt0fuookYM
	P3CaIfq/Sxq1XWWyY/YzTb0QNtwWDbWUKDPGA8X6OYbdz5m4vik23lX7klzwTcyPY5n1yJf89jM
	FTCxFO9u4iWPHA8P+HZdq0tY1IMgzXalBwb8BeyNv34xLeQSnUYcy3BH+Vd7t0RNU1SPmYWdZxu
	uOddemSVBGDH8fc8juJBJgDEHRopMvSSBUNC7tvYET/7Fikd1WNSmNSj/2dKmAB3bnkQVSyND0e
	hp6Lbuafju8GEZlQFY8n6PpMr+Tqjq7f7hCKWHMzByp4HjXahINng0TL36sctDmjau465LNaU8E
	MCFPHCdqjlIlzP6nAaSfFMK9PqXYlur9sTH/e/paiRqOmHejRYTPuaM0Nqv1mnOFKbzMdFRtAkC
	6sXVHn9QDNDR8EbavUQ6Ll5iEf8JqH/Azdp7VDPHy/rUzl+jsI2RUw4SdztH/9i/VrMXBgaBNl6
	LvsdfDNotw4OLbh16Mf9hXAIsN8KgDWvdAni5LWgwilF6+zC02EyJhig/KKYlQacPwA5KZg1iTi
	3Spbv3mO9UU=
X-Received: by 2002:a17:907:d28:b0:bd1:fe0f:1c93 with SMTP id a640c23a62f3a-bd1fe0f2210mr131603366b.6.1778525612748;
        Mon, 11 May 2026 11:53:32 -0700 (PDT)
Received: from ahossu.localdomain ([2a02:a420:22d2:4061:8cc7:b361:391f:af99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcd7bf48623sm310803366b.48.2026.05.11.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:53:32 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 1/1] staging: rtl8723bs: fix missing frame length checks in OnAuth()
Date: Mon, 11 May 2026 20:53:14 +0200
Message-ID: <20260511185314.1625375-2-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511185314.1625375-1-hossu.alexandru@gmail.com>
References: <20260511185314.1625375-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C6512514B6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245316-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Three out-of-bounds read paths caused by missing frame length guards in
the AP-mode authentication handler OnAuth():

1. OnAuth() reads GetAddr2Ptr(pframe) without verifying the frame is at
   least WLAN_HDR_A3_LEN bytes long.

   The first operation on pframe after the AP-state guard is
   GetAddr2Ptr(pframe), which reads 6 bytes at offset 10..15 (Addr2).
   If the received frame is shorter than WLAN_HDR_A3_LEN (24 bytes),
   this reads past the end of the frame buffer.  Add:
     if (len < WLAN_HDR_A3_LEN) return _FAIL;

   Using return _FAIL rather than goto auth_fail: the auth_fail block
   calls memcpy(pstat->hwaddr, sa, ETH_ALEN) to build a rejection
   frame, but sa has not been set at this point.

2. OnAuth() reads iv[3] inside the GetPrivacy() branch without checking
   the frame is long enough to contain the IV.

   When the Privacy bit is set, the code sets iv = pframe + WLAN_HDR_A3_LEN
   and immediately reads iv[3] to extract the key index.  If the frame is
   shorter than WLAN_HDR_A3_LEN + 4 bytes, this reads past the frame
   buffer.  Add:
     if (len < WLAN_HDR_A3_LEN + 4) return _FAIL;

   Using return _FAIL: pstat has not been looked up yet and status is
   uninitialised, so goto auth_fail would send a malformed rejection frame.

3. OnAuth() reads the algorithm and sequence fields at pframe +
   WLAN_HDR_A3_LEN + offset + {0,2} without verifying those offsets
   are within the frame.

   offset is 0 for open-system and 4 for WEP-encapsulated frames.  The
   reads at offset+0 and offset+2 are both 2-byte, so the last byte
   accessed is at WLAN_HDR_A3_LEN + offset + 3.  Add:
     if (len < WLAN_HDR_A3_LEN + offset + 4) goto auth_fail;

   At this point sa is valid and pstat is NULL, so goto auth_fail is safe.
   WLAN_STATUS_UNSPECIFIED_FAILURE is set first to avoid sending a garbage
   rejection status code.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v8:
  - Change if (len < WLAN_HDR_A3_LEN) from goto auth_fail to return _FAIL:
    sa is uninitialised at that point and auth_fail dereferences it via
    memcpy(pstat->hwaddr, sa, ETH_ALEN) to build the rejection frame
    (sashiko review of v7).
  - Add if (len < WLAN_HDR_A3_LEN + 4) return _FAIL; before iv[3] access
    in the GetPrivacy() branch: the missing length guard was a new OOB
    read path not caught in any earlier version (sashiko review of v7).
  - Set status = WLAN_STATUS_UNSPECIFIED_FAILURE before the
    if (len < WLAN_HDR_A3_LEN + offset + 4) goto auth_fail check to avoid
    sending an uninitialised status code in the rejection frame.

Changes in v7:
  - Add frame length checks for OnAuth(): guard before GetAddr2Ptr
    (len < WLAN_HDR_A3_LEN) and guard before algorithm/seq reads
    (len < WLAN_HDR_A3_LEN + offset + 4).
  - Correct commit message: rtw_get_ie() uses signed int limit and
    returns NULL when limit < 2, so the prior unsigned-underflow claim
    was incorrect (sashiko review of v6).

Changes in v6:
  - Add frame length checks for OnAuthClient(): guard before get_da()
    and guard before seq/status reads.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 68ce422305ed..c3f2d4e5f6a7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -687,6 +687,9 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
 		return _FAIL;
 
+	if (len < WLAN_HDR_A3_LEN)
+		return _FAIL;
+
 	sa = GetAddr2Ptr(pframe);
 
 	auth_mode = psecuritypriv->dot11AuthAlgrthm;
@@ -698,6 +701,9 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 		prxattrib->hdrlen = WLAN_HDR_A3_LEN;
 		prxattrib->encrypt = _WEP40_;
 
+		if (len < WLAN_HDR_A3_LEN + 4)
+			return _FAIL;
+
 		iv = pframe+prxattrib->hdrlen;
 		prxattrib->key_index = ((iv[3]>>6)&0x3);
 
@@ -709,6 +715,11 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 		offset = 4;
 	}
 
+	if (len < WLAN_HDR_A3_LEN + offset + 4) {
+		status = WLAN_STATUS_UNSPECIFIED_FAILURE;
+		goto auth_fail;
+	}
+
 	algorithm = le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset));
 	seq	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 2));
 
--
2.53.0

