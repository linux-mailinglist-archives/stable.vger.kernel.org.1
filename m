Return-Path: <stable+bounces-213968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAIiJhhlg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:26:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEBDE88D4
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAA76313F962
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCA441324E;
	Wed,  4 Feb 2026 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YUz4QHzE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92922332E;
	Wed,  4 Feb 2026 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218115; cv=none; b=g34MJEs+tQqppc+YoHHLFfn2ay2vD4Omjh/BrBH0IT4SXl1+1KQftXcUvuOx7wKeM6QAg11do9B6raAKvwY49lxKEDGNGE5UX6WQDwchIKicr+UfkTyYxIM866GFn5+Qa9P7qiTpYzsZKhKo+itJsSL9A2wjSE2Eu35G0iY73Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218115; c=relaxed/simple;
	bh=+bBMKIGZZuWgvb8B1s8nhoGNJmiRilHJ2eadZIKdkK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kg++bt/fk5tPo/+feApD3lMVeWFQ5EIZzlRi9AiCuddsvWttx2RkXBy/UdS81bHQk6M8VO+Y59aaq+hi2cOElPA1QCjlsu91av6QRhEMJ5LPBT8THuWY7YIm57DTANg7iajn8fc2tshw+4HxcY2KcQ2Skd5ubEObnfYK8cHXNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YUz4QHzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE56C4CEF7;
	Wed,  4 Feb 2026 15:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218115;
	bh=+bBMKIGZZuWgvb8B1s8nhoGNJmiRilHJ2eadZIKdkK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUz4QHzEQvzS0ybp/U7ZHTOsK/TKDPwECZqR+tw5+zYXUNEk6i/sXEFpKhjC4zVvm
	 Q2GkJP3nq/7XKLF3tokK7lIa6h0EJkmX/ctqjUdSj7mQ3tCuLmY8v7TUG/ea4VqcsF
	 2WKnNQWrAP5gaffHSh3np+XMtdgLh8XXKjdLWaiw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 216/280] drm/amdgpu/soc21: fix xclk for APUs
Date: Wed,  4 Feb 2026 15:39:50 +0100
Message-ID: <20260204143917.381877038@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213968-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: ECEBDE88D4
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -202,7 +202,13 @@ static u32 soc21_get_config_memsize(stru
 
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
 
 



