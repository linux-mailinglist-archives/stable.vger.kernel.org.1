Return-Path: <stable+bounces-253545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHNuNXIOD2qSEgYAu9opvQ
	(envelope-from <stable+bounces-253545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:53:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 815DF5A66DF
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC14431CBEC0
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451FC3D45EF;
	Thu, 21 May 2026 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiuJ/EIy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E853CC7DC
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368646; cv=none; b=GYaGDG/gB88P7qiGdLiONsddXuHNbx9KZJ3/x2gFRR2Qa4GhJLzPgUzGnuSoP99v6plyEM6ERRRKKWXG67+rEulUjnKhJ0DQGM41IUNaDsUWVxhJheVqSNS+GBnAP6wtPZwoXMjpImRvEQRa+5Uq8PlHL0KEP41w3RPuqhMBmbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368646; c=relaxed/simple;
	bh=HrGZAnQwY9MJbd/wv7fd5eZFlQP7idEHOmDb1AkwUaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+4TRKAaAndquJckro3luSt9R0r0O7EtuYIo5k/zyCaCpKWYdED5WUXWIpOEVjydAhHQ6KId87sXcJTuMne4CShSRK1Qxfx/gd49j84RKswGCnYgkm4/qA3PeqW6oH7JzDkdzOxL5l9x1pikSB0y5SM0h6faWjNdtj1WTmKnx4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiuJ/EIy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9358bc9c50so903162566b.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368643; x=1779973443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuMzZ0oPIB63SQlMEwBPtCu4kk4sfKKOYS1JICO/Nwc=;
        b=HiuJ/EIy3r/WEi621TVg8jGpYZMl/lak5xDJBIYT1CfmEbArTvJEexnDpQW+UyZUcG
         kcdSpk0GszpYnVCo3QZ7XjIt5SL0JNvV3GyGe69L5LoSqOM/UFYoRzQuizoMwGQNsmeS
         +Rds2uDglCMmmQ7ohx766no9O41JmXDMtWY4MXOvR9gUV88Jj1IEaS1JpSTyXp780+iZ
         cbxxypJUExxOnSKvw+7Fk54HqYTRCkamlxZqf0P7xA6aveVLNwqO8nOy3yV+vnafgDjo
         ZhZKYjuDz/VQBQ09tuyoYoDvwRKw8FaSgM8MlaL8JozhUAbR1o8Y5om3w7BfvZp1xoaG
         y5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368643; x=1779973443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GuMzZ0oPIB63SQlMEwBPtCu4kk4sfKKOYS1JICO/Nwc=;
        b=iVIdrNisOXBgSFdygEHPoSRgfH+8jgLDrXIhuxTalwhmW1ST0XWZ++L+h/zSSKbU52
         CnC3PJ5l2DGqnfdG4GbNMNT/hlyafflHqO8mAo1oddknOG+PhuM2RelGCC5rtPJ79h+R
         oNQdLE5oC1AzJgyjLiwdGLcpYYdJHS5tEuUGPRcffqx031hnyXpuC5ZiEwM+4AuBZAdG
         9r+cWX8reqtt/tP55BfH1kne0x/2juISsVgZg99sDuFTTWzW7qFcPJlAlP4YGRjGH5Li
         NS02svQTofXe1lYzYnRbXBboAgXsGxa5ChFzl0wPk6DYuqRlnKmWOjQoOI2epOT+v0T7
         3Dug==
X-Forwarded-Encrypted: i=1; AFNElJ/7pIznyD4CojRNaN3sKU33ZRkbCK10Pkibn6gp8aTV2qGShVUOtOAmuUgj5jjo5uCEIKNU15Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbiKtFX0DfX+RFTBK5nInIsej2ZLL2qVkOR1Ebg5nUedZL0U12
	iih1n/8tXlxFQtjeVPXKh+yLKmM9EeD3wIM9sj+qJVvNIIpPqToDkk8o
X-Gm-Gg: Acq92OFmNE2uB60lRl5HoLZQVIIBqOJGAEvAWrAVD1AA5bs1IAD5kBjzGYi7M5tTupT
	Z2JGHUwf2EEMcKoZy6zzkGi0moB/cps6n0lYz08MHRvpmgIJnYCApYH4RtOHi8EwIgUQkqkskNg
	ppPn8zExq8g0/7YCSt0cRNvCPuuLo3Nnk2ETrnmCcT0QaIiLr0tvtDLR5zfuRwO9OLiMQXIC4a6
	KIa/uZjkwZByvkJ3kf67yC+am7p7Ii9UUpmO03C3BR9E0kfg0DHzqaYprDjJ4iR03lXzmF0DD4F
	HN/qOKMRNUbEEy2u7bTfBv8Zj98MNIILChRU2fKYm8hFMvmEXPIbPdTZmVFVdv2OFTBx13PKnu+
	R9nQt1Sb44Byy2djpCwfF8SxxO0gGrNm8CeWghsgA07iXzOJJZZojamXhPlIH/6lzOTOudUIdN0
	F39whR6xRmIqCv4hWY3nEw8CmdRdWv+oyJxDf705odXG3YFMov+v2HMeWOq3lVf3rg7SipHpwzD
	CXW45+acXQncufHMFhiqxENZbTlLAPvk3z86sJ8i9rRes/VT05FEVaSb4nlMYwO0OeqfbvWG24D
	MESegQ5t23ydHaz6HcQ32zcFR5Xg
X-Received: by 2002:a17:907:7388:b0:bd4:e5bf:1ed1 with SMTP id a640c23a62f3a-bdc13b781eemr112177366b.15.1779368642720;
        Thu, 21 May 2026 06:04:02 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8a505905sm43766266b.37.2026.05.21.06.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:04:02 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	stable@vger.kernel.org,
	hossu.alexandru@gmail.com,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH v6 2/7] staging: rtl8723bs: fix OOB reads in IE loops in issue_assocreq() and join_cmd_hdl()
