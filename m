Return-Path: <stable+bounces-274677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sn18LF30Vmr8DQEAu9opvQ
	(envelope-from <stable+bounces-274677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 04:45:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3990B75A1CB
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 04:45:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JD8VwKIU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274677-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274677-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D05F301F14B
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CDB38A702;
	Wed, 15 Jul 2026 02:45:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119BE36F415
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:45:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083547; cv=none; b=ZRmvtdkG2YVps5tjKZNXgUpPP/LHWQWiS12KHaPQl7rOKQFQKSYhTJss/vq2aDIoMTBjLKFFM7SA6/iXHY0UXLHiKMWcb5Ub3SZL5pGmz2zmApUPc6myNBSHMRAsS4uHoJZzqAyjxIEIKr/3WM1LmsmFpjPE4wn79csMf//cZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083547; c=relaxed/simple;
	bh=oRazmrbbw/E9EbKfPye/XDabSaDGq6niu0baIpJ5qJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6AkMv1Wa/1s7D3dXv1Vc1JuvzZzca3d7CqfbJFqZLcGhivMUoAvc3f98wAxX82TIvWqgNpwcvvgawSD03+m+LdLeDmFjDRe4pAm7tFMO4HmFfK0kGlFXUHHeT4B0MyjwK0Q+NVmRpHyny+UuZVoRJ+EYZBo+IgF8TN4agOqL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD8VwKIU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7F81F000E9;
	Wed, 15 Jul 2026 02:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083545;
	bh=pHxOhuWSIYgU/PTQEkUJ8/NB3l3o53g7PaCD1JWmio8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JD8VwKIUsyIkMOaeFl9C3bNG3l+GXMg1bbvdd2Oeyqw4l3Lys4RdU+UDO4uCOwKgC
	 9lAEfIeohJJcRZTBkaRHEhBxORI0jqsXoHxXCAK4pTqRiGTfAm4AiMOlSpOlZPynlb
	 pyqH0aXz0U0Va0A5MhTH5yuNTv918ivGi2qrwyKwTo95Vw3cAhGXjSBCf2Akn+HZew
	 hUYR5yVfa715r4OYISVeaL9ij9KoXQnXI8HXvIoGQucqgWvqnbynMr03Ca6/oOMRQH
	 50G4nXQuuZ5jUqik19l1UqyutWZqZJnwIaTuvcbGf2vWsLDXuS8ExVyjoEGYdkhXRl
	 dqMyTn97eiyVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 01/10] staging: rtl8723bs: remove DBG_871X log argument
Date: Tue, 14 Jul 2026 22:45:34 -0400
Message-ID: <20260715024543.105642-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071316-urchin-unenvied-752f@gregkh>
References: <2026071316-urchin-unenvied-752f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274677-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:fabioaiuto83@gmail.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3990B75A1CB

From: Fabio Aiuto <fabioaiuto83@gmail.com>

[ Upstream commit 42c3243ff23d119331a8ace011e0c18b222a1138 ]

This patch prepares the application of the semantic
patch aimed to remove all DBG_871X logs.

One occurrence of the DBG_871X macro has one
repeated argument, that's not even comma separated
value with the previous one nor a format string
parameter associated.

In normal conditions this worked, for the macro
is usually not expanded (the do nothing behaviour),
but if I try to apply the sempantic patch to remove
all macro occurrences, all macros call after that
abnormal declaration are left untouched (not removed).

Remove all of the DBG_871X logs as they currently
do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged, so just remove them as they are unused.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/3473925ae9ee5a3bcd0ab86613dbce80b6d3f33f.1617802415.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ed51de4a86e1 ("staging: rtl8723bs: fix OOB read in update_beacon_info() IE loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 6979f8dbccb849..2a60c8bb61f95f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -923,7 +923,7 @@ sint ap2sta_data_frame(
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s BSSID ="MAC_FMT", mybssid ="MAC_FMT"\n",
 				__func__, MAC_ARG(pattrib->bssid), MAC_ARG(mybssid));
-			DBG_871X("this adapter = %d, buddy adapter = %d\n", adapter->adapter_type, adapter->pbuddystruct adapter->adapter_type);
+			DBG_871X("this adapter = %d, buddy adapter = %d\n", adapter->adapter_type, adapter->pbuddystruct);
 			#endif
 
 			if (!bmcast) {
-- 
2.53.0


