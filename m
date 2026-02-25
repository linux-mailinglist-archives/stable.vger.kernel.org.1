Return-Path: <stable+bounces-218669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDOXDSBTnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BB418F6DB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E2EE3092215
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C244425EF9C;
	Wed, 25 Feb 2026 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k7/wgifY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86271258EF9;
	Wed, 25 Feb 2026 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983523; cv=none; b=CADjE6ZYNK0hlo36J9cm92LJmF/BhMFBF5hV3uhEQWITije12tz5zuRBXiP2EkW6TZkNJ7984cD0WQ701RbRGPrffi4lde33KnS9UeaTZrbvzKVIyx6DaYEeEeZJmUbyMMWoQBiwXs/UNI07VPr7uivc+iUPsQIgFWlO+834RQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983523; c=relaxed/simple;
	bh=/r+5Y3/Wx3rV9tP+WNWt267zVm1fSwEhXao/DLnD4g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hocg4tYQGeIK6zMoed9PhpsNTWN/BVNlsr6wFgBTZbC88I7n15xpM7B/6/2I06iCJwhey8OkpZ1uuh4VGCFlCf9smI50LN6GtYFRI91ghtzSLKDjSibP3svLZayPzMBNGdENliBVbFlvoRzghCCUwic68HFn6q51Ct9qweFPonw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k7/wgifY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D77C116D0;
	Wed, 25 Feb 2026 01:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983523;
	bh=/r+5Y3/Wx3rV9tP+WNWt267zVm1fSwEhXao/DLnD4g8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7/wgifYtmDFiObTx/rHnuAgt/X3gIl8BfP0uQs8blsXlyCR65OfBuIetfI504ub1
	 Nm0SZkKJEO53knoVr6tzuQlyRK/7KwinQnKUT+0kcnHGpdhaT6DIF5hw5GGjZCDIST
	 ZMYZRu+uU/ryQe989DeFvhVkn7X+6hydEuE/XH9I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 631/781] cpuidle: Skip governor when only one idle state is available
Date: Tue, 24 Feb 2026 17:22:20 -0800
Message-ID: <20260225012415.286207835@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218669-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,arm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: F2BB418F6DB
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aboorva Devarajan <aboorvad@linux.ibm.com>

[ Upstream commit e5c9ffc6ae1bcdb1062527d611043681ac301aca ]

On certain platforms (PowerNV systems without a power-mgt DT node),
cpuidle may register only a single idle state. In cases where that
single state is a polling state (state 0), the ladder governor may
incorrectly treat state 1 as the first usable state and pass an
out-of-bounds index. This can lead to a NULL enter callback being
invoked, ultimately resulting in a system crash.

[   13.342636] cpuidle-powernv : Only Snooze is available
[   13.351854] Faulting instruction address: 0x00000000
[   13.376489] NIP [0000000000000000] 0x0
[   13.378351] LR  [c000000001e01974] cpuidle_enter_state+0x2c4/0x668

Fix this by adding a bail-out in cpuidle_select() that returns state 0
directly when state_count <= 1, bypassing the governor and keeping the
tick running.

Fixes: dc2251bf98c6 ("cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START symbol")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/20260216185005.1131593-2-aboorvad@linux.ibm.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/cpuidle.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c7876e9e024f9..65fbb8e807b97 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -359,6 +359,16 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		   bool *stop_tick)
 {
+	/*
+	 * If there is only a single idle state (or none), there is nothing
+	 * meaningful for the governor to choose. Skip the governor and
+	 * always use state 0 with the tick running.
+	 */
+	if (drv->state_count <= 1) {
+		*stop_tick = false;
+		return 0;
+	}
+
 	return cpuidle_curr_governor->select(drv, dev, stop_tick);
 }
 
-- 
2.51.0




