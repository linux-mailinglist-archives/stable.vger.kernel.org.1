Return-Path: <stable+bounces-226939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCAjN/z1uWnnPwIAu9opvQ
	(envelope-from <stable+bounces-226939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:46:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CFD2B4AFA
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D33A23095320
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754F4288D2;
	Wed, 18 Mar 2026 00:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9ARaFS2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C1363CB
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773794809; cv=none; b=AfKKaNPbSYSWljFk8FaIa5LGWlAn1+1mGzqoUa0AnjJjmxnEJS60P6x54BpURT+ZJUe5Na9jZK/yDK3fdoNALlc3+Aw/XE6RHcJ198OrRVcwn8eGgJLVJvN92roFPDmDL7cw94k0vgKF626KV7UhXgxsuYlTWB/i+BRvh4G1iVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773794809; c=relaxed/simple;
	bh=A/Vst9YxyRftOZ6yJ5rf/8b5CJ/7UyOV3w8J8Gl2qtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEj5GIYjS1s5qlN+WlaCn9QYvoAgdYx2UNZPtUnDKAkhwiamQYG2/Jnb0PvOBcxVzJRYFHbCxnuVsDb10KMh0v9Qt9/Fn0oal/mL/02y2HtS9feC2Daagn2KXhY/j1eNx16XYlHlBLJyQgcALKu4blqx7QKDrIJpdHE0r1PRrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9ARaFS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D8EC4CEF7;
	Wed, 18 Mar 2026 00:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773794808;
	bh=A/Vst9YxyRftOZ6yJ5rf/8b5CJ/7UyOV3w8J8Gl2qtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9ARaFS2SMcx3XjMnIvik98LiceeedoQyhTjtPBxgqJ89QpNLpQcaIPFKibU5fce0
	 Shy5aoYR3FuGPCUpZj/BDPytE0nPe0R9sDw6gjqKrfLUOBg9WtRYaCN/hgXvOhHzT4
	 8NPQ2IMnph9u6g69QV+dZ0gW+sTGbtqWFZAKm3dzLvSKDnGlPSQx/wyfbQI7s7KZBf
	 mCcej3FYGO01nSDRRlA0TF6m8Bw91DLBzJ9Yha9+i5Wqx4k0bFfkhGbmsVlPoNl5bA
	 62z3nUrxm2i4gvBrRO5pMurbM8c9RRp8szhTwP1moDfPBDlo1XDutGAsqAxRDCvTv8
	 yim+Jo7VXiANA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Simon Horman <simon.horman@corigine.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] ice: sleep, don't busy-wait, in the SQ send retry loop
Date: Tue, 17 Mar 2026 20:46:45 -0400
Message-ID: <20260318004646.408222-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031702-configure-decorator-0097@gregkh>
References: <2026031702-configure-decorator-0097@gregkh>
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
	TAGGED_FROM(0.00)[bounces-226939-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 39CFD2B4AFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit b488ae52ef9f74155ab358f8c68e74327b45e0e1 ]

10 ms is a lot of time to spend busy-waiting. Sleeping is clearly
allowed here, because we have just returned from ice_sq_send_cmd(),
which takes a mutex.

On kernels with HZ=100, this msleep may be twice as long, but I don't
think it matters.
I did not actually observe any retries happening here.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: 326256c0a72d ("ice: reintroduce retry mechanism for indirect AQ")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 3de6f16f985ab..75b54bef8be3a 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1442,7 +1442,7 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 
 		memcpy(desc, &desc_cpy, sizeof(desc_cpy));
 
-		mdelay(ICE_SQ_SEND_DELAY_TIME_MS);
+		msleep(ICE_SQ_SEND_DELAY_TIME_MS);
 
 	} while (++idx < ICE_SQ_SEND_MAX_EXECUTE);
 
-- 
2.51.0


