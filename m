Return-Path: <stable+bounces-238394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G3ALuCi4Wn9vwAAu9opvQ
	(envelope-from <stable+bounces-238394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:02:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B634166B1
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0349301516C
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 03:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2931634EEEE;
	Fri, 17 Apr 2026 03:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFln3G3H"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879682E7F3E
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 03:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776394968; cv=none; b=LqzH2B9SR/3JZ8Z/O0EPOp+LBkoOt0kLVxWoBHiXouEdV9lPB5mdIC5Un72eglN95BEfsvEK7otUS2A5/Ibx0f30ZnoZBpPdQpF4QBFxfQ20F0aWo6IQUZMlYxWTUbZnl7XTUkZlkybORrvF7a1gdvxwYORxzxngSmnZSrbR2lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776394968; c=relaxed/simple;
	bh=+aSkfcuIjVSvk/tb/QdCgJX5VS1QAhakWqAzEua2/lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qq7gto97Rnur7xjzugUvy6t/hEcVld6JuJ2XT6WSV/aDePewbO9Z48wMxxaIUbSrKCEoafUcKuz0rr+146ElLN4Vr+g01jbsvNO8ow+QCKqSsQHhStNoDiW2L4Lr43rgzmsxiuiG5zacrg2IrNF4y7snwWJc+8QafsD4tIliPKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFln3G3H; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5675d609621so172554e0c.2
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 20:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776394965; x=1776999765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RVJw3Uf7eb5I7g48M7g9HFFPwSMs2PN92kKQtKwpSKw=;
        b=YFln3G3HEjR4vgMmY/7mGxTIT+Ws0x1j8Fyn52/+FaQKf5gnjqiUyZInORdBkoNRzi
         I4YebwBDw8prrrXVYrHFhSa/6F7iltzGk1aI8m+N556eoXpF9sFCmU2rFLt03kIbcUY4
         KW5TsPy7+TrrQdkbPumrLq4Y6eXmd+sqhL2PjZ/PlW7YyPhlK+oaxfROKgDGt4LdHc2M
         CWcxaRZ1NeHn35tLaQYFIr/gjNJ0RKarrQLrrIYusf4MX+9UW2r/5XQq0YnS46pvCCsd
         O0JFYdPXNGkCE1DR/c22hpvShZkiZXCLhvF9q7/5zwaS2UO9qzOdIJHeuEov4oDc+Dfi
         OPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776394965; x=1776999765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVJw3Uf7eb5I7g48M7g9HFFPwSMs2PN92kKQtKwpSKw=;
        b=aYyfZinEpEt5diD7XXyIc+qsHrKAhASlRZF7TIVZ529TcYcDRnagnISTKyVTE2ZFMo
         dxxKMSPAxu6+/bNaYo41fvyEFGOyMiBK7tDgeaPOaSj/VQnEBb5fD+RQ8RsiwI+fzCgf
         Z5awlQRcOUCR9xg0fI0MhKy5PTqF1o5bAdq+tmHnMof/J7ISy4iPz6flzGXPNz7lQzPA
         Llm1JRWEKOZKBZo91HgZ7lnXyGluTUL3D5mph6Cl8HBLulvTK6Uwt5q+xamfiP3V5H5H
         ZxKFmxyYmqVhuy+HheeSKhx/9JJIa1ay/a5ZZxjpJ705uyHbfRot2YrkuFgRrkAesjkR
         Xvnw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ju/KEuegvPfKKRpVGDbPGWV0XSvIZauYWmwM5i3tDbbu48ZfxFJPM0lwXcTc8QN1jWV9nN30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAzrgR9qT8fyIxkAqPlSQaUqCbMUrHq9FkbLIuSNmj+Dp/ZYdS
	5gKy0ZdIRVM+nmE/ynU369EfrP6D/75k0W8A6lkeawLeuwzoqX2xl6ah
X-Gm-Gg: AeBDietz9TGCnfzZy/0fOIocYMZ4aeQi1gdDMM+amxl9wQWt6vHUxtIMkjwsyql8by2
	QFTaKLsOeFmGkvla0dNUVHsQRIncuXHmvGVxMsR8g2Eug+ZWGsMqAW/dUa3/9oN2zao+zjxTio1
	Y43N7yOWUKW450uzQkIFFjahaPkOD+eZLTygdmcPx88YE7anRSxzI0twOJZT8AXckRI1xrqGie6
	yjI0jxHQTAV0He5HBqZPwu1pGSrnqbMe+zYDkns5RG/Ben/0/Wq546YI2G5qKB7zA+y054a2pTy
	rVS3KW4r1Q6+f44TOFbYqBZi7LcC9hb7rlS35WEynM2DpvKgp9POGfPK0ZrGnea4I+WqUkQzHoH
	bvBHCE+ir/57/bNC0/Oo3FhBPscCYRvCNoku//OKaGIP5+QpOEu2UoU1ZBywMGwsmx+7Le5olJ2
	1kfKsORwgo/2TCzhb6VDCsspfzLGUpxxWsaZ8gqEKl31n8TOpoPXDV+FXp6qDWCwM=
X-Received: by 2002:a05:6122:247:b0:56c:e871:31a8 with SMTP id 71dfb90a1353d-56fa58cb67fmr608412e0c.7.1776394965430;
        Thu, 16 Apr 2026 20:02:45 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.124])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa93275f4sm131275e0c.13.2026.04.16.20.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 20:02:44 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v5 0/5] staging: rtl8723bs: fix multiple security vulnerabilities
