Return-Path: <stable+bounces-214073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NdBIM9mg2ntmQMAu9opvQ
	(envelope-from <stable+bounces-214073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:33:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7DCE8DD7
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 133B230603EB
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FED41B37E;
	Wed,  4 Feb 2026 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K37M/pOH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF1E2C08AC;
	Wed,  4 Feb 2026 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218473; cv=none; b=T399+ycl1wLRI7F6LGmLRz1Dg9Fu33dxakA+7NqRwgo053SKEwZJUZP79WpqVdMjuIt3a7dikrc7VgTxyeoM6dABlliBeJ5Bw3Czu0DJO+XwfM6PVjcibekdp/i7722kG6s3KVqciP227x0dBG9bAxB7IZKf0zcLMVyO3ZEFzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218473; c=relaxed/simple;
	bh=IvAZDp7R4+Xsf7bFwWVCTirHuOk+ja6Llf/Dyz7u1D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGYv+nx5P2hMtLcDL/697m7V4shltuXgKbuVexe71wVER2h0U2gU/pLoa764IuWOxtsmbe6TW3RK8bC5Xa/HNpCvCoIEejW9BZJStQ661vYjM5GbnINz/7JXd+7L9hluvSHP/q4pujVWFXQ3nEi2CKmuRNeSJrcOSTVrSG0J1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K37M/pOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7064DC4CEF7;
	Wed,  4 Feb 2026 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218472;
	bh=IvAZDp7R4+Xsf7bFwWVCTirHuOk+ja6Llf/Dyz7u1D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K37M/pOHiOxGOyXfY+irPTjfWmi9KNshLx2QJoWhFNP/kigHJmXDUO8EgGP+QOVIt
	 82Ru08Q7khAhTGotgbzBsYm1yq5aVj61ZuEEHq7P+C7EVLYMJLAK1WJXchOFe3qEV8
	 a2uK78zSXDz+fiPbKH7Iako0lihi9oCJCZ8f9eZw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 39/72] drm/amdgpu/soc21: fix xclk for APUs
Date: Wed,  4 Feb 2026 15:40:42 +0100
Message-ID: <20260204143847.043345495@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143845.603454952@linuxfoundation.org>
References: <20260204143845.603454952@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214073-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,gitlab.freedesktop.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD7DCE8DD7
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit e7fbff9e7622a00c2b53cb14df481916f0019742 upstream.

The reference clock is supposed to be 100Mhz, but it
appears to actually be slightly lower (99.81Mhz).

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/14451
Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 637fee3954d4bd509ea9d95ad1780fc174489860)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -218,7 +218,13 @@ static u32 soc21_get_config_memsize(stru
 
 static u32 soc21_get_xclk(struct amdgpu_device *adev)
 {
-	return adev->clock.spll.reference_freq;
+	u32 reference_clock = adev->clock.spll.reference_freq;
+
+	/* reference clock is actually 99.81 Mhz rather than 100 Mhz */
+	if ((adev->flags & AMD_IS_APU) && reference_clock == 10000)
+		return 9981;
+
+	return reference_clock;
 }
 
 



