Return-Path: <stable+bounces-265178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FFXpNU+FMWoYlgUAu9opvQ
	(envelope-from <stable+bounces-265178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:18:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A456692F91
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:18:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=WEsvoUso;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265178-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265178-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00A553023DC8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297E835AC3E;
	Tue, 16 Jun 2026 17:11:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C343D4E8;
	Tue, 16 Jun 2026 17:11:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629874; cv=none; b=kHNapBB16OdVIEVNF3r4MHNyQpo7LTwVR1pbSW2vv8bp6kOmSjKL5woKDoiyxC7YozTzDaV+5yUZHKmyX5wKb1GWRHxeE37Zq+xh/kz0WCDtZ8IneC3Zm0QBskypARSJ6RsJmo0g+P5UHNoCPZ+St9ovplQbHp5174hq0Oy7ELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629874; c=relaxed/simple;
	bh=hyokYjUU9sOIRRraBPJZ2ngiDMyxk881YlGllkf5dOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2FlRxS71je1R1GN7JG/A+qJTNvTun7PUk/G09wAkVgzAhJr7ZzFmKZEz3hnlnbLk/3gMdsuMqGTYyumVqz52zbTFiRDIDTBMzSPDcCUHJXi2fnMkdr5LPLJaX9AQF7RzNn39/eFLPSyePPeCcUmfGOQjakFR0Lko0e1DpmrkQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WEsvoUso; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC761F000E9;
	Tue, 16 Jun 2026 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629872;
	bh=1apqmHeFLI0Q3/Ai5V6GRo6mbjKtlAfSBJRZoPkYqng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WEsvoUsox69/WHDhfGOICOxPLbTG8FXvmxzk6wDzNP2MydbLtGNiW/cn0vmm2snZy
	 qEeqLmewAZNzAj1SF4/QCWoIRgLqjk1EoG4O0AVFhAHeZR+uR3XQqOTGKKg3uZSM2Q
	 rjmOIIErOyc/YelR93rd8x/HlzLrf182sjzIt70A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 367/452] drm/amd/display: Use krealloc_array() in dal_vector_reserve()
Date: Tue, 16 Jun 2026 20:29:54 +0530
Message-ID: <20260616145136.340192172@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-265178-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:alex.hung@amd.com,m:harry.wentland@amd.com,m:ray.wu@amd.com,m:daniel.wheeler@amd.com,m:alexander.deucher@amd.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A456692F91

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Wentland <harry.wentland@amd.com>

commit da48bc4461b8a5ebfb9264c9b191a701d8e99009 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/basics/vector.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/basics/vector.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/vector.c
@@ -288,8 +288,8 @@ bool dal_vector_reserve(struct vector *v
 	if (capacity <= vector->capacity)
 		return true;
 
-	new_container = krealloc(vector->container,
-				 capacity * vector->struct_size, GFP_KERNEL);
+	new_container = krealloc_array(vector->container,
+				       capacity, vector->struct_size, GFP_KERNEL);
 
 	if (new_container) {
 		vector->container = new_container;



