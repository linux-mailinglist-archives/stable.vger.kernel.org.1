Return-Path: <stable+bounces-241059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEOaNLPl62nNSgAAu9opvQ
	(envelope-from <stable+bounces-241059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:50:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DE0463936
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8F423018760
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BC835F197;
	Fri, 24 Apr 2026 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/frN8ZU"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11D314B95
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777067420; cv=none; b=lWGKMJIAmd6A7Oz1I05JCswFgykUTrZ7/DUlQ+7fZOBPLkmAvSFSpOvZDysGlfzxZyTI/MRCxdhCKZvNhpHmlvhe+ZiPS71JGXEHagfIpXq7cMc3SIk+qn5P2MV5PA4pOQvUxSRLrDhLtZm0fMiEYqxgos1lEQGk+ix5kk8RT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777067420; c=relaxed/simple;
	bh=sOzXWXjps4JMTmPSEpvaGYrcfzquE0jv7XgocWHMu+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RYNYP/wIcaD7nQ7NmubWovlSrspph9SBDtD6yK44dokfbCamcFrBeoN5MNWNGr/Q9X+RjyyumfTGQDOueoRfZ4+31YO8zACFd8DHRtq+tPs/S8IFEi8fnIjhmMwt4O+rZozdSREIQcwqGynjd13NMsZrL2xCHeqGsEvitREQwMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/frN8ZU; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c15849aa2cso11257596eec.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777067418; x=1777672218; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7c5cn3YaWCRG575DFbshGCJWY8c9pDATtWOqeL7XQQ=;
        b=h/frN8ZUKhdauSPza0lxH0uc96qPoTbHNYWW4VOnuJABqqdIfoxgupMA8cg5m8vUwX
         uxdc9ftaH8DQ1wQWlm32SBd/kxkB1KL7UUhpz5VLvWAoHIKGxqvesZdLZndALDczozxi
         0kmNX1zKzSl7csJEOmGbuWtQ3SwG5Zj5CTmp4NQwaTis1ThEVdJGVwx5ts/ui86SH5o6
         aZ+1kbVAf9XnmtEZ1PLOGLhiY75lylTjloPq1pAKNMkA8neleZGpFdk1++jM0eWVtVr1
         1pc9LpsMvCFVM3z/YUyrJ6vq49mFkAX/O3BGTiRlj65u2Bdysmd2hPtH6cLewn8HzVPe
         +e1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777067418; x=1777672218;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7c5cn3YaWCRG575DFbshGCJWY8c9pDATtWOqeL7XQQ=;
        b=Ip7dXzzVqwKdzPJJsa8thi9RKRWWbGzbqKzjtz0R4ExJt2VxOTEvv6LJgfubJ0+x+m
         zXxz27TQXSKSH/a6eimj3SRyQyPQTuDGC2hEtlAnhddNXOWwOEEuIAFFuWewPEEVUy8l
         7lLTxkrjE2pJrMk4L4gDqOybGLgZvLlIMQ5AMmJnWJN/P9V6ei0+ODOMQMH3koh1fKgc
         lFrc28kvJimzs1ODVAxTKFsBLstOL/EPfQBzZJ7BlEyRAbQReCVvS4CYiDiiCV6pvtXw
         xhQ7GJQp03DZ6wvljEXAGgnY4mIniXSr+6CbB1Q5kTfjnm/k6gyOrsHA+fbK1Rtqr3Am
         oUpQ==
X-Forwarded-Encrypted: i=1; AFNElJ92NHJvZmh2lmrjiST/p/R/YbgjpUhBuhRQMLVWKpuobBVLSn/nSFJD4j4sRQcHPD2kgKCZgmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZOj1DBmnuhbVvXXjH6IZJUJtbjFyxVZCKP9a83xbFq0j3PmP
	ZOXkYCZKbKR4dTCUj6pYdBlX45GlobvtiGx+t4k3F+puCFJcyBQpQnT0
X-Gm-Gg: AeBDievMLnZEwy3asmuTtg/ahVQbQbSoPLAloaWGSI4Zjst7vqq7XFtXhGika/nrwkM
	YLvh3LDCrrWjUA0A+N233TpRHCzObAwrXHatYBE3XnpViYxgZ7wc7YSeG1vga21RxMWsyj+KZCN
	Njba0NtDwzhd+Hkj5cGGjNkK0FcPGhw0kHS3Kx8iikQC6dQbjtCWr4n7yuuDVOx33tb3Ulia6ec
	LWv+rEBoo+THqttorLuTsCQ+ucSutiX5YcXevtOW6rvUPXDFDns67mDrxeZHKTA7U0wHS4rkTD4
	mS5GkOGnpx/m4x2v/O6Uc3PSzZaGk37YWr97qZCkXERbQwA6tWp0fug/sF1BbWra1wEyy4tqhhR
	loeJBKX9NopXXPS0slndpP24KSeXmJxxFkL8711LgzMdhO4aVk5vVMtABN3C8CKH44QtzIP2fNL
	dpysPS6Ff7GqXzjGZ0lBim8GesCYqVUEgF8V1CyNKlL+D5mxD8bwMqeTCdpMVCb0yCC8zkY+dvv
	BsGtSJz6lAaEQLjhPoL8/c=
X-Received: by 2002:a05:7300:dc88:b0:2be:171c:5048 with SMTP id 5a478bee46e88-2e4646cbd46mr16530489eec.5.1777067417797;
        Fri, 24 Apr 2026 14:50:17 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ac84c38sm34723359eec.13.2026.04.24.14.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:50:17 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Fri, 24 Apr 2026 18:50:10 -0300
Subject: [PATCH] ALSA: usb-audio: Fix UAC3 cluster descriptor size check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260424-alsa-usb-uac3-cluster-size-v1-1-99a5808898a3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMAwA0F8hPdtkbssg/orx0I0KJQTNyoiR8
 O9OPb7L20E5Cytcmh0yb6LyWCrOpwbSSMvAKH01WGOD8dYjzUpYNGKh5DDNRVfOqPJm9LFr++C
 caQNBDZ6Z7/L65dfb31rixGn9jnAcH0X7XLN+AAAA
X-Change-ID: 20260424-alsa-usb-uac3-cluster-size-4b87d633076a
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
 Youngjun Lee <yjjuny.lee@samsung.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=sOzXWXjps4JMTmPSEpvaGYrcfzquE0jv7XgocWHMu+o=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJmvn07LfebX8jLij8IECwmd//zJfzcyFpXeKHIs2xbet
 63u9bGvHaUsDGJcDLJiiiyrkxZZ7ul6cLU+boUHzBxWJpAhDFycAjCRvQyMDId3Zmqvd/6j6JUd
 IcgU7M3HUr3qFPv7o4xTG56/KQ8PYmT47xShG2aw9xp3+yXXt7sXzbv0Qrl0wT2ez9nTDUW2PbA
 7xQkA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 41DE0463936
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241059-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]

The UAC3 cluster descriptor length check in
snd_usb_get_audioformat_uac3()was added to
make sure that the buffer is large enough for
a struct uac3_cluster_header_descriptor before the
returned data is cast and used.

However, the check uses sizeof(cluster), where cluster
is a pointer, not the size of the descriptor header.
This makes the validation depend on the architecture
pointer size and does not match the intended object size.

Check against sizeof(*cluster) instead.

Fixes: fb4e2a6e8f28 ("ALSA: usb-audio: Fix out-of-bounds read in snd_usb_get_audioformat_uac3()")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 2532bf97e05e..6c51226f771b 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1003,7 +1003,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	 * and request Cluster Descriptor
 	 */
 	wLength = le16_to_cpu(hc_header.wLength);
-	if (wLength < sizeof(cluster))
+	if (wLength < sizeof(*cluster))
 		return NULL;
 	cluster = kzalloc(wLength, GFP_KERNEL);
 	if (!cluster)

---
base-commit: 876c495d412ef67bd4d0bdc4b74b0bd3d9f4e890
change-id: 20260424-alsa-usb-uac3-cluster-size-4b87d633076a

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


