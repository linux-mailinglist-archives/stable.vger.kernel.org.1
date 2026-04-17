Return-Path: <stable+bounces-238397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMnIHRSj4Wn9vwAAu9opvQ
	(envelope-from <stable+bounces-238397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:03:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7920C4166DF
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67B4B3025709
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 03:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA6A350D58;
	Fri, 17 Apr 2026 03:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQPx0SZK"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69C34F46F
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776394982; cv=none; b=cma3KaGzo8TRyLatRslzg9aP4FPbWuUwXNfGo5NmzLhYG+F0BEY1eH1XLOZVPGrw6fZM1mGTeIcQ6xbkTAL99u9Z60qlCo2ctT8DvKPe4LN+i+U+N9hRCo1zmmxDRjEWXLjuML2+43usqmBiipzISqPIJ5QuL1VJdA/M9fpug9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776394982; c=relaxed/simple;
	bh=f1VpgAuRFjAB6eoW8D6yTIh5CxnI/XQ9GddAe5a7FWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DP+1O3Z6bwwYrsCRQ70aLTYsi8Bfyo8qF+G5Xw8g3C1rK0saqS7a8rComcCDefTSVyk6xcUaHyuz/YFucDmVzHGdWEEEJungGFHc2S45sE7KbCrW9eBnRBTO7z0ll/0uFdZpywo0/iEqx/lKCKco1Hgsi8SYIW5E3m+76JsEjjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQPx0SZK; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56f6afbd205so140754e0c.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 20:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776394977; x=1776999777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7KTE4O+2+d+2qHtwnX+mTdh1bXJy9Vw8u/PEwC7xVE=;
        b=XQPx0SZK0dU7dwfOkXbfG/w6MxLjjHziFBzOBq5+9zDMo73YENdEUy0qJEIXpuYSuQ
         tUg86kbH2U0wu/xKvnTELdIjT2p4+vR1lO8tJqIYnSrbDc0+GLloRAblrtuf+tYKG9aU
         wOfT5KJiKfoFie66EBH/js0mXvQDM2xEdxUR/JKLTCO2wlnQLo32g59BH1lWJrnh4tCr
         1Binb7spvuI4wuuskRTpXkAQK2fl+Z1AzXeR8HwcD0jGr+Wf2xBW3Njc6zl8MS2GPNtD
         T76i5VQrdyJhK/B7yH3TgzdyAP9HBed5p+fVWXCYinkUgkTShomSerM4Qb0/FBrX+Fla
         SOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776394977; x=1776999777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+7KTE4O+2+d+2qHtwnX+mTdh1bXJy9Vw8u/PEwC7xVE=;
        b=SXUpELMUfPR5n0f2vMZXhTbvvsygV4sIlEcQu35QqWRAOnJzQEApWybXJEEZk2qTBV
         eGylQubU5SEdg/EPJH4qK1WnGODyYwIntXSFU4LFW+7yRGhCWmTWKGrC70Bp9h1TMMt/
         EvPwJjsNpHCou1RSRpoC0IWi5SameO+QcokElON07+6uOLQHiPLyDmqhTCGX9EFBZfNA
         SXfY1pwBNLJ690fv9aaUaVBgZ5sBrdvScXKi4XcZa/gzY/7CNQlH7d3ArAxUZHDk9CDY
         hqwfzuAFIwFHKkN5wYgtIfIbP3Rs/X4vkxoE9ysYO/EsSJqWLpMb01k3OVWveuhs7kgp
         kh+A==
X-Forwarded-Encrypted: i=1; AFNElJ+DKsMNuPh+ic5VFZ0PaEnil2dOvHb6gqpCzxfMO3og0BxfOzg3tiaqRpVxTLcL+xWj0cYQn1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxClTEHdpO5/cY6lsEGG9nDNsJeWHN4XTAByYDU02TbYozZ0+fU
	0eoGnj1XRlkB8+4jE/AShrAHX+tDlWKV+WlY16OgXLuhN/BcSu+rfgUp
X-Gm-Gg: AeBDieuNYEn69nm5RKE5j/llaSAB6Ah+CfdSPLcYiUwYFIfcXOs1LB1hQXObj31qOBc
	BSul61wwv+IACdJ3ZTMVefETMjOry3vo+9Bk8YlmDE6B05Q8Owt7se/2P1shUZM9kkTxs1c74fo
	a5p0a821vKb7wVOtZbGGAtkzIUteNvMCqg4W0ZTVu0+rHJvrvFrLRPcK4H8MwHbtqbHAtdu74Q3
	qn3mBdAN3NjqLjdjwI7/U53HZmCDUcDb+8pzOmrGiLyXmTHwktejMB6yOIpP7ChJzRjvwtMgB17
	amVh4jAKb/0+t6oJcq8WKzZs7jq2DvDMFYXwWKhmgoCW73bQUJO4LBrXLMbibPLsogo/FzdMctm
	zpmx49ii6qTixmctBaBKNr+0E/PilEtghfEh8Fj0TdtCQjE37fpnLBiDYtlWn1kH9e/Iyz4yHt/
	JzwNcvqoQaaqlsI2Veuh9tfqU2aaFIhLstrjHxcnyg+TU6ooT5RpCR
X-Received: by 2002:a05:6122:168f:b0:559:6788:7b55 with SMTP id 71dfb90a1353d-56fa6673f07mr350594e0c.3.1776394977018;
        Thu, 16 Apr 2026 20:02:57 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.124])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa93275f4sm131275e0c.13.2026.04.16.20.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 20:02:56 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v5 3/5] staging: rtl8723bs: fix out-of-bounds read in portctrl()
