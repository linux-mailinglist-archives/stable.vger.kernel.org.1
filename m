Return-Path: <stable+bounces-245298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AlACkoLAmqknQEAu9opvQ
	(envelope-from <stable+bounces-245298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:00:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5284512E24
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 903B1301B6D1
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDDF43D502;
	Mon, 11 May 2026 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ8RxoO6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FADA43CED5
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518698; cv=none; b=n+9pFTB4byHG8t7XZSz7kXQC0VFcm0Mh2S/028iTFAbTkV+kzOOMDiTjvoeD4944I1oSgRPiq8K4MjGqOq0XevPydn1lV8957FQrAdOLnvqyW8sokVKZv5MgUv/fYH0MtIKq/xJv5LhLwSWppJ09cHlMX1WVRg7FC+JCM0pPC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518698; c=relaxed/simple;
	bh=HKYwCKFrxrTNxIuDqdTGdZEBRIKmdUAkdTkcZIem9Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZCSN2gVfQ9kDMwco9ziQKDxSIwWtjDCL2A/UjMNo6x0owJMQpU9hQUH09y/fYMDQYRHPecn1O/iDUGfEWXeh+BNRXMRtYAzs2XD7fch9mfc2rRA8zWjA8kRM0xBRztuVoXvlgOyglTfCdNWjMe6fQ9QM+bMVjBWaDBEXO4NW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ8RxoO6; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bccb9dca1beso342543466b.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518695; x=1779123495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tmJuGZ35NiKieokNGtQzmCewPJbbbcM3RBjjaKzQsfU=;
        b=iZ8RxoO6VEH9E0QyeWmkRwMgZRF8/dRfMiPAnt+sVyIuG77a084fG2sErWqZF7MX5w
         ccIuSqmdR2f5sGTYKG3mBICs9Glg2Y9RMrkecZiIUXAQa4Xb4VygGS+bA9s2gbheJm1c
         vZ8niezpOUss2KAyg2M9yXBsd7dn3RetNxM3LdQKJ+04Pdk78GxdmGzL6AoZqXvVvKNB
         2QlW9obyJkF+ibhRRMdunfHbLCdT0evXDsADp7Diy6mTrMusGtBKq9FnDYssCWL5CPBM
         wL3qCnggMIgTx/lQ/W1oMjaz2gFhFE/2AorIDrcpn4rphEoVgN3bqWFyD65b2AEHs7jO
         6hcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518695; x=1779123495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmJuGZ35NiKieokNGtQzmCewPJbbbcM3RBjjaKzQsfU=;
        b=Vb8491ce3Td1FpCw6eH6TCkxW6jEP4a7LdNskB3kKUmX5MPOzG0b84KvOw7bhTD/x9
         F5doym5HY3ioyl8Uu6aWAD74kUtwSTDZv2L5Z6J6ZU+/uUBqYZga8PKtIgnu2ZHd1wfs
         X3r7CG1lQ0En/+jJMbfpNgVypQJbKCqdBpRD+xjPpt/wIZ1bIH+qQYvBrQJwYcWIGtN5
         6m4MF1pRBw/bMHwd1hDRDqcUXqfbqS/nf47eDdFZip4pxhyF8UB3+5yjYF2qimoa1Mv6
         zNlD7uUmADEVnIrTTvDiJiOYcS22T059h695Eco6OyPu7OyzVmK4GXmQ9C4b/Ucr49b7
         1+SA==
X-Forwarded-Encrypted: i=1; AFNElJ/O13gUNs8O99fDigXukZ6IXnBssoXeFpjfECK+71Gl9cTt8AlaQVTQo3LsPedarinl61LgM4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeeU9ENfqIp1lDFlvFIpHX635PRK9EJ/ma89aXvxIRsGkyIjXE
	BX/SWqzGbIAzoLcW3ZyEuSw8Ts6FhoCjGo+n8wl6h9yWw77JGB/JKHmX
X-Gm-Gg: Acq92OHFSc04zqQ207qKK9bqtZpjulUFD+CRBKF02cdTD26cnELwkHhMv+jHdvCIRyT
	f5TBIn9ozqvMwIRVx8jOJZ3vkFn2LQX1xLBtzNjYP65vVUjOjenwWhH+WuLuWoEtanKV4xW7kZ7
	xx/+YGdfnDZHuvxlqsgFrzDeAIS3/sI0CJPfgB1v/zIGHyZmG93iKX7asGkFx+UgmSxY4Z//j67
	Srf8GVm9fO7ZSoC0+LEbSesbNVKOhMAr+RLmaYNdIXTFNBF1URd3ImUr3ctpATcMkJNNgTm9PIq
	Mw7iqRUstnK2iwPbVILJWI4SOZn8xrn30C7v1oHL0Ed3KLBbLPmje9H+I20lzPobGcNoYw9olHG
	PtRGV5ZCFy68rXtgS8IRGrkYMofTUVmZ6vV0drE73nioznGqTm4xTrkMwbtFuFT8s4ARfu/cBme
	RlANzM96kYKZl0aNCytNHlys27wtH1HSBDLh8rWrw83a1ZObhwob6batunudBPkQG7NZjqPWzHp
	CTuOL3SrFFqrPt2A5nluN3oe6I4Qw4hKZDvPSrxs2wdw1Un1NwB3Y+b1JyKQ5/4rVZvUx0X+h9X
	jywW17J3w9k=
X-Received: by 2002:a17:907:c81b:b0:bcc:d84b:5663 with SMTP id a640c23a62f3a-bccd84b5bc9mr502548666b.33.1778518694531;
        Mon, 11 May 2026 09:58:14 -0700 (PDT)
Received: from ahossu.localdomain ([2a02:a420:2368:9048:c0cb:8552:96ce:1210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bccffbac588sm325319366b.6.2026.05.11.09.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:58:14 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: greg@kroah.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 0/3] staging: rtl8723bs: fix OOB reads and heap overflow in IE parsing
Date: Mon, 11 May 2026 18:57:40 +0200
Message-ID: <20260511165743.1588637-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C5284512E24
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-245298-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

v5, addressing the sashiko review comments on v4.

This series builds on the fixes already applied to your tree:

  83255a78cc46 ("staging: rtl8723bs: fix OOB reads in IE loops in issue_assocreq() and join_cmd_hdl()")
  96bcf0a58df3 ("staging: rtl8723bs: fix OOB read in update_beacon_info() IE loop")
  92f3954ca9e9 ("staging: rtl8723bs: fix heap buffer overflow in rtw_cfg80211_set_wpa_ie()")

Patch 1/3 adds the remaining three fixes for update_beacon_info() and
bwmode_update_check():
  - An unsigned underflow guard for the pkt_len subtraction.
  - The WMM condition is reordered so pIE->length == WLAN_WMM_LEN is
    checked before memcmp(pIE->data, WMM_PARA_OUI, 6) to prevent the
    6-byte read on a short IE payload.
  - bwmode_update_check() now rejects IEs that are not exactly
    sizeof(struct HT_info_element) bytes, preventing an OOB read of
    infos[0] on a zero-length IE.

Patch 2/3 adds the remaining fixes for issue_assocreq() and
join_cmd_hdl():
  - A pIE->length >= 4 guard before the 4-byte OUI memcmps in
    issue_assocreq()'s vendor-specific case.
  - In the WPS truncation path of issue_assocreq(), if pIE->length < 14,
    the IE is skipped rather than passing vs_ie_length = 14 to rtw_set_ie()
    with a shorter payload, which would cause an OOB read.
  - A minimum length check and sizeof() fix for the HT Capability IE in
    issue_assocreq().
  - The WMM guard in join_cmd_hdl() is strengthened from pIE->length >= 4
    to pIE->length >= WLAN_WMM_LEN (24): WMM_param_handler() reads
    pIE->data + 6 and copies sizeof(struct WMM_para_element) = 18 bytes,
    so a minimum of 24 bytes is required, not 4.
  - A minimum length check before casting pIE->data to
    struct HT_info_element * in join_cmd_hdl().
  - i += changed to sizeof(*pIE) + pIE->length in both loops for
    consistency with the header bounds guards.

Patch 3/3 adds the remaining fixes for rtw_get_wps_ie():
  - Header bounds check: break if fewer than 2 bytes remain for the
    element_id + length fields.
  - Payload bounds check: break if the declared IE payload extends past
    in_len.
  - OUI length guard: in_ie[cnt + 1] >= 4 before the 4-byte WPS OUI
    memcmp.

What changed in v5:

Patch 2 (issue_assocreq, join_cmd_hdl):
  - In the WPS truncation path, v4 set vs_ie_length = 14 and called
    rtw_set_ie() with pIE->data even when pIE->length < 14, reading up
    to (14 - pIE->length) bytes past the IE payload.  Fixed by breaking
    out of the switch when pIE->length < 14 (sashiko review of v4).
  - The WMM guard in join_cmd_hdl() was pIE->length >= 4, sufficient
    for the OUI check but not for WMM_param_handler(), which reads
    pIE->data + 6 and copies 18 bytes (total 24).  Strengthened to
    pIE->length >= WLAN_WMM_LEN (sashiko review of v4).

Alexandru Hossu (3):
  staging: rtl8723bs: fix OOB reads in update_beacon_info() and
    bwmode_update_check()
  staging: rtl8723bs: fix OOB reads in IE loops in issue_assocreq() and
    join_cmd_hdl()
  staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie()

 drivers/staging/rtl8723bs/core/rtw_ieee80211.c |  9 ++++++++-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  | 26 ++++++++++++++++++--------
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c |  8 ++++++--
 3 files changed, 32 insertions(+), 11 deletions(-)
--
2.53.0


