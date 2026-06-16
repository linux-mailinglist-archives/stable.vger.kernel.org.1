Return-Path: <stable+bounces-264171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lmYHMoJwMWphjQUAu9opvQ
	(envelope-from <stable+bounces-264171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:49:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A29E69168E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:49:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Xfl+slYI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264171-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264171-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A70553028245
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C42844CF44;
	Tue, 16 Jun 2026 15:41:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5F4611C2;
	Tue, 16 Jun 2026 15:41:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624494; cv=none; b=jYUfvJVvbtIkHdFa8IiNQGdzv67Diwox0CJR5894pn/wHE1DGoCklbPt4gPoiiXpHDK9RlDjUVH7HHd/6sGa9Btu2eApoq9SxBXIFVS/ct2Q8e6WmZkvplE7FImDQOT30zufgv0tkODwS3U5OQOYuvMpzj3NbOVoXMlhuuV03Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624494; c=relaxed/simple;
	bh=s2lH5y8hQB6awWW4Fng8HXZnntn82NaHiFeltELGArk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZkBRAiFLynuqI1/fPpfNMFo4oD4UH10A4VTOO+0h3VWmAQQRK3EtJVcwzI4Btu1Y3anB9wkWyjsnNV7RvTReNaGo7GYtHPzg8fQltPLA84FI2kzMIk+yqgLiVl4t40H9sJeQ3X7xaUTbdltuCYgg+E6fpyr+TfDUEU0B/ffatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xfl+slYI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462CC1F00A3A;
	Tue, 16 Jun 2026 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624493;
	bh=bTFe0mMoQdH4WrpoxAAAUUiOPNS6wewKQymZO6gxLOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xfl+slYIRu7QVE3eoZs0TRXzAebdKiFK57zoMwGPT3b9KvHjtuIa8uxWnMPV1RtsN
	 tZMi0HLQuUr9Wsjc6Xfcoups0aB6lhbfVvzfT8X7w1Fxn5tpeGXdp7UbjWQv7LA//P
	 fy5xqfHHzRv12XWL5YNpSxGUjdWay02E0eh24/lU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Wang <kevinyang.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7.0 348/378] drm/amd/pm: apply SMU 13.0.10 workaround during MP1 unload
Date: Tue, 16 Jun 2026 20:29:39 +0530
Message-ID: <20260616145128.478565137@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264171-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kevinyang.wang@amd.com,m:kenneth.feng@amd.com,m:alexander.deucher@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gitlab.freedesktop.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A29E69168E

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Wang <kevinyang.wang@amd.com>

commit 2493d87bb4c31ec9ca7f0ef7257e33b8b175f913 upstream.

On SMU v13.0.10, sending PrepareMp1ForUnload with the default
parameter may leave the device in an inaccessible state. This can
affect runtime power management and partial PnP flows.
e.g: kexec, driver unload, boco/d3cold.

Pass the required workaround parameter 0x55, when preparing MP1 for
unload on SMU v13.0.10, keep the existing behavior for other SMU
versions.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5133
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4e8ee1afeedb8d24dd22cdd5ae9f98a6d76ebe4b)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2801,11 +2801,19 @@ static void smu_v13_0_0_i2c_control_fini
 static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
 				     enum pp_mp1_state mp1_state)
 {
+	uint32_t param;
 	int ret;
 
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		ret = smu_cmn_set_mp1_state(smu, mp1_state);
+		/*
+		 * NOTE: Param 0x55 comes from PMFW 80.31.0, ignored in older versions.
+		 * No PMFW version check required.
+		 */
+		param = amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) ?
+			0x55 : 0x00;
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PrepareMp1ForUnload,
+						      param, NULL);
 		break;
 	default:
 		/* Ignore others */



