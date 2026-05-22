Return-Path: <stable+bounces-253658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFGpDIOnD2rCOQYAu9opvQ
	(envelope-from <stable+bounces-253658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:46:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4525AD895
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8102302445E
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 00:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27360282F34;
	Fri, 22 May 2026 00:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOmiqFM3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DD289367
	for <stable@vger.kernel.org>; Fri, 22 May 2026 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410774; cv=none; b=dJibHp+VKRv+WIa0prwX40QACRpgNM8v0qMtFlhvJE756mDyCLgrp/7DiZDqie+3vzz1kRI7Cg3m37cFmwYm7ZOWvsU5WnC9qGGQmaa7uNPuMuo6pmafW98TRfU3mqfGFdB6P3OLrWFP5lwC6eFCyQIHg5IW+0c9fvwc/G4/dj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410774; c=relaxed/simple;
	bh=HrGZAnQwY9MJbd/wv7fd5eZFlQP7idEHOmDb1AkwUaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtTMBkkVUEDATa0WsnKU9DpAGHh0LxCdhifexCFYfNNNfDaGZMtHylo32sS2aMC+FZxkCdDCR7ETctHaBmSOC/sJn/cdGLCi2tWj97sSJp5wUVj++kMFqGYBayWx+/7lewGU4/hpqZQdQKMvR556xdxug0ulvxhLzrcvQMyw8EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOmiqFM3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68852b58d87so2007500a12.3
        for <stable@vger.kernel.org>; Thu, 21 May 2026 17:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779410772; x=1780015572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuMzZ0oPIB63SQlMEwBPtCu4kk4sfKKOYS1JICO/Nwc=;
        b=dOmiqFM3lj29GWbIcJQ01h1f5w7HS30Ctx3zmow+b4R63it57Y8Dl8zZLNX2IgE0Ck
         SyVG1HNUnxH/SUwChPyBDgzj7F9+9xg0z0C5271E41WOicknE9IhVH5LMgA+pljC6S5Y
         QI8grfUcOskL/dDO3tNB9k82OJRQaHL2bv4VbHqPs/oumlqWx/4+0eqTYIIoxT8qpl27
         HfJ8eugfIvETMMIX64c/f/lvlcEB+mVpT4naHZDECnYby1d0ImYG0vzTWINnm/wmjHVO
         smmwDcStmduLLYDxnq0KV8XhawvO4WyeYc4krJJ3kr3tUbbYR7jDGDlfh6JROWozvqvx
         RPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779410772; x=1780015572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GuMzZ0oPIB63SQlMEwBPtCu4kk4sfKKOYS1JICO/Nwc=;
        b=a8rzWHxwmRrDlPHc0/CEwmfzpCHUFX6UK5/JzIVBn7c1Sle6lyFmmj3ePs27ZdVJGP
         sCftgj5FenV4KDFI7v+3yKSYVx0duKB7/uVShFGVbE0P3ejphoR6JcqY/I8dK9G7iAcl
         aXhLV9XZdVEweH1riak46g+pcjOUVQNAXDcH3F29KzFhLncOg8hxIdGDFwAJLv7x9WO6
         EJQ+eDfIUs+SZJOaBXyVhcjHSgdb/I74eaVZE4ywu/MICu2pRfZA13uBWqRPIqsZqXjX
         ia9mN9/NKUf6MV1K55G9ZSEwl3R1T1CkKZGYRDI5F1jhFli/uMupqdd+ZfkIJxSFi247
         ZK6Q==
X-Forwarded-Encrypted: i=1; AFNElJ87PTNaQegmE47/vIwNOIRLbBk2NyYKR4pieG6blmp4FTz+KkMTksIfvIrhseGKa1lFNN0xSys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg6qmE8WMT2bJHgTUASdb2bRfP5k0vT11MQRiBQxseWIoz/ioQ
	9BAzPo6JXpTpDdgCWCswLWdteXwzfCUILf3IcR9YhuSdmOIjy5poezH8
X-Gm-Gg: Acq92OEUu8giU8Qd/XEVPl52ZGyP5OdAcRsjPQFxSPzeOUdxn3QoC5eLDD8nw/FfHWh
	0haXEMH4LGZI/2mCT8cdghYOAm411THv2crJIcRDeoc9Jsy92R6i9Z1fMJ2m+xhJMWkdVLD4yHK
	iyzYYPlVXv4mx3tG7whtpWsqXMipympzAowLcuvQrJ4SJTZ6+/VK4yMOirQglo8TpSkJzkozQs5
	hQKAnTry8w3GFbNLBmjy07l1/0TdkZLSJsNuiZtXaYLfPqclteKeF4GLZnkcSimRNpmcSbpWZLp
	+d6buLQJ0jkXMCo6cQdVjLgeHWA0YGTk/RrFaItcSYvCMDP/2kmRDBNCD35jc/XI7BMphURQ3co
	vsrxs7eno1QA/ehz0LcazhREwvI/XGMBgxGmuqSPbYzJSx9NiFYxAubv0Sj5/g1rSfWRPakn3PN
	SPt6zvEDTw/JCz4NnYosKetCHxmnlK32R5fjsDlMv8WEOutfVaa0soYgnwSDhkSlRwpMEsQuG16
	J8Whm94trgSwr8vMoIlWGBDqs9Qrmg4BEW43KoW3PPHbnlc2AdqOY45EOauQZ3gXGvWzjgS0wut
	/Ffc9ek2dA0YVjmtoqRhGJ/B14fX
X-Received: by 2002:a05:6402:4495:b0:672:bdaa:3e75 with SMTP id 4fb4d7f45d1cf-6889c432190mr513119a12.9.1779410771911;
        Thu, 21 May 2026 17:46:11 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b72cbbf3sm3535a12.0.2026.05.21.17.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:46:10 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 2/7] staging: rtl8723bs: fix OOB reads in IE loops in issue_assocreq() and join_cmd_hdl()
