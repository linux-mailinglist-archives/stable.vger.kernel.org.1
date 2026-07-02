Return-Path: <stable+bounces-270595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mHjFHXWURmoBZAsAu9opvQ
	(envelope-from <stable+bounces-270595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:40:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1506FA58F
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:40:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=bfD0QW09;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270595-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270595-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CED2E3002F6F
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C96344052;
	Thu,  2 Jul 2026 16:22:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8950633C19E;
	Thu,  2 Jul 2026 16:22:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009347; cv=none; b=EUFgh+DFZ9vmhafWeYCMH1mDiR3sPCHqKm9Pa1PqEXb77/ZrjLo75p9sENXenmxKulTXCR2/Y3Izr/Apns2TM1Xvrx0eWUNcOUvXArg9R++PtXY14Y87lxk+3piJIb9ZmQ2Q02WffPLaFi2ADqJwQmI8OW2wAxLrnJUkKtU5PMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009347; c=relaxed/simple;
	bh=5RQUyqaHkor8XWvXxEBRhLzFB9x/pasP5ESCMZUBEvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0FxGiBNF2/U4T9//l+QHw3iRMO4Wo3xv5M88L/94pCfwVsoo22COmfYynyX/7XEbdyRShGnI/NSbe+vdKldpoymc1C7At+hgVFmEU5pkcFWlnIEQqqMZtNMbRQv/bzjeV5AE+e41bMvbCr1WzwzaXgaChdO00qGlhVbJluD/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bfD0QW09; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866A31F000E9;
	Thu,  2 Jul 2026 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009345;
	bh=2myOTq2cWpX7cHBj9TjTO8uAnC2xdxVNa9i4E3NdQY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bfD0QW09iF63igPQAFcTFDkOhUKU4+0geY9z8e6GDXe9D4MbeDTAfsBct2HDXjIuZ
	 AjkEgLwcVnXegUpKhozsphNeJ60ZftOrrqBzPRCdiXtGhI8hqTKqh+YgvVo2s6/riy
	 2A8/dDjeMI89Qy+rS6/dSx0DhQ9idZWL4247iRfE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hangyu Hua <hbh25y@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 17/96] net: 9p: fix refcount leak in p9_read_work() error handling
Date: Thu,  2 Jul 2026 18:19:09 +0200
Message-ID: <20260702155109.348948232@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155108.949633242@linuxfoundation.org>
References: <20260702155108.949633242@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,codewreck.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-270595-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:hbh25y@gmail.com,m:asmadeus@codewreck.org,m:alexevgmart@gmail.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A1506FA58F

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangyu Hua <hbh25y@gmail.com>

commit 4ac7573e1f9333073fa8d303acc941c9b7ab7f61 upstream.

p9_req_put need to be called when m->rreq->rc.sdata is NULL to avoid
temporary refcount leak.

Link: https://lkml.kernel.org/r/20220712104438.30800-1-hbh25y@gmail.com
Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
[Dominique: commit wording adjustments, p9_req_put argument fixes for rebase]
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
[Alexander: this branch doesn't contain 8b11ff098af4 ("9p: Add client parameter
 to p9_req_put()"), therefore the parameter is removed from the added line]
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_fd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 40d458c438df1e..a75668534c81c3 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -346,6 +346,7 @@ static void p9_read_work(struct work_struct *work)
 			p9_debug(P9_DEBUG_ERROR,
 				 "No recv fcall for tag %d (req %p), disconnecting!\n",
 				 m->rc.tag, m->rreq);
+			p9_req_put(m->rreq);
 			m->rreq = NULL;
 			err = -EIO;
 			goto error;
-- 
2.53.0