Date: Fri, 17 Apr 2026 04:01:08 +0100
Message-ID: <20260417030110.42991-4-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417030110.42991-1-delenetchior1@gmail.com>
References: <20260417030110.42991-1-delenetchior1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238397-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainer.pl:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7920C4166DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In portctrl(), when 802.1X port control is enabled and a non-EAPOL
frame is received, the ether_type is read from the LLC header
without verifying that the frame actually contains enough bytes to
hold the MAC header, IV and the LLC header plus two bytes of
ether_type. For sufficiently short frames, the memcpy() that loads
be_tmp reads past the end of the receive buffer.

An attacker within WiFi radio range can exploit this by sending a
crafted short frame. No authentication is required.

Validate the frame length before dereferencing the LLC header and
return early on short frames and on non-EAPOL frames, rather than
staging the result in prtnframe.

Found by reviewing length validation in the receive path.
Not tested on hardware.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
v5: return NULL directly on the short-frame and non-EAPOL
    error paths instead of staging the result through
    prtnframe (Dan Carpenter).
v4: add Fixes: tag and Cc: stable (Dan Carpenter).
v3: rebased on staging-next; sent as numbered series with
    proper Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and did
    not apply).

 drivers/staging/rtl8723bs/core/rtw_recv.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 40884788a30d6..b11982fbe7e1f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -537,20 +537,25 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 			/* blocked */
 			/* only accept EAPOL frame */
 
-			prtnframe = precv_frame;
+			/* Ensure frame has LLC header and ether_type */
+			if (pfhdr->len < pattrib->hdrlen +
+			    pattrib->iv_len + LLC_HEADER_LENGTH + 2) {
+				rtw_free_recvframe(precv_frame,
+						   &adapter->recvpriv.free_recv_queue);
+				return NULL;
+			}
 
 			/* get ether_type */
-			ptr = ptr + pfhdr->attrib.hdrlen + pfhdr->attrib.iv_len + LLC_HEADER_LENGTH;
+			ptr += pattrib->hdrlen + pattrib->iv_len + LLC_HEADER_LENGTH;
 			memcpy(&be_tmp, ptr, 2);
 			ether_type = ntohs(be_tmp);
 
-			if (ether_type == eapol_type)
-				prtnframe = precv_frame;
-			else {
-				/* free this frame */
-				rtw_free_recvframe(precv_frame, &adapter->recvpriv.free_recv_queue);
-				prtnframe = NULL;
+			if (ether_type != eapol_type) {
+				rtw_free_recvframe(precv_frame,
+						   &adapter->recvpriv.free_recv_queue);
+				return NULL;
 			}
+			prtnframe = precv_frame;
 		} else {
 			/* allowed */
 			/* check decryption status, and decrypt the frame if needed */
-- 
2.43.0