Date: Fri, 22 May 2026 02:45:26 +0200
Message-ID: <20260522004531.1038924-3-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522004531.1038924-1-hossu.alexandru@gmail.com>
References: <20260521130330.754181-1-hossu.alexandru@gmail.com>
 <20260522004531.1038924-1-hossu.alexandru@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253658-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: BC4525AD895
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two IE parsing loops are missing the header bounds checks before they
dereference pIE->length:

 - issue_assocreq() walks pmlmeinfo->network.ies to build the
   association request. If the stored IE data ends with only an
   element_id byte and no length byte, pIE->length is read one byte
   past the end of the buffer.

 - join_cmd_hdl() walks pnetwork->ies during station join and has
   the same problem under the same conditions.

Both buffers are filled from AP beacon and probe-response frames, so a
malicious AP that sends a truncated final IE can trigger the issue.

Apply the two-guard pattern established in update_beacon_info():
  1. Break if fewer than sizeof(*pIE) bytes remain.
  2. Break if the IE's declared data extends past the buffer end.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 884cd39ec756..c646dc2a1741 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2931,7 +2931,11 @@ void issue_assocreq(struct adapter *padapter)
 
 	/* vendor specific IE, such as WPA, WMM, WPS */
 	for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
+		if (i + sizeof(*pIE) > pmlmeinfo->network.ie_length)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
+		if (i + sizeof(*pIE) + pIE->length > pmlmeinfo->network.ie_length)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
@@ -5324,7 +5328,11 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 	/* sizeof(struct ndis_802_11_fix_ie) */
 	for (i = _FIXED_IE_LENGTH_; i < pnetwork->ie_length;) {
+		if (i + sizeof(*pIE) > pnetwork->ie_length)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pnetwork->ies + i);
+		if (i + sizeof(*pIE) + pIE->length > pnetwork->ie_length)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:/* Get WMM IE. */
-- 
2.54.0


