Return-Path: <stable+bounces-226930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HNIFl3tuWnFPgIAu9opvQ
	(envelope-from <stable+bounces-226930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:10:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF552B4893
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 237573015BB9
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137C6175A5;
	Wed, 18 Mar 2026 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEksY1FW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4D1C6B4
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792589; cv=none; b=kE/Tpu2JhB0nuUggoLYS34EDokXC/GAXCS9VyiCTMDLDJpMsIqoZbnjzFixojxEVER9Kooy4mwxJgqRHvcHJfvwI8yBPV2C8NO9jN0fsPYexR+K5cdFSCTVKK52w+lykgPYV4A5H+qRetHakSPZnZ0wqbZVqnXKqIpU8KZYL69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792589; c=relaxed/simple;
	bh=XIFa2+jGNyYLyO7S66LFWMQ1xBZtqieffgcYyd0uElE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcxscM6+vV63BjDnEXoH2JUUorPiSVEvVPuXKBt5rM1+98oPTzRNFJkPLAhQXyH98D6v1K/gO04+3q20pAThPgdG0dR+Y4O97T8/sUXXbbINfZKLf4k+ZPBZmI5n6i4UJ/Zvc19Au9iJRss/2V3MdN0u3cSPHujEbtdBmb+9Xa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEksY1FW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC68C4CEF7;
	Wed, 18 Mar 2026 00:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773792589;
	bh=XIFa2+jGNyYLyO7S66LFWMQ1xBZtqieffgcYyd0uElE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEksY1FW9cfkv01umiF9+rHN00/lTuEvc1vo+iLzuyF8Bu3PkjE9zblDpWCCw7706
	 5qlxc0iQmKlsI49bFMppguFlX8VaVZXeClJGAgAdD/PnVSFifGcINwbId/EkE11Br/
	 JI+1AWgnqsLQzH35XtYMXLkIyuObnbv6cJ/Fa9yaNbodGllQ2kZOGJp54X09IqXWJg
	 OVKoXGynWlFke91cXHLEOFQdMT05H7U5tvPYWmDPGKE24hSYtETH0G3cVXa1Pn+QV6
	 nG9sAzts2M89ZjmCm5f74QWllhGhLGz1CZ99jJMFb6lRiHfjFlqDRNpugZkNo6NN7t
	 gwDnqem6JKmjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Simon Horman <simon.horman@corigine.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] ice: remove unused buffer copy code in ice_sq_send_cmd_retry()
Date: Tue, 17 Mar 2026 20:09:45 -0400
Message-ID: <20260318000947.379271-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031701-reapprove-dollar-1839@gregkh>
References: <2026031701-reapprove-dollar-1839@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226930-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,corigine.com:email,intel.com:email]
X-Rspamd-Queue-Id: 7CF552B4893
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit 43a630e37e259fee83ab3fd769c42e2fed97ca81 ]

The 'buf_cpy'-related code in ice_sq_send_cmd_retry() looks broken.
'buf' is nowhere copied into 'buf_cpy'.

The reason this does not cause problems is that all commands for which
'is_cmd_for_retry' is true go with a NULL buf.

Let's remove 'buf_cpy'. Add a WARN_ON in case the assumption no longer
holds in the future.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: 326256c0a72d ("ice: reintroduce retry mechanism for indirect AQ")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 419052ebc3ae7..55a08fa1bf348 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1595,7 +1595,6 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 {
 	struct ice_aq_desc desc_cpy;
 	bool is_cmd_for_retry;
-	u8 *buf_cpy = NULL;
 	u8 idx = 0;
 	u16 opcode;
 	int status;
@@ -1605,11 +1604,8 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	memset(&desc_cpy, 0, sizeof(desc_cpy));
 
 	if (is_cmd_for_retry) {
-		if (buf) {
-			buf_cpy = kzalloc(buf_size, GFP_KERNEL);
-			if (!buf_cpy)
-				return -ENOMEM;
-		}
+		/* All retryable cmds are direct, without buf. */
+		WARN_ON(buf);
 
 		memcpy(&desc_cpy, desc, sizeof(desc_cpy));
 	}
@@ -1621,17 +1617,12 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 		    hw->adminq.sq_last_status != ICE_AQ_RC_EBUSY)
 			break;
 
-		if (buf_cpy)
-			memcpy(buf, buf_cpy, buf_size);
-
 		memcpy(desc, &desc_cpy, sizeof(desc_cpy));
 
 		mdelay(ICE_SQ_SEND_DELAY_TIME_MS);
 
 	} while (++idx < ICE_SQ_SEND_MAX_EXECUTE);
 
-	kfree(buf_cpy);
-
 	return status;
 }
 
-- 
2.51.0


