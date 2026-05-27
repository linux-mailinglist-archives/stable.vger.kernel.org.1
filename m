Return-Path: <stable+bounces-254573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPhqFR3hFmo9uQcAu9opvQ
	(envelope-from <stable+bounces-254573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:18:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9415E4090
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EE91304ED4A
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E547A3D1AB2;
	Wed, 27 May 2026 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="jIeCI3rb"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57B53CF047;
	Wed, 27 May 2026 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883844; cv=none; b=jMXdexjW0S0+RfYgLxchIqpx5Y+X35JYAblH0y0AmLH0XRgC1Xr5y+6vD+A8c4yd8ySNauikotur0dNoZLZ4e6J7ZDUPLVt6LbOWqanf1yfMe0S5yaWeQ4TRQGwXL9coQ8rKj7UQVqV//Q8dpV+7w+fHOvm8M+LZPJyRef/mNkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883844; c=relaxed/simple;
	bh=DsyrqwH9z1wPy+iyN1XvW8sHgzFQ0mb94h3X51fopYM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cV6hkzOE7+pb+9AwwwR0QSRSO+YaWv6Ra45zsucBdeUP5iK5Pnn88JMGOv2tI5/d/gvHn21O1/nOS++fwi2YMAX/15ImQBZxYmSidV6Jnqou4ZPXYHjaZZKFPaFOqUDkWI9UQXTRqx7QnmSnk1Y0fwbke24bWd/7Kpha1nzXKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=jIeCI3rb; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779883835;
	bh=SdQzQQXDOvVTvDu89953WL14dsKKHE8EvVQ4hgHnk0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jIeCI3rb0nNYuSKqe6pyOCJTzicFAcGx6h9pVxI1NpP6tLZ7taL16hnlstpC2pS8v
	 3YMkDODhrUpzn3Dp1RdZaGyri+rGvZPgLMIIVpgcHhxqKYcYsUMEtY45/UPMM5mMc6
	 5CLDHqEsUqH3JIFckVXc7hwSGx/CxEf8qtoH1ZnQ=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 2518B808; Wed, 27 May 2026 20:09:17 +0800
X-QQ-mid: xmsmtpt1779883766th4pdboyc
Message-ID: <tencent_964433DCD132125D5EDA79EE068A2D6EFA09@qq.com>
X-QQ-XMAILINFO: MzFuFcyvqEECV4J1NXDv+jT8AE60QFYYhsT+4rm6MBOncxR8h5yNqWtgngiWTd
	 frDhs29siCFgz0MQos4WhBKPWOq8VdG1VMKiDtCtgFquP0zm8PcAsgTeTaGBUzV1TI48uQI5Jgo3
	 cC/cMIdNQ7daCHElve0Uw+YvRHSvkG26bgBA18o3EUJupMFzYBmkmTzG1dhrRd4icNXapOt75rUe
	 YPaobwQnuCj7dmHeAEf5Pix9q9sD3nhbwXuzbJbVJawg70itGEHbSTj/YEZ0VO4yCV6AKgYK9hbM
	 ki/mmfs2vtzTrOEevfIHXsipnDYySlSWFd2wRap3LxBYybXfjDoHz9QsZN02KwuokDd7jbIsntFn
	 Gp95vwXvLuzL4RFQiJoQwhSA5hjQ1rgVrlqJn9tTfiAUiWlvtwqocyK0GoyuLL+qw6bLKb+xc1ja
	 Rclx+/99vkSBD3uS92Pcnh0QsrOB3eY7VFMCqIz81rCEgoFyUJdo+wk3NM0wCt9wTtLXa+GeI7sJ
	 skNAm1xc1Q20GL3+Gjhe788ksc2d19lEugGnvcWLZ86kGSj6P3tWFwnP5ZyArpL/Zagr+Khb3ntn
	 XOYrldNVyEH7SxgZ0rpTAZMrhpURYglPQkfYP3bsUcYXNY4ptLLVWTeAoL7FQ7W33HZHI+WeIxO/
	 iJzYMnsegr7eFzluARB6V8b5ogzrrHClMXHqxayo3R9VHGLVl6jTVZLS0ctX3eQaba5AJ8X9nCur
	 CGYdB4lvUyDsVdR9wdXETBk7yXsqg9hZZGfExnNzOzg42psqYVYbz3xdd5SYkM5xdmOQ9nG4id4U
	 z/jJvC7howpnebSDhsNEVYWRQffJhLIvCOvQKNoqWq3HJIrsu9o5tI8CvHGS+kyNB+7vndIP2dyx
	 LkowQdeJaLYGqnG7kFpp6PaWbM/tFnSOsqefFP8XP68b5K9BkP5Uy7AaaMbvQ6cMpTEg3DdvRb7P
	 eyJ8ZsrwCL6DogD2hJC0dDzu0WHfminz35xuBNSA1FsHWaNWIcFXOJYfmgar2yhXijhBGHQn2Dd1
	 ysoTuNsemTsWo/2vIHDkYDTG+10/0UnrzRA0/VEoWrCh9GI6buEVsv/6rnDIGA322CPa/+TFSLai
	 ssofszJkpHJ+zH7e+vvCzYweigVUV0p39x2N273bx2Y2x5E2s=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Zhao Dongdong <winter91@foxmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3 5/6] ALSA: cmipci: check snd_ctl_new1() return value
Date: Wed, 27 May 2026 20:09:13 +0800
X-OQ-MSGID: <20260527120914.515037-6-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260527120914.515037-1-winter91@foxmail.com>
References: <20260527120914.515037-1-winter91@foxmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TAGGED_FROM(0.00)[bounces-254573-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AD9415E4090
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

snd_ctl_new1() can return NULL when memory allocation fails.
snd_cmipci_spdif_controls() does not check the return value before
dereferencing kctl->id.device, which can lead to a NULL pointer
dereference.

Add NULL checks after snd_ctl_new1() calls and return -ENOMEM if any
fails.

Assisted-by: Opencode:DeepSeek-V4-Flash
Cc: stable@vger.kernel.org
Fixes: f2f312ad88c6 ("ALSA: cmipci: Fix kctl->id initialization")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 sound/pci/cmipci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index cd73b6833639..ff4bfbf94b81 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -2637,16 +2637,22 @@ static int snd_cmipci_mixer_new(struct cmipci *cm, int pcm_spdif_device)
 		}
 		if (cm->can_ac3_hw) {
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_default, cm);
+			if (!kctl)
+				return -ENOMEM;
 			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				return err;
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_mask, cm);
+			if (!kctl)
+				return -ENOMEM;
 			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				return err;
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_stream, cm);
+			if (!kctl)
+				return -ENOMEM;
 			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
-- 
2.25.1


