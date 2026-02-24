Return-Path: <stable+bounces-217917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO0mLoCnnWmgQwQAu9opvQ
	(envelope-from <stable+bounces-217917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 14:28:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F046187A9D
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 14:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A0CD302AAD7
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480AF39A806;
	Tue, 24 Feb 2026 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mB8O8O4B"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4A39E16A
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939651; cv=none; b=GJsHgrvVVANAE2aBtMJOr+DCURBd6uBXVMRyH0Hn6kjgU/y+uI7bbxMEn0n4jm+lprv1VAfpZGJb6SY3uZAnlyETIZwzDSskr8pVtidVk1LWwjqSGblTpU9UpB1TJHUgjH4hvACTbsDouAN4aeBLX1iA413vgZjhs/29h7PgxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939651; c=relaxed/simple;
	bh=3CRa2xqFPuCqir1qs/FRWzim9splHWlfsP95dW2c6jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZ6kJ2T5Tb0LOjJWmUQDt8x6NwVLL2lc7nFZOkYCQTbmZxMhs7C8jtgj/uj9kzsAqgyVHtr8LZiVAcnqZ2//EK1no+tsQcEvfcz/gAHbljOvAuFh3buBsHjyqykzIy62aAx+8E8j00yiDOhDnAAp8ijUFW8BuIhXd4uwUAFrCK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mB8O8O4B; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771939648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PT92cYBr253vss6P3ozpdqaZBeLr/if4yR/Go/cY8jA=;
	b=mB8O8O4BTjOfivi9DdiTiWB+gA8xtWI8KImf6/HK9cSB3lWMH1Lonm+xi/rjtmSkxINF1b
	wrkisgntETYmG5oLb29vG8exzTnhe+RTi75M68DEsWIASfrIzf2auhqfNepk5U3svIFPCt
	ktUNdp6AQ/YX/wi41JSaOFT0mFxfl9c=
From: luka.gejak@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] staging: rtl8723bs: fix potential out-of-bounds read in rtw_restruct_wmm_ie
Date: Tue, 24 Feb 2026 14:26:47 +0100
Message-ID: <20260224132647.11642-2-luka.gejak@linux.dev>
In-Reply-To: <20260224132647.11642-1-luka.gejak@linux.dev>
References: <20260224132647.11642-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217917-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 0F046187A9D
X-Rspamd-Action: no action

From: Luka Gejak <luka.gejak@linux.dev>

The current code checks 'i + 5 < in_len' at the end of the if statement.
However, it accesses 'in_ie[i + 5]' before that check, which can lead
to an out-of-bounds read. Move the length check to the beginning of the
conditional to ensure the index is within bounds before accessing the
array.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 22dc36e8e38a..2bd6f5367bdc 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1988,7 +1988,10 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	while (i < in_len) {
 		ielength = initial_out_len;
 
-		if (in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 && in_ie[i + 3] == 0x50  && in_ie[i + 4] == 0xF2 && in_ie[i + 5] == 0x02 && i + 5 < in_len) { /* WMM element ID and OUI */
+		if (i + 5 < in_len &&
+		    in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 &&
+		    in_ie[i + 3] == 0x50 && in_ie[i + 4] == 0xF2 &&
+		    in_ie[i + 5] == 0x02) {
 			for (j = i; j < i + 9; j++) {
 				out_ie[ielength] = in_ie[j];
 				ielength++;
-- 
2.53.0


