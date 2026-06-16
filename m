Return-Path: <stable+bounces-264629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PKwlFid4MWqFkAUAu9opvQ
	(envelope-from <stable+bounces-264629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:21:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C07E691FB2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:21:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=kURWEvmV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264629-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264629-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9861303682C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D735346AF02;
	Tue, 16 Jun 2026 16:21:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30381E8320;
	Tue, 16 Jun 2026 16:21:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626908; cv=none; b=LRfNbZC6u/SzkWAIt2gSYor+pjTViYXB+reYwy0OwrWfKGGQzxoyuaPzjvctADXQ5Jeqo+LNNVA4byu2hunvFL+O1GeRVIJaa0UkgqcTzliwjMjUFVOtpdfF5FMliyQHrEUlB9pDmIDTtWdGk7hg0mhzGWiVGteYzAOTDigAlnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626908; c=relaxed/simple;
	bh=gH3MQEgJz7Qipey4HORe7iCdEiWpMQPoayhHTHxaB5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zma2grP1olGsxYobXLnKerYCM4Izcn5epnvk80m7jdsxcStXSKWM2K9NDsOaJZkXeiWqGLKCC3VFk4D3N97IRmqsxUr/j8rqo0UifCz6S1AbDH1quE6HZmQ3//eZ6pmjJiowHA/NbJ5sfDz7wtPMfg+aD0VIm3keGLm6RQeTUhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kURWEvmV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49FB1F000E9;
	Tue, 16 Jun 2026 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626907;
	bh=1H4PDtGrEwSA9iYeV7+tpN3JzTu/cqPvJ5CkFgD6LXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kURWEvmV4wxHstyxDOyRL36C6HX5UhoZy7fvm3na3UdqZuSblhI8pWX4KvYvz8vEL
	 rwDIPziLTE81jYfAWcCZTtaQIXJrPxOPnYg4JeM9hFcGIEX6P7nzPYHAr25eRQCXrP
	 Y0TaQM9POtlB8U6cNTBGvJlaukMCTMZwHPUFxJKI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 092/261] sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
Date: Tue, 16 Jun 2026 20:28:50 +0530
Message-ID: <20260616145049.301059271@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-264629-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michael.bommarito@gmail.com,m:lucien.xin@gmail.com,m:kuba@kernel.org,m:sashal@kernel.org,m:michaelbommarito@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C07E691FB2

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit f8373d7090b745728de66308deeecc67e8d319ce ]

__sctp_rcv_asconf_lookup() in net/sctp/input.c only checks that the ASCONF
chunk can hold the ADDIP header and a parameter header, then calls
af->from_addr_param(), which reads the full address (16 bytes for IPv6)
trusting the parameter's declared length.

An unauthenticated peer can send a truncated trailing ASCONF chunk that
declares an IPv6 address parameter but stops after the 4-byte parameter
header; reached from the no-association lookup path, from_addr_param() then
reads uninitialized bytes past the parameter.

Impact: an unauthenticated SCTP peer makes the receive path read up to 16
bytes of uninitialized memory past a truncated ASCONF address parameter.

The sibling __sctp_rcv_init_lookup() bounds parameters with
sctp_walk_params(); this path open-codes the fetch and omits the bound.
Verify the whole address parameter lies within the chunk before
from_addr_param() reads it, the same class of fix as commit 51e5ad549c43
("net: sctp: fix KMSAN uninit-value in sctp_inq_pop").

Fixes: df2185771439 ("[SCTP]: Update association lookup to look at ASCONF chunks as well")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20260608122234.459098-1-michael.bommarito@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/input.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index 032a10d82302c3..df5b2187b8fada 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -1204,6 +1204,14 @@ static struct sctp_association *__sctp_rcv_asconf_lookup(
 	/* Skip over the ADDIP header and find the Address parameter */
 	param = (union sctp_addr_param *)(asconf + 1);
 
+	/* The whole address parameter must lie within the chunk before
+	 * af->from_addr_param() reads the variable-length address; otherwise a
+	 * truncated trailing ASCONF chunk lets it read uninitialized bytes past
+	 * the parameter.
+	 */
+	if (sizeof(*asconf) + ntohs(param->p.length) > ntohs(ch->length))
+		return NULL;
+
 	af = sctp_get_af_specific(param_type2af(param->p.type));
 	if (unlikely(!af))
 		return NULL;
-- 
2.53.0




