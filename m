Return-Path: <stable+bounces-231903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LMoLNEBzGk8NQYAu9opvQ
	(envelope-from <stable+bounces-231903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:18:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1F36E729
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE78A32B2E02
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C8F425CD1;
	Tue, 31 Mar 2026 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bZykPqzJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504E402B9B;
	Tue, 31 Mar 2026 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975365; cv=none; b=YRuAB9as8YhzY9y41XYYJvWBcHc0ifm/gDlA4J4p/mSX5a3Fk7loR39pt/E6uaHEtuCTCA8JMafnZNDOd1ScIQZjp+pLSacHCnh7Ls+j40N0mygf2JiwS6TlHxGyl5DM8XCkaEKKdHN7/YCueQ1GumAAQim1vX5TLQous1QvSsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975365; c=relaxed/simple;
	bh=k+tbv3bDS5DbLCfISkVceSu1IoHvLjdpYqS/iVbK+yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6g7Nnm3Cv8oy9vm4FL76nGRMH2KxTyq/WKnH1BU9W3BgEklZrzze1yLfv1PWAXm7JWqa/IOn1UOlw+DbAixF5k2wm5+fywX36wmnbDf0pmVAIZwNQeQaVDPsPkDS+aRBgKah3e+8Ix15h5VUUwD9Gp0/ZB0e23Ij13KprpRBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bZykPqzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBC1C2BCB1;
	Tue, 31 Mar 2026 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975365;
	bh=k+tbv3bDS5DbLCfISkVceSu1IoHvLjdpYqS/iVbK+yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZykPqzJX5xHnSoT7ot6+zsHbNqNEZyI5CLOgS8ODqOiEzsC/N4WwpdvJ4CP2L6Is
	 q9RDL6N6uobi1o3NpjMSXoOJgJm0X5OPHLHF/RdIQlPZqOvn326QZEF5lAtbYDi5cB
	 3RnjhdtxagAJE6azxDpSJrZMeNs60kqIgaiv0kMc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Chuanyu Tseng <chuanyu.tseng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.19 265/342] drm/amd/display: Fix drm_edid leak in amdgpu_dm
Date: Tue, 31 Mar 2026 18:21:38 +0200
Message-ID: <20260331161808.701856298@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231903-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 16C1F36E729
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Hung <alex.hung@amd.com>

commit 37c2caa167b0b8aca4f74c32404c5288b876a2a3 upstream.

[WHAT]
When a sink is connected, aconnector->drm_edid was overwritten without
freeing the previous allocation, causing a memory leak on resume.

[HOW]
Free the previous drm_edid before updating it.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 52024a94e7111366141cfc5d888b2ef011f879e5)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3891,8 +3891,9 @@ void amdgpu_dm_update_connector_after_de
 
 		aconnector->dc_sink = sink;
 		dc_sink_retain(aconnector->dc_sink);
+		drm_edid_free(aconnector->drm_edid);
+		aconnector->drm_edid = NULL;
 		if (sink->dc_edid.length == 0) {
-			aconnector->drm_edid = NULL;
 			hdmi_cec_unset_edid(aconnector);
 			if (aconnector->dc_link->aux_mode) {
 				drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);



