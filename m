Return-Path: <stable+bounces-245373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JnNLY2GAmrVtwEAu9opvQ
	(envelope-from <stable+bounces-245373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 03:46:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37455518689
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 03:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CA553051EAA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 01:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28C131079B;
	Tue, 12 May 2026 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRMaQD+5"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2BB2DB7A9
	for <stable@vger.kernel.org>; Tue, 12 May 2026 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550306; cv=none; b=ccjYq5cqBQYTj3/kX536ZANHQaFDc/pCD84lrnsc1tspMVeiMrP+rCLSMwaRykCZfc2FyMixiJUY52kuViEj86EXHRzNlRptSDp6pA71TseV0G/ZN+NlVs8COys31KNCee2dKl7kkf2PObw3OmZklY59eBySWEtfUUjOuHvcECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550306; c=relaxed/simple;
	bh=KqTQRneBMfvDtD0NGh/qnie7L+jkNNCpExxYKyw+jhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAOOJwItD716SaEelDAYfPoOb+MND/ZsOdw+NogsN+8aho2J8Fx7XiRKlrJSEvII+udR+o9PANvexAjOgIYvQts0ayMDzxLj1dtN03fJmobccflSmN02zNHQ7ERBqol8HrEpKk3gZzkKavdTaj+wwScWK2INFF9mb2HZDEAjDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRMaQD+5; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f0ad52830cso7289698eec.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 18:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778550303; x=1779155103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt10RUM2UXri9I9UIGCyRKsgv2xs4QwM0yEoyhATCiU=;
        b=BRMaQD+5wwXguex3EVGHXCScmPyYE/dProi+e8W9e4PQY6XHxEvBRQMSfusNSAO/G+
         /msatXHKYPXaz3QvF8PgQxmjhuRo+FYgENGX87yydUCT3n2B2jTUVXHMpLEbbsJBKYHm
         qoDwi0L1j+u+nJN0hlYixzwqsw6NFM0ndpFhBZpNGWFwoZXcTSDsx63S4HY5UxSywxTL
         IFKRczMPZjGv908KDpuWU+uT+afmggQ8jXyYjkn4z+fxz/+PdYjcEiXl1g4Zk5aqpOq7
         l1UHha39f97sGP5M/anaZ9L/W/LXmfAQLCFCanGxYBaLWgJ7jm4WnJMvzW2oQIdA+uoA
         sfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778550303; x=1779155103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yt10RUM2UXri9I9UIGCyRKsgv2xs4QwM0yEoyhATCiU=;
        b=eZ3/MmljpiYAUCA/VbPgo9E+ULGkwGCHGI9mqD7oXnvxDSxw+vIenbDZkHhpVW/dBZ
         +/xd6yIxEGyFZQVn/jj0KRxTyNDai85+nZI3WLpQ/Giqoxi7zZeE1cZ0Q6JIzeYOZGr/
         Pl453oBC8Q/NHEZQTbly5kiTbuurf2AO/3MulxDX3qy1uvf2UyFcODjX89oChSWEzVK8
         3USGBX+NhRV/aq2ihxQTLu3/qMapDw3pt04jSeiulIBBJfKV2zq5CpTyTbEYjEpqMLGh
         KzGXQ7xiS2k8TzlmO2pNilypQPhCrbNHO9zrCC9gsABlIYROmhIPitKp02dmLNxRVhvf
         9UGw==
X-Forwarded-Encrypted: i=1; AFNElJ8q/+UJ/SqKjnJx6FQ9kpt+ngQ7SWk6GMcCpGyQ7n+0Cw7Y/wUW1UL+ip0ocZqCcF83zE2ZQ90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6nfrJZMvw0R83tq6TpS+0PJxeL8xx2cEYzjIOUh3NxFVcH7eh
	PH+GTPd+Q3LCEJagwrZpSo1jviCc/8xIYi/9YiycdR/mb2eAu/Ah5mKX
X-Gm-Gg: Acq92OFYe1Z/NndxE83+cGw/6xvEGyVwu6lO0kh6jeaapIXPU4d/H1Lskr47YK/oV24
	jpooTpsKOP46CmsQiVnap39JKfjhlqJLKbWFnBENNVhA7xKY+WIhJcGCGKwOT0+MOvE8pLi4B54
	Q0ofCQkJitGOVLGjdFFTryCLrdIUq83H6bWsW7N+8K/VkO9pX5H++7yu6TQwUrgV1RcL6GCvCWT
	aybv3pYcndjgHL4Yn/729dTVdiD/yrt9es87lfjK1VdrZ3I9xWfQ5+KcRTHfBFqNEnq2k7otXjg
	6nlgcDxk9A+PnIiNIwMdppy5RPURwANhSQs0GhoI0nJJc/qVxgkE3a0ZWcsgdgzoks+5pzqHdl0
	9qzl4o91+AxdkS+Q0xNbocreXQkTDyhHMWjng6KwiF96l3CMAGLvz+D3urpAbRFQjz76Mn/bwl9
	F60vDsSJY/Ex5/8Q1VubJjfucjjmts/izKyY5mBT2Xss7Mg5WShLuVmlZbcGxkviZgn/OQ5ivGs
	YHlvLA=
X-Received: by 2002:a05:7301:1f18:b0:2d2:c60d:4fe5 with SMTP id 5a478bee46e88-2fb4b92173amr5138362eec.6.1778550303413;
        Mon, 11 May 2026 18:45:03 -0700 (PDT)
Received: from localhost.localdomain ([50.231.3.67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e4016asm15816499eec.28.2026.05.11.18.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:45:02 -0700 (PDT)
From: Shayaun Nejad <snejad123@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shayaun Nejad <snejad123@gmail.com>
Subject: [PATCH 2/2] staging: rtl8723bs: bound SUPP_RATES IE length in rtw_check_beacon_data
Date: Mon, 11 May 2026 18:44:56 -0700
Message-ID: <a56d8fa71dc6843e5096ce69d4c216c0ca99a7de.1778550157.git.snejad123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778550157.git.snejad123@gmail.com>
References: <cover.1778550157.git.snejad123@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 37455518689
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-245373-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snejad123@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

rtw_check_beacon_data() copies SUPP_RATES and EXT_SUPP_RATES IE
payloads into a 16-byte support_rate[] buffer.

The IE lengths are used directly, so oversized rate IEs can overflow the
stack buffer.

Clamp the supported rates copy and the combined extended supported rates
copy to NDIS_802_11_LENGTH_RATES_EX.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shayaun Nejad <snejad123@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 4b40124110..363ecb02b5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -873,6 +873,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		       &ie_len,
 		       (pbss_network->ie_length - _BEACON_IE_OFFSET_));
 	if (p) {
+		ie_len = min_t(uint, ie_len, NDIS_802_11_LENGTH_RATES_EX);
 		memcpy(support_rate, p + 2, ie_len);
 		support_rate_num = ie_len;
 	}
@@ -882,8 +883,11 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		       WLAN_EID_EXT_SUPP_RATES,
 		       &ie_len,
 		       pbss_network->ie_length - _BEACON_IE_OFFSET_);
-	if (p)
+	if (p && support_rate_num < NDIS_802_11_LENGTH_RATES_EX) {
+		ie_len = min_t(uint, ie_len,
+			       NDIS_802_11_LENGTH_RATES_EX - support_rate_num);
 		memcpy(support_rate + support_rate_num, p + 2, ie_len);
+	}
 
 	network_type = rtw_check_network_type(support_rate, channel);
 
-- 
2.43.0


