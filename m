Return-Path: <stable+bounces-257584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK08FYYdG2qW/QgAu9opvQ
	(envelope-from <stable+bounces-257584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:25:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D852F60F9A3
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7E1E30DD283
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712CB30E847;
	Sat, 30 May 2026 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NbfdW3cw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68A3242D7;
	Sat, 30 May 2026 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161489; cv=none; b=UcrEYN8QP5jYU/W05b5G833ssHMPT6BmHd2JlQF7gD4OCZiQPkBNIrMTeU2DHoDOxEhu75jS1WrbRFCM6kVkWnmlmgIIRppbkgXjER/9gZ1VOicnx+Cb7sYTE3d63wyPYU0ZPNc2+3U2OwGnCMnXgNxHz5qG33MGypZiF4sn7sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161489; c=relaxed/simple;
	bh=r6UgYIcY4oQG3qAHaXp/4ehTYDvwtNhoXnihMYO8V5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVd6BWvFqdv1LkrgaIAFvu9evJbfMdXuB+SkY1Zo7wKxrWwSVO1lOPFDz6G4NyIOXUrIEE7KpueZa8pJwJdrb6J69LM/bwObmUx+mY+22bfZsKzKaA7WS326Qlts4ovRbEy8hrjkihfRIy0ZmZjXxeXoWn6HAVfzKLRcV13IBa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NbfdW3cw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20471F00893;
	Sat, 30 May 2026 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161488;
	bh=bwlIo3hNc2gj5YPwM7GEcLOa3tfmfOd/CXFs3UUclnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NbfdW3cwoZ0RkTB977BOicYBK4ZbujPmHynxlPU+ZPwd/Ivu1VwGMbcWDx4HCHCVY
	 6F0kKlsykN4WfoVwetWvSjb/6GVOXA+9jk2czprt+CxLD5TiaG1/o9VXN0cKskVLGU
	 lzJXuHN16wQv6+i6UDyHKDa8V45Qd3ZxhvPyLddg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 598/969] dmaengine: mxs-dma: Fix missing return value from of_dma_controller_register()
Date: Sat, 30 May 2026 18:02:02 +0200
Message-ID: <20260530160316.935432513@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257584-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D852F60F9A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit ab2bf6d4c0a0152907b18d25c1b118ea5ea779df ]

Propagate the return value of of_dma_controller_register() in probe()
instead of ignoring it.

Fixes: a580b8c5429a6 ("dmaengine: mxs-dma: add dma support for i.MX23/28")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260225-mxsdma-module-v3-2-8f798b13baa6@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/mxs-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index dc147cc2436e9..5d34440b9e127 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -827,6 +827,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(mxs_dma->dma_device.dev,
 			"failed to register controller\n");
+		return ret;
 	}
 
 	dev_info(mxs_dma->dma_device.dev, "initialized\n");
-- 
2.53.0




