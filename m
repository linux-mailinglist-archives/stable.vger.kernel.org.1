Return-Path: <stable+bounces-247682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDXAIn0JB2r5qwIAu9opvQ
	(envelope-from <stable+bounces-247682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:54:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E8154ED9A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCCE530C0A18
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FB7466B66;
	Fri, 15 May 2026 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDzipM06"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68328399013
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845522; cv=none; b=VGcoSJtf+KipqvV1TPTp52M/sZvzW2Tm/zYNIrH8clvE1GRVOKMjBCA11CxG3IQNpp3Nlg7d6FLSGm7dmbRlfjBUzH06RHfXN7dyTfaYZla5fhi10pQmgBcMfxAtOCvxGXRwfSghonKRgoipUGTcE0ACXuwhHEkZhGCNmj3W9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845522; c=relaxed/simple;
	bh=E1Q97Ovnph5ZvEPJtFqMTSoFv4RektaI0JFakHaDqCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmPepNTXPFlYzrrRDlNvZ89+ny7o0RRw6BZk9zqiAJm4dVTxpz7v4HqSmdL7plSwqHtMMPY2Xlwx6gt9pGA+10R/CsOZcrZOsrFuFmpPpe664sEqUl3bqzZ6yvldv8oyiWjsM5omfED4MhMJ6OIHX+nklO1aD4J1GDCjNhD3II0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDzipM06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5DDC2BCB0;
	Fri, 15 May 2026 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778845522;
	bh=E1Q97Ovnph5ZvEPJtFqMTSoFv4RektaI0JFakHaDqCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDzipM06+mPlevD8xfnJMmaG8+JmAOnxZBeN6Vi0fVwLSpG/LMF8HFImKtQM0HuRD
	 RHbTkC3C6ORg9rcFjL8hac5pureSRx/tjrNa/y4ircZuEd1HsiccUw7G5pITF5cqVK
	 IZqN6DB3OvvUazxhLzNoYHxKBdSDu61VYLnYeMQ7VOWlrCxvUDwPnHu+QXQhGbwIdu
	 FQxSsjh/dzXwJENDFq5sKPUsQYHPFPzMXtF2df1fwutviQk3CASL0ELh4EJf5lWktN
	 mDXKvVLbylCgqT/z+cCfAUOAYolE7+vlNqSJoiu1oGb6GUZmBTFaPhbIcSL5LWMTxf
	 VEd7Iykqx8Jww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fbcon: Avoid OOB font access if console rotation fails
Date: Fri, 15 May 2026 07:45:20 -0400
Message-ID: <20260515114520.3021992-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051242-filling-volatile-696b@gregkh>
References: <2026051242-filling-volatile-696b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 26E8154ED9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.de,gmx.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247682-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit e4ef723d8975a2694cc90733a6b888a5e2841842 ]

Clear the font buffer if the reallocation during console rotation fails
in fbcon_rotate_font(). The putcs implementations for the rotated buffer
will return early in this case. See [1] for an example.

Currently, fbcon_rotate_font() keeps the old buffer, which is too small
for the rotated font. Printing to the rotated console with a high-enough
character code will overflow the font buffer.

v2:
- fix typos in commit message

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org # v2.6.15+
Link: https://elixir.bootlin.com/linux/v6.19/source/drivers/video/fbdev/core/fbcon_ccw.c#L144 # [1]
Signed-off-by: Helge Deller <deller@gmx.de>
[ renamed `par` to `ops` to match the 6.12 local pointer name ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon_rotate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index ec3c883400f7b..4a06e71ae4434 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -46,6 +46,10 @@ static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 		info->fbops->fb_sync(info);
 
 	if (ops->fd_size < d_cellsize * len) {
+		kfree(ops->fontbuffer);
+		ops->fontbuffer = NULL;
+		ops->fd_size = 0;
+
 		dst = kmalloc_array(len, d_cellsize, GFP_KERNEL);
 
 		if (dst == NULL) {
@@ -54,7 +58,6 @@ static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 		}
 
 		ops->fd_size = d_cellsize * len;
-		kfree(ops->fontbuffer);
 		ops->fontbuffer = dst;
 	}
 
-- 
2.53.0


