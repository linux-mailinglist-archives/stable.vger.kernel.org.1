Return-Path: <stable+bounces-258738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFVCEZ8rG2ow/wgAu9opvQ
	(envelope-from <stable+bounces-258738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:25:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDCD611B1C
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BB4E3072821
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0B425B0B3;
	Sat, 30 May 2026 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uuahXpS4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ED6219303;
	Sat, 30 May 2026 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165371; cv=none; b=aEFXlAlzhKeDq06u+vDZs0LthcKbo8EOoOeqvNSp5OQhYJ5P/8qyuXTprS4v5YMjrtJYvgO3g1iLRAlUI5YFmwDYEWw+NDHns5fCKkYDKEC+TqXaMQrTZak56IpxvaVKGtIGJZk0FAwQmEII5IwGv4Pde4VUZSkxVcEJmPq8Lww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165371; c=relaxed/simple;
	bh=lLq74fo+f5yiHeEczv2joNCOyTulueAAh1qThQpHsv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZszlPQvb78rZLTeBKmgvzqxd5vwcmJo4H0B+naHcaMTNsAwQSJZ4ne8Pwaj1dvKGFY2r7GVc4CJcpPWISTo126y6RtMYMr4XbZ2DpigoYtRM7NVRPACEry7acMsw0bgprRnvCJf7O1KN/3Gy6GZHu600PyL/vLWqSU6Xfc+e0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uuahXpS4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1BE1F00893;
	Sat, 30 May 2026 18:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165370;
	bh=MGHthj33QWYO/Ed0j/htjXUZ0dCNheiCHf/4Wj0Gsg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uuahXpS4c/6iIEiJLZUYL0j+m+V8C8na8meUmUUjw6lKkyV1slIr2rJAGscPgR5o3
	 dqFqF0pxgiqHdxT2z9v47bOT7Mp/kzmUGC8sJg6nMumBNN0u93f9zcmzMqrw1Xbs6k
	 hd+hiZ/49ikwkRWruXZJX5Ur3h/eh5WvHgBja/Sk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bernie Thompson <bernie@plugable.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 5.10 058/589] fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
Date: Sat, 30 May 2026 17:58:59 +0200
Message-ID: <20260530160226.120538464@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258738-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,plugable.com,gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,gmx.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DCDCD611B1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit a31e4518bec70333a0a98f2946a12b53b45fe5b9 upstream.

Much like commit 19f953e74356 ("fbdev: fb_pm2fb: Avoid potential divide
by zero error"), we also need to prevent that same crash from happening
in the udlfb driver as it uses pixclock directly when dividing, which
will crash.

Cc: Bernie Thompson <bernie@plugable.com>
Cc: Helge Deller <deller@gmx.de>
Fixes: 59277b679f8b ("Staging: udlfb: add dynamic modeset support")
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/udlfb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1077,6 +1077,9 @@ static int dlfb_ops_check_var(struct fb_
 	struct fb_videomode mode;
 	struct dlfb_data *dlfb = info->par;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	/* set device-specific elements of var unrelated to mode */
 	dlfb_var_color_format(var);
 