Date: Fri, 17 Apr 2026 04:01:05 +0100
Message-ID: <20260417030110.42991-1-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	TAGGED_FROM(0.00)[bounces-238394-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4B634166B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes five remotely-triggerable memory safety issues in
the rtl8723bs driver. All of them are reachable from the air by an
attacker within WiFi radio range, without authentication, via
crafted management or data frames:

  1. Heap buffer overflow in recvframe_defrag() when reassembling
     fragmented frames whose total payload exceeds the receive
     buffer capacity.
  2. Integer underflow in TKIP MIC verification when a frame is
     shorter than the sum of header, IV, ICV and MIC sizes.
  3. Out-of-bounds read in portctrl() when a non-EAPOL frame is
     shorter than the 802.11 header + IV + LLC + ether_type.
  4. Out-of-bounds reads in three IE walkers (rtw_get_wapi_ie(),
     rtw_get_sec_ie(), rtw_get_wps_ie()) due to missing validation
     of the TLV length byte and of the byte ranges touched by the
     subsequent memcmp() calls.
  5. Integer underflow in rtw_wep_decrypt() when a WEP frame is
     shorter than the header + IV + ICV.

Each patch was found by code review and is not tested on hardware.

Changes since v4:
 - Patch 1/5: collapse the five identical cleanup sites in
   recvframe_defrag() into a single out_err label (Dan Carpenter).
 - Patch 3/5: return NULL directly on the short-frame and
   non-EAPOL error paths instead of staging the result through
   prtnframe (Dan Carpenter).
 - Patch 4/5: in addition to the outer TLV length check, add an
   inner bound check before each memcmp() so that the OUI read at
   offset 6 (WAPI) or offset 2 (WPA/WPS) stays inside the declared
   element (Dan Carpenter).
 - Patch 5/5: tighten the length check to also cover the 4-byte
   ICV, so that the subsequent crc32_le(payload, length - 4) call
   cannot underflow length - 4.
 - Patches 1/5, 3/5, 4/5 and 5/5 lost Luka Gejak's Reviewed-by
   because the code changed; patch 2/5 carries it unchanged.

Changes since v3:
 - All patches: add Fixes: tag pointing at the driver import and
   add Cc: stable per Dan Carpenter.

Changes since v2:
 - Sent as numbered series with cover letter.

Changes since v1:
 - Rebased on staging-next.

Delene Tchio Romuald (5):
  staging: rtl8723bs: fix heap buffer overflow in recvframe_defrag()
  staging: rtl8723bs: fix integer underflow in TKIP MIC verification
  staging: rtl8723bs: fix out-of-bounds read in portctrl()
  staging: rtl8723bs: fix out-of-bounds reads in IE parsing functions
  staging: rtl8723bs: fix negative length in WEP decryption

 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 70 +++++++++++++------
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 65 ++++++++++-------
 drivers/staging/rtl8723bs/core/rtw_security.c |  6 ++
 3 files changed, 92 insertions(+), 49 deletions(-)


base-commit: bf9c95f3eeefb7fc4b4a6380cc23f1dca744e379
--
2.43.0


