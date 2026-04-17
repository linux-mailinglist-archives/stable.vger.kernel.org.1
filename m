Return-Path: <stable+bounces-238399-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INMnHEmj4Wn9vwAAu9opvQ
	(envelope-from <stable+bounces-238399-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:04:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A814166FC
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B5C330461A5
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 03:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93D134FF79;
	Fri, 17 Apr 2026 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLS8gYon"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B934EEE3
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776394993; cv=none; b=tLH8elKZR2Y20FA5X6jSFEQIvElLRHMRgH6YgXSXndKTyVXDrzI40DqRqSsWIx7uEb/4j8dWs7ZX0/bfacZ891kr7sWNPsjxgf8W1SyESH8DtUv8sQN6+aDDyiFSRay5LVHxpP4zHcp6YHFcERkGPehmcZXMYQzj+t3V9pgr3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776394993; c=relaxed/simple;
	bh=Qf2pj9mdWhoOhQaMbpBXpuYL+EpLLGiJqu1COixk28I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvTNtfi3Urd7Jx60syZIBdkheUQG43oAacqFjv+RnhCkxsCm9v0kYG3zuX3yzQZtLMF40UAaQw2KupQXHtn2nbIol7e7olOqTcT9wmTyn7+fqMcou55NPNlV+cQVhcUNPdySi0oc+HQqMlXcEK9AlA22uPGME1b7XFJzhHd26CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLS8gYon; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56d89f35940so69542e0c.2
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 20:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776394987; x=1776999787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rovnln3bQexjtYGlnIDtq4x3huEk7/gghBgaMQ2B6FQ=;
        b=YLS8gYonNFxa/gf2Z7h+fPWpE2PEuXBZAm6gfa6RnkjCYcXkmwQqQDLPkHRQF/qz2Y
         /bYaIFNCcKb2Rqzkkmf93APSiWxNiUmBY/BasnHK11eircb6Eh+tS9j+VWQ5+/7wZtlz
         Rp5A7TionvvBLMA7enQBERC9RpYMCTWlnl5LKRBnqwuzqXSwbLswxOrsthDrrV5VvMVZ
         H/ogmEW98AAEpedQ5W4bP289gL6hWwfsiumSoLEE0mxxpW0m7mQ+jRBZtFFzrSmh+NUC
         Z+h75cfNc0X3C263g3wSLa8Lbxzsvnsg/qswFJrSk7E3aJIyf6hw80cLMMZtkRKsq6ST
         QbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776394987; x=1776999787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rovnln3bQexjtYGlnIDtq4x3huEk7/gghBgaMQ2B6FQ=;
        b=oDsn28hJdLc8wbM0Rmif1qhFMNl02HuelgqKd3qLS5LQ7VhtNtvG2AwOSwSsowHHSv
         hCkPUoWr89w3CpIjE+6dYBZEBWRU2l9dws6fy+R2apTi5EUKh1Xx6IDsXfAs0LMAf9OD
         XFGH3R4yQT3U4I+j67AIhP22BqcYjcvFykP6bdvi0IdifuPgzCnbfIOB8FtRvR+mRBnM
         4Rz/KXiIR3QYP+NklUf+6RQ/guhNmkc94bi+8xbvCfqnQE/itv1CoBlMBYgQ8xKabLJO
         /pilaWDvAHf7+KknkNGbSMzVMG4KItDnl+Yz3UrRFt9Ho6nRxnCyMTcLTBTc+Pz1oaA9
         9Fbg==
X-Forwarded-Encrypted: i=1; AFNElJ8wgDVk6l8JsdceUWItYiQ8qDbvhIsISUE8mklGEkfPiFRK60ahpnMFeO7sqv6He8T0Y6IqkG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi9Vi1C5T7O+QL199+EfMhPOC8n2cI8CL5kDiq38EKdIpfeS1O
	3rkvZeyIp3nKQooMmUqBsZqB34HROsddNY3zbtS0wShECHPw16IKk/83
X-Gm-Gg: AeBDiet7G1L7H8Jij4ucCxTJDvAXQ8FTO68JXuIrdxAkEMyOAevqzdYh1eAg9c5r8fo
	kxCOniCnognR/4zWpcYq4KBxLBUYlGr3B3JmOpElBw/JOV4z/O/9BrqtnNwG3CnbNJF89yx5OpW
	lBl5gUeQgxnt1azEw258tr17s+57rjwQ0xPNpbe1gLuA0ZYOy4LjA7oCwmRYAFQzNoUVE6cASI4
	2X+X6RrM2kuj3FR5qamzhjrZAR5y6zqVGE+2xiNMaMUeyKeh7TtkXyzEiNN4VjEKo44Fgq9NtZp
	BONfkhVeMadNriMzgBzH8gWqCZ+4FOMaUhc8n06ELzDaaZIjz0B7SXHRm7g7rIC174rN4kTTpFE
	IVtfI4LaJR8TqehZZ9csVigjtpvmhkCS8QclQIiHCB4NJIz5i7E4yK5TdtGcwv14ZloSrE7OiLU
	pHifXT5Ihe46Ef7T+z/I0xoKNH+aLSTQKe36JVmJQtf/3Ri9Wy9obE
X-Received: by 2002:a05:6123:10b:b0:56d:b4d1:3c3a with SMTP id 71dfb90a1353d-56fa55c512amr711056e0c.0.1776394986916;
        Thu, 16 Apr 2026 20:03:06 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.124])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa93275f4sm131275e0c.13.2026.04.16.20.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 20:03:06 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v5 5/5] staging: rtl8723bs: fix negative length in WEP decryption
Date: Fri, 17 Apr 2026 04:01:10 +0100
Message-ID: <20260417030110.42991-6-delenetchior1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238399-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,get_maintainer.pl:url]
X-Rspamd-Queue-Id: 31A814166FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In rtw_wep_decrypt(), the payload length is computed as:

    length = frame->len - prxattrib->hdrlen - prxattrib->iv_len;

All operands are unsigned. If the frame is shorter than the sum of
the header length, IV length and the 4-byte ICV, this subtraction
wraps around or produces a value smaller than 4; the subsequent
crc32_le(~0, payload, length - 4) call then wraps length - 4 to a
huge value and reads past the end of the receive buffer.

An attacker within WiFi radio range can exploit this by sending a
crafted short WEP-encrypted frame. No authentication is required.

Validate that the frame is large enough to contain at least the
4-byte ICV on top of the header and IV before computing length.

Found by reviewing length arithmetic in the WEP decrypt path.
Not tested on hardware.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
v5: tighten the length check to also cover the 4-byte ICV so
    that the subsequent crc32_le(payload, length - 4) call
    cannot underflow length - 4.
v4: add Fixes: tag and Cc: stable (Dan Carpenter).
v3: rebased on staging-next; sent as numbered series with
    proper Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and did
    not apply).

 drivers/staging/rtl8723bs/core/rtw_security.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index a00504ff29109..ddd6ed2245035 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -113,6 +113,12 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		memcpy(&wepkey[0], iv, 3);
 		/* memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength); */
 		memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[keyindex].skey[0], keylength);
+
+		/* Ensure the frame is long enough for WEP payload and ICV */
+		if (((union recv_frame *)precvframe)->u.hdr.len <
+		    prxattrib->hdrlen + prxattrib->iv_len + 4)
+			return;
+
 		length = ((union recv_frame *)precvframe)->u.hdr.len - prxattrib->hdrlen - prxattrib->iv_len;
 
 		payload = pframe + prxattrib->iv_len + prxattrib->hdrlen;
-- 
2.43.0


