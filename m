Return-Path: <stable+bounces-242485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKlAMNDv9GlKFwIAu9opvQ
	(envelope-from <stable+bounces-242485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 20:24:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 384784AECF2
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 20:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E020300639A
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 18:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B130410D19;
	Fri,  1 May 2026 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m65Mbash"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E940F8E0
	for <stable@vger.kernel.org>; Fri,  1 May 2026 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659787; cv=none; b=JUEfML4Wm2cbKTNfXQcixB2FeI8vE6ayMGe00XWawWjCeQSaZEuhfTx5nuP9CyE2jvL4s7wGzBDVCfqkzSpXWfZlwt7B+q09B4++/TFEC3kknaJvMU2SjXoicIIicHUFwg2LzTdFqiYhVr4T/zfVQtQZ7awD6jVcYJUETXQkDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659787; c=relaxed/simple;
	bh=SVi8OGcFQK9lZRrLuOntWSN6V+qhlhdqgyG2gVPyLdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GmtMA5xVXxvJPKMn/r3KFqOZ3YzKmuEy/j/OqnAx/nwewqlKkGleqpn+0GhIn8zj7t3dEVKai9mtaDkrHbqRvQYY5FY9W8QEp/h9M97GESTwcPmirU6E3Mfr3KPVBlOHL8Q2LbkFqMVbaRVszMV02B8wGFy8y/Nwhxd6XN3QhME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m65Mbash; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2d868d014a5so2298961eec.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777659785; x=1778264585; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GLMoGsBUlC+X0dGT0ghykkSOnQo8Jg5A53fEDIQtS04=;
        b=m65Mbash/ozRr3MOwpXi1yKZaB6rG77kw55N5XtScnqSQXXQiDAQo8tl2juwcQOAKr
         iiljU0Ta0hfBZ2b5A5AqfGinVQISkcDxNYltWTEPs0YYMvBxqJMlGsiVoHVWrsbMkcSA
         DCgailzWMPl4JFpYCNaNYXdy36oD5YKAhzDnLNywefha37GK5EET+/1iIoIOE5aT7pZg
         PSSwAsrZgpHHmrseSpYbH4BpA3nA1C+hvc46QzbyC64V0ZWytQOlxgWtpMjyFrNPtuN9
         mCkP2dqhvqRhV+IHSnUU/QgGEVHRmBp0Fb6/3mWnjzsuOFreaU0awvX9BMIPLooKe24H
         aJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659785; x=1778264585;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLMoGsBUlC+X0dGT0ghykkSOnQo8Jg5A53fEDIQtS04=;
        b=UJY2az7KJaq4puTkoeCt2cjnQujXK5CX83YYLh31y+mYthxfRizzknPkOotwUuES0T
         2HhFeCh67vC5G/7NHojI7A0ZvUza7sYamNSchyP/Fa1DDWh9Kz1++1nLDuudsh4MwPXN
         da56BiYifCO+AiJhdT+ORjPSw866rnHt7i7gpdRRLXIUWNq4NwtTvHOQVYUVOzgFzQCl
         C9Edj2wLysJmR3bDq2KioEJKyWToCSa0QfBxcf1nuw2ILr0se/UiaYDcNuprC+9vnfU8
         FTtQK8ggDZ3syRuMzCf7BHWk/dEpmwxIdXDS6ju+PNWj59zL5zTRV6KMI52GntOt1LLf
         pYxg==
X-Forwarded-Encrypted: i=1; AFNElJ9L04IxWiYaNEerlItFlm4d2vwW9tA45Iz9cXw9x7gMb/THqAWl0UsoyR4GpRU+2byAHi5xOd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWljvMzMeaUtu3hpbwLiZ+b4l9aNKZMeSDGepPCEGzAAEQnH1l
	J7nuPudYms+mWhXS6ks9xRRqJUP3ic39ygWu3lK4XedljuqJWBWgtilzf+D0Yt06
X-Gm-Gg: AeBDievzukZQie6nfF8AsBsyZ/MloZsrqB5WjBCfV+VtVpNkEQ2rJJQrFZYYqDyn25G
	B8SL4RjVCow5cjFEG3n3UqsufMZ9VQ3KUPyhLPbefzj/rX+rB1DMVE7fW5UYmoRZ6r18Xh7+vgl
	rNrSMQzP1xJ7eFPXmab+D5jcv4sC71sWgmm2M+yrk6lWwsNp89bk5K/hTj9sfVVZMy6APsKA+UF
	bg6A0BDR3RlLF/y2D2pqWnhrzgCFvapiuRr182TwDxg6Qba3xu7IGL39PcNF0VB41BL66PSCF7k
	6o9/bhVkgHJx/4sQt74U/lzKEEAo+4zCLmxNtM7JZZx8CXo/8LhPMSv2OSD+jrVX7fMkiSmYRgm
	0u8qFlzfjW5tupp+h6VhxNz26jYF6WsJsWK4+W5qYVkMKSFLwe82XCI0y3nNGyc8O0pkGn6QmVn
	krNuekju/3493OPGeptBnukjHDZKGz+CgSqqEuI+eoZKllgfy+0hULNa0kLqfKUTc0Xn72jcxWV
	A7F0YGhMIFw
X-Received: by 2002:a05:7301:228f:b0:2dd:6937:79cb with SMTP id 5a478bee46e88-2efb82b272emr220762eec.12.1777659785240;
        Fri, 01 May 2026 11:23:05 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71cedsm6590624eec.9.2026.05.01.11.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 11:23:04 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Fri, 01 May 2026 15:22:58 -0300
Subject: [PATCH] ALSA: firewire-tascam: Do not drop unread control events
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260501-alsa-firewire-tascam-read-queue-v1-1-7baa4ba1a4de@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQrCMBCE4Vcpe3YhKVjBVxEP22SiK1o129RC6
 bs36mEO3+WfhQxZYXRsFsqY1PQ5VPhdQ+EqwwWssZpa13Zu7zzL3YSTZnzqeBQL8uAMifwuKOA
 DBMm7zknsqVZeGUnn38Pp/LeV/oYwfrO0rhsMvmkKgwAAAA==
X-Change-ID: 20260501-alsa-firewire-tascam-read-queue-7eaef1060adb
To: Clemens Ladisch <clemens@ladisch.de>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Takashi Iwai <tiwai@suse.com>, 
 Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=SVi8OGcFQK9lZRrLuOntWSN6V+qhlhdqgyG2gVPyLdM=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJlf3rdeq72b6CQ5wyFaaCOvq9I/jkS23GlMW0/eFVJdz
 jhp6YNXHaUsDGJcDLJiiiyrkxZZ7ul6cLU+boUHzBxWJpAhDFycAjCRc/kM/5T0lRl+B+kIsQcX
 SH3LUWPhU+nNP+Z6drGZ5/cnD8UlpzH8z4mZ2HHiPP+vCe6hj9xv6zdH/bugM40pflYFG8OOvXe
 C+QA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 384784AECF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-242485-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

tscm_hwdep_read_queue() copies as many queued control events as fit in
the userspace buffer. When the buffer is smaller than the current
contiguous queue segment, length is rounded down to the number of bytes
that can be copied.

However, after copying that shortened length, the code advances pull_pos
to tail_pos, marking the whole contiguous segment as consumed. Any events
between the copied portion and tail_pos are lost.

Advance pull_pos by the number of entries actually copied instead. When
the whole segment fits, this is equivalent to the old tail_pos update;
when the buffer is smaller, the remaining events stay queued for the next
read.

Fixes: a8c0d13267a4 ("ALSA: firewire-tascam: notify events of change of state for userspace applications")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/firewire/tascam/tascam-hwdep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/tascam/tascam-hwdep.c b/sound/firewire/tascam/tascam-hwdep.c
index 867b4ea1096e..dcd3fbcbeb79 100644
--- a/sound/firewire/tascam/tascam-hwdep.c
+++ b/sound/firewire/tascam/tascam-hwdep.c
@@ -59,6 +59,7 @@ static long tscm_hwdep_read_queue(struct snd_tscm *tscm, char __user *buf,
 		unsigned int head_pos;
 		unsigned int tail_pos;
 		unsigned int length;
+		unsigned int entries_copied;
 
 		if (tscm->pull_pos == tscm->push_pos)
 			break;
@@ -73,6 +74,7 @@ static long tscm_hwdep_read_queue(struct snd_tscm *tscm, char __user *buf,
 			length = rounddown(remained, sizeof(*entries));
 		if (length == 0)
 			break;
+		entries_copied = length / sizeof(*entries);
 
 		spin_unlock_irq(&tscm->lock);
 		if (copy_to_user(pos, &entries[head_pos], length))
@@ -80,7 +82,7 @@ static long tscm_hwdep_read_queue(struct snd_tscm *tscm, char __user *buf,
 
 		spin_lock_irq(&tscm->lock);
 
-		tscm->pull_pos = tail_pos % SND_TSCM_QUEUE_COUNT;
+		tscm->pull_pos = (head_pos + entries_copied) % SND_TSCM_QUEUE_COUNT;
 
 		count += length;
 		remained -= length;

---
base-commit: 9e8d6ddd7ecf2ad42d614243f86e50fcf0183b9e
change-id: 20260501-alsa-firewire-tascam-read-queue-7eaef1060adb

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


