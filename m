Return-Path: <stable+bounces-246415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJbWBG1sA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:07:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A711F526D19
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C62AD3058D47
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5CC364959;
	Tue, 12 May 2026 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="klvcbjE0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316143EDE61;
	Tue, 12 May 2026 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609167; cv=none; b=BSDmfv0YS4bhnoPUek+XxbS+jG2LH47+rmcPYI4vzHVSbAnTCVYbUWJ6XfB30G4+nlCan6aWNsb9Ku+TxR/pddzxWI8VgsXDejTfy03f21FffY+AvCLBumDxE87WtOzS2DpQoRyfVHyYAXbj9Z+DmAfWn25JV1o2v8VWzZeqQ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609167; c=relaxed/simple;
	bh=SO9o8OftRVVqTJWM5/j4AjsDwaMZHhToYJ6x4Uw3onQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYRCWrx3cGpSDIx3pBwkKMKo60p7oqnEnqPBumvYPvLrmL79VZmcJzeSgStcZFrMGsBa2IGvzubhxPAqd+xQURzwGcma8IBjsYBOxtDUmlfGsx87Lg7S6n13t9aXoWS3KLGGocS32HoXGnGPc1z8WCWzwtCHi3LnKWS+951HumQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=klvcbjE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD47CC2BCB0;
	Tue, 12 May 2026 18:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609167;
	bh=SO9o8OftRVVqTJWM5/j4AjsDwaMZHhToYJ6x4Uw3onQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=klvcbjE0JpIaHyKnB1EDeWqzwVQfEs7H5frH0je9fT9Iy7eyH3NDO1llIAcnl6H97
	 dOM468Xoq0e4XL+sm+ZLuowAlv6wfE6HqX0RYefF/IopuDoRGKLYegSkUM0WML7HOY
	 d7rdfsTIc/YLdyr1NS7RuIRCTpstU0EEWm/2cvDc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martyn Welch <martyn@welchs.me.uk>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 7.0 091/307] staging: vme_user: fix root device leak on init failure
Date: Tue, 12 May 2026 19:38:06 +0200
Message-ID: <20260512173942.049423038@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: A711F526D19
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
	TAGGED_FROM(0.00)[bounces-246415-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,welchs.me.uk:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 32c91e8ee039777d0b95b914633fc6a42607959c upstream.

Make sure to deregister and free the root device in case module
initialisation fails.

Fixes: 658bcdae9c67 ("vme: Adding Fake VME driver")
Cc: stable@vger.kernel.org	# 4.9
Cc: Martyn Welch <martyn@welchs.me.uk>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260424104910.2619349-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/vme_user/vme_fake.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1230,6 +1230,8 @@ err_master:
 err_driver:
 	kfree(fake_bridge);
 err_struct:
+	root_device_unregister(vme_root);
+
 	return retval;
 }
 



