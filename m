Return-Path: <stable+bounces-237777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E+FD4MU3mlBmwkAu9opvQ
	(envelope-from <stable+bounces-237777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:18:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FF33F88F4
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66DA7304E5EB
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D700397E68;
	Tue, 14 Apr 2026 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV9CgUmD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A84C358D3D
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161377; cv=none; b=WBWuwPxyP5s4m5C8AsovxY0NMZqkdSLQUn6cwrQUUzklny8dRRrHy15FSSIAxncRQznXjHxKPBQH0uH9r465TVRNg7uxFn9K+zjfi5oYLADUhnJF1D9/3dExiwF5VQ8UWDSArV1TBBFuKJ/67W/FfgPlEMG88Xi4Z6Ee/wUUr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161377; c=relaxed/simple;
	bh=UVuQEQwO9ZjOxcyAo++XxY7tWYlDW2Ukg5Q5WnLhjsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptEhvLNPcSLIcu6U8hiKsob8dUU3a7LW/ix3e9Yxd4CAeJY0/HTvWgyvfQfdYR6Sc70E1K0L3dml+7W6VfXcAz+iJ1jlsT49M6t56GHI9k9vxWJGm7kE5Y4omVmtdi0SgtcxCRD12GZzp+YI2wYkcTHnJbY2b0HdEUyhqYD/4X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV9CgUmD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66f727d6849so7961434a12.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776161374; x=1776766174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM29ecLh9a+Div79GBVrni0H0EBRd49ZucMDpXYMiyQ=;
        b=KV9CgUmDzK54IoncnN9j8xQ6+bHKk4PktW9r40rrV6ujAI9uDkdw9RtktaMKhk/M3T
         EjLmYge66cSyIpTnvIz3lEtBKbN1j4ka4OWW9gb49njVhHT6XFCMCMIrAdSCYF3ljSa6
         7fvdbjOmKeEUXxo6FOIjmzFvQ8N4EVJhWDrnCo6MStKp91lmRA0mIyv4fxyfG5KfVu2X
         FTodOTOhMkXjk4+EGhMOZ9mOsg9Mkav1EbOhwSTOmqdEKDXP22tp+uGi6BF/aJePIqmK
         sbXwqthcUmCHbxL3F6ii3n/JMLNESE3KlI1NWAik7KPWY/zNJ5amPVgKW82FvVv6l/Vb
         k/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161374; x=1776766174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YM29ecLh9a+Div79GBVrni0H0EBRd49ZucMDpXYMiyQ=;
        b=pCBDMJAil/dLCMJ5P2V7aBrhF/j7E101K77YpT07ig9KQxMu9b1LiZrSi9xEaflyh5
         yoA8DkabEMjVsqQbT+E8ki+TDgBmtm84C9cAFSBmdTIxzbFD6zONRrmWCWYDkCjxUZS/
         wZ34y0icoERJA8am90KgUJDjcO8N9nfrY5iI2xhlTm0mLgzO5mH9LVECqX/TULugt7zf
         +/Bzw6v5Teg/ccEbcMZ9A5CaLripJjYn510iNnC5QD+4R9xUpJsFNkKUP9lLIOVHme0x
         zJXpfEr/vueMkz4+eMW/6d3+TSvMYqZUzFc72pmyjhzMx3rsLa8yZk+wpowXhlLUMjiH
         8dxQ==
X-Forwarded-Encrypted: i=1; AFNElJ81c2YAZGhg9F9wRrW/HeCpRAafv5JhEGl8DWhVxyFkcG1Lvpxg/sixpfaBTIiWnGc50vlQnBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+3we+zt0szBXsaTBZAbEYenRkZV9zmuUaQZ7b3Nrv8Wx7i2Bd
	iAnmLimCm+HwRjamhb4U3pW0XTr9zCN6dfw7GHKBh2LnLcJek2Kk5g+Y
X-Gm-Gg: AeBDievecOGqGSoBKqtYN+d7q7dxzVsPRohAz0ntpbOQdWwZTuGPNLZDPgsF71YtX/9
	/eNeQQi09pTnamY3DyLbHdWpyOSIkNrhJUOWEX9AwTyOsc6T2pGdMtwhz9Frowiuf5X00pEqYjh
	qXTqHbnADj9Jjm72k60WYFrDUGDStXUZIndR6/TDrpiQV6wJnxhYN+ueHoImWolKsUT7kz/Q/X1
	aMjn9KoobAdRJ3tGPbRBOxfgD1kaz/ec0UXCXukh1yd0IsU0iQwtfSq0uujxHn7hNJxdsw9+sGF
	CvTMFMiTy5CVS1a/ncigbvFiqyOgluTMQYPI5wOcy1+eEHXpC6eO+slZEb/BHhLYc3h+phqjpSm
	Abzx3aLRr2zlItrTH6qFgOkEEHfHgFgXfgAzsAPMo2Jkx4x1tSZgiwwjldkI9n5bIedQVGNyZod
	ygsP47Agqec0fOwU8HycoR0aBtzqPZsk8F2F1KcZyLIZkHequ8pqKp+ROpoVrw5RezTmgRMug0R
	KmLP/9rpeiRg2eJcoFora0guYMHX0L0+ZRIAqQC/8B0dJdlB9t5tMZzMIyNUXd1BcbT
X-Received: by 2002:a17:907:1582:b0:b98:32c1:2496 with SMTP id a640c23a62f3a-b9d727a0736mr667489266b.18.1776161373534;
        Tue, 14 Apr 2026 03:09:33 -0700 (PDT)
Received: from ahossu.byod.tudelft.net ([145.94.221.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7c8a4fsm375261766b.54.2026.04.14.03.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:09:33 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	hansg@kernel.org,
	stable@vger.kernel.org,
	hossu.alexandru@gmail.com,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix frame length underflow in OnAuthClient
Date: Tue, 14 Apr 2026 12:08:04 +0200
Message-ID: <20260414100804.871764-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413202824.740653-1-hossu.alexandru@gmail.com>
References: <20260413202824.740653-1-hossu.alexandru@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-237777-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linaro.org,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8FF33F88F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If pkt_len is less than WLAN_HDR_A3_LEN + offset + 6, the reads of
the seq and status fields go beyond the frame buffer. Additionally,
when pkt_len < WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_ (30 bytes), the
subtraction passed to rtw_get_ie() wraps around since pkt_len is
unsigned, causing rtw_get_ie() to scan well past the end of the buffer.

Add a minimum length check after computing offset to reject frames
that are too short before any fixed field access.

Reported-by: Dan Carpenter <error27@gmail.com>
Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 90f27665667a..6b0ac54ad3d4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -869,6 +869,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 
 	offset = (GetPrivacy(pframe)) ? 4 : 0;
 
+	if (pkt_len < WLAN_HDR_A3_LEN + offset + 6)
+		goto authclnt_fail;
+
 	seq	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 2));
 	status	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 4));
 
-- 
2.53.0


