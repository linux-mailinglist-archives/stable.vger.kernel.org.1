Return-Path: <stable+bounces-248291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBv8Kc9NB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:46:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3034C553DED
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D36E93111389
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEC13F6C4A;
	Fri, 15 May 2026 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L0O2OL/B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53DC3B6354;
	Fri, 15 May 2026 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861358; cv=none; b=huq+eCXYw000XcePH16L2T9WVF7LudUVoH8wsTimxYFvBxX7zaUPgSp2/gBxq0NWz9F/2aLIXLbxM1Vyy6riNbh18U72lbMPj0UO6G9twHZxhv0h01GwXPEq5kLLRvUr4DQDOiIrqniakBOchjrAT5oc/qVPLHRzM0ITCD9qUdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861358; c=relaxed/simple;
	bh=11VYSdsHI5D6JRFhB4zosFkdIqMvGhUGPvG/gIvIOcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0jhTtk/xQvcWpbAmIW8vS4qgnJGGMmBtjsYb5dk3KDQtSNbruYXdre1lsaBW+QshgmlxKdvztlXK3BJRg0xyZzcCt8hd4Vp7ZVfJq4pg8KYC+KKDRtSVi7bysW9KHurDAGPoiv7y9i3DzxUJSnPNxUXeeDYwW8Ob1gcZQKgpxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L0O2OL/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B295C2BCB0;
	Fri, 15 May 2026 16:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861358;
	bh=11VYSdsHI5D6JRFhB4zosFkdIqMvGhUGPvG/gIvIOcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L0O2OL/B/Av+HrIGGobQFwzeNm3KHIubqqbS1OPSCRFdj8DjWBtPG4QRD5OQXgwFS
	 2zn8Yfzp9Y60ilVyrTA0tyveEXZOgOkT6DSurUIw69ZlpReewQ4DhZ2jO36U0z6lqG
	 DAHno3MYCS/kh92N+U3qZQMbFSZt//1DYOknZDQE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Koskovich <akoskovich@pm.me>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.6 299/474] media: i2c: ov8856: free control handler on error in ov8856_init_controls()
Date: Fri, 15 May 2026 17:46:48 +0200
Message-ID: <20260515154721.472787886@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 3034C553DED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248291-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,pm.me:email,intel.com:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Koskovich <akoskovich@pm.me>

commit f75e160745663ce9b13362ae6e90bd439c58df69 upstream.

The control handler wasn't freed if adding controls failed, add an error
exit label and convert the existing error return to use it.

Fixes: 879347f0c258 ("media: ov8856: Add support for OV8856 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ov8856.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -1954,12 +1954,18 @@ static int ov8856_init_controls(struct o
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



