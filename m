Return-Path: <stable+bounces-233306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC7VM4yb0WkYLwcAu9opvQ
	(envelope-from <stable+bounces-233306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 01:15:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6353239CD95
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 01:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C66613009FA4
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 23:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF30F377574;
	Sat,  4 Apr 2026 23:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQqDWV2Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4F3750DB
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 23:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775344517; cv=none; b=u2vakFBHSEi0SVf4YDxpe9YjeFcWCwkws8BGNWF3K8KCXzucMDueySvGn9AiHgmKW45pzFbcj2SPMiAZycKokDfSfbN6dqD49Fo/IFFipzcTK7p+9JIacHdUbKFHKCHiT5PDojVkKEbm8smrAJQ1kCEWwe2S6YKLW9zfIUYmyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775344517; c=relaxed/simple;
	bh=BFfEBHoOQD9zKHEK3USgxGLRzNVMUlg5LDU4MWxYSFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ur27WGlrqHkQ2U+Se50tz94SoEPYnCxalWdkEW8o5/x4I5HIWAb4j2FmoKUYUInNp0g5GVYeyC4+TcqW9HXoshWDhp1BiwngrZUgYpm7N8TJ/xNGqFS8qrgS6rYHq87g+Y/J1hB8UV7GHG5st/FzVjNKisk/mpuamH+uWwII6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQqDWV2Z; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56db1b3626bso1074508e0c.1
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 16:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775344515; x=1775949315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IsyZtp0eCcqVcLwkTIytTvDvI0E5vLNCVUYCrxMKN0s=;
        b=TQqDWV2ZWtiSia5KTHLrULhdxU10Gk+qRIVrVFJNQxKdS/WxsVPeJaNB1g6Cy2Ww/V
         0M2YA+5hYcmRERswnQVybfAiBuht+HHjSWIoqShfyKL7NiVZw86H+UcOQnrj/hs65CJH
         3LY5L/EmgzqCJxp4/LV1r3uExl175xQSAjMljqwYF2gtFtnBVasY9AgSmgDyjFrrhnjN
         FFE4GL23WOJNTbx0829Z/4K7q3IWCLzDhkOnUvdHM5LynFQq/XnrkaHDi2LNKkvwke/R
         QIXbk6h6I6iZYhVhrmIuzZbmODQo7udj7fIISLLl7pjdPA00kgNH9Nk8fM13a+S1b+Z+
         tNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775344515; x=1775949315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsyZtp0eCcqVcLwkTIytTvDvI0E5vLNCVUYCrxMKN0s=;
        b=RndU17NXFkqweRdB0Srf4ekcYSGfc8gsygnTMgysFhp5o5R9WUIyQD8Df8fvAg0WWa
         JeUbOvr2W/CwTMHBKHs33y/EvwLjg7qLA8cZNLBrMZ53iKqbulyn51ygdZl1bxuI7HaD
         B8IzXM3cU0Z/ORyBPZTOiVjkBsOaOyUyYcFOtbt/HH6MtXDYwLYeIAmcADI5+zo7GG+N
         zJbjiqNHKsNlgp+z5bfo1O6LF7SBNXcLa8bS04t4kanaEZbYOrnTbmuYlkvt75jss+Fr
         oQvDH5xCBOgTCtvrihB8XeM8hIwnf5xjDrWXft8AUVzMsaGaUE9zinEy+iHnNF/I2YRP
         EjAw==
X-Forwarded-Encrypted: i=1; AJvYcCWFN/cVhjDhLso2I5c+c6lZEIEWFjCPaJUxU4RMhMVj8ftMGwoQPD/SM6Awc6OMXyGX/E6ZhRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2M/ibgyTnYTdrlr9BqJj4VamIVmcUvbdAQFDdeNx6P7l/29p7
	RizcFWDfNlI7IfY160mrnEmcKX2NzvvwHTmMEqsHsnqSQTzjCdMGm8tK
X-Gm-Gg: AeBDiet0TYkv76VL4CoUTxW8/FwuZ838ZhyCdxBBFHD7gWaLC6gYnka8kjWdxjgMdBz
	ACvVyh0zMKc5MDGMW55osMWQoDylsiXkJwv8sErNf0QUGEPxCALUrCuxG1zG8X9QNDkvm9IJMTY
	Z+WMb8lb9qcEuKJ+24IsQGoX3f9NbOVYzKe82n36ECHo7tBzVj6jxxIlA6kS4Ymxz2MDp966i4Z
	Bq0+IXQ4GMcug8YrdK5Np9g2SjlX8Gzzz97S2lietN8UuGPhkN3faTevjkYFlEHYM6kRkmA/+2K
	UQiUlz3IzPTi1mLYEiuadwvMYdGayaht4U7S34BqdhJdRBcK4pMdxNopBl6XE3g4iMF4aL0wUsU
	ajMaatzAo5KtJf3yQU0AcFORrXvIsd4Rz7QQAY8ageR6GrfAR9DBbv8BLlJIW9ZyNizM1wksKoa
	zKd0wJGC+Ny/yLKLVMnHef2Cg/mHttCbDOtYuV2TAj
X-Received: by 2002:a05:6122:4b8a:b0:56a:f34d:f225 with SMTP id 71dfb90a1353d-56dab9b2575mr2856867e0c.11.1775344515249;
        Sat, 04 Apr 2026 16:15:15 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bd0a8a3sm11835630e0c.17.2026.04.04.16.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 16:15:14 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix out-of-bounds read in portctrl()
Date: Sun,  5 Apr 2026 00:14:49 +0100
Message-ID: <20260404231449.63661-1-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233306-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6353239CD95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In portctrl(), the pointer is advanced by hdrlen + iv_len +
LLC_HEADER_LENGTH and then 2 bytes are read via memcpy() to extract
the ether_type field. There is no check that the frame is large
enough to contain these fields, so a short frame leads to an
out-of-bounds read on kernel heap memory.

This code is reachable during 802.1X authentication when the station
is in the ieee8021x_blocked state.

Add a frame length check before the pointer arithmetic and wrap the
existing ether_type extraction in the else branch so that short
frames are dropped safely.

Cc: stable@vger.kernel.org
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 28 +++++++++++++++--------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 337671b12..1c84a5f6d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -532,17 +532,25 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 
 			prtnframe = precv_frame;
 
-			/* get ether_type */
-			ptr = ptr + pfhdr->attrib.hdrlen + pfhdr->attrib.iv_len + LLC_HEADER_LENGTH;
-			memcpy(&be_tmp, ptr, 2);
-			ether_type = ntohs(be_tmp);
-
-			if (ether_type == eapol_type)
-				prtnframe = precv_frame;
-			else {
-				/* free this frame */
-				rtw_free_recvframe(precv_frame, &adapter->recvpriv.free_recv_queue);
+			/* Ensure frame has LLC header and ether_type */
+			if (pfhdr->len < pattrib->hdrlen +
+			    pattrib->iv_len + LLC_HEADER_LENGTH + 2) {
+				rtw_free_recvframe(precv_frame,
+						   &adapter->recvpriv.free_recv_queue);
 				prtnframe = NULL;
+			} else {
+				/* get ether_type */
+				ptr += pattrib->hdrlen +
+				       pattrib->iv_len +
+				       LLC_HEADER_LENGTH;
+				memcpy(&be_tmp, ptr, 2);
+				ether_type = ntohs(be_tmp);
+
+				if (ether_type != eapol_type) {
+					rtw_free_recvframe(precv_frame,
+							   &adapter->recvpriv.free_recv_queue);
+					prtnframe = NULL;
+				}
 			}
 		} else {
 			/* allowed */
-- 
2.43.0


