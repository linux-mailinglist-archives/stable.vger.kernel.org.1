Return-Path: <stable+bounces-258592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMGfJgQpG2rg/ggAu9opvQ
	(envelope-from <stable+bounces-258592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:14:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FBF6114EB
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C6F2300B5AC
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DEF39A7FE;
	Sat, 30 May 2026 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TzBEDPeD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6276223DC6;
	Sat, 30 May 2026 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164866; cv=none; b=NLqZhZQ5nV4S9y8Q/MlRaZ0x50Bge6sIpoOtDBr+BmWMlsz6uWm7h3Hae3CCMqjQsq6wn9iYOqiUUgCEkfaL6jnfU7SvXcC/VYeQgrMU5ZLvuHYHUXXfGLPMJiQlK4zyFQiIl+xzLGcsj0UHKKTk4s1cWw12UWJK0DtQ/SGCoFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164866; c=relaxed/simple;
	bh=1Qb1vXFSYh5rq6nXhVWYZES14X1QBZQYwmFatMcuah8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew6kcQAhUUoQuSIY5iITLc3LqSEuXTgBj2hi/DpGhJvKNye2eWMUO2jwcXW3kS2kfzItl7mmgattcK3yi2u57WmktQqvr31v5yIvlWJlUa2x2EqBFrylZM3bRBRB3ziu4w5nFavf+QLAKZ9S7UKeXL3Da/GJK3X2vPGvEXBqesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TzBEDPeD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB841F00898;
	Sat, 30 May 2026 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164865;
	bh=KVYM9AVvCP0vXUgpyoQGfafq9TkHBhAp2zQxoP9zWq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TzBEDPeDCpDg5rQdQ8R3zcLiOpZa0MyffnsDjrI/hQzizi8ZuuxzDuGun5/iSuY1c
	 odAc/iHQhb+wgcWyHdg/Q23HXLmUBqHNCbapSDLdZxybi8oSZhQ7no6tZqbTgxEQgs
	 YRRGkrTwLxI9JsqL/2YM4ERJQHL4bRHLlqZNNoCY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 681/776] ALSA: asihpi: Fix potential OOB array access at reading cache
Date: Sat, 30 May 2026 18:06:35 +0200
Message-ID: <20260530160257.467219036@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258592-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.de:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 40FBF6114EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 7b7d6572145c1dab2dd9bfb550b188e5f0ff3c3f upstream.

find_control() to retrieve a cached info accesses the array with the
given index blindly, which may lead to an OOB array access.
Add a sanity check for avoiding it.

Link: https://sashiko.dev/#/patchset/20260511230121.28606-1-rosenp%40gmail.com
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260515085606.242284-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/asihpi/hpicmn.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/sound/pci/asihpi/hpicmn.c
+++ b/sound/pci/asihpi/hpicmn.c
@@ -276,6 +276,12 @@ static short find_control(u16 control_in
 		return 0;
 	}
 
+	if (control_index >= p_cache->control_count) {
+		HPI_DEBUG_LOG(VERBOSE, "control_index out of bounce %d\n",
+			control_index);
+		return 0;
+	}
+
 	*pI = p_cache->p_info[control_index];
 	if (!*pI) {
 		HPI_DEBUG_LOG(VERBOSE, "Uncached Control %d\n",



