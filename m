Return-Path: <stable+bounces-226932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PtRE2XtuWnFPgIAu9opvQ
	(envelope-from <stable+bounces-226932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:10:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D722B489A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFB8C3046D8C
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A5122301;
	Wed, 18 Mar 2026 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOtLwndK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4D11C6B4
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792592; cv=none; b=G8bHxJczdS1yWcOviYMtHFVRYQQXiFlo5px641J6lw+PVjhJ3tC4HVWGGIKEHcNP9uflxg3IspXlim2vm/m0QXyLgVh6ixWxaMCldPTc9NnZobl4R+b1NKhooJTbeBefRGTvtr6HqK9U811fkk+sKx3UfRFCr81bYNgwEGCPPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792592; c=relaxed/simple;
	bh=3YkKkSHO6+IBcUoy7gY7umNAPNeI89Zk06SADk+z24M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHCQx5KvVvhykfAPtIOkgEJ3NF58xXW9MMjVzSe8O83UShdENvjL/LBCmVswkychJ4VUknSjUTmLN8+/ilMlRiP8PV5M4GmcC1JLFhVBINOMPBzcfKjjNdvlr/hZZAXS+9oP5rjW8/9bUY5rLlHj2PgHjl1VLM2q1ql0tBORZnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOtLwndK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29A8C2BC9E;
	Wed, 18 Mar 2026 00:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773792591;
	bh=3YkKkSHO6+IBcUoy7gY7umNAPNeI89Zk06SADk+z24M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vOtLwndKCvZHJQeDqqz/Mz1fit79E05Dh8CjlL1Ny76QiyVX9o/uY5tNU3j9kNoGO
	 nxBloqSl43P5+h+YZLvif+G0qQUhEYaaYyxLcTzvTot6cEQy36tLWVqrI1zPJMfdcs
	 fPrwN/36vhjxf1/hvj9GGq89kL+rfMWJysgNA0Nh4LXg0sVEdehdaI+04HO2APDkay
	 q5GLOuPeG+ym7HSvGAi9RQ1T/BhY1mJx6orP0WAQ7zf7rj9T1N/qrtoKMWXbxP85Hu
	 hnL1ob0aplO07b5sNE1oD03mMp/UanrKZhnjDhN9XrMLyhnF3SjyQaddKbZZRRJsfC
	 FsBV0HXiGs2hg==
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
Subject: [PATCH 6.1.y 3/3] ice: reintroduce retry mechanism for indirect AQ
Date: Tue, 17 Mar 2026 20:09:47 -0400
Message-ID: <20260318000947.379271-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318000947.379271-1-sashal@kernel.org>
References: <2026031701-reapprove-dollar-1839@gregkh>
 <20260318000947.379271-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226932-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mpg.de:email]
X-Rspamd-Queue-Id: C0D722B489A
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 780c847cd1ffb..7bce89ba0a6fc 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1595,6 +1595,7 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 {
 	struct ice_aq_desc desc_cpy;
 	bool is_cmd_for_retry;
+	u8 *buf_cpy = NULL;
 	u8 idx = 0;
 	u16 opcode;
 	int status;
@@ -1604,8 +1605,11 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	memset(&desc_cpy, 0, sizeof(desc_cpy));
 
 	if (is_cmd_for_retry) {
-		/* All retryable cmds are direct, without buf. */
-		WARN_ON(buf);
+		if (buf) {
+			buf_cpy = kmemdup(buf, buf_size, GFP_KERNEL);
+			if (!buf_cpy)
+				return -ENOMEM;
+		}
 
 		memcpy(&desc_cpy, desc, sizeof(desc_cpy));
 	}
@@ -1617,12 +1621,14 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 		    hw->adminq.sq_last_status != ICE_AQ_RC_EBUSY)
 			break;
 
+		if (buf_cpy)
+			memcpy(buf, buf_cpy, buf_size);
 		memcpy(desc, &desc_cpy, sizeof(desc_cpy));
-
 		msleep(ICE_SQ_SEND_DELAY_TIME_MS);
 
 	} while (++idx < ICE_SQ_SEND_MAX_EXECUTE);
 
+	kfree(buf_cpy);
 	return status;
 }
 
-- 
2.51.0


