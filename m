Return-Path: <stable+bounces-270594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 499NN+icRmqnaAsAu9opvQ
	(envelope-from <stable+bounces-270594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:16:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ABA6FB2D8
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:16:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=t61tWErh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270594-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270594-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E50A31B6750
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E626333C192;
	Thu,  2 Jul 2026 16:22:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2686331A66;
	Thu,  2 Jul 2026 16:22:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009343; cv=none; b=lWxjiX79lkaXiAxLDpdvUcxnSco02mJY8QRxrGCeNBxmcit3Rl6o2p27GtvH+PRZEGC/vVEpDWBzQAVSVgz8PVxq3BnabaoWCiikfaXKyaDU02Y+Ii7EctYoBa3xJKcxeSAqEoBHrW8103N1/SsHyOUXvm/BZi8bVxiqXadJ1no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009343; c=relaxed/simple;
	bh=5pM5ZBuc20cjvL3aNT+U2Gp5JmGp3xJT+dJJeTZluTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZBdnACReoIup+Xqz/nEVwU9Mtse05pKpHwMuw95vrZTEEKzsaAVjRPM5UVpM1w2+zyF4KfBlsEDsePaGuOmoWQlVuwO+5vrj7XLL4VMjAWzVhaOdxAvvdRYPp0lV4VBEcclLVDvKtJwENK4OGCC/qVIPon//CcMzSszMyDwqsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t61tWErh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EC51F000E9;
	Thu,  2 Jul 2026 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009342;
	bh=YVyL2IySaUP9nPRXOObLnt7+vD+c0aIscn3TQ5gZ/XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=t61tWErh2peTZibmeTQjugHNmvkQH6mTIu+GSNr5gCieFUfHMFaVABH+JI/YsJBUM
	 7/SMNdqgxGTfpN7tLhW1WBr9wcUyLfT1PVe4mDWXJ/MxU9EL8+VRBhA4HQ8kKuztLH
	 x+Yj1DDpTVDWi43v0Ry+Ncd/q4/+3mHsxjx+g/iE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 16/96] drm/amd/display: Use krealloc_array() in dal_vector_reserve()
Date: Thu,  2 Jul 2026 18:19:08 +0200
Message-ID: <20260702155109.328267089@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270594-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:alex.hung@amd.com,m:harry.wentland@amd.com,m:ray.wu@amd.com,m:daniel.wheeler@amd.com,m:alexander.deucher@amd.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39ABA6FB2D8

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Wentland <harry.wentland@amd.com>

[ Upstream commit da48bc4461b8a5ebfb9264c9b191a701d8e99009 ]

[Why & How]
dal_vector_reserve() computes the allocation size as
"capacity * vector->struct_size" using uint32_t arithmetic, which can
silently wrap to a small value on overflow. This would cause krealloc to
return a smaller buffer than expected, leading to heap overflows on
subsequent vector appends.

Replace krealloc() with krealloc_array() which performs an internal
overflow check and returns NULL on wrap, preventing the issue.

Fixes: 2004f45ef83f ("drm/amd/display: Use kernel alloc/free")
Assisted-by: Copilot:claude-opus-4.6
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 37668568641ccc4cc1dbca4923d0a16609dd5707)
Cc: stable@vger.kernel.org
[ changed `krealloc_array(p, capacity, struct_size)` to `krealloc(p, array_size(capacity, struct_size))` since krealloc_array() is absent in 5.10 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/basics/vector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/vector.c b/drivers/gpu/drm/amd/display/dc/basics/vector.c
index 8f93d25f91ee2b..68c34a4e253ac1 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/vector.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/vector.c
@@ -292,7 +292,7 @@ bool dal_vector_reserve(struct vector *vector, uint32_t capacity)
 		return true;
 
 	new_container = krealloc(vector->container,
-				 capacity * vector->struct_size, GFP_KERNEL);
+				 array_size(capacity, vector->struct_size), GFP_KERNEL);
 
 	if (new_container) {
 		vector->container = new_container;
-- 
2.53.0




