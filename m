Return-Path: <stable+bounces-233297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kmbMFGt/0WkHKgcAu9opvQ
	(envelope-from <stable+bounces-233297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 23:15:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C0239C926
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 23:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C45F8300A8D1
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 21:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A4C34D91C;
	Sat,  4 Apr 2026 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDZW6/r5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522534DB59
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775337319; cv=none; b=Bc4edmKmdeDXewvxhVGUPAkanzy5tXMBtxNrhcnu8AXbaCKMjoIjJeHhX1dYyK1jOUv5D6ofB/jzeN/XfKZDcT+3IIHS3ZrjNByFZuos0GQzLJ4kvwcC0dFCPpEBfDG8Xbxe4UOxyjaiDrwOLG/JTorwZpAFL/1BWiqPO0Xn+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775337319; c=relaxed/simple;
	bh=AxK7wyi3JVV+dK3cUdKb7CBM0BbT27IsZ/ngqvAHKi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4UivXlzBRl4GC6e+DghIqVzEDcPJy0AE3tYVdnumP8zdXtx8WbsV5T1rR8AgqCnznFt3hmWinKgbnZ2N/aB4rA/vTI34P5804gZKGqH2dJL7I6XXLymOWheV5dYdmUXaItsc/HqGpt13L+8cCfFgQGUjFu+autrzkaF6kiSgoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDZW6/r5; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-953b7d2c820so915657241.3
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 14:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775337317; x=1775942117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aAE9COXdUwRjY+/DxrJjBm8Kf33N0AgtEDa7elegUYc=;
        b=SDZW6/r5VbesKh/k8Vfqu4Ei+396FJmrGCfCnl3zfzqxDsyoNfnn5czXsPo1Ep7vBg
         rLULhy6V+nLp8eODS5n/Jro0oLbn25cQNcnlbI0UdE3lYfKIuvioY++yvGDPo7SHLZ31
         uqFfn8NLZu+WnvW2eUiTqcJqsMcIwZg2hrIrt0k04OwNcxiRsR0/6+/1CkWu9rIz6E3F
         vyxz/HytSb2p91iceTkrlH7t0Gi1deBXNZkUd/sU224RTQkUFR69O8QZGtrb258+BUpK
         lawT/gthUfx0SVdVWmAUXCF3XZq6pZ5vzyBbFYPoOaya0x4ugIhmFou9NEAu6HugcvS2
         NGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775337317; x=1775942117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAE9COXdUwRjY+/DxrJjBm8Kf33N0AgtEDa7elegUYc=;
        b=sNz94BPDaCXJd7MpmLJCwKcqzOQWzm/jhkfmKNSf589LzqJJ2vFlKl5lWLON+jkbyH
         dckgV5klj1NcUVuTNHqahFfL3olUysexuSdO0W+kCtrJZ+IVjGkHPcbrsX/57Lvm/OiF
         iNWy3yC6dyXC+EkOf6UweNt5UrhzuHcPxI4c1aPIDc+IKo0sJEN3QynN0oPksGDBd52o
         SFiXuQGpqrhNU1TXB9iUwQGxTN2tQEZQLSHmF+IlxBowyA+trNYwUXIbH8rGT3mxvHe8
         +BtYeFNTX+fasZQSTsi0t7Sg5+lm8oxEb6pEGKDMRrv8jM8MQA6r/+YnX4Qo7dYaVAXJ
         oJBg==
X-Forwarded-Encrypted: i=1; AJvYcCXSpS/+8s6DjW16OrQpf9+J5t8FAw84WbXfbZ8Nm1YATaQniCfMTs4tPTjBhhgrcOc5kq+3vCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZX7+TgLg3KcOWQairzt+U5qiNwjwwgIG7Ic47I7OKfQRdaKAD
	4Rg+lc2fdb+EmmNbhUZgRUsuKmQ7+/593AajnyK6d0+5b9vwlWkaqpWjIDJ0QEh+
X-Gm-Gg: AeBDiesX3w2xPinG9GAmAoHEjPnnpJjKZ6ZnVz4WKVjFLjPaDk3n/p6NMk4a8sVqHga
	DEppzJBqmUwmMpww/CSeX7OsIuml4NfF3fdYhBXdS0fxLE9xbRaYVzqJaf+ta01EN2Zh8OgpfhD
	5rsAfzoBtzGsc3K5keVBuizmZ0DO65wKG/U/N3UfOxqFUp52qqN9SEzgWKRDcu/Fj+uwvzaEJ0C
	T5zULZYbuL73FE1QfF9J9+RyRWyCFerFh6T09wO8O24HfwBMUpfxPRGDNCoCWz3RMpBTsB+EDTs
	L9Ml84te8LYe959ygeFf/1XUN7okVvk0h/c+oeGo/g9oF2DR9iYlS5ueQBvhevGnjdQp0ioL1wk
	PW5tz8s7B9FM+UuROJqnmXGKI1koIqGs1Sb2PT1tGYXhU8bJ2LPs5QJ+MZ3yJfQkTvR/e60BD+5
	BE6ijSDhNvi1iW3da7KTMqJla1qe06AZSs/nq+IpGz
X-Received: by 2002:a05:6122:e153:b0:56a:9841:efd4 with SMTP id 71dfb90a1353d-56dab8849a2mr2559153e0c.1.1775337316967;
        Sat, 04 Apr 2026 14:15:16 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9babf3e6sm10830305e0c.6.2026.04.04.14.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 14:15:16 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: security@kernel.org
Cc: Delene Tchio Romuald <delenetchior1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix heap buffer overflow in recvframe_defrag()
Date: Sat,  4 Apr 2026 22:11:41 +0100
Message-ID: <20260404211142.53071-1-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233297-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89C0239C926
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In recvframe_defrag(), a memcpy() copies fragment data into the
reassembly buffer before recvframe_put() validates that the buffer
has sufficient space. If the total reassembled payload exceeds the
receive buffer capacity, this results in a heap buffer overflow.

An attacker within WiFi radio range can exploit this by sending
crafted 802.11 fragmented frames. No authentication is required.

Add a bounds check before the memcpy() to verify that the fragment
payload fits within the remaining buffer space, using the same error
handling pattern already present in the function.

Cc: stable@vger.kernel.org
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 337671b12..901f4b1ff 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1132,7 +1132,13 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
 		/* append  to first fragment frame's tail (if privacy frame, pull the ICV) */
 		recvframe_pull_tail(prframe, pfhdr->attrib.icv_len);
 
-		/* memcpy */
+		/* Verify the receiving buffer has enough space for the fragment */
+		if (pnfhdr->len > (uint)(pfhdr->rx_end - pfhdr->rx_tail)) {
+			rtw_free_recvframe(prframe, pfree_recv_queue);
+			rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
+			return NULL;
+		}
+
 		memcpy(pfhdr->rx_tail, pnfhdr->rx_data, pnfhdr->len);
 
 		recvframe_put(prframe, pnfhdr->len);
-- 
2.43.0


