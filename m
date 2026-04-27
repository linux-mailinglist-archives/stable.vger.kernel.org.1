Return-Path: <stable+bounces-241451-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNdUJJP272mFMwEAu9opvQ
	(envelope-from <stable+bounces-241451-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 01:51:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6B947BF51
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 01:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50B993042253
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 23:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A5D3B892D;
	Mon, 27 Apr 2026 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="nqYFNf0F"
X-Original-To: stable@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948AA3B775A
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777333854; cv=pass; b=u4EbFMIBdtIN+PCjSRp4QFk9zYfxB121UY6x9KoJZz5AaMmA57Ph8RUxGztP42rSlGAYUPJM7WQL7VFoEVWkTmZlbCveGlX/1Ol5c2jOOtJ2AS+3j1XXbRXnw1hZHJEUcv4na9/0jiHoK45mpFTFbwh8Hmrnll2uDtwrAVTtv4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777333854; c=relaxed/simple;
	bh=6H9B8viJHMdRgWfVa71sTWomqky/aO5XNzH8uHWvAvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bl/ykUSe/Z+E3BivaSd8edXKSuIzWKmBtNXDWcCrHwsnPsi1JD7Y4MJhQ4V2oOI5oEZIhhAXIx9ajedqr3yuYZ1Shwyul2yG3UZrGVBdC0HCJe8i+Lduxsx+YvPktlYFpD5aRpC1UIp95QGdEnQZEMAZJ1F9zXeAdXlJnfYK81E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=nqYFNf0F; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1777333834; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VGEB8GdLEjb8rDNxOcppYitvtn2z6MsUAkDLceDCEMRqqKMWH0ZiDVZRdrFS5urhg5OihgABicHQ0D8UYGmQltDHFmc+9X+Wd9y0rDy+Ou1XfprEPsdvzojalCGDxULx2EY3Zd+pSKBSxsPf5KRB2b6qXJpEpvDFfO9WGHstaUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777333834; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KgHNHwy986mQko+AXCe15b4cFbyoBz/VH5W9uV60InA=; 
	b=AUVDd3/1TPKwOxwOYlFSViE+AT01QMN/Z2qOVfFHnattMy8YHix+dVuecoLuIgyuYoU9xt35GpmHAa3qxB5jJxNtzVxJe7ZV32IBLzAvEDQmUKj5Hxj230ZiaBBvswkULmbT2arfH1GjZXSTkTqLXQLaiefVQDjTTrc3jsD8ngo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777333834;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=KgHNHwy986mQko+AXCe15b4cFbyoBz/VH5W9uV60InA=;
	b=nqYFNf0F/b1Qr9O5p2FNYYnyqXjsBbySejZZESlPE6IWjORjQ9i4DQvDIeHLLuEf
	OWFftbyiVebqDOK4KM7Ctev3bVuCUIbX2U3T8otfK5y/DX/9mQFJtFShyLHqDAIuumY
	WFkegwjnh5j5nYgsFA9dcG868LhT0o9sBuV/XCTY=
Received: by mx.zohomail.com with SMTPS id 1777333832000463.8710881772233;
	Mon, 27 Apr 2026 16:50:32 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net] mptcp: use MPTCP_RST_EMPTCP for ACK HMAC validation failure
Date: Tue, 28 Apr 2026 05:19:34 +0530
Message-Id: <20260427234934.1611893-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: ED6B947BF51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mpiricsoftware.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241451-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,mpiric.us,mpiricsoftware.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When HMAC validation fails on a received ACK + MP_JOIN in
subflow_syn_recv_sock(), the subflow is reset with reason
MPTCP_RST_EPROHIBIT ("Administratively prohibited"). This is
incorrect: HMAC validation failure is an MPTCP protocol-level
error, not an administrative policy denial.

The mirror site on the client, in subflow_finish_connect(), already
uses MPTCP_RST_EMPTCP ("MPTCP-specific error") for the same kind of
HMAC failure on the SYN/ACK + MP_JOIN. Use the same reason on the
server side for symmetry and accuracy.

Suggested-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Fixes: 443041deb5ef ("mptcp: fix NULL pointer in can_accept_new_subflow")
Cc: stable@vger.kernel.org
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e2cb9d23e4a0..afb174ed9c47 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -908,7 +908,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 			if (!subflow_hmac_valid(subflow_req, &mp_opt)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
-				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 				goto dispose_child;
 			}
 
-- 
2.34.1


