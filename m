Return-Path: <stable+bounces-238418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCCYL/DP4WnuyQAAu9opvQ
	(envelope-from <stable+bounces-238418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:15:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DF441750B
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F1913052926
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DAC371072;
	Fri, 17 Apr 2026 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mydm7QCZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172D36E496
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776406340; cv=none; b=A/49epVQq8/b6l8RWgPqHX+mRYwFiBU9sSDoASUwh1lXkh9zqeShlwCZnOqm5HCk+sMPt1zwRexrI0KSySlj9rXmTaXwCQjrx5+ZlZlyCj12DcXWPz+uWjw8tlgNZqsY6A5YqDoFtl5JHq4w5DoRRqNnQqS5wuo5MjyohAAgF/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776406340; c=relaxed/simple;
	bh=LQIdA2y7R70azffM7vEEmPT21jtKvg4tGGwa02Wpxc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kv9lyaQfcb6fhDv2QIZXY4lV6wFBS6+MO9dYGNlEaVN6CH736hevt/Q7VYkXm6iZZuejqWSjSQzSTyiVNvc/Ru7P3dgx5n+ytA6O5tl4+3LJl1bwDoSliSU4cjTLC/QpKooC+9QJKXxZE3AUQVzNegLsGtUp6MRIiY3yrkKE8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mydm7QCZ; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-60fbbac2938so103308137.1
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 23:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776406338; x=1777011138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHAr/pp9xx4L0THvS20kiAAKgkB/RVI3w/K0Awkrlc4=;
        b=Mydm7QCZd/5V+9VS4qRPOZ12DO69LkUcCdiUr9HPfpfvvZlCunyAiNxL9EZwEP4tkQ
         cFiUWaxQ18vAk2/Ch8+fopoK7KL8gQgJZd1CLaAKhkYDRqH4onEMRLuZgOmQR6FRR1Jq
         qgde+UBMO3/TCeN65KqPl5gN3lBvchrDXm6eoTjT6D1OvAaV3FJ1vbs2pTS+hn/B7LgE
         LpUONEg6OgMG3wZoLn3V+hsrDyXg5J5Om9Dq+Lusx26h3BIK+B8mMPI7vpO+q6oDZ7ce
         M2rUugb7bPHg+BXzM/kIsVAljRnO3BcYQmOmgSW3YJG5GyNt5zuz9w8yRP+f3BRU94bG
         h14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776406338; x=1777011138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HHAr/pp9xx4L0THvS20kiAAKgkB/RVI3w/K0Awkrlc4=;
        b=e2yMqcCD08QbD99dvQ+2/NcRT8e/mVtaNjnjtPNjB8drfwgPL+wuK4xL3MXS566jcc
         8XRMirWGT6vxBnJMBWn2wbPurHL/KJehK2GRPAvTMtBLhFoAjBbj4hKh/tmtpZTojMlO
         nUpHEM6FouUnA3/IR2nenAa3B9RJUUWV6rkrSkok/8jD0AjtvTwqEjqjmgC9xw5FxcLQ
         2bjJPY7TdLhr62ptIs72QzIpnqEzV/SQ+LVHZONQ18gBJPOAi8WW1RBx/7U642nesRje
         PhSDTrrrnH04oZEsTT/Rx48VR8zzeasl5MM33NH9Ae36W//CI3huQjsOO7QX7+ekJyDn
         aNYA==
X-Forwarded-Encrypted: i=1; AFNElJ9K7/gK3mFflAKmmk1tXEJ2wbbkyDn9fnEbdiIttCbGgxPGmwh2hOH/xVNJtE+Cf0yvQEUoEMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpx2ddRcaqiy0BiXuK0iGeqJDWww7kzYdCrdqbq9m/y8TYSIi5
	ygoByDmsZMGHMu5Eh+W4DFsDpDXome4/FLkrLq74OnnpXRoNqUuuhThD
X-Gm-Gg: AeBDietC+f3BFpX3Y/2WMgtsTpOJGL90pIGbaJorv9Ih+CbQDjEpmER9V2p9QIibjAk
	wca1na21ab9pDy23+/fzKBvsqeqPptbP+6DrLPbHBHrH2xqZM3MmZ4KIHna5aV/ynw7XcWUDdwW
	qEt13yC0Y49kwlwA7CAYzK1dZkjKydfcphpEHJSnHKKBSRQ+jYFmgJsRP6wEGqxCf/COyv1vrcc
	VddN4Fea7ThbrmuK3EfKqsFJDtnNT5QDYy1PUs457Aj1a5ZlM/cBTJ+iP1lHZpTYLVNo98mQpoL
	IbBuAOdE1x9i1wYP/IDQtyOPVnj3y1obVq0AxobCeM1GQ9frvnJl9Khw5NV8ILGPamMK/TqMY56
	QUoaZafUv5MmCPauX7dZPItNb9y5n9CHzA7CRJAchg4R29z3wVlTp4Ev2paribBhS6kCPOtSqsy
	QOcVZrZLeqTl2l0WfXmSoHEDxfuFo60p2u8vnIBc4ryT6ra0Qfh6PC
X-Received: by 2002:a05:6102:5493:b0:60f:ac13:c99 with SMTP id ada2fe7eead31-616f88b47e4mr465946137.29.1776406337613;
        Thu, 16 Apr 2026 23:12:17 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.124])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9589093a8bbsm297947241.3.2026.04.16.23.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 23:12:16 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v6 2/5] staging: rtl8723bs: fix integer underflow in TKIP MIC verification
Date: Fri, 17 Apr 2026 07:10:45 +0100
Message-ID: <20260417061048.62484-3-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417061048.62484-1-delenetchior1@gmail.com>
References: <20260417061048.62484-1-delenetchior1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238418-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainer.pl:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: E4DF441750B
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
v6: unchanged.
v5: unchanged.
v4: add Fixes: tag and Cc: stable (Dan Carpenter); carry
    Luka Gejak's Reviewed-by.
v3: rebased on staging-next; sent as numbered series with
    proper Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and
    did not apply).

 drivers/staging/rtl8723bs/core/rtw_recv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 8d5d9a6dc4db0..e30617875a69d 100644
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


