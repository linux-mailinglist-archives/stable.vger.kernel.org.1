Return-Path: <stable+bounces-273141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /aZ5L6eBUGor0QIAu9opvQ
	(envelope-from <stable+bounces-273141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 07:22:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1884D7374F0
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 07:22:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K0HzaCBd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273141-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273141-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D3B9301B174
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 05:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9AD36683D;
	Fri, 10 Jul 2026 05:22:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E71A6831;
	Fri, 10 Jul 2026 05:22:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660964; cv=none; b=Dbsv3d1Mf89+/6KN4ToyA/ggD3KURBmOoNg8T/+WX6CZYGBEokx96TpXPa5BRi9g2HbF60+kNv+i6r6NSlAt5gBphY1gjSlToEFz4UCGKEy2mgsbQR7XA6/WARWJnkqr/hiCnEGnIXuQNtngllQVgX8nDA78b9rstf8jrqcXmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660964; c=relaxed/simple;
	bh=jC4Pq8beK1OE8Pjt35/Dh+v2/botcoOJUhz/CHgFvN8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JX+kIgL7zrhKFQoHESxFAcMrrrQYrYOAmVWqJUICsVsLQ4AUoYFYl+n2LDNtFGAv8D2cs1jYYcT5RNhbsndweyTTCWPJGC6I4Hw7PJQatJGzZl/s/llSSDaU7RnBxDl8Ka9a6lrAbY863MKrRJ7gBBQzBcOnWqqVpC5imVqWzZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0HzaCBd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 999EE1F000E9;
	Fri, 10 Jul 2026 05:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783660963;
	bh=viL4lMwmA+kS6yt7DsEr4i1uMANgTfNR2BFp/itXgrY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=K0HzaCBdUj0bKmyFfApjX9QinbgRo7w06oAei091dOID+MO56t4Ic0CtCyzNtoFOq
	 VXz2X/GJXvCeNjESrhXgzUdunYmRbR7lPh7p9FeLbJMNLEwVneWoPlx137erNigfel
	 mqTCyNripqK9BwxgBBTCKfqdeL5qwjtB5yA4rGbW1JgS+/YgyS3MjCn8u/PRYt4G1V
	 JcSD+q+Uz57cbLSZyefZX7vOPsMswrPyOCrxXowPBneoDi2+/80iW6MZZIPSXniZCi
	 BWWyneB+0nZzv+tXaPzDkZKNiX4SVV7U/0ecCfqsbfSWd72bAawaD5x/CGWKx4uUcM
	 aX70SdFfX7C6Q==
Date: Thu, 09 Jul 2026 22:22:43 -0700
Subject: [PATCH 4/8] xfs: don't wrap around quota ids in dqiterate
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org, hch@lst.de
Cc: stable@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <178366081078.1173468.14647626689811028631.stgit@frogsfrogsfrogs>
In-Reply-To: <178366080946.1173468.2461850065055339934.stgit@frogsfrogsfrogs>
References: <178366080946.1173468.2461850065055339934.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273141-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:cem@kernel.org,m:hch@lst.de,m:stable@vger.kernel.org,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[frogsfrogsfrogs:mid,vger.kernel.org:from_smtp,lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1884D7374F0

From: Darrick J. Wong <djwong@kernel.org>

LOLLM noticed that q_id is an unsigned 32-bit variable.  If it happens
to be set to XFS_DQ_ID_MAX due to a filesystem that actually has a dquot
for ID_MAX, then this addition will truncate to zero and the iteration
starts over.  Fix this by casting to u64.

Cc: <stable@vger.kernel.org> # v6.8
Fixes: 21d7500929c8a0 ("xfs: improve dquot iteration for scrub")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/scrub/dqiterate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/fs/xfs/scrub/dqiterate.c b/fs/xfs/scrub/dqiterate.c
index 10950e4bd4c3c0..079dc4e691a01a 100644
--- a/fs/xfs/scrub/dqiterate.c
+++ b/fs/xfs/scrub/dqiterate.c
@@ -205,7 +205,7 @@ xchk_dquot_iter(
 	if (error)
 		return error;
 
-	cursor->id = dq->q_id + 1;
+	cursor->id = (uint64_t)dq->q_id + 1;
 	*dqpp = dq;
 	return 1;
 }


