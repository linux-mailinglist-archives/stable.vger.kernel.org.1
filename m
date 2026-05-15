Return-Path: <stable+bounces-248011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FafFbNFB2qgvwIAu9opvQ
	(envelope-from <stable+bounces-248011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:11:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC32D552CC0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39FF53076D7F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4BB34D911;
	Fri, 15 May 2026 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xnuogeu2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD853FF1BE;
	Fri, 15 May 2026 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860639; cv=none; b=HO+6rIKMvj64puS0YVar0wo4rXbkmkG29uljGgtFBwHKBz7BcBl/k9opvgcXfYa2kBSpEuieVPd9Xc2rHdfFZcRBKsrGCoxmIIMCN6EcngetW3DqJRNTDG077Y2Rozs/UF7g7h5CbQBUJkMGjyxLxJHXd8QWMuRrsSVqMewshDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860639; c=relaxed/simple;
	bh=SpReF6MLl76F4wJXUOVwUh0SICkF9VtE8dT/cjwrpVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckGXV/7DEP1j3JI2jdPrjtbW+n30t4J/hWciKy1UJoBVWfCogum9/bCXsBp712vYTGFq2Om6iHulqwqi56oQbINjFG8r805IwubAxQURLP6iJRL/V6Kqv/gWAAhGIwFiKehQYmbsj4Nk1EWzfPP/MEIqGziVvP9fiowmUIbECnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xnuogeu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E90C2BCB0;
	Fri, 15 May 2026 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860639;
	bh=SpReF6MLl76F4wJXUOVwUh0SICkF9VtE8dT/cjwrpVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xnuogeu2KK7VkoYnxGpt0bE3Dme8OSFexBPJ0irQf031fskEqXfNc55VCWWkfYLu/
	 C+cHVuraMYYb4eYHoZvK9s5OzDVPm/oIFVyBKxetILnfjqrHuyeyS+Ki3zRiytUUrf
	 /0XUfWl4fySsOE2uuS3lMi3iib0Zjro6226C2qV4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Chen <peter.chen@kernel.org>,
	Jun Li <jun.li@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 6.6 005/474] usb: chipidea: otg: not wait vbus drop if use role_switch
Date: Fri, 15 May 2026 17:41:54 +0200
Message-ID: <20260515154715.171690334@linuxfoundation.org>
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
X-Rspamd-Queue-Id: DC32D552CC0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248011-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nxp.com:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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



