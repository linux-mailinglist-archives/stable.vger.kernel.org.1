Return-Path: <stable+bounces-249617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI5pJsJ6DGoSiQUAu9opvQ
	(envelope-from <stable+bounces-249617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:59:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3657458103F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 976D43060098
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03672F2607;
	Tue, 19 May 2026 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTMiW/7v"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A53769ED
	for <stable@vger.kernel.org>; Tue, 19 May 2026 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201988; cv=none; b=JCNzCXNRMy1MASTRJIlK74M/tGKg8ulq9kCQzYyFowbpc/hk/XVneqJLk2/I1jDTfTCeNd4o9wvgchQAXl19c58u9jZeRIjua+1PgutGRbaUPW2qc1ztCT6JTx1w1mkgICyLMY8sra9r3F7Q/rbBtDT9Np1/kmAf3rAsksi55Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201988; c=relaxed/simple;
	bh=DnpFjzLBf0jW7wEnEpei/oKl5zYUrdA8NFbmjkgUKtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HHs4R6MfejORjtXLFlME7fB7loSCxWzWksp8hQzggCVPen4c0WVq0WsJebhlYZrnIOxqFKyFnzuIVr3gDRiJODbBfFG1Zamk/vSTH8e1oIBvB5E1pz9eP62wKGsZMRRxP3cxFLnZohgRlyLZ6nfQ2YR/xfR71sswKVO+uEywolI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTMiW/7v; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so3506541eec.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779201985; x=1779806785; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fLMlW/U+mAE6qh9Fg2eWb4MjQCTjnxY74Wi6IiUhl0Y=;
        b=lTMiW/7veW4wxXHEshD7xB/MnKXFmxVotswUSIfR4DYR/fEIQi51gXbCkdmhbAQGp8
         C1liajt2JFCKvWP+VmYWCzePOl3CSQb9uyI41d1o5yNOpS5pxCodM/Y6ce0exD5sFiC8
         Sm1TnsqFkxsDLX85/L73Fy1P4Y8vH7kwj5WGB+JSq8Mg4JF2p28rgLgFe9sp8u3zCJ1G
         DqoFz3kH3xDpHYk5/MUs1sKfGatbaiP3gXafz94A3a4SrKejfNniFETIYkmwrpWE5yG+
         L8Ngv7T0UAoTOoWU+stMbvEqydqVfZMk3HU8j3+wPZN/+3lKx/VueXQLHl40V2C6/RPR
         KoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201985; x=1779806785;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLMlW/U+mAE6qh9Fg2eWb4MjQCTjnxY74Wi6IiUhl0Y=;
        b=e3VI5CqkwwYBrzqKYsmVongXoYWoy48/qld0NUF90Ym7VVyKkWkSMPKnZSl+rRVlw5
         +H+gNX1AghprRjSQfcH4gWox11VpGkcTpKsbnpJ8QEu62dbo5Y41E/+W/YvPlq9e9X0S
         iF75qVwkTV2ELGjbNKWQjYH7ILVAMQz7ejEZgTWPUxilabyn6JnTnrGxLt00GINH1dzc
         +qQ055vzA0rYAXSHrKmWheYeI4vQLQzcLzBJSeMUJRfAI/+DmFQjUJ9dWzh588qu2huh
         QsX3/dRE62r5+g8jbIQ5yPf7DHNIgO9wmlnmRUBpGtyv1YElZOcuf7OGIFfW8jk6xwPr
         m8Tg==
X-Forwarded-Encrypted: i=1; AFNElJ8vqgMZ+ivvf1Ik/ld8w7ZmF7lpefDrD0+mLd0JaBXcodHrqF8I3y0ANDhRgPD+vp5XT8OK9e8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03IsOc6kMsf9KrT7fDQJOXcb4RoDiIM36jDbL4yREH4knWEMD
	e+3LuzO22oRpFKWVuwPg0zgnMbFBbvQrmD5UoonifCJkSet0Gq1nqD42
X-Gm-Gg: Acq92OHgZKJc4IjfmcVeXf2jI1MddxbNq0yFziTDJHf5hId5J0LQubxBXtSKgLGXWnt
	0KFUpg+ATrydbBn0rnooSaJhxp/wR4fVaSsaSeOuK0yuf7jqAiYcsk5g3mldStK/6FP/fMCvjNm
	XFrScNxFhBR0JmV/oMLcJtiUBvH+YKmZfYzZWiuKu+tgzI6aFtPZZ7UqhS3a0a+eAOD7JRJNh/8
	cVP46nCSlOz0SfcMLxuWO6mdSjaWIInXHothQ4K+4QVp8lHEb+0bC+Dud5B+sni87JMVdIaK/6m
	IH/r4KIoP2V6FCt0CeqjXsHL8dv7o/SWxVdNlYp616epgMOKkbQ/m0VIAmPHASEBllo8xEehb1k
	Xe+qeOWZKLcl+P6oZfh4WueLfXLBLpOgaTDGMC3nFI8/cwEQXtDL0X4S23AFPTIw1aR5H01i7+1
	oaLI0sBqn52bnTpTbyju16Y9pv905b1PJtOeaYjJC2ieFMUQR5RsT8IFR3xnwJrfn9Qc8YJzjOt
	pE2WGkwR618
X-Received: by 2002:a05:7300:7490:b0:2f5:5907:3a48 with SMTP id 5a478bee46e88-30398285d3bmr9086564eec.1.1779201984612;
        Tue, 19 May 2026 07:46:24 -0700 (PDT)
Received: from [192.168.1.18] (177-4-162-74.user3p.v-tal.net.br. [177.4.162.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bbd50sm16098423eec.20.2026.05.19.07.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:46:24 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Tue, 19 May 2026 11:46:19 -0300
Subject: [PATCH] ALSA: scarlett2: Allow flash writes ending at segment
 boundary
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-alsa-scarlett2-flash-write-boundary-v1-1-b550480e92da@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBBA0auQWTtJbQqmXsW4GMogNU0xMwU1h
 Ltbdfk2/2+gLJEVzs0GwmvUOOeK46GBMFG+McahGqyxnXHWIyUl1ECSuBSLYyKd8CmxMPbzkge
 SN9Lo2pP3xvmuhVp6CI/x9btcrn/r0t85lG8a9v0DzsId9ocAAAA=
X-Change-ID: 20260429-alsa-scarlett2-flash-write-boundary-af4579904965
To: Takashi Iwai <tiwai@suse.com>, "Geoffrey D. Bennett" <g@b4.vu>, 
 Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=DnpFjzLBf0jW7wEnEpei/oKl5zYUrdA8NFbmjkgUKtM=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFk85XtN74s5NzQE51d21O6c0J29vEGs5FneT5MvUy8kB
 +3a+6elo5SFQYyLQVZMkWV10iLLPV0PrtbHrfCAmcPKBDKEgYtTACby7Dgjw9Luz0ynD8+N/KOn
 /XEJu/HDvx/qK+oevq7MurfhJBP3x2MM/ywObJrqUC3AtUrizrzz3+o9OGZv4eBWKpisedXy9aF
 DIfwA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249617-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3657458103F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

scarlett2_hwdep_write() rejects writes when offset + count is greater than
or equal to the selected flash segment size. That incorrectly treats a
write ending exactly at the end of the segment as out of space, although
the last byte written is still within the segment.

Split invalid argument checks from the segment-space check, keep
zero-length writes as no-ops, and compare count against the remaining
segment size. This permits exact-end writes and avoids relying on
offset + count before deciding whether the request is in bounds.

Fixes: 1abfbd3c9527 ("ALSA: scarlett2: Add support for uploading new firmware")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/mixer_scarlett2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 7c43ca51938e..78fb72e626ca 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -9634,12 +9634,15 @@ static long scarlett2_hwdep_write(struct snd_hwdep *hw,
 	flash_size = private->flash_segment_blocks[segment_id] *
 		     SCARLETT2_FLASH_BLOCK_SIZE;
 
-	if (count < 0 || *offset < 0 || *offset + count >= flash_size)
-		return -ENOSPC;
+	if (count < 0 || *offset < 0)
+		return -EINVAL;
 
 	if (!count)
 		return 0;
 
+	if (*offset >= flash_size || count > flash_size - *offset)
+		return -ENOSPC;
+
 	/* Limit the *req size to SCARLETT2_FLASH_RW_MAX */
 	if (count > max_data_size)
 		count = max_data_size;

---
base-commit: 9b14f636834630e5473ee5020c8289823a481a7c
change-id: 20260429-alsa-scarlett2-flash-write-boundary-af4579904965

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


