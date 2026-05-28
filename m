Return-Path: <stable+bounces-256303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPX6D/arGGpEmAgAu9opvQ
	(envelope-from <stable+bounces-256303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:56:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B402B5F9E4E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D761F3136F06
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3B318B9D;
	Thu, 28 May 2026 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mSRjhOZX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF42F549F;
	Thu, 28 May 2026 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001322; cv=none; b=NiaeOxbbC8AKeho1zqk5U4Ivx3596DjK9BEcdwhMb4RzcEG8sWJCs7+ofQQ8t/6lHyYXnYYZo98YHUiTaYrU6j6crYEHide63TnjSDUa/Kk3QGhKOi8L0aj4hwdxUvpMuhhliV8OSQu2n4Tnq8eMTwOUogG3hq7cvxGc95q3gEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001322; c=relaxed/simple;
	bh=4+fo+TOMumO5EeA6N24v4uBLmg4qHSjFaghTZ9CMn3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYcpSFXnbFW3LzjuxlI2UUAhI/t2zdKQ1HNVB50ATI1KyzIO7WxSYpDWr7yiZs199uuyBWhHdE0b7lbYNEqXlpHw79779A3Sqfe/h6h5u0iCp42686B4zwiNwRr8/sfRmQxWxhtWgk8UeObzeZaxptHXkLfv5JSl65KC8qdrbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mSRjhOZX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848C21F000E9;
	Thu, 28 May 2026 20:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001321;
	bh=LaSHIwa5yCyc6cIV24+dHOh9zhgNXsBTb5Z0+CBOIYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mSRjhOZXK0OTZ2JKltN1l83hl49N/JaSemFXj7356Ip5IAeXyImtALCZ4bBib+uTT
	 sHPB2VnF23OTxevcSX92yxnT13N2oVBAZh5n+VeJ1rKEfYfPVdWNu1MMI9naGgtFP1
	 ydueeGclSYWOhQn6OWXd3HHHWIBAlqP5LdC4CPbg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.6 086/186] batman-adv: tt: fix negative last_changeset_len
Date: Thu, 28 May 2026 21:49:26 +0200
Message-ID: <20260528194931.258462159@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-256303-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,narfation.org:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B402B5F9E4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit fc92cdfcb295cefa4344d71a527d61b638b7bfc4 upstream.

batadv_piv_tt::last_changeset_len len was declared as s16, but the field is
never intended to hold a negative value. When a value greater than 32767 is
assigned, it wraps to a negative signed integer.

In batadv_send_my_tt_response(), last_changeset_len is temporarily widened
to s32. The incorrectly negative s16 value propagates into the s32, causing
batadv_tt_prepare_tvlv_local_data() to allocate a full sized buffer but
populates only a small portion of it with the collected changeset. All
remaining bits are kept uninitialized.

Using an u16 avoids this type confusion and ensures that no (negative) sign
extension is performed in batadv_send_my_tt_response().

Cc: stable@kernel.org
Fixes: a73105b8d4c7 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/types.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -994,7 +994,7 @@ struct batadv_priv_tt {
 	 * @last_changeset_len: length of last tt changeset this host has
 	 *  generated
 	 */
-	s16 last_changeset_len;
+	u16 last_changeset_len;
 
 	/**
 	 * @last_changeset_lock: lock protecting last_changeset &



