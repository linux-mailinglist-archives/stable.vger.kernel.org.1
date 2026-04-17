Return-Path: <stable+bounces-238396-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKsJOQSj4Wn9vwAAu9opvQ
	(envelope-from <stable+bounces-238396-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:03:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0937D4166C9
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED02D3021C34
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 03:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E60D351C3C;
	Fri, 17 Apr 2026 03:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfqtDTu4"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1D2E7F3E
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 03:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776394978; cv=none; b=gBBKgOcY77fIjCI7zpPcr/Mpv+/JmdpYJg5i0HL99a2l7oU+bBsnq8QsDTgLAum0QY+Ni6SZcBvt5HLGV/jslq+GFv6whfCs/6s0lOsmbcAdKR4uhaj3l1AUTU70f8UL5aOYBajiY640Apjz5zgxdpMsuXm785ZqEEoy53F8qPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776394978; c=relaxed/simple;
	bh=gjYu/2ofJyGBRiCJbFCjes1+fHC4+IquDZRUtme0YS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRpTbPNm6cJ1Tss/soUQd0TQkYSJSkHi6+g6NrZ/X0J5bQIeAg2z8IhpdbPbqY642sWmha09oSsJisFfiHR0jGEH2yGG0MZspap7GWwdYSTpGDk9YlEyMJ49iK6Zh1R3pVt6bfTYtX27sA8RhhpptOH+oDf8sySn0EtGJtaPTUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfqtDTu4; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56adf76631cso78613e0c.1
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 20:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776394973; x=1776999773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXJlWBy5EhJS9h5WNvEWvOfpNAQjbgOfXUdi7AOiHOE=;
        b=jfqtDTu4eBEd1CIiNEncQU8DYAEfcsgTFvDd/GhgUTppLin7OoVHF9AQ/UIxl1yox/
         HeFx+X8XCzJKfVhG7G0/dZ7XJL4k/wGE/173APn1u/ko8W/PTk96K/BA+Onfo8X821JS
         4eSYdfUHk2sGuuZuy0rdQLeGg+Qda4C4ijYY+6aL2dLybOZ1niSdfHVMNORxtvsZE7tO
         1w367lD5pPbcqW4L75e1WYed8vtMC7P7xWeUkXwsimNeAaI6MKHjnb8TxAQjhBvZR3/2
         gqzy9ln5w+yKPU32Pg/u6iwQMAzrWW3IJnuJaGh5WARAS8wshyKT5GXI+xqVnF38BP8g
         K22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776394973; x=1776999773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SXJlWBy5EhJS9h5WNvEWvOfpNAQjbgOfXUdi7AOiHOE=;
        b=rIouIrCk4UwxlblRZdvxl6HUg0gKqEnsRZAyC41Tt9vSpW67JRs+cMfHDbnONpikOg
         mEIVespN88S3977GCPjon6Qa2yNP+Kd2Lso6VIpKchc1MC3+X2AXQc+NEQABB7cE6+5K
         tGiPtl0MjY8cvN5QDzNSiNj2dOqciTvxH6dTbxZgCXKMtDP6U2zQ7cGtr1kMTNjHD9X+
         Br1sTeNuDsFaND9q6lkPUN8xJv8Dyl6EokE4mTooxXlBzYT2BiNUslTTPG10coohUBfm
         otP0xvUP/EKvDFVB5/5TVvqhF7Q3KeuGrYYApDLY65EqXObcQZZS7UXGIAEGzzs7ZhO5
         l2CA==
X-Forwarded-Encrypted: i=1; AFNElJ9FsdHeiPKCy39b9hYuY8e3dbUqVmv5KZqU2HTg02bmK5F9Jvif1Pvh35CoA2Kj1S1WI8Z+koI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt2eb8KRQMneTuOCw/ZJBpi2GyP/g/5c4ruDuBUO6M0pPwJxPp
	Q7x/gmW/2x+90vZffLffPM7ACvWRQQxyWUyUjbO30EbbLzZ26nm8fBf3
X-Gm-Gg: AeBDieuauJ8AGovnATi+L2irkqEEg065+JjLFNsHEcT4mNE1eCiSJp5Eaz6jHLHh7hw
	gcPOIXYK3q6izuaHC6ttgDcONmUCgzeOWuRZM1HUfT5Ns2XZROIJ4urZEt9J40uUfYftbGZICCF
	bTLXTTnChG3vrhK2i7K+ukJFixmrS3zr9+8NMS5D2mnbJzUMnaUrPu5YWOSN4L991j5wj/Gkl3+
	w932d5R7hl9PJfbL/cleAP1pxCyQwj+oFtZ8BZxeDL5FqhkVD25VMfk8fgD27tdrkfu+Hn2bVY/
	4MZSdbQ6XioLA0u6l17ECNhdkDWjkimtfWWeh4yceP0VlXmlnyBR2cxTNxLXzMy+P/mHHgIZsNI
	Q93w4cMzczvNeK8MIla/AhIi0kpBBARLadt0bMxq+UdIF2U5psERisZIvPQEpVlFDAr9Ya1chrk
	u9R4u3+CnXnkXvJYfJ+llVnhpWP21DGC0rGV94smv3jaypBVHkjcar
X-Received: by 2002:a05:6123:14b:b0:56a:f576:cfca with SMTP id 71dfb90a1353d-56fa57d82ccmr569595e0c.2.1776394973122;
        Thu, 16 Apr 2026 20:02:53 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.124])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa93275f4sm131275e0c.13.2026.04.16.20.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 20:02:52 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v5 2/5] staging: rtl8723bs: fix integer underflow in TKIP MIC verification
Date: Fri, 17 Apr 2026 04:01:07 +0100
Message-ID: <20260417030110.42991-3-delenetchior1@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-238396-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 0937D4166C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In recvframe_chkmic(), the payload length is computed as:

    datalen = precvframe->u.hdr.len - prxattrib->hdrlen
              - prxattrib->iv_len - prxattrib->icv_len - 8;

All operands are unsigned. If the receive frame is shorter than the
sum of the header, IV, ICV and MIC sizes, this subtraction wraps
around and datalen becomes a huge unsigned value. That value is then
passed to rtw_secmicappend(), which reads past the end of the
receive buffer and can leak kernel memory or trigger a crash.

An attacker within WiFi radio range can exploit this by sending a
crafted short TKIP-encrypted frame. No authentication is required.

Validate that the frame is large enough for the TKIP MIC
computation before the subtraction.

Found by reviewing length arithmetic in the TKIP receive path.
Not tested on hardware.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
v5: unchanged; carry Luka Gejak's Reviewed-by.
v4: add Fixes: tag and Cc: stable (Dan Carpenter); carry
    Luka Gejak's Reviewed-by.
v3: rebased on staging-next; sent as numbered series with
    proper Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and did
    not apply).

 drivers/staging/rtl8723bs/core/rtw_recv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 52d029c28ab1f..40884788a30d6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -390,6 +390,13 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 				mickey = &stainfo->dot11tkiprxmickey.skey[0];
 			}
 
+			/* Ensure the frame is large enough for TKIP MIC verification */
+			if (precvframe->u.hdr.len <= prxattrib->hdrlen +
+			    prxattrib->iv_len + prxattrib->icv_len + 8) {
+				res = _FAIL;
+				goto exit;
+			}
+
 			datalen = precvframe->u.hdr.len - prxattrib->hdrlen - prxattrib->iv_len - prxattrib->icv_len - 8;/* icv_len included the mic code */
 			pframe = precvframe->u.hdr.rx_data;
 			payload = pframe + prxattrib->hdrlen + prxattrib->iv_len;
-- 
2.43.0


