Return-Path: <stable+bounces-238084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG5YLJFe32m5SAAAu9opvQ
	(envelope-from <stable+bounces-238084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:46:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F361402CD9
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3D7B300831D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 09:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258DE33F360;
	Wed, 15 Apr 2026 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFvV8OXB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AC33DEC8
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246400; cv=none; b=WMhwaCsHJgnulasukfV7J3TWkY9POtQwF0kMM+xDv4+sC890LX9Gb5Fd8y5qKr2kIFwW4ekhGAVVuMP6zbiZhF1IZejQgoIP0vyTUm2vvnl5YEFFWSa7dtGBdhsnVMwSmHAVrV0byntuveP6qXJq4Q26BNvOumiSFIrq/C4J7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246400; c=relaxed/simple;
	bh=Z2lRbePXb/WkTbD0C7QUi/a02dwEcYPjuzTeV4XTjEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r80pQ9kTerAtPp9l5xapZfxK9Nv2KE7QAB2qwWTPXzT8XBOUP8sl6re6B/xoSRrNaZrXGzZF7NBxNFbE2aAZEdZ946wIgBnaqtH3FqsgT2Rtfs+A58V1zyHW42EuHxlQv/mIp9biuAM70GMNh7pEOoqHCDxBjZVkEbPfvvyqUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFvV8OXB; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-671ab90fc1fso4646955a12.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776246395; x=1776851195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lqRzq0kk7QUDv7Zgb0cPFlnME2nNgpszREhEUniJWOk=;
        b=EFvV8OXBSV3K739eCis/zR4mmCwKzb9DioShTyYzbpUm8JTQqRx0O45TxTJAXTBlLi
         I1xWNwOcd+JV2iu1swvB1trIzpTNxdCk8DLl65xdUVK+2iSn6EAPQdIvNf7fasfEEz4D
         jhYAALPUz7otfyoS0V1sTKHco7mkMkqAwJNxPBLydj7SfbHX3uqYkS4SaYt8K929+jrb
         lCA9XMWo3X7yP36h8CxkKg1mykP1oF4NC8WKGZBZaJu8+uuHPDnFB+futVidjqtYnUph
         4lotln+EhesAaMVdTfQ95X9YjRwb2cGSvsHFKtJ2KXSoCiA1QKesQcZp7FMUN0OL5bWw
         Z2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246395; x=1776851195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqRzq0kk7QUDv7Zgb0cPFlnME2nNgpszREhEUniJWOk=;
        b=lmy2Hi5/6BQmTm9EgtY8odLWVMHnmIQi5h6wvt6leB726H7hUt+uAFMMgQ7PP8rXL2
         TVAKWhsrE6IB4PymYGEIcnZuYY39vyUSFhDErRFeNUYXKRC/yn5MNzqhc01/xKuq+3Dj
         BoSb129HOmL+9l48s3dxwMHcemxxw/8wvN/AFJMP7ihaee1ytT1sZvmY9bUi9shRzTWa
         hOLQPyFMnAFTbExkwXB7cOy95dQaGlFHKBOAVyU/KO6RKQPFpGj/eVDi3ZBoAUheW5IE
         a27Is25piVsmbiFydPJr+KzVQBBCLmy/Kl2rBvTmtuDUV7/zfJJoS56phH3wFW2VSCZm
         2P2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/SQWnMc5IdkoMMCOMJRbUNphtmjCdUD1N6906iQd0qUN7jtJs0hSrdFy6KD2Geo2F7EXTmT9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPpDincWW8sQBgB4hjVxniBUBCSLXrERcg9GCBWDuxtoNcAvy
	/skFz2oLr9LyJdkomNNVs0WzSLZZblvdN4UNCV75bdhr1eRBVGwRF916
X-Gm-Gg: AeBDiesNRcHD3rDvqSdjTCy7TA8BkkAmMFzvJwij5hibdWB+nCdFQXW95l6h252olp5
	vRPJ8PVhAoCrXAWQ5q3/BvPfmJt2i+8EWjxoeBQwbNiR4VyjL5MI/xesFlow0XUGqWMpuxy8Idh
	a3peTL422qwGoKWSIT73V09W7/6Rf+SOcAObRKAh1tenPcer4b5WjP+aLkDC5Q3hnDqw4qAODYx
	pjPk9P5GRsA91iwULua/xlrMUplo+vfEml+piyilx+dCqVLu5YCqQQ9+3hwWfrdRoBCBmXWKbzc
	47Rl747BN072K/84kq/+1oFxyLdhOelMgfaqK7Q9kNI7P7/BvmvLuPUX8jDycYAgOb/Gii6VUWv
	4IhoEKqBkIbojr2jnP7plEMQjr0GenPNRIu7ztHtOLGOr5d+WlYdaxMbD+JnELa9t4FyREiGtFH
	i4UnX2YzltHlW7E/JupxUzN3Vf0VqeFPT0RaBEjDzXNhKvITgmIn4vdMadyGNm5u5FpmL9f8xVH
	8BEBmFVTaK7STXAqaRFvgSkGHeyT2QDLONeipILhKGlXaolC2dh6Osdq7D+UEq/6XwzdBgAk9Gy
	NIr5g85oIawAIwaa
X-Received: by 2002:a17:907:c80f:b0:b9c:9da7:9107 with SMTP id a640c23a62f3a-b9d7267ec77mr1325324166b.41.1776246394992;
        Wed, 15 Apr 2026 02:46:34 -0700 (PDT)
Received: from ahossu.residents.sin.openfiber.nl ([88.202.160.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba1778c4e57sm39310166b.47.2026.04.15.02.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 02:46:34 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	stable@vger.kernel.org,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: [PATCH v6 1/2] staging: rtl8723bs: fix heap overflow in OnAuthClient shared key path
Date: Wed, 15 Apr 2026 11:45:04 +0200
Message-ID: <20260415094505.1115208-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238084-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev,kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F361402CD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtw_get_ie() returns the raw IE length from the received frame, which
can be up to 255. This length is used directly in memcpy() into
chg_txt[128] with no bounds check, allowing a heap overflow of up to
127 bytes when a rogue AP sends an Auth seq=2 frame with a Challenge
Text IE longer than 128 bytes.

IEEE 802.11 mandates the Challenge Text element carries exactly 128
bytes of challenge data. Reject any element whose length field does not
match sizeof(pmlmeinfo->chg_txt) (128).

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Cc: hansg@kernel.org
Reviewed-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Apologies for the version numbering confusion across previous iterations.

Changes in v6:
- Add hansg@kernel.org to Cc (original driver author; accidentally
  omitted from the v5 series)
- Patch content unchanged from initial submission

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 5f00fe282d1b..90f27665667a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -891,7 +891,7 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&len,
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
-			if (!p)
+			if (!p || len != sizeof(pmlmeinfo->chg_txt))
 				goto authclnt_fail;
 
 			memcpy(pmlmeinfo->chg_txt, p + 2, len);
-- 
2.53.0


