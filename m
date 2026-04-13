Return-Path: <stable+bounces-237203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJtUD+4e3WmsaAkAu9opvQ
	(envelope-from <stable+bounces-237203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:50:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 103CC3EFF9B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44524302570D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8614A316197;
	Mon, 13 Apr 2026 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="szYsTsAv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C7B314A6B;
	Mon, 13 Apr 2026 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098851; cv=none; b=bnvNv4MyRujbcJb7mvPo/qaC8+tuSQgKiNYl+Nv2sA+vz4nVwktcxpo8Hm8d4dJr+8C2KxAo8aYoQGFYM8H7B6KlQHJGHTREgt8HyZ66QE9nfhHCEx1lVwLJoceN3fAG6hdkTR7TKUFBv4HQO2JTWfYiKkD4uD9Nnm6XbOLy5zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098851; c=relaxed/simple;
	bh=mDJ28eWkxk6XNIr1wIp/+3ywI8xqMTYTGYGh7mIehj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqf8m7DoPS3e80aIh6eETI+PksveFGbm6pWSKZ/XhM14TRzBNCRPY+Wzre9raxawVz9efLmyR+zUioAMnUQ0YluUJkOUj9LE8SUGLdRSbyrgqLoRZ5pilXxAvHGTP7OHsrsTcixYxnsZDiQJ15hd6kMj/gSFEudGVB7NvzlsFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=szYsTsAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2CCC2BCAF;
	Mon, 13 Apr 2026 16:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098851;
	bh=mDJ28eWkxk6XNIr1wIp/+3ywI8xqMTYTGYGh7mIehj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=szYsTsAvrXKwRbmUqXJ1dm7WqEMIw7BPu+6Vsza54bGJgbSvAM1kEloHN8aXbx17y
	 esdysbR5599xYKhTRb3C1dkfpxvQ6QDRlIwngCOroChFRcplbiw9QheMFjJ4OM/eEQ
	 V1m8Bj3JGm0iQSVSVyW0ZZNh8A8HV6HG3m7Gl2aM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Navaneeth K <knavaneeth786@gmail.com>
Subject: [PATCH 5.10 114/491] staging: rtl8723bs: properly validate the data in rtw_get_ie_ex()
Date: Mon, 13 Apr 2026 17:55:59 +0200
Message-ID: <20260413155823.309508145@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237203-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 103CC3EFF9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -194,21 +194,25 @@ u8 *rtw_get_ie_ex(u8 *in_ie, uint in_len
 
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
-		} else {
-			cnt += in_ie[cnt+1]+2; /* goto next */
 		}
+		cnt += ie_len + 2; /* goto next */
 	}
 
 	return target_ie;



