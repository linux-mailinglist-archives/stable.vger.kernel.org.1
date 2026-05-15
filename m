Return-Path: <stable+bounces-248231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFyzHqFKB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:32:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0093B553618
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDFA631CF98B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB533F9286;
	Fri, 15 May 2026 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KyZSvv7b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3199C3F8713;
	Fri, 15 May 2026 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861206; cv=none; b=tcDRR5KCVb6l+d+Vkb6uEuHlh+ulRtjY82tG6HI5jvC23VhKqPn/cYVehgLC3DWlIDQRmXLWpJ+vYlR5mJ/ZbFCedI+u9OcrnyafmQQBEr3ZqZ28R22+xThRqmxMvbZUA+v0a3rvKyr5fmxli9wCLIIrOldCG5pFldS6frSVK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861206; c=relaxed/simple;
	bh=2AFAPLE5wppAEAwUVVP6uX1stnv5RfY+XnYai2MjH+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoxwDX7nYxzSSC0GltqMXnHBi9KsgCUPbAvtMOczi1TsvbE5iHf0ORrljMsb2Q6rMq95FO0VABz1GVaZoLf0Mao9+KTTk4020nKUtWcxZ2jqMwrgWlZb2hpryjLY9yl66XVbzu2RC9Oui/ZJgG/oGhci7NFQz2qX81mHbih8nvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KyZSvv7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D878C2BCB0;
	Fri, 15 May 2026 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861205;
	bh=2AFAPLE5wppAEAwUVVP6uX1stnv5RfY+XnYai2MjH+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyZSvv7b7O4RTCHYHJK0ZljUGXiX4vKLzRU2R8Vr1/aAVLxVhJGzhEbq2GgbWjiP7
	 p9PYIJDWhhArcWwyUn9VwLHPwAPf4a2cHR4tVX3SyfrIxQR1ScaDuHPkS8yG9QTOh8
	 6YVZcTZ62/KjGeCCGGY3OrnEkrC4S04UUTev/aK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH 6.6 238/474] thermal/drivers/sprd: Fix temperature clamping in sprd_thm_temp_to_rawdata
Date: Fri, 15 May 2026 17:45:47 +0200
Message-ID: <20260515154720.152931667@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0093B553618
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248231-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linux.dev:email,msgid.link:url,alibaba.com:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit 83c0f9a5d679a6f8d84fc49b2f62ea434ccab4b6 upstream.

The temperature was never clamped to SPRD_THM_TEMP_LOW or
SPRD_THM_TEMP_HIGH because the return value of clamp() was not used. Fix
this by assigning the clamped value to 'temp'.

Casting SPRD_THM_TEMP_LOW and SPRD_THM_TEMP_HIGH to int is also
redundant and can be removed.

Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver support")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260307102422.306055-1-thorsten.blum@linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/sprd_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -192,7 +192,7 @@ static int sprd_thm_temp_to_rawdata(int
 {
 	u32 val;
 
-	clamp(temp, (int)SPRD_THM_TEMP_LOW, (int)SPRD_THM_TEMP_HIGH);
+	temp = clamp(temp, SPRD_THM_TEMP_LOW, SPRD_THM_TEMP_HIGH);
 
 	/*
 	 * According to the thermal datasheet, the formula of converting



