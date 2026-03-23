Return-Path: <stable+bounces-229751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPpbBcFswWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:39:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A63382F88B4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 554AF32D3F4D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9D73AF663;
	Mon, 23 Mar 2026 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p0rK6aAk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426303AF678;
	Mon, 23 Mar 2026 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282770; cv=none; b=lFsK/tHNXTHQqAF7us7Kfw6o5uLoX4R5nHwLUZAdKkR7rYqBDNdG29/KHAh18JxQ/uTOfnVwEwwuy6g6hBoP4OLFM8p4pGPpkgxOPtdC+6rJvNEiM0u2Fkd6M23s2qFX/gC8XHdMeioXk7GabcbzH86ZYvaLeWs9v/a/1hgqDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282770; c=relaxed/simple;
	bh=/uY2nOPjpYlr6g8/PPxT2hrLGJH1jM77uEV1arxxdtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbTHlWB72ZB9RO8a2X01THYFrHs+bFFGqfcmqDJ/LH3Z51tbYQ5QcJofdD3ZQTRPbZsUPCZ2fZrIkfhpi2iOESMlJ2QkE74EQxA9FaFwZ16MCqeB0LyKe14q1NN/bfmDsSpzquyED1UvpVvkVY2ITWtaRq/7K29pUFUDVw9BaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p0rK6aAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D50C4CEF7;
	Mon, 23 Mar 2026 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282770;
	bh=/uY2nOPjpYlr6g8/PPxT2hrLGJH1jM77uEV1arxxdtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0rK6aAkjvBx8TqVKQQArlnD9OePEmq4IYkeWIbkLx3VbEUSK0ABfg9blF3nnUa1i
	 avoZ96j+xw8DJNSIE7nQr9czDcQroIYv3yc4d77JhPUTwFcD94sid25nAKpOj+qCA9
	 daS4+8y6UIu9GEXJgKJioN4LkNMNlGX1buW4Vl1I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Navaneeth K <knavaneeth786@gmail.com>
Subject: [PATCH 6.1 235/481] staging: rtl8723bs: properly validate the data in rtw_get_ie_ex()
Date: Mon, 23 Mar 2026 14:43:37 +0100
Message-ID: <20260323134530.869557200@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229751-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A63382F88B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit f0109b9d3e1e455429279d602f6276e34689750a upstream.

Just like in commit 154828bf9559 ("staging: rtl8723bs: fix out-of-bounds
read in rtw_get_ie() parser"), we don't trust the data in the frame so
we should check the length better before acting on it

Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Tested-by: Navaneeth K <knavaneeth786@gmail.com>
Reviewed-by: Navaneeth K <knavaneeth786@gmail.com>
Link: https://patch.msgid.link/2026022336-arrange-footwork-6e54@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -186,20 +186,25 @@ u8 *rtw_get_ie_ex(u8 *in_ie, uint in_len
 
 	cnt = 0;
 
-	while (cnt < in_len) {
+	while (cnt + 2 <= in_len) {
+		u8 ie_len = in_ie[cnt + 1];
+
+		if (cnt + 2 + ie_len > in_len)
+			break;
+
 		if (eid == in_ie[cnt]
-			&& (!oui || !memcmp(&in_ie[cnt+2], oui, oui_len))) {
+			&& (!oui || (ie_len >= oui_len && !memcmp(&in_ie[cnt + 2], oui, oui_len)))) {
 			target_ie = &in_ie[cnt];
 
 			if (ie)
-				memcpy(ie, &in_ie[cnt], in_ie[cnt+1]+2);
+				memcpy(ie, &in_ie[cnt], ie_len + 2);
 
 			if (ielen)
-				*ielen = in_ie[cnt+1]+2;
+				*ielen = ie_len + 2;
 
 			break;
 		}
-		cnt += in_ie[cnt+1]+2; /* goto next */
+		cnt += ie_len + 2; /* goto next */
 	}
 
 	return target_ie;



