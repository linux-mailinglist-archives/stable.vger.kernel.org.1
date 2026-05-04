Return-Path: <stable+bounces-243356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEajETKp+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E077C4BEC3E
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6952300AB0E
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7EC3DEAD6;
	Mon,  4 May 2026 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wjCUtoVG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820CC3DE43E;
	Mon,  4 May 2026 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903675; cv=none; b=aiOi9XJRnhPS9nETzCvL1tZ7YTYG0PsFtq0+3T2jtRa4/g9t0TTa+xwZGvor0uwu7B3wqgLeLEtVfCrJH4DLgLkPXf34dFJ/g31Qd9WdBeX7UVAmngrysXjHR8EzL42k+zVfoNbW1KWxObjT8cz3XvtcFMrx0om/YnP7dQr9oSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903675; c=relaxed/simple;
	bh=GtkaY5LbgJ7N8RB5C3HWjDo23iwaslqKa6G979RYRGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLcH+9RfhNB4hVybWNixXXogSKmzkTZYzzc7nJ5V14obO/NhS8JNHTxI/5wNnIlISJE7VCh0JqDfUsKiON6EqcGmnpbrCz4Dh0AQPhLvLhmxpkBDsQgPow5Z+TfBLev98frJ/XpXXJijiIZVoTB05d/UXYXQqlBf/JcsmArUuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wjCUtoVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C64C2BCC4;
	Mon,  4 May 2026 14:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903675;
	bh=GtkaY5LbgJ7N8RB5C3HWjDo23iwaslqKa6G979RYRGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wjCUtoVGju9MGB1Agu/YPvLyTTECfoNSH7ostv5GM6ERVdItrD4+WD0FxCPGaQJio
	 90wG8kysY4Z/2hvoI0ILpvcjxaeC2A5At43EcYwH/wHltUQjrPuEtuiL3HkHJP+6Wo
	 C5qxDhKP9vs3+FKTxmGQ7B1vXjYjoGLbGXCJwOPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Chen <peter.chen@kernel.org>,
	Jun Li <jun.li@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 6.18 005/275] usb: chipidea: otg: not wait vbus drop if use role_switch
Date: Mon,  4 May 2026 15:49:05 +0200
Message-ID: <20260504135143.136831217@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: E077C4BEC3E
X-Rspamd-Action: no action
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243356-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yang <xu.yang_2@nxp.com>

commit a4e99587102a83ee911c670752fbca694c7e557f upstream.

The usb role switch will update ID and VBUS states at the same time, and
vbus will not drop when execute data role swap in Type-C usecase. So lets
not wait vbus drop in usb role switch case too.

Fixes: e1b5d2bed67c ("usb: chipidea: core: handle usb role switch in a common way")
Cc: stable@vger.kernel.org
Acked-by: Peter Chen <peter.chen@kernel.org>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://patch.msgid.link/20260402071457.2516021-3-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/chipidea/otg.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -187,8 +187,8 @@ void ci_handle_id_switch(struct ci_hdrc
 
 		ci_role_stop(ci);
 
-		if (role == CI_ROLE_GADGET &&
-				IS_ERR(ci->platdata->vbus_extcon.edev))
+		if (role == CI_ROLE_GADGET && !ci->role_switch &&
+		    IS_ERR(ci->platdata->vbus_extcon.edev))
 			/*
 			 * Wait vbus lower than OTGSC_BSV before connecting
 			 * to host. If connecting status is from an external