Date: Thu, 21 May 2026 15:03:25 +0200
Message-ID: <20260521130330.754181-3-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521130330.754181-1-hossu.alexandru@gmail.com>
References: <20260521130330.754181-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253545-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 815DF5A66DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two IE parsing loops are missing the header bounds checks before they
dereference pIE->length:

 - issue_assocreq() walks pmlmeinfo->network.ies to build the
   association request. If the stored IE data ends with only an
   element_id byte and no length byte, pIE->length is read one byte
   past the end of the buffer.

 - join_cmd_hdl() walks pnetwork->ies during station join and has
   the same problem under the same conditions.

Both buffers are filled from AP beacon and probe-response frames, so a
malicious AP that sends a truncated final IE can trigger the issue.

Apply the two-guard pattern established in update_beacon_info():
  1. Break if fewer than sizeof(*pIE) bytes remain.
  2. Break if the IE's declared data extends past the buffer end.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 884cd39ec756..c646dc2a1741 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2931,7 +2931,11 @@ void issue_assocreq(struct adapter *padapter)
 
 	/* vendor specific IE, such as WPA, WMM, WPS */
 	for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
+		if (i + sizeof(*pIE) > pmlmeinfo->network.ie_length)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
+		if (i + sizeof(*pIE) + pIE->length > pmlmeinfo->network.ie_length)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
@@ -5324,7 +5328,11 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 	/* sizeof(struct ndis_802_11_fix_ie) */
 	for (i = _FIXED_IE_LENGTH_; i < pnetwork->ie_length;) {
+		if (i + sizeof(*pIE) > pnetwork->ie_length)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pnetwork->ies + i);
+		if (i + sizeof(*pIE) + pIE->length > pnetwork->ie_length)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:/* Get WMM IE. */
-- 
2.54.0


