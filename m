Return-Path: <stable+bounces-250837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJt2ADHyDWrj4wUAu9opvQ
	(envelope-from <stable+bounces-250837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:41:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8D2594475
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D1023263BE0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AF53F1ACB;
	Wed, 20 May 2026 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FsWLaRo3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A23F23D9;
	Wed, 20 May 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296436; cv=none; b=P4hUdCsOuoHcHuZ0xrKq+bDcWxOMUFfiuaX6OYLOFqGnu0sXqv/D6Ia3HLffxiU+Ijoshzudn/XZVbOuD74ZtMnG+7FEi6HzbT8Ruwybpe1+aYuia4SRRWUnCUaqKe6PysrrkEPjNEkjl0ZFGgLq0SKhUmkhaFZM5S3lmGLu9jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296436; c=relaxed/simple;
	bh=8KbvEuxYn9gEwyFV148VCHVDzdX20prLPkjugddkYzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNgRmJRICIf5y8yx2tIeog6JZRcjlgvLFn8mRXyi5ednjNKopCtRNIhxxXscOW1djGZLh8aNdV2FJfBa/6ijgAJRV0S8RPEko8k9pTb+AXSMtBViNHODRObfBBRV4XTR003h1iUaxzmES/owNlWEiycSUJvfzl9UR0Q5+JUj1s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FsWLaRo3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DF11F000E9;
	Wed, 20 May 2026 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296435;
	bh=dLTtR9tJLnrOtWoceNj2AGfvWZIjeilmazThWt4WLts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FsWLaRo3cYUXKFcXb2vbapVS9f43lc7S0J8OeTpxwLrpDIEirbk/MdPT61UuHsi7r
	 Di+RbuAZou5xDrDNQem+3J8Bn5rC6euWEpMxNNJ1mHatD1dfGBRsSFM2cLDZc9rLJn
	 xiRbpgjxQWLqehzJ8I9a6dTbpdoMVE99Ax7iatEY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0798/1146] ice: fix ICE_AQ_LINK_SPEED_M for 200G
Date: Wed, 20 May 2026 18:17:28 +0200
Message-ID: <20260520162206.286658276@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250837-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ED8D2594475
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Greenwalt <paul.greenwalt@intel.com>

[ Upstream commit 4a3a940059e98539de293a6e36e464094c2e875b ]

When setting PHY configuration during driver initialization, 200G link
speed is not being advertised even when the PHY is capable. This is
because the get PHY capabilities link speed response is being masked by
ICE_AQ_LINK_SPEED_M, which does not include the 200G link speed bit.

ICE_AQ_LINK_SPEED_200GB is defined as BIT(11), but the mask 0x7FF only
covers bits 0-10. Fix ICE_AQ_LINK_SPEED_M to use GENMASK(11, 0) so
that it covers all defined link speed bits including 200G.

Fixes: 24407a01e57c ("ice: Add 200G speed/phy type use")
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20260416-iwl-net-submission-2026-04-14-v2-6-686c33c9828d@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 859e9c66f3e7e..3cbb1b0582e32 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1252,7 +1252,7 @@ struct ice_aqc_get_link_status_data {
 #define ICE_AQ_LINK_PWR_QSFP_CLASS_3	2
 #define ICE_AQ_LINK_PWR_QSFP_CLASS_4	3
 	__le16 link_speed;
-#define ICE_AQ_LINK_SPEED_M		0x7FF
+#define ICE_AQ_LINK_SPEED_M		GENMASK(11, 0)
 #define ICE_AQ_LINK_SPEED_10MB		BIT(0)
 #define ICE_AQ_LINK_SPEED_100MB		BIT(1)
 #define ICE_AQ_LINK_SPEED_1000MB	BIT(2)
-- 
2.53.0




