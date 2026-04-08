Return-Path: <stable+bounces-234802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMD5Heuh1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:43:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB0B3C15C8
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECB7D30117B4
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766573624B0;
	Wed,  8 Apr 2026 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="idd7BFZ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3F827979A;
	Wed,  8 Apr 2026 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673800; cv=none; b=StNJJhYeXR1f+vu2Cvh7Rs/j+j5IjtNhry59wKdzjcEToWqj4KWRjuXnrItWu3+c0Mkey/quvOTj3vODAoTDUlyHlivqi8j8zJ1tskPOFKI7wMxz+lsdsvCVGPuOrx9L7KC+N62I8MksW324zq1RXy20tgXBYEHgQnIExpvc2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673800; c=relaxed/simple;
	bh=2DMiE1voqQhrG1YQS75gTeL/j7iiSqTBAr8jFXQ7xtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5pmjhceHS84wInRpLa2b0GQFc704mNhEaRTnmsgUhLxs57j+b+RuIKdDdwtZ+U9rdsPZQd/trHilslmAoZQYnJ57h7za3vOlPFAx0CucMZq+h7cYZI0Z1ac0Attc5uVirOMGRcbEDuyxXLyrVAJE9+qOlJ4NKwYTjsNfPKK7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=idd7BFZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C502CC19421;
	Wed,  8 Apr 2026 18:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673800;
	bh=2DMiE1voqQhrG1YQS75gTeL/j7iiSqTBAr8jFXQ7xtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idd7BFZ52OmN/u2Jv1629DuWf1/0S5LQ5DSBiU5nqL6ylo8oSGT5y3Sf/pcwNZSVC
	 S6+F1X90x7BFkna6QVPeYvO17R92vU9Ot+GRTZP6ckBZDc6OO8RWlucNMm4SoQXrZQ
	 cnsMJcylsXCSLoATou5k/5KQb6KYiaPUUEAJc0oY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 094/242] bnxt_en: Restore default stat ctxs for ULP when resource is available
Date: Wed,  8 Apr 2026 20:02:14 +0200
Message-ID: <20260408175930.602771235@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234802-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,broadcom.com:email]
X-Rspamd-Queue-Id: 1DB0B3C15C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

[ Upstream commit 071dbfa304e85a6b04a593e950d18fa170997288 ]

During resource reservation, if the L2 driver does not have enough
MSIX vectors to provide to the RoCE driver, it sets the stat ctxs for
ULP also to 0 so that we don't have to reserve it unnecessarily.

However, subsequently the user may reduce L2 rings thereby freeing up
some resources that the L2 driver can now earmark for RoCE. In this
case, the driver should restore the default ULP stat ctxs to make
sure that all RoCE resources are ready for use.

The RoCE driver may fail to initialize in this scenario without this
fix.

Fixes: d630624ebd70 ("bnxt_en: Utilize ulp client resources if RoCE is not registered")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20260331065138.948205-4-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7748,6 +7748,8 @@ static int __bnxt_reserve_rings(struct b
 		ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
 		if (!ulp_msix)
 			bnxt_set_ulp_stat_ctxs(bp, 0);
+		else
+			bnxt_set_dflt_ulp_stat_ctxs(bp);
 
 		if (ulp_msix > bp->ulp_num_msix_want)
 			ulp_msix = bp->ulp_num_msix_want;



