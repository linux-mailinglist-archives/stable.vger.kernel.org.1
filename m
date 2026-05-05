Return-Path: <stable+bounces-244228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDC8N9sr+mlXKgMAu9opvQ
	(envelope-from <stable+bounces-244228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:41:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A4D4D2389
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94027303FDF3
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C075148C3FE;
	Tue,  5 May 2026 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGBRTXao"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA148C411
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002708; cv=none; b=lUGbLuhEXVvDHfK2QF9MmexeIghaHmKVdh2zsdsDUkNdlwZBc60cj97IEwdOWGWYetrFkzjvSZRZc+Rawf2hG4+7cFYDFB7DO9EkzyrThO2ADIXZzARIcpw0hj6mXUU1QRa2Ba+7Udm9KyImpsEqsuluDeaREIg++1yw0O0NqOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002708; c=relaxed/simple;
	bh=INBOCCEs/oacPKzfuDtT4wyL09tCY+XD1saY/b1Qxm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVbEqqQXe+NEpqaFl0Leca7Edlkfp42aEjJZedZ1eBEEucA9RHbY3wc2Gq/oIWb/ujdyJCulKENRpkbXyCUSSVGYHcvDnrwpjj1REQaVmEgf0can65CaJXBjJmpF3bS4s1wFY2Uk06UMTJzY5MaS6YywILPpt1fwC1RqOS0JAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGBRTXao; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891b0786beso37352995e9.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778002706; x=1778607506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2pGThJvtdEZffGBgV5Up5wNelL6nr81TpmNS4CpWqE=;
        b=RGBRTXaoTS4M+VAJv/1ea0T7VZps12uZSu9ontPhUHtfPQMGqMmGgy8dng8VjRLP/8
         erPfUO0oqryspOFY25a5hbOrT97mFrlVifqOwB4ecgfr1EYnSsahjsbVhaawh5jJOcqA
         DtsonXd21JiC7USrFBJ/I+3oWs6jf36v8BwyBNv63V7qUAnPUryyCGuxKjhOYk9YH8Cp
         nZhvorX/0OjmhvlLKADLtyCqHvmjxAzphnjRaivCUiuflqn1MItCxDQ59awd5zzA189W
         eFNCE/nJe8iYNo+gKV6ZAC8VICRE5OUSnyJBQ0i7YELDqmd2w5z5ON/B8ZlxWMeIC72S
         ehaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002706; x=1778607506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t2pGThJvtdEZffGBgV5Up5wNelL6nr81TpmNS4CpWqE=;
        b=b+v79tMOMBaXo6DMbUq2Z1ghkP8bBU1D7cuKB1n5/TBdk7nsh5Hg+IlUCNwcJ8CewC
         UEiwgFZdIvIRJXrF8i5jS4rJv7tTPK9TFGLCRDCxofIqXBeevPeyXfMqVnPugHl/ROFP
         QIW6xyPpw6S/7xIaMtZg4W/jjf0OcSeFPstzpMS4W7FCdcob7vg/eNi7jcNil0N+4vrp
         Ylz0tuy81ePxywsu5zEweHrxMdYbeIn0buUkH5UN+WPVBg6EEmSQ1EqRecPDLylL0E++
         Svwq+Sn+3iOQL3/M2RjGXwRS1B6/UaGpIFrrJmafaHgLz4k19YD+x7dvKud1/tLppDwQ
         g07w==
X-Forwarded-Encrypted: i=1; AFNElJ8x54+Wy5s+yRZCCQyc2+UbQhdfW38bJHPtWwo11kRoFKKQRB/IaTiAsbZukpXuwwASUJGjd+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7zjF7VHeS5fZfyCIMbUAaUoN9E1cCv83v+WiZAtEMv3VA3bdB
	H+0freoX2HMzdOz5FV8co4+jkNsK6XdThiUNaLY0sEc5oOUmO93VcZGU
X-Gm-Gg: AeBDiev+7q8RGNMbdwdlG0eyNHGMDr2mcilqxms24Ph5U4FvHWS4DWuQtr0tP+R0nhy
	x50bas+DW7dKCmBn7kdGiJKGvDE/KZgmGVQpcc5Ewcu4DtZ1jXgbOTtuds6Jf7EaVx/beP4fa8I
	GwIQOXIqo2yRd92WCconkJwnzp1/1FbEKgcIIEHWP2OQ0pc0LQFAc3jNsfE7g5hFcIN/NeRmQVw
	RzGBEBugtwNQgUzMSRc4jl7RycG/7HKu+S03MXIXFNy9SmA7zZzu5OTelcHnD0oL9aWKa/538lL
	O8KCZNMKx1oH96JVLkYWd5/VeNVLa78KnVV96nBNV4rQV03MkTWeyuGZHZuzBRALsAN8hNwdHlD
	UmsgT0FJPiQCMx2kskfzNVW3gW3doZZ2tv7y3PdeDLs+rmrDkqfN60/vvB7+skUL8xmFddlxntM
	PHCAGYTyNZICGfwMAbomyzmw1GopaGZ3m5v+d/YYVRdWC01Q2PP3revtP2+VpZKmNkQogjmWcz1
	K4w6D2+B7GrCkC5B0PO2/Gma2XJWSMc7f98ltXgX42+bTaDrGn8GGU47abg1yudbdfye6s=
X-Received: by 2002:a05:600c:8b08:b0:48a:5501:7995 with SMTP id 5b1f17b1804b1-48e51f32ca9mr3729715e9.18.1778002705492;
        Tue, 05 May 2026 10:38:25 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301ad1sm655473875e9.9.2026.05.05.10.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:38:25 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	luka.gejak@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v4 0/3] staging: rtl8723bs: fix OOB reads and heap overflow in IE parsing
