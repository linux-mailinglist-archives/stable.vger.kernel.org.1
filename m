Return-Path: <stable+bounces-274598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QnEhOnfHVmpxBAEAu9opvQ
	(envelope-from <stable+bounces-274598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 01:34:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CEA759738
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 01:34:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S0XLkRsI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274598-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274598-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5B50302572C
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 23:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110FB367B9C;
	Tue, 14 Jul 2026 23:34:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3BF294A10
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 23:34:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072050; cv=none; b=CX7RRYxBYXJYBq9ivIZ/AuorXOCGvLGrCxB+c1+GRFF/wi7PUNwvotamJMe2PCsaK4vQYef6CHmIjc50ntxWHz9IjrqfNVn1HUaJ4+G1mYxBMAh5FuqUw+tghF0bH2kPB5+A+t3wtiefeFrAWstPXL4RKBOV/CU7qGQ6TcnIHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072050; c=relaxed/simple;
	bh=WkXk/jyhxD6VsRE7gkA14xDbAXbBgM3SNNHRBbdNqfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=df8OVwksbN3++GS7VNP1nLVz9Dsf0roj12n9QoCkpQYXEz5tWKMS5ZB8WsQm2c/TFrfMvPvGSF+ZXDyTToOBzv7Zd34Q2tiC1eS5m/2LHBkdEi9IMKdKH/g6xITJyMMk6bM6fcjm59p8JamJGMYeUIz8QNP05GTROXrknaE0qxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0XLkRsI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20331F000E9;
	Tue, 14 Jul 2026 23:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072049;
	bh=8CZH2ZFDZP7P5RRhdJEIT0T8Zw7nEQDxh6Vkkz9yJw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S0XLkRsIyntjdQ6IC/s2Cn4ZNmP9Nx4JGhX6OtqgkBqmsa/yXkpy+Ugw5GfJyZa3e
	 Hmtj95TbhpIbZM9PEoP6mRxuXcdxI0/ThhsEut+i/90u9/gjTnG6xcWVvVFV1SrEl+
	 kiAinhcA6Mv3wGa/IM+5nMBKRxN+xB8t21LIESKjmhm1l9XiMYmY/cQw6r2f+syE52
	 z7jlnAbiRP0gMgHumFnA4aRjntnbloDMgZx51pDbBVYu6RFQO88ojGnwQtdNtQrIQF
	 b5t8bVk6+zolO2ESlBRgxM4nDnHUXWOmvS8D2m/iTFzdfqG7f54fwd/sh/HGONxZyF
	 gc1ReLJdCn6yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/8] staging: rtl8723bs: split too long line
Date: Tue, 14 Jul 2026 19:34:00 -0400
Message-ID: <20260714233407.3591885-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071352-wreckage-humorless-3481@gregkh>
References: <2026071352-wreckage-humorless-3481@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274598-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:fabioaiuto83@gmail.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39CEA759738

From: Fabio Aiuto <fabioaiuto83@gmail.com>

[ Upstream commit 98dc120895a9a669e35155ee03b98452723aba95 ]

fix the following post-commit hook checkpatch issue.

WARNING: line length of 103 exceeds 100 columns
30: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:711:
+
receive_disconnect(padapter, pmlmeinfo->network.MacAddress, 0);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/4e87fb741205b9f314aec739921405a7ebef908a.1618480688.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: a1fc19d61f66 ("staging: rtl8723bs: fix WEP length underflow and OOB read in OnAuth()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 1144749b4f585d..183c4c2f553101 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -835,7 +835,8 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 				ret = rtw_check_bcn_info(padapter, pframe, len);
 				if (!ret) {
 						DBG_871X_LEVEL(_drv_always_, "ap has changed, disconnect now\n ");
-						receive_disconnect(padapter, pmlmeinfo->network.MacAddress, 0);
+						receive_disconnect(padapter,
+								   pmlmeinfo->network.MacAddress, 0);
 						return _SUCCESS;
 				}
 				/* update WMM, ERP in the beacon */
-- 
2.53.0


