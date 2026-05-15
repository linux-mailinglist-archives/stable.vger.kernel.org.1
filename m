Return-Path: <stable+bounces-247338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAU2O2quBmrImgIAu9opvQ
	(envelope-from <stable+bounces-247338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:26:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B7054983F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1DBA303DACB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B18322B7D;
	Fri, 15 May 2026 05:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NdlDXae6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E952A3033FC
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778822760; cv=none; b=it9KrhyYYHBpghwQsNsQfdnn2JwQI0OocbT4fiLxcTCx8VcTetOW7cXLmUHMGDur5VZfHEwwhaiAJZEexfko3d+H786n4UUORs/4XD0i3DpViW8KRPnMSzphv0urGt3IyBwCw/agv8cOCzjSOtOUNGbZFMkhPP6ZlvBPxYn46vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778822760; c=relaxed/simple;
	bh=BAQuTF64M33yX0kTW0Jh2pTO/cw0MYmhcNa+SApM1Tk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iCESPGfyQyukLElpsxjYpoQKIyCUFMPkxDk4gG72CkQi6BqTD0aD/pqJo0DZLDl7qTBRuwpuLf4C9jmKy4/f8VQq+LwIkXlbJn6ybnivKGIun1ldOGYrs/x8r7JKU4z7ll7JkRE2W7KFPmVi0Q48mNToLUCWdc8M5eReFTZzU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NdlDXae6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5AFC2BCB0;
	Fri, 15 May 2026 05:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778822759;
	bh=BAQuTF64M33yX0kTW0Jh2pTO/cw0MYmhcNa+SApM1Tk=;
	h=Subject:To:Cc:From:Date:From;
	b=NdlDXae6GMPdiXnEuFAb6uXJD0WDJ22SCkPkNg9qHnESYAtyhG2QLuheYElwPNhG/
	 NFinoVhM2DmlrZOCAgMzWDbpk+QjfwFXnAK/OLPlzXuD/LYVpdM0HMcPKbbw9PNbNo
	 YKJroGGY2lp4d+XQyUijSZRERuSKWWQ2PcWC32IU=
Subject: FAILED: patch "[PATCH] media: i2c: ov8856: free control handler on error in" failed to apply to 5.10-stable tree
To: akoskovich@pm.me,hverkuil+cisco@kernel.org,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:26:03 +0200
Message-ID: <2026051503-polish-carwash-55e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 51B7054983F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247338-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,pm.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f75e160745663ce9b13362ae6e90bd439c58df69
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051503-polish-carwash-55e9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f75e160745663ce9b13362ae6e90bd439c58df69 Mon Sep 17 00:00:00 2001
From: Alexander Koskovich <akoskovich@pm.me>
Date: Thu, 12 Mar 2026 17:16:20 +0000
Subject: [PATCH] media: i2c: ov8856: free control handler on error in
 ov8856_init_controls()

The control handler wasn't freed if adding controls failed, add an error
exit label and convert the existing error return to use it.

Fixes: 879347f0c258 ("media: ov8856: Add support for OV8856 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index e2998cfa0d18..dd01e1d515ff 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -1951,12 +1951,18 @@ static int ov8856_init_controls(struct ov8856 *ov8856)
 			  V4L2_CID_HFLIP, 0, 1, 1, 0);
 	v4l2_ctrl_new_std(ctrl_hdlr, &ov8856_ctrl_ops,
 			  V4L2_CID_VFLIP, 0, 1, 1, 0);
-	if (ctrl_hdlr->error)
-		return ctrl_hdlr->error;
+	if (ctrl_hdlr->error) {
+		ret = ctrl_hdlr->error;
+		goto err_ctrl_handler_free;
+	}
 
 	ov8856->sd.ctrl_handler = ctrl_hdlr;
 
 	return 0;
+
+err_ctrl_handler_free:
+	v4l2_ctrl_handler_free(ctrl_hdlr);
+	return ret;
 }
 
 static void ov8856_update_pad_format(struct ov8856 *ov8856,


