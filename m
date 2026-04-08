Return-Path: <stable+bounces-234052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKSsCGOa1mmTGggAu9opvQ
	(envelope-from <stable+bounces-234052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:11:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A315F3C0223
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70909301370B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8AC3D8918;
	Wed,  8 Apr 2026 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ifpy4GuI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8D347517;
	Wed,  8 Apr 2026 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671861; cv=none; b=Hz9Ou9kYjSlQDr2Aujm2DNwiYnRNGhniEMUf9PsKYbyPXQLvZaxPs0qj1uevZmb7c0a/5yUKcMnti/eVsq/lUlI4CwvwjXJp/JxsubWjeAjeiieSCTH0c/CSAlXgUwrKJ5Od/ClHxIcH8oWXkH9riY6jCZMTIGMU7oSpjn7X2nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671861; c=relaxed/simple;
	bh=f4co/522mvAh/IkM2BiAPDL6Yid3N2ZNj7xc38aVRYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzpTgt/QbYySpbVSLJWmwu7yGj4nm/4njVh7q65dZwFK7D/NhIA99nd7DIicM2VcbsY63edqI2ks+Eeb8C3XMxeLbTk2PuMOp5WjwmNt0x5UJ13MEJNyqMbRNiYJow21fOfqwjlronW3UZ4HO15CzVviZDWwf+7bVJa6QYz2Nz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ifpy4GuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FF0C19421;
	Wed,  8 Apr 2026 18:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775671861;
	bh=f4co/522mvAh/IkM2BiAPDL6Yid3N2ZNj7xc38aVRYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ifpy4GuIIQ0JWecjqTV3sG8Z/8BSkOVpRzmPaHVPdzg8rNZeLmSTgT94ASoAsIpxR
	 cGXN5NDyu7atlPoQCEmRVP6MGfhvh03dBySTTx1BW7+t2zzIqn2gIMShkdjFiIG/7U
	 3YRVPHr114dvb6thIme9jql3u8Bdu76kArQllUNw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.1 097/312] hwmon: (peci/cputemp) Fix off-by-one in cputemp_is_visible()
Date: Wed,  8 Apr 2026 20:00:14 +0200
Message-ID: <20260408175937.385440800@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234052-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,roeck-us.net:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,juniper.net:email]
X-Rspamd-Queue-Id: A315F3C0223
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

commit b0c9d8ae71509f25690d57f2efddebf7f4b12194 upstream.

cputemp_is_visible() validates the channel index against
CPUTEMP_CHANNEL_NUMS, but currently uses '>' instead of '>='.
As a result, channel == CPUTEMP_CHANNEL_NUMS is not rejected even though
valid indices are 0 .. CPUTEMP_CHANNEL_NUMS - 1.

Fix the bounds check by using '>=' so invalid channel indices are
rejected before indexing the core bitmap.

Fixes: bf3608f338e9 ("hwmon: peci: Add cputemp driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260323002352.93417-3-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/peci/cputemp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/peci/cputemp.c
+++ b/drivers/hwmon/peci/cputemp.c
@@ -339,7 +339,7 @@ static umode_t cputemp_is_visible(const
 {
 	const struct peci_cputemp *priv = data;
 
-	if (channel > CPUTEMP_CHANNEL_NUMS)
+	if (channel >= CPUTEMP_CHANNEL_NUMS)
 		return 0;
 
 	if (channel < channel_core)



