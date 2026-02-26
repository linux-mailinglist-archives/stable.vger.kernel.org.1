Return-Path: <stable+bounces-219829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP6AAXpsoGk3jgQAu9opvQ
	(envelope-from <stable+bounces-219829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:53:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 735641A927B
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8709F31E510E
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C03A40F8E9;
	Thu, 26 Feb 2026 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="pifSszUl"
X-Original-To: stable@vger.kernel.org
Received: from forward202a.mail.yandex.net (forward202a.mail.yandex.net [178.154.239.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2540F8E7;
	Thu, 26 Feb 2026 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120316; cv=none; b=rGO7tR9XDHHdHdLwFAI3qe6602s5fz/TMXr7N3rltgUDgGfgubQ+pZl/0TViLX8gDi9MpnYE3B5igNZOb0EeH3HZqL3Gu2/iGteQHBeZ7Uk15PUTTu1dQ+sGCvLv9Txuk38Z7Cid9irXcWziMX2GlnQsY4FU6wnmI6C87f6gDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120316; c=relaxed/simple;
	bh=Jc1KCw4PS7kSTbxiHStSFaR3kFALt652H8w/cv7GtBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PuWyWz6EOG10/D3ur2wjr9JRNwd9akw9sdtdytF365aYbNpjoid7FfjZD2v4LwrKsR84aiTyomLgcDRQzEnGB7yhkukZeIsvIhCNPGBA+O3h+fdkNBn2jK50Ca+TDOHDKisMwbk/lc6F/BiZJPNoAjexL/h15Scz7rEo6947QzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=pifSszUl; arc=none smtp.client-ip=178.154.239.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward202a.mail.yandex.net (Yandex) with ESMTPS id E6A57851EA;
	Thu, 26 Feb 2026 18:31:37 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1ba7:0:640:dccd:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 9729980D13;
	Thu, 26 Feb 2026 18:31:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8Vkqhh1GMGk0-wRfDlrsE;
	Thu, 26 Feb 2026 18:31:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1772119888; bh=9u+hw7P1kZrxGYw4H4TMvbi/ck0cvcuM+YKL6lqFTQo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=pifSszUlb2N/rZIVP+qPjlC1mTVLnGQ+aRmMCUd0EMVWv+lDjZEr8EPNi6shDDHhn
	 AVTXYtpAvv1hL7QnGdCeD62wWo9sPP9ztWQFT2kYkBa5nUH7tWc/THp1QataVcsfs+
	 BBuIH0Csbof6gtSyHXiCymRbThXXJaK7riUut3FY=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	lingshan.zhu@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] vdpa/ifcvf: handle dev_set_name() failure in ifcvf_vdpa_dev_add()
Date: Thu, 26 Feb 2026 18:29:23 +0300
Message-ID: <20260226152924.38790-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[yandex.ru,kernel.org,redhat.com,linux.alibaba.com,lists.linux.dev,vger.kernel.org,linuxtesting.org];
	TAGGED_FROM(0.00)[bounces-219829-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[yandex.ru:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 735641A927B
X-Rspamd-Action: no action

dev_set_name() may fail and return an error, but its return value
is currently ignored and overwritten by _vdpa_register_device().

Abort device creation if dev_set_name() fails and release the
device reference to avoid continuing with an improperly initialized
struct device.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index d46c1606c97a..ab6d6ab3b3d8 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -734,15 +734,22 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		ret = dev_set_name(&vdpa_dev->dev, "%s", name);
 	else
 		ret = dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev->index);
+	if (ret) {
+		IFCVF_ERR(pdev, "Failed to set device name");
+		goto err;
+	}
 
 	ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring);
 	if (ret) {
-		put_device(&adapter->vdpa.dev);
 		IFCVF_ERR(pdev, "Failed to register to vDPA bus");
-		return ret;
+		goto err;
 	}
 
 	return 0;
+
+err:
+	put_device(&adapter->vdpa.dev);
+	return ret;
 }
 
 static void ifcvf_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
-- 
2.43.0


