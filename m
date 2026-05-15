Return-Path: <stable+bounces-248157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cILjLqVLB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:36:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDF455396D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBB3930DF4E9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868193E0099;
	Fri, 15 May 2026 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gP0L57Ff"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0553FF1AD;
	Fri, 15 May 2026 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861017; cv=none; b=t4dHE1wuLOyiUmudAUavSuIVgDSLG/UAgmiqzyuHWZGInJ5FodOwJx5n3LMDb1/JJaT+G4QRkPOARv93wUPCeKwGNtvyaUxldpACWP3sgWklSECSBheS4DsPKbd8UdD8LSOkPPp0MdiJzDk9nS4Xwgo6xrjci0f0it6TWYCPow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861017; c=relaxed/simple;
	bh=TYQht9LyPQpfs5skXqw5ma/6d4us4bO7EGLElXEg7Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ib9WWhHEL3sCVDhs0eDUvl48WRrrijWcuRqOBAKwjGwaTnjoHH6ml2OXHchmFWjrf/v1q8SbS1xlJ1xGJS7trMj7J2UVLFuLF1nhPI9lFnngftoMWle2LjMjniHLGk00SsgHfc6iEBPQqC0xLzVmUwctnRJBDN/sy0cllDMYFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gP0L57Ff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DABC2BCB3;
	Fri, 15 May 2026 16:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861017;
	bh=TYQht9LyPQpfs5skXqw5ma/6d4us4bO7EGLElXEg7Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gP0L57Ff1jS6sdhg1p3HV4iSacyPK1xVyaGKNHEZcJ353j4NB/a9L6S4WvRx9N0Nw
	 KYN/FT2DA5kIdNebigvhij7TaM5YLHes56ANR4uY7ostl073xohgX3orHrbOLypOnq
	 uMfSnxIYI7Uyf0+S211+1CbNNtjHxGBmHFd7FluA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Jiang <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wenshan Lan <jetlan9@163.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 168/474] dmaengine: idxd: Fix crash when the event log is disabled
Date: Fri, 15 May 2026 17:44:37 +0200
Message-ID: <20260515154718.659215544@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 8DDF455396D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,intel.com,kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-248157-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit 52d2edea0d63c935e82631e4b9e4a94eccf97b5b ]

If reporting errors to the event log is not supported by the hardware,
and an error that causes Function Level Reset (FLR) is received, the
driver will try to restore the event log even if it was not allocated.

Also, only try to free the event log if it was properly allocated.

Fixes: 6078a315aec1 ("dmaengine: idxd: Add idxd_device_config_save() and idxd_device_config_restore() helpers")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Link: https://patch.msgid.link/20260121-idxd-fix-flr-on-kernel-queues-v3-v3-2-7ed70658a9d1@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[ Only the idxd_device_evl_free() NULL check portion was backported in v6.6.
idxd_device_config_restore() does not exist in v6.6. It was introduced
in 6.14. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 44bbeb3acd14e..e769e1f0d28b2 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -810,6 +810,9 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 	struct idxd_evl *evl = idxd->evl;
 
+	if (!evl)
+		return;
+
 	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
 	if (!gencfg.evl_en)
 		return;
-- 
2.53.0




