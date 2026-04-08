Return-Path: <stable+bounces-234874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DtrOf+i1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:48:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AD83C1998
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D5E53041492
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FAA3822A3;
	Wed,  8 Apr 2026 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="be6ODjaR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB4033121F;
	Wed,  8 Apr 2026 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673986; cv=none; b=WGPUMZvwcr6LbJlAwuBl6daPHuSEWFL+hr9xMekCLdJ4Z24oNv0hRhRu3ihJd7XUt8mXQBJMZYcVGkc24gnljgWzS/7nCw1Uq6DIsfhWx6BQNaHpadXa3N00bmV9AfVIlh+5qbQ9ZAqP0dl/ZO2kI4CElY4fzrwl2UJjwplitRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673986; c=relaxed/simple;
	bh=ImiOu7plNoN7e1M+Z9rUoIXZ8Ce16SVswk82XVTbaEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUQ3kJdq7qGu2lSNmJytbvIv5uVamu3iQ89JgkL1Ch0CEWWiM2F6wX3ihPjXsjhUjKbfy41R6fOLkqDVbBFOY7WFmufLStD/YfpJlhw6vA/rmnzHrdbwA2NBgPcI9gEAtGEpbhqPhKO0HEm2ssXK9fx0cQXlQuXeueHQDOpca0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=be6ODjaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D30C19425;
	Wed,  8 Apr 2026 18:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673986;
	bh=ImiOu7plNoN7e1M+Z9rUoIXZ8Ce16SVswk82XVTbaEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=be6ODjaRSHh8HIX3FD/Nim+IE9souxtDGRxLU3JHpazT67Z6UW/b8/RWLiuwCtIzN
	 kVSYN0iaT3JUO6qETi4pehA+dAGhJpKnzj7s6Ky73auV4si9kYJNXoJvMbm3oOYdu5
	 Poyanit/m2yTpOU+juEcybVTGj18SFL1RlDEPytU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Yongchao Wu <yongchao.wu@autochips.com>,
	Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 6.12 165/242] usb: cdns3: gadget: fix NULL pointer dereference in ep_queue
Date: Wed,  8 Apr 2026 20:03:25 +0200
Message-ID: <20260408175933.264440910@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234874-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[autochips.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84AD83C1998
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yongchao Wu <yongchao.wu@autochips.com>

commit 7f6f127b9bc34bed35f56faf7ecb1561d6b39000 upstream.

When the gadget endpoint is disabled or not yet configured, the ep->desc
pointer can be NULL. This leads to a NULL pointer dereference when
__cdns3_gadget_ep_queue() is called, causing a kernel crash.

Add a check to return -ESHUTDOWN if ep->desc is NULL, which is the
standard return code for unconfigured endpoints.

This prevents potential crashes when ep_queue is called on endpoints
that are not ready.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Yongchao Wu <yongchao.wu@autochips.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://patch.msgid.link/20260331000407.613298-1-yongchao.wu@autochips.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/cdns3-gadget.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2589,6 +2589,9 @@ static int __cdns3_gadget_ep_queue(struc
 	struct cdns3_request *priv_req;
 	int ret = 0;
 
+	if (!ep->desc)
+		return -ESHUTDOWN;
+
 	request->actual = 0;
 	request->status = -EINPROGRESS;
 	priv_req = to_cdns3_request(request);