Date: Tue,  5 May 2026 19:38:15 +0200
Message-ID: <20260505173818.3674164-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050436-italics-clumsy-e83c@gregkh>
References: <2026050436-italics-clumsy-e83c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38A4D4D2389
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244228-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

v4, addressing the sashiko review comments on v3.

Regarding hardware: I do not have rtl8723bs hardware available.  The
patches in this series are derived from static analysis of the code,
cross-checking against the 802.11 spec, and reviewing the patterns
already in use elsewhere in the same driver.

What changed in v4:

Patch 1 (update_beacon_info, bwmode_update_check):
  - Added unsigned underflow guard: if pkt_len < _BEACON_IE_OFFSET_ +
    WLAN_HDR_A3_LEN the subtraction that computes len would wrap to a
    very large value.  Return early.
  - Swapped the WLAN_EID_VENDOR_SPECIFIC condition so pIE->length ==
    WLAN_WMM_LEN is checked before memcmp(pIE->data, WMM_PARA_OUI, 6)
    to prevent the 6-byte read on a short IE.
  - Fixed bwmode_update_check(): changed pIE->length >
    sizeof(struct HT_info_element) to != to also reject IEs shorter
    than the struct, preventing the read of infos[0] on a zero-length IE.

Patch 2 (issue_assocreq, join_cmd_hdl):
  - Added pIE->length >= 4 guard before the 4-byte OUI memcmps in both
    WLAN_EID_VENDOR_SPECIFIC cases.
  - In issue_assocreq() WLAN_EID_HT_CAPABILITY: added minimum length
    check and replaced pIE->length with sizeof(struct HT_caps_element)
    in rtw_set_ie() to prevent reads past the HT_caps struct.
  - In join_cmd_hdl() WLAN_EID_HT_OPERATION: added minimum length check
    before casting pIE->data to struct HT_info_element * and reading
    infos[0].

Patch 3 (rtw_get_wps_ie, rtw_cfg80211_set_wpa_ie):
  - Added two bounds checks in rtw_get_wps_ie(): break if fewer than
    two header bytes remain; break if the declared payload extends past
    in_len.  Added in_ie[cnt + 1] >= 4 guard before the 4-byte WPS OUI
    memcmp.

Alexandru Hossu (3):
  staging: rtl8723bs: fix OOB reads in update_beacon_info() and
    bwmode_update_check()
  staging: rtl8723bs: fix OOB reads in IE loops in issue_assocreq() and
    join_cmd_hdl()
  staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie() and
    rtw_cfg80211_set_wpa_ie()

 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  9 +++++-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 30 ++++++++++++++-----
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 14 +++++++--
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  8 +++++
 4 files changed, 50 insertions(+), 11 deletions(-)

-- 
2.53.0


