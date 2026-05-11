Return-Path: <stable+bounces-245297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCLAC9ASAmqIngEAu9opvQ
	(envelope-from <stable+bounces-245297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:33:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A441513856
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 024EA301CED0
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C127143D4E3;
	Mon, 11 May 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luDFbtHv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD89425CFA
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518671; cv=none; b=XwA0karGfSbXpJApQ9YGoMLmMG/hrsqmiEn7SX6r1NnYajdHUFK8Y/xgaibobt4f9PYZ6oDOS3SUdxXKtDKKTu5b3EIOgXNwxij18C2z4Sdje6E/jtHqoMuKOpN6M+k+TYk66JkIEBh9gRtbSixRbaitw9mzH/uJ1yknt+A2ETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518671; c=relaxed/simple;
	bh=HKYwCKFrxrTNxIuDqdTGdZEBRIKmdUAkdTkcZIem9Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzFUMTPflVhTwDARb1fGSA105BlRRl9Rg3ycU3FKN0dUDnYOrc8rsdTVICEOjFRcbiGiBz8/x5dTM435f0TctP7Sh/HFOVi0sJLWtL8MV0tnc0KyAWvGSYEO4DiRiRMW8t/Ii3K9aNcQJHkYo/8qnLRokU7ZRDykYChNE9VWKGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luDFbtHv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so721981166b.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518668; x=1779123468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tmJuGZ35NiKieokNGtQzmCewPJbbbcM3RBjjaKzQsfU=;
        b=luDFbtHvgzGUFa52FACKpsIwblMK3O6UFS0zBbIY8bXG9tMb2erljMq2qAXpYQ9tNP
         yBillEPexZYxdgB66Wh98Ly5UuQVtTM5nqyPmPGQGEfz4J9Mn3vE1I7G9d5cMveXteak
         8+OX5IdtWMXlixVHPqinvTkwcW+bRh12BQt7UH1HstxFE1Hv85IOGUOHopoD9OQezFOL
         6MHEIgwBiT6cQJ+gj5PBiIGpW8UTII4v+O0P8v+ectOjeWrAX9HKVAf46JZUnD2EHGGG
         2C3njx6tWZbNUc/V/IIJ0/bOx5SxVUbLM82yGU5GR4B84Ni484d8IGiz3IByhO3zmqfO
         JNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518668; x=1779123468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmJuGZ35NiKieokNGtQzmCewPJbbbcM3RBjjaKzQsfU=;
        b=W3yKXHUjceGBKqvROlrk6uwGEAq5Yv2kYOxmCb/igPTw8mfsGfyVZPOWonqbQlzghe
         aOsJeXILs1WaTRfP5FrULra4HBd9xXOJgmiDj2I6Vvg0gmUKLIJJ8RSmNYlD7eMCjIhK
         F8plSdJpHmqwE6mbtC6DksTjpiLBMoe0jjsXcD2UegWf7oWmjusGHDJA4MddtO5cGjzh
         QkZ6mm1F5yDLOVZeFwLM6NCGoLPwmboxcPxHTgF4EWXmzV7P+Rb4SupkHiRmcmLej3vs
         hAQ5lI/dQxvz/zQo2FTn2IH1hvwuiZjJQ8fRjQ2UYNxhbKkcEdGghPAyvqsPl3TrPUJu
         6fBA==
X-Forwarded-Encrypted: i=1; AFNElJ/X9TRvj+/ESHVkCH49deTPqh6/PyYucKKlcBS/zvPgRlV7DoK5k/6lgXJwa2T09g//8sMGxK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcY0f57j64OiexRXkO6k2ZhM+KxSunKlyjV1FOs3/qH7WY9piw
	fgZmBwVoNOQBvbDPZ1CHcCweK0aVbuBqGGS7u00j/zzPevvK20/TLeax
X-Gm-Gg: Acq92OGb1YRxH17B5xBYLWt90PHTFVYreXOXrKTWgrrlyZkcu3YMCbFPB+MrPMHyT+7
	T4SydiSpgu8BNBsyXJ8/ipesMYTP6IreP1CuDeskrgJBufL/HQRNEkdZzwdjNlOEm3QXDazyk2x
	IPPXtMwt6DqL+c3KMu/8ovyvB5MnIBKs1lK++y0L8Zs9Bire7xdGGDfuqm/82tXaOVsPxG8M7s1
	qsVg554Fbzgw5ZkLPgPIT2aVEmH+EH+T61j0RpsN86Ne6HB0jZT1T/P7yXsBq2+xkxO30Fhemel
	45jUT5tvoHm2X4XmvbSjgsmdq1+CxcQQn9becdWDSn3bKBQ8XxrEafT5QxYeDgiguDBm5+uBcsa
	xX/wQWUn3N//QJsMGeUE68BpCxsPEQm6+d0U4oQQHx21rEX3VmfXKKiwLOxf2PwzB6PmolXrTaO
	6yglljybRy+lunimD+c3tx+YGqSKREYxPIrum++pL/3B/WEmW2O/ILK7d0YiA5bK0BJar/lzpQ7
	dz8y981syIM3ZTW0li7vQywvdQggjGpzG6rnw2iHzAn5EQ0Klv0V4p1GZBZeM37qQ==
X-Received: by 2002:a17:907:6d16:b0:bd1:4da0:b0d5 with SMTP id a640c23a62f3a-bd14da0c8f7mr201249366b.17.1778518668108;
        Mon, 11 May 2026 09:57:48 -0700 (PDT)
Received: from ahossu.localdomain ([2a02:a420:2368:9048:c0cb:8552:96ce:1210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0a6fb24sm3928280a12.0.2026.05.11.09.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:57:47 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: greg@kroah.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 0/3] staging: rtl8723bs: fix OOB reads and heap overflow in IE parsing
Date: Mon, 11 May 2026 18:57:30 +0200
Message-ID: <20260511165730.1588543-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2A441513856
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-245297-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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


