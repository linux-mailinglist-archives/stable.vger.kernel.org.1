Return-Path: <stable+bounces-244270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMDZFb1d+mnmNgMAu9opvQ
	(envelope-from <stable+bounces-244270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 23:14:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3F04D3D5E
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 23:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 870333055DF4
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 21:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5B048B362;
	Tue,  5 May 2026 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fb4l/Sts"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE614949E7
	for <stable@vger.kernel.org>; Tue,  5 May 2026 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778015609; cv=none; b=Bv2oyQ77ufHjZfMWn+l0poNBMAs90FiHhmUamILAmHEhPbyCuQo9Dv1YxCQdT7nPO0mlqdjXCBVskkTRO/QrGI6s8938WwvLci33lOp63JVjWRwjeF+HXQyAkthEI1MCyHohh+m4Ud1sS6TFz4Ci5fdqV7LvnuHIBmBkHKmL0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778015609; c=relaxed/simple;
	bh=yeZk9yOeTk35adoPsJ72JURTsAZ9MYmWZqZL5l4j7yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMp1YyI6kBOqhVzayrjFjkT/qyBhhPt6MClukcZAUq5jMHz0JGxbTUXZairFsLmG0vFYWTUKxjhfp1f8r0L11c5dQGG7O+JONkymVMwjZUp5BHGEHPdCf3O437uRXJRKe/wEs3gxQ7MLnH2C/Y3g6YfohWT331UnK2s5z1vPIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fb4l/Sts; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so89430915e9.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778015607; x=1778620407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D1fo51a+Fqwvih6rAM0AOM8n9BMVTDWYpVR0qTGxW4=;
        b=fb4l/StslmsqnVs/TBjJhheYSqqJc+SMl8VCMXRwLW2mnv608bLdILWLhHoLN3iZ9W
         2XjQmXQphTMct01lV2KsFp9wOEf8IcSSjBExdtbtywDKbVE9F6EZevUSK6/A3YRFd5CD
         Z3LaogPUlFIDEfHGSHrW6GVsU7XHAk+ZLzoiH2K8yGU5XvZAX5p2XqvZCifH5uf6n0xK
         rW4A3/zApDJVQvuqyT8WgdU8f54duL47p2DClyTluldLnW/k+Kl/75FIZg4k0Dv8/6lo
         kFGagudYkjtM00Fa0pWaAfuMWH5Az+Sp6m1RsOdagHCDReI6wpNfe+LG6EFdDQ7tHCuc
         Ndzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778015607; x=1778620407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3D1fo51a+Fqwvih6rAM0AOM8n9BMVTDWYpVR0qTGxW4=;
        b=etBPf4x6e4noCyxrRkUy9OFnWHdfBlkDPaqW1GcZXwWEmJXwpkCh1+FJ/i534jUTzA
         VjzM/kUUBVeUO2BS4MN5hFXPn8X09RwEEmoLpEVA8GH2vuQh8aWTHu35TKZkqVDmqhif
         RPahCs8cTgGXV9sF9t8I8mkoJ02Bm1F+LbZCBx14KKkJV9LZAcOHQbPc8pK8D6bfdLbb
         DLmqCyWcedSfmz5Aq6DUTZpgVzyhNWyysPz4fiiQoj7sVTA8ijog8224cIE1kibFZCmS
         4KT9l6veT8rQU6SmzMGu5ZDy8KGHg0eRsFsAfMES3eJBE/R7Z2Z6cr5DSoyEOAI3U3qn
         M1dg==
X-Forwarded-Encrypted: i=1; AFNElJ/1W3AEeCI5nTg4994CRtGW4tftia/lusWLs9xLFpRmEMVmSLa/rkzojv7bTntchZHQKhYu63k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5/Kzwvjai901boheReflTnxE1a5o+nkBlw8kESNcCRUzV5da
	kt5iKdoATrbV5JlOdWQJzlaZiNiCbsbHUvfllbkEZq4HhyZoDhNcTO1V
X-Gm-Gg: AeBDieuz5bYvLuxhu/hbv+80kazDbuMJOO+h89n5xWMEF9t6866Lr9uU79xftyZUgv/
	s6GwRMsQDA79X46FnY5Jzz0YYdmbviZ1l7FrOPOtbqncYz0YaUB+9jFIyGhJ/ktPgjL9ZEBTrtu
	5Es5Vd7V3M0TkYxR+2STSsz0iV5LeyCXQGa3aL2ZcKdpZgo+1Q1PtQID48cYTOFIP57jHuhP0lq
	q1RaI0D4nVjgbrSkBUZPndIRtH2cQ1sHFiQ/cvQxew6FmBhb5HGfNsrl1QtKgs6M6iWzKMtcpGx
	9gpuMHNKOkRB8K7c9Q9nKWtTlrDRLcXA8WqYyasQ3/6/BHp7tHZeyb5L0roQym4M6HRUnnDzqg2
	GGbRBuGWHJM3/JHSBV7TnE5+2cpgTLNWtLAheh74eYE/3JenWZvKwjoHnve+SiwGfAywmut4vlW
	b/bHVpWid7WgWSnyxbM8NeqIeEeOOUU9EuIDaz+aApFE7vXtvErHTysSmiHc/Tb8DN6Axpys0s0
	Go/6EO38nj9VzoHHfxQrLydjoNP28qzv0/NEYX5GF5ffrQUoWLLBRmiX2GERcJoPSUYXzI=
X-Received: by 2002:a05:600c:b8a:b0:48a:5574:3a48 with SMTP id 5b1f17b1804b1-48e51f32bf7mr12038625e9.16.1778015606400;
        Tue, 05 May 2026 14:13:26 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb6fffcsm403400045e9.4.2026.05.05.14.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 14:13:25 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: error27@gmail.com,
	stable@vger.kernel.org,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: [PATCH v7 2/2] staging: rtl8723bs: fix missing frame length checks in OnAuth() and OnAuthClient()
Date: Tue,  5 May 2026 23:13:16 +0200
Message-ID: <20260505211316.3837020-3-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505211316.3837020-1-hossu.alexandru@gmail.com>
References: <2026050453-scorer-rebate-3898@gregkh>
 <20260505211316.3837020-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CC3F04D3D5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244270-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linux.dev,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Four out-of-bounds read paths caused by missing frame length guards:

1. OnAuth() reads GetAddr2Ptr (pframe + 10) without verifying the frame
   is at least WLAN_HDR_A3_LEN bytes long.

   The first operation on pframe after the AP-state guard is
   GetAddr2Ptr(pframe), which reads 6 bytes at offset 10..15 (Addr2).
   If the received frame is shorter than WLAN_HDR_A3_LEN (24 bytes),
   this reads past the end of the frame buffer.  Add:
     if (len < WLAN_HDR_A3_LEN) goto auth_fail;

2. OnAuth() reads the algorithm and sequence fields at pframe +
   WLAN_HDR_A3_LEN + offset + {0,2} without verifying that those
   offsets are within the frame.

   offset is 0 for an open-system frame and 4 for a WEP-encapsulated
   frame.  The reads at offset+0 and offset+2 are both 2-byte, so the
   last byte accessed is at WLAN_HDR_A3_LEN + offset + 3.  A crafted
   short frame causes an out-of-bounds read.  Add:
     if (len < WLAN_HDR_A3_LEN + offset + 4) goto auth_fail;

3. OnAuthClient() calls get_da(pframe) without verifying the frame is
   at least WLAN_HDR_A3_LEN bytes long.

   get_da() inspects the ToDs and FrDs bits in Frame Control (bytes
   0..1) and returns either Addr1 (bytes 4..9) or Addr3 (bytes 16..21).
   A frame shorter than WLAN_HDR_A3_LEN (24 bytes) causes an
   out-of-bounds read in either case.  Add:
     if (pkt_len < WLAN_HDR_A3_LEN) goto authclnt_fail;

4. OnAuthClient() reads the sequence field at pframe + WLAN_HDR_A3_LEN
   + offset + 2 and the status field at offset + 4 without verifying
   those offsets are within the frame.

   offset is 0 for open-system and 4 for WEP.  The status read at
   offset+4 is 2 bytes, so the last byte accessed is at
   WLAN_HDR_A3_LEN + offset + 5.  Add:
     if (pkt_len < WLAN_HDR_A3_LEN + offset + 6) goto authclnt_fail;

Note: a previous version of this patch claimed that the signed/unsigned
mismatch in the rtw_get_ie() limit parameter caused an out-of-bounds
scan when pkt_len < WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_.  This is
incorrect: rtw_get_ie() declares its limit as signed int, so the
wrapped unsigned value is reinterpreted as a large negative number,
which is immediately caught by the if (limit < 2) return NULL; guard
inside rtw_get_ie().  The actual out-of-bounds reads are the four
direct pframe dereferences listed above.

OnAssocRsp() was already fixed by a separate series.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v7:
  - Add frame length checks for OnAuth(): guard before GetAddr2Ptr (len <
    WLAN_HDR_A3_LEN) and guard before algorithm/seq reads (len <
    WLAN_HDR_A3_LEN + offset + 4) (sashiko review of v6).
  - Correct commit message: remove incorrect claim that rtw_get_ie()
    unsigned underflow causes OOB scan; rtw_get_ie() uses signed int
    limit and returns NULL when limit < 2 (sashiko review of v6).

Changes in v6:
  - Add frame length checks for OnAuthClient(): guard before get_da()
    (pkt_len < WLAN_HDR_A3_LEN) and guard before seq/status reads
    (pkt_len < WLAN_HDR_A3_LEN + offset + 6).
  - Correct commit message: OnAssocRsp() was already fixed in a
    separate series.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index dd3c94d314d8..b42eab61d8a8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -687,6 +687,9 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
 		return _FAIL;
 
+	if (len < WLAN_HDR_A3_LEN)
+		goto auth_fail;
+
 	sa = GetAddr2Ptr(pframe);
 
 	auth_mode = psecuritypriv->dot11AuthAlgrthm;
@@ -709,6 +712,9 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 		offset = 4;
 	}
 
+	if (len < WLAN_HDR_A3_LEN + offset + 4)
+		goto auth_fail;
+
 	algorithm = le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset));
 	seq	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 2));
 
@@ -860,6 +866,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 	u8 *pframe = precv_frame->u.hdr.rx_data;
 	uint pkt_len = precv_frame->u.hdr.len;
 
+	if (pkt_len < WLAN_HDR_A3_LEN)
+		goto authclnt_fail;
+
 	/* check A1 matches or not */
 	if (memcmp(myid(&(padapter->eeprompriv)), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
@@ -869,6 +878,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 
 	offset = (GetPrivacy(pframe)) ? 4 : 0;
 
+	if (pkt_len < WLAN_HDR_A3_LEN + offset + 6)
+		goto authclnt_fail;
+
 	seq	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 2));
 	status	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 4));
 
-- 
2.53.0


