Return-Path: <stable+bounces-234938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA2dFOyo1mlKHAgAu9opvQ
	(envelope-from <stable+bounces-234938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:13:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C14CE3C29BF
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C348313CEF3
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C49A3D75C3;
	Wed,  8 Apr 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oxLJ6Ew+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFE733121F;
	Wed,  8 Apr 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674152; cv=none; b=Pz0K4pK626m7OJRocYB6uDKmFnsyDOs0ahPAoCRscosqe3QWi4F/dejhRR6u4kkgTsCDiK+t6aY/ZFAyadS1cVC5GinMtSJiIDHBIvvK6LeZL2FgNOzXd087i0pLrreKopYEBhsvQgw9LS8qZeQmZQNpDzeXAr2aWH0JNRJ+DaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674152; c=relaxed/simple;
	bh=TwnnLIhSQeoG7JwXZyMOPRJLkOUA/sWbHdvnaBbpCsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBYrjiM1QHuf/sqw8AEYYepCLNid1WCLECv2akrJpWRFD5MvVMhPTQT+Eq5UwpgazgAvFy3qoNxApJYiZlLp/Mmiq6dRsQIl2lJ7eylyE+EHI6e/ZILR1S80CAGT/erP83bH4E4p5emYiwhrxUvNQsqnrJksSyoJTI0QHCsq1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oxLJ6Ew+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB0EC19421;
	Wed,  8 Apr 2026 18:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674152;
	bh=TwnnLIhSQeoG7JwXZyMOPRJLkOUA/sWbHdvnaBbpCsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxLJ6Ew+QyeQP8wVx0wWm88yoPQScQCCODaVZBFGA3nqVNCvu1UIJBhRfAOaFjhEu
	 qqWfQuO9PR3bQyKqUwN6I+q+u31JIS1+lcrlf93UGXxiz9X4GfALVDnNuBiVsEHJCd
	 dcIYc2ursPx8FTOHOxas5YYy27MlMGXH1kb1z/ag=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Rosen Penev <rosenp@gmail.com>
Subject: [PATCH 6.12 229/242] drm/amd/display: Disable fastboot on DCE 6 too
Date: Wed,  8 Apr 2026 20:04:29 +0200
Message-ID: <20260408175935.667342079@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,igalia.com,amd.com];
	TAGGED_FROM(0.00)[bounces-234938-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,amd.com:email,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C14CE3C29BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]

It already didn't work on DCE 8,
so there is no reason to assume it would on DCE 6.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1910,10 +1910,8 @@ void dce110_enable_accelerated_mode(stru
 
 	get_edp_streams(context, edp_streams, &edp_stream_num);
 
-	// Check fastboot support, disable on DCE8 because of blank screens
-	if (edp_num && edp_stream_num && dc->ctx->dce_version != DCE_VERSION_8_0 &&
-		    dc->ctx->dce_version != DCE_VERSION_8_1 &&
-		    dc->ctx->dce_version != DCE_VERSION_8_3) {
+	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
+	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
 		for (i = 0; i < edp_num; i++) {
 			edp_link = edp_links[i];
 			if (edp_link != edp_streams[0]->link)



