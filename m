Return-Path: <stable+bounces-226940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGxWEwL2uWnnPwIAu9opvQ
	(envelope-from <stable+bounces-226940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:46:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E0D2B4B01
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 334DB309C76A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF6F19CC28;
	Wed, 18 Mar 2026 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVcVxsuL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1CB63CB
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773794810; cv=none; b=b0W1WXb/Vynncr09gFe1G7YFyrvpMb0mmYUtOPrHVIX9ufI1fxVGw7AABh7Pey3NqP1DiJQtigtwMXE9lh0EulpHh2rnk2qqv+ftS2E2PX5LyePhxQPRV5yOfxZ2ta1ci+O2MyaLkqRp0FrIOAA0RiM3e6Ode80w00YjxCTdoek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773794810; c=relaxed/simple;
	bh=nu5V9txB2lTknRc1Zna4Z4zJoICLCBp3mRzjTzJgaEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4K+dm84O69163vWB+5fayCTuAh+AtQ9BK8pymt76lcrol//0CHnhjWUFwVoVLqyubZovzy2cLGX8bY21/WS7kN9fISB6bMD9U2MWPe0kyJFtucVs0QqWW37kvPSoenz0vYhU3lNxZRR+8NRojISokGWyj/z4/nez16AINXY2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVcVxsuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10338C19424;
	Wed, 18 Mar 2026 00:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773794810;
	bh=nu5V9txB2lTknRc1Zna4Z4zJoICLCBp3mRzjTzJgaEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVcVxsuLrLopECFyxarpjkh0DHpX/FX9iUHGhY5zvpz7Pt67Dkds7fP/3h7yTdiEG
	 iidpLbrSQHnwLqTIz46rS9FSvV9K2DKUe8heFILGoVAyi5iNabzLZLCvexf0S+d7Z6
	 Oz2C09dx9cCuI+PFf7SbHfv+Y4elFci4hHWlmx6UwxS7L23K7OXHJxeyyxWZyTtSaH
	 ppygh2Sq8iZdUIDjjvhuxIKsD9agA7tDm8Q32X0kc1ncT32JGwuzrznosczsCVslov
	 rY29pKMge2vAtKSHwupZS7lBVZFaBDNZxsql+FihEweGiL6eicLRSa2U/1Bfw5FR8z
	 QktxcQTDY4UoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] ice: reintroduce retry mechanism for indirect AQ
Date: Tue, 17 Mar 2026 20:46:46 -0400
Message-ID: <20260318004646.408222-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318004646.408222-1-sashal@kernel.org>
References: <2026031702-configure-decorator-0097@gregkh>
 <20260318004646.408222-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226940-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 86E0D2B4B01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>

[ Upstream commit 326256c0a72d4877cec1d4df85357da106233128 ]

Add retry mechanism for indirect Admin Queue (AQ) commands. To do so we
need to keep the command buffer.

This technically reverts commit 43a630e37e25
("ice: remove unused buffer copy code in ice_sq_send_cmd_retry()"),
but combines it with a fix in the logic by using a kmemdup() call,
making it more robust and less likely to break in the future due to
programmer error.

Cc: Michal Schmidt <mschmidt@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 3056df93f7a8 ("ice: Re-send some AQ commands, as result of EBUSY AQ error")
Signed-off-by: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
[ kzalloc() => kmemdup() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 75b54bef8be3a..3f16b80308f92 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1422,7 +1422,7 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 
 	if (is_cmd_for_retry) {
 		if (buf) {
-			buf_cpy = kzalloc(buf_size, GFP_KERNEL);
+			buf_cpy = kmemdup(buf, buf_size, GFP_KERNEL);
 			if (!buf_cpy)
 				return ICE_ERR_NO_MEMORY;
 		}
-- 
2.51.0


