Return-Path: <stable+bounces-225846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E5OJW89uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:39:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7632A90B5
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBB47302DAAD
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD09435F5E9;
	Tue, 17 Mar 2026 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pfWDBXI+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F60A21B1BF
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747425; cv=none; b=Dpevl53wl1Y3+CyrAUumMKDkYxfNHBmtByFDXCNHfB0tQWrSZ+VZdjXg7ebYVwOh2JOgX0i7boR1a0HfvKYnuZ4wqjle7UDBw4KCAcUcbv4/aR8SKmrHUgfI8xAunOTPSwGQcNJPVHZg+92L5pdBeltoQ+ZipYWQBIKNjSOfjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747425; c=relaxed/simple;
	bh=8Idj1yZPbDdm6+ZCtQVsXtNJt/0dD0lze4LJJiKIf8A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jjFZuIdFDdU6MesHnsO8sUU9HuZyyDBrLOSznXtD0c3QqFK48hhqyKipQCKB/yIDVgZxLbs5blDa6NBWqJ5KErea6mQYHG56eDV23kYAFDfr3FAvxR2bAzPluJTD3suNr8Sxx7Q6hPbcF+3Ha1Z50YIfXXqgMs971KgSyFA9mLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pfWDBXI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10956C19425;
	Tue, 17 Mar 2026 11:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773747425;
	bh=8Idj1yZPbDdm6+ZCtQVsXtNJt/0dD0lze4LJJiKIf8A=;
	h=Subject:To:Cc:From:Date:From;
	b=pfWDBXI+AR4mqlW740EK5wf2sq+wNkDb5fupwM6vbHv73a4g6oihuDIA2YULrhmTh
	 mCfKU59MO4aU9zHboX3Jnduzg1OcpKoHGrxdDry7dmn8fvvPZnjnzj1/SvH/8UrT9i
	 O/0NkWz6xkYw9tFa1D3R4n4WmfTGY5ME5XUnZIV0=
Subject: FAILED: patch "[PATCH] ice: reintroduce retry mechanism for indirect AQ" failed to apply to 6.1-stable tree
To: jakub.staniszewski@linux.intel.com,aleksandr.loktionov@intel.com,anthony.l.nguyen@intel.com,dawid.osuchowski@linux.intel.com,mschmidt@redhat.com,pmenzel@molgen.mpg.de,przemyslaw.kitszel@intel.com,sx.rinitha@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 12:37:02 +0100
Message-ID: <2026031701-reapprove-dollar-1839@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225846-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,mpg.de:email]
X-Rspamd-Queue-Id: 3C7632A90B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 326256c0a72d4877cec1d4df85357da106233128
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031701-reapprove-dollar-1839@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 326256c0a72d4877cec1d4df85357da106233128 Mon Sep 17 00:00:00 2001
From: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
Date: Tue, 13 Jan 2026 20:38:16 +0100
Subject: [PATCH] ice: reintroduce retry mechanism for indirect AQ

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

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 74fe74225277..fd32c318d3f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1841,6 +1841,7 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 {
 	struct libie_aq_desc desc_cpy;
 	bool is_cmd_for_retry;
+	u8 *buf_cpy = NULL;
 	u8 idx = 0;
 	u16 opcode;
 	int status;
@@ -1850,8 +1851,11 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
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
@@ -1863,12 +1867,14 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 		    hw->adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
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
 


