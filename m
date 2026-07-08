Return-Path: <stable+bounces-272546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5iK+ADvaTWqc/AEAu9opvQ
	(envelope-from <stable+bounces-272546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 07:03:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C110F721AED
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 07:03:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YWHmYGO8;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272546-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272546-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85A7A3018885
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 05:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B94B3B5DEE;
	Wed,  8 Jul 2026 05:03:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FFF3B1009;
	Wed,  8 Jul 2026 05:03:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487021; cv=none; b=XVhiR2ygjmLOG9aCoNxFNdqaDbY303+CknFH31U4WIpIVh1NZkqWfa+KLZpifO68h+3AFtZiFwfGi6cwGZ91NvtG54n/nO7wm3Ru3YautW/vLuNMT1DDeC0w2YcZ7U6lIWTbWGYv1uA1N8VVOh03536JElCJxXQQWQBDieKHOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487021; c=relaxed/simple;
	bh=QHXUNSfpQcTmpJt6upSujzwZVJRjY2cWS0+fZBpq/zQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVJLpQcRc0XmbTHyoIv8GJfW/IoAXm+gGhnYMwoxv1DiwBYIpbu2rHjJNqc3pwonzMOmXYQyeH8T1nAm8hDv7ITl72/R71ruJj4/PEC/4mjGOhwxqCwED/mzfKUOLNBhO4lBDnFO+eufyjsO9GTwNyOXiNRexMRaZnuMWQ7wslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWHmYGO8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 56C7C1F000E9;
	Wed,  8 Jul 2026 05:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783487020;
	bh=9lmtlHd30OexsM+BbBr33BKyqEniYqLQI00N1E9dtac=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=YWHmYGO8Q/GUc05CjyGOP1v/FS24mmVqlpUY1lNI5uYKzoP6CmOWr/WFYDPhJZNXz
	 pr8+Szev1HjrpLEXqtVabYTz43bI/5nBMmQu1vYz2Kz8z64zQKMk//BYWRvILs72hT
	 OOvcbrhMN0ahPtMKG3A3y1fnwF8YBrGZt8KBDPkYs29W9E3KCXcj1b9EAAVZWB4YKQ
	 N7KkGduJD8HHtn3gpbKBYGIBmqPxOYc8Xu93AjxeVzastB9neYFHLSdnksmGG7p9Hx
	 BFTgUWYbFHQKY6hUB1+YFTM224zkmP9kb2VWlHtL1puBuuw1nWvuPqxPKnzonYaLCq
	 BZZJhCPRJ/VwA==
Date: Tue, 07 Jul 2026 22:03:40 -0700
Subject: [PATCH 2/6] xfs: don't wrap around quota ids in dqiterate
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, hch@lst.de, cem@kernel.org
Cc: stable@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <178346726130.1271589.15159357342663936453.stgit@frogsfrogsfrogs>
In-Reply-To: <178346726054.1271589.14164163317011378817.stgit@frogsfrogsfrogs>
References: <178346726054.1271589.14164163317011378817.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-272546-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:hch@lst.de,m:cem@kernel.org,m:stable@vger.kernel.org,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C110F721AED

From: Darrick J. Wong <djwong@kernel.org>

LOLLM noticed that q_id is an unsigned 32-bit variable.  If it happens
to be set to XFS_DQ_ID_MAX due to a filesystem that actually has a dquot
for ID_MAX, then this addition will truncate to zero and the iteration
starts over.  Fix this by casting to u64.

Cc: <stable@vger.kernel.org> # v6.8
Fixes: 21d7500929c8a0 ("xfs: improve dquot iteration for scrub")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
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


