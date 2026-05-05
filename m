Return-Path: <stable+bounces-244222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMDmI18n+mmHKQMAu9opvQ
	(envelope-from <stable+bounces-244222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:22:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A14D1F93
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEF2B303DAE4
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450F448C40A;
	Tue,  5 May 2026 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxME+vvT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428948B384
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001746; cv=none; b=pBZK/9Y3e4VjUC5ZsrJXXbwU+M9eLai1EI86E22KBVy5NE77T1Q/wkETO9zP5OZFtreZlGwihNL33gRncbbK1lsvt5cuRWiBnuZwsEev5/r2fcgtQP3q94IAS4Re8qEqv3TRX+/88f8n81VgRlN8HbkcssiGkKJonV+bsmEsCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001746; c=relaxed/simple;
	bh=KJTkgvv/SJNjuSQIuIfvbMJw3S0+LfY8/xHH/7J7BD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppcs289bgsTz6BjWyBmsN+YUaewEORarfZwtK03gxGcudbhNgoGv6r6OEDLG6RUwZtlyD7xAcn+mPSoMU5BAbfLI40u3wKE+1DsVi053DNL0NSLMIMnJfZXvWzF862vHbOQKOA/ti3q9DcpxX4KTKQh+Vv/CDzA1cucVLLHiAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxME+vvT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48d102471a4so22506655e9.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778001743; x=1778606543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2DVA509Tz2RLR/PrPqbXJHTRanKYIEGVqimJbKfaro=;
        b=UxME+vvTUfLh95BFYBzFt1DYYbhpM0GTpiuaadUa1hsONwczxf/dtpyOwPwkS0HfWp
         D7rXZSJpa8TXHtCT9SlfJ5QIL+ba6COSKf03caUhYEGD0kcVgbfC2yjde30QmHjDfWQs
         +J0l5HIdqfM8hZ1AZ/uiK37aQFrpI/CaqNvnpNds4VAu972GqSEDRpY3gtCpMU+0VL3+
         /5hHgvEcjgx4WmZHB5BIgOgQNCfg/Ehb4oP3lR78MsApD3rcvAqc/xyzgYnBH1vjxlhU
         0ng9AsCBr2fjG6epz3xLjj25h8x8sPP5dWGYl3J29keSCwhthPs6k7WqoMJbVaGuqjJg
         +fOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778001743; x=1778606543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2DVA509Tz2RLR/PrPqbXJHTRanKYIEGVqimJbKfaro=;
        b=qyT9X5wT5JVVn++l+5IqoU50Y2GnnUAB1h4NUcc6+Xrpv71Vk9SfvigYajhJP4RaK4
         iASB2dTpa+/Bh3LMaCLFFLUAebUKHjOtMm6PIzRcUOrtzosgTjynnZuyNxraX/b8kRYk
         xdk/7WkAkyLs3VQC7XjKOXXw1T/k1yRggHCF7V06Mtyc0Wcs/NM1O6e/8udzaZgHXY7J
         2mxP094emDwX8wMns95ArhU+4fj8X3Tca2n5Gt8ejyxrSMm3RmAz9nhBf6S91E1EBuV0
         PtPq229YmPxLCn3QQQcz2xSwVFGxgwtY6lkGTJBOzAG5ZJTOXXhdo/A+Mrci635QN2gF
         cfVw==
X-Forwarded-Encrypted: i=1; AFNElJ/BU390JCdvGWIMq3WAyJTtmoUrQAb8rvjl3Ni30fVJm/QLnfZDvFaHAbQBBJZekXuDVD8QvDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxacEFWEdzD5JwKRCkWAeYy27189M9mof6DZUJSJLNPZEfRDguV
	vDAnykkDj4Bd+7jFdgaYe6a4uncWaQ9/qKoh59i+Cq4WVHb4pKA0vsa/
X-Gm-Gg: AeBDies/zKrgFjfAn9GfyRmi4iz0eA2SalO7En3Vj2OfsyRsxkltDMVJjCffJ0s2BKr
	lyFxwrhdbmtQ7gPEYKp0A62y07i3zm042vqSZ6IZhrTH1w+Qo1gIt03Mmac0AJRbMG2D4FETGLi
	rmBnpL3Qcjxnpzk5Uc0kvhmhJMghkHC+Z7tgxrvaFnF+edI5tUnjY6FwCL5xwMxO6mmBjb5UZrJ
	Jqxfnf++DxnMew3YeE0o7uivGEa93/0dJRDNZN7bOyinNs4y3W70jC4bG9dN/o/3XbWBYyI5Koq
	kUHHf6E0g+TB+gAd9WMkVo9nLSVfa5OUSu8bSUGnwA2E12vUUZGrua3DmaNtFb2TKVXkcb2bem5
	0d4TpIR1UsFEFM8V4k7EVQyQ6Pww7sAFpEVv9vA4ra6GPGMlASwTjiSEpxMv8biToO0Aplq+nxw
	CujdiWFeG3dhx/1S3+LDjQApAKyzqQ+kufyh+SxU5PmK+qD4SP80dhO4Dr+LBpyBjhK1P5FfLQi
	XJ3NtxIfDmKPn1aPgIUNuLZAXoEC9tj2wCiyfWwBryvJtzZAit5BmsCrUujKhEaaApjc2s=
X-Received: by 2002:a05:600c:4f53:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-48e51f4456cmr2315795e9.20.1778001742511;
        Tue, 05 May 2026 10:22:22 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960902sm6640747f8f.28.2026.05.05.10.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:22:21 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	luka.gejak@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v4 0/2] staging: rtl8723bs: fix OOB write and read in HT_caps_handler and OnAssocRsp
Date: Tue,  5 May 2026 19:22:12 +0200
Message-ID: <20260505172214.3650398-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428091621.739680-1-hossu.alexandru@gmail.com>
References: <20260428091621.739680-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0D0A14D1F93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244222-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

v4, addressing the sashiko review comments on v3.

Regarding your questions:

The two patches to drop from your tree are the ones applied from v2:

  41a866092f09 ("staging: rtl8723bs: fix OOB write in HT_caps_handler()")
  e36c54247447 ("staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop")

v4 supersedes both.

Regarding hardware: I do not have rtl8723bs hardware available.  The
patches are derived from reading the code, cross-checking against the
802.11 spec, and comparing against the existing HT_info_handler() guard
pattern in the same file.

What changed in v4:

Patch 1 (HT_caps_handler):
  The v3 umin() loop bounded the write side correctly, but three macros
  that run after the loop access pIE->data[0] and pIE->data[1]
  unconditionally.  If pIE->length is 0 or 1 those reads go out of
  bounds.  Added if (pIE->length < 2) return; placed after
  HT_caps_enable = 1 so that HT negotiation is not regressed.

Patch 2 (OnAssocRsp):
  Two additional issues found by sashiko:
  - The fixed-field reads (capability, status, AID) at
    pframe + WLAN_HDR_A3_LEN + {0,2,4} run without any minimum frame
    length check.  Added if (pkt_len < WLAN_HDR_A3_LEN + 6) return _FAIL.
  - The WMM OUI comparison (memcmp of 6 bytes) ran without checking
    pIE->length >= 6.  An IE with length < 6 at the end of the packet
    caused the memcmp to read into adjacent frame data.  Added
    pIE->length >= 6 guard.

Alexandru Hossu (2):
  staging: rtl8723bs: fix OOB write and read in HT_caps_handler()
  staging: rtl8723bs: fix OOB reads in OnAssocRsp() IE parsing

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  | 10 +++++++++-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c |  6 +++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.53.0

