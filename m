Return-Path: <stable+bounces-258191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NzPB94lG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-258191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:01:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9445E610D06
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C8B430BF94F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD13B8920;
	Sat, 30 May 2026 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qIPAvoeC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2ED342CA7;
	Sat, 30 May 2026 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163519; cv=none; b=GWVOry/HekQtYJ+ePhLv0uWAxKhbSK+nf57L90P8cuvQauauzyHJK3xKvdzO5WkBoZwPf3f6cJjG8E1sqL+Mq9TPu77Eg+6GTPa405vUtP2RbEJOWf8CDec+otjmOXRA02aCsi9+BtDTj2+X8QtFrx9sOVNBDGcSrH5vhBwzaXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163519; c=relaxed/simple;
	bh=slnpEI9J4MIZMGFQH6jKi3Q63WQTGZzOeTfkRb+ekPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8ObDo37TE2K4BttAbFDCHUBF9Binq8AKpwnXT4CnzQs/rUEPU3IgK/WkQmcJpMf/9w9Qp0oMSRSAJNXggThk2GeE6yLfqx8lqMf45z2Q5wl4YipVysXHdWRJIM2PSa+euv/cY+bgZ6xOKlmLgfaSh7yeDjPYQ1zcoNRYaZusHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qIPAvoeC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625721F00893;
	Sat, 30 May 2026 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163518;
	bh=Cj1B6bYF4tw9XRg0RvG7+40486V6q1saGmzfyL6UjfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qIPAvoeCAW2U8ITXRYA25OjTU05W/ykDmZXkYeH3zXZ8vj9JHVcaijJklHEkjqRzr
	 7gE/aWvo7POYZwmeJNb+s70GsUzccPpIrqyP9z5/awRMEwvcApRW56ENMVOvtcROL7
	 +GoZteGVHhT/EY9eUhhwc0/+Y5AfIK/Uro4c2nuo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 282/776] um: virt-pci: Fix build failure
Date: Sat, 30 May 2026 17:59:56 +0200
Message-ID: <20260530160247.845443520@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258191-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9445E610D06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <florian.fainelli@broadcom.com>

Commit a27e95a6ff3f ("um: virt-pci: properly remove PCI device from
bus") assumed that virtio_reset_device() is present in the 5.15.y kernel
but it is not and so backport would now cause a build failure.

Fixes: a27e95a6ff3f ("um: virt-pci: properly remove PCI device from bus")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/virt-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index d762d726b66cf..0666c9e0998d1 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -641,7 +641,7 @@ static void um_pci_virtio_remove(struct virtio_device *vdev)
 	}
 
 	/* Stop all virtqueues */
-	virtio_reset_device(vdev);
+	vdev->config->reset(vdev);
 	dev->cmd_vq = NULL;
 	dev->irq_vq = NULL;
 	vdev->config->del_vqs(vdev);
-- 
2.53.0




