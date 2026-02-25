Return-Path: <stable+bounces-219480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fv5JdWgnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:12:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1765719316F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBB8831F6081
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393473016E5;
	Wed, 25 Feb 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FxULdQBh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C292D23A4;
	Wed, 25 Feb 2026 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002744; cv=none; b=XAMtEzg+mcnOhiV1zYsu8Io5PCe0BpPFvyUnVFHXkG+dZJ5tnl/I+ATmai+pNw3uYGZJ52DrkBlndec2Og4f12KpP9cjB3hlrku90eh57IJYp1GUSPzSLZQqSwtzWKClc216OVlfiNUzHpIYLscxAPm5nHvRhA1G4psKGXTSFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002744; c=relaxed/simple;
	bh=jyWTrhbMeSD/iBbhrRN3jCSjKq0CjYEvTM2+ZYKblUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPjQyXyjGZrbjblAAix2wD3+zBJqzzGWf5Ahm2VUgiV9vJyjm3bPVvXXUeFv6ITOQ8St+7PPdvTA1ZG9nftws2QPuZNfJn9comKQfr9+4fI9QFzVzbEYj83HlLil4lQtmvjfy65Ag0Tjz4FuDc7w5M49SkH0JCW7JwvSCnptlSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FxULdQBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA032C116D0;
	Wed, 25 Feb 2026 06:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002743;
	bh=jyWTrhbMeSD/iBbhrRN3jCSjKq0CjYEvTM2+ZYKblUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FxULdQBh7wN/yDRZQAT2DK4TmnUtabZLWJq+aUTwAMnqlpgWDsKMEz5NW7+iL9fV+
	 SXPcZJtNk3ORe7YLjizm04WmvJj7NWcDHPl0Jq8KQvCD4d38Z+gRl4wD/lzHbXCHAo
	 2iClMnjVR6bMV87JwSCQ7Q8TzZM3rBRta7LizhJo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 557/641] bnge: fix reserving resources from FW
Date: Tue, 24 Feb 2026 17:24:43 -0800
Message-ID: <20260225012402.020660876@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219480-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,broadcom.com:email]
X-Rspamd-Queue-Id: 1765719316F
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vikas Gupta <vikas.gupta@broadcom.com>

[ Upstream commit 604530085b2ef484843c723a105b6fd3218b4710 ]

HWRM_FUNC_CFG is used to reserve resources, whereas HWRM_FUNC_QCFG is
intended for querying resource information from the firmware.
Since __bnge_hwrm_reserve_pf_rings() reserves resources for a specific
PF, the command type should be HWRM_FUNC_CFG.

Fixes: 627c67f038d2 ("bng_en: Add resource management support")
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260218052755.4097468-1-vikas.gupta@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 198f49b40dbf0..2994f10446a63 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -442,7 +442,7 @@ __bnge_hwrm_reserve_pf_rings(struct bnge_dev *bd, struct bnge_hw_rings *hwr)
 	struct hwrm_func_cfg_input *req;
 	u32 enables = 0;
 
-	if (bnge_hwrm_req_init(bd, req, HWRM_FUNC_QCFG))
+	if (bnge_hwrm_req_init(bd, req, HWRM_FUNC_CFG))
 		return NULL;
 
 	req->fid = cpu_to_le16(0xffff);
-- 
2.51.0




