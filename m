Return-Path: <stable+bounces-262681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M5lKG4yfKmp1twMAu9opvQ
	(envelope-from <stable+bounces-262681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 13:44:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAE46717EC
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 13:44:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262681-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262681-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA594325FAD2
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 11:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF35B3E9F96;
	Thu, 11 Jun 2026 11:44:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D193E8359;
	Thu, 11 Jun 2026 11:44:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178246; cv=none; b=pu5tvU/BdB6sf/nefkh09U4rfohUIw1CUgKG/bV5v+JCUvnRh4yZbRmakPeqao7JIGiR9rImSrMoWeisRtlx6iUZfbKbSOj1COf5C7vgvhvddqgRtL/E1PYs5mcZeNc4Pa1R+Hy09gAVTVByBA1UyKtBaWO0CcwaSrB34WDq45w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178246; c=relaxed/simple;
	bh=/YXxyHXTqHsqvEX56BgGHLdQeyr8pfFezDRaGSt+e4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BW10RuT3X8dN5wC+9EtkeFsM37GAaxUsfqt57FzYNp5yI0aERASW4HdBPh3FZJV330rywN8b6oMJO/qUVcXDKeEtS2Tpf/FVoE1WzEwPsixzX5/gp8pIN/Ovcyatq7wGTOz6wFangL0Sts6LUj66bvsohH2YASMMx7GNsRnY6gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-03 (Coremail) with SMTP id rQCowADH5dx2nypqC0heFA--.468S2;
	Thu, 11 Jun 2026 19:43:52 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: parthiban.veerasooran@microchip.com,
	christian.gromm@microchip.com,
	gregkh@linuxfoundation.org
Cc: hverkuil+cisco@kernel.org,
	laurent.pinchart+renesas@ideasonboard.com,
	s9430939@naver.com,
	error27@gmail.com,
	vulab@iscas.ac.cn,
	kees@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] staging: most: video: fix refcount leak in comp_probe_channel()
Date: Thu, 11 Jun 2026 19:43:35 +0800
Message-ID: <20260611114335.77216-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADH5dx2nypqC0heFA--.468S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWxAw4DKr1xAw4DXFyDGFg_yoW8GFW7pa
	y5Kay5tryYga1j9a9rWF1UXFyrCwnFy34fCFy0kw1S9ryfGFyfZr4vq34UKr4xX3yxAr4Y
	qa47Jw4rZa15ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwPA2oqhtFJ6wAAsy
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262681-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:christian.gromm@microchip.com,m:gregkh@linuxfoundation.org,m:hverkuil+cisco@kernel.org,m:laurent.pinchart+renesas@ideasonboard.com,m:s9430939@naver.com,m:error27@gmail.com,m:vulab@iscas.ac.cn,m:kees@kernel.org,m:linux-staging@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:hverkuil@kernel.org,m:laurent.pinchart@ideasonboard.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ideasonboard.com,naver.com,gmail.com,iscas.ac.cn,lists.linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,cisco,renesas];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAAE46717EC

If v4l2_device_register() fails in comp_probe_channel(), the
function frees the allocated mdev with kfree() without releasing the
reference count held by the embedded v4l2_device.  Because
v4l2_device_register() initializes a kref in the v4l2_device, the
reference count is already 1 on failure.  Dropping the last reference
must be done with v4l2_device_put() so that the release callback can
unregister the v4l2_device and free mdev.

Replace the kfree(mdev) with v4l2_device_put(&mdev->v4l2_dev).  The
error path for comp_register_videodev() failure already does this
correctly.

Cc: stable@vger.kernel.org
Fixes: 3d31c0cb6c12 ("Staging: most: add MOST driver's aim-v4l2 module")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/staging/most/video/video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 04351f8ccccf..aa846959b217 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -491,7 +491,7 @@ static int comp_probe_channel(struct most_interface *iface, int channel_idx,
 	ret = v4l2_device_register(NULL, &mdev->v4l2_dev);
 	if (ret) {
 		pr_err("v4l2_device_register() failed\n");
-		kfree(mdev);
+		v4l2_device_put(&mdev->v4l2_dev);
 		return ret;
 	}
 
-- 
2.50.1 (Apple Git-155)


