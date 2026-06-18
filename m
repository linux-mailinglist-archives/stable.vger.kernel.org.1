Return-Path: <stable+bounces-267127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aLT2KrLqM2qdIQYAu9opvQ
	(envelope-from <stable+bounces-267127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 14:55:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4626D6A0389
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 14:55:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FT2QI7Ry;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267127-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267127-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3017300D347
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 12:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662833ECBDA;
	Thu, 18 Jun 2026 12:55:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366683B4EAD
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:55:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787312; cv=none; b=uO8tlOhhvoYF1PuBTchohcy3onzQhTbX/WMXiqkHgsFLMy8xfQgh6IasziFArxJRgCnk2e7Rqwqm4fJLEXqrT9uI+648eb+HY1DFy+HEl/7mZuNkM0Ef7D0JOl6kwLbxNY/Ai6WllO9Q7EEhNWljNCgU7agwAhXnObJ5lVZ/41Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787312; c=relaxed/simple;
	bh=EmpfrdCO5EgsqLEjX2SnmBVxKoWYKXReHd7T8A+t3do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSUSQKBfEkHq6Pu6kZq9c1xED3iWPWhDosjcqyaY6C8rhjqt45tcIUWVWf/0vOfK5AwDA9bQVlNtUnCAhwOoLKqkryP97eFcc8JncRySkkdRJccnJ4qhLb4PYT/HPFxhSOo4xSayggx55VF6EMY+yA5r3yLtrAUebS22l5jWHEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FT2QI7Ry; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C1B1F000E9;
	Thu, 18 Jun 2026 12:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781787310;
	bh=RfZKI3D/yhYRk7MBuRA2f2zeCVtHtrZqlF9ARYn1gMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FT2QI7RyOYljHrDjfm7QtCRZsrM9d81IsyitjCokqLZ/0pghui7Wl9wyrxH1SlDsX
	 5zRTX2V1uOcXT2LtXhYKKsPwQhTdOv5Gjwv7sCFIhFnuZezCxcWa/vG9yhsoPEtYtQ
	 Mw71Lcpr0s0XeaV311bi8cwsCmb1APkfNv89qPXK2K4Fk6jCvSE0DreraDkPZ2odfX
	 eOt3rMARa5rH+7kGgMEhoHtMpfvOqgHkQNqtvdjt6k6RcF4L6Gr3BMM+yGoucN9CVN
	 rWhM6W0KjTqaCqlY9JBBqBAWgc4B0fta0ghpN/i0tQKtexLXwLH1fa70qtoanyEfpE
	 gUpzzi1e5PNXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amd/display: Use krealloc_array() in dal_vector_reserve()
Date: Thu, 18 Jun 2026 08:55:08 -0400
Message-ID: <20260618125508.651313-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061531-reattach-unlatch-3025@gregkh>
References: <2026061531-reattach-unlatch-3025@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:harry.wentland@amd.com,m:alex.hung@amd.com,m:ray.wu@amd.com,m:daniel.wheeler@amd.com,m:alexander.deucher@amd.com,m:sashal@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267127-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4626D6A0389

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


