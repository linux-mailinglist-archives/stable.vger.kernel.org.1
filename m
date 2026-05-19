Return-Path: <stable+bounces-249482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLntAiETDGoZVQUAu9opvQ
	(envelope-from <stable+bounces-249482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:37:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C5579328
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12BAD30EB721
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0D33D8906;
	Tue, 19 May 2026 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0mEfy97"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A642F3D88E4
	for <stable@vger.kernel.org>; Tue, 19 May 2026 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175827; cv=none; b=jhqVcgOprYG3rAe6G/1peZRcWdqhdhaClB5vV+IElya4ZUuvulwFnKnh1Jq+CezzZH2pLq18+O0uNJuU7XtdhL93ytQQ2izs04GcVqAAoNFPJTMQiswpH/1/bAfz1M2y6nZg3JveTwTrvDBd4m8MA/ETOGOtbLE9M4Ocg3/Zcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175827; c=relaxed/simple;
	bh=E5tbrL6gDSZ/C+kamk4PKO0Wqa9UDvCknl/PJPOeSAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGj6WqUEH7Vhw4WSE2Lkuj+Vhw7g1NW+4vh31X2MHvK1lHEnOWPyPCYGJmLW5YawIT3t8tB7M6VWadrFpwmq8s67SMXeVAuyxjFwiOrXh+ibbF/pB173qzL+dPlSxzfHKVz2YuCqjaOOIsrFUwvOmwgsaC8gKxVsM3HLVsf7ONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0mEfy97; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso2946573f8f.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 00:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779175824; x=1779780624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J0yD7Ov4S/iFthQxZco1gvVMz6aNPT7+SQbTZFwmogE=;
        b=c0mEfy97zwfhA0j7z42mj6tQX/pTQqWKLjiwLxcd8nkUI7qZjubdJ54X1h5riyVpm6
         GVXpWrTLfaTE6BZj0l7X2PPFiAOcm6ta7M7feP+78Ua0JVIXdScGWXW2W1d3FIEVauVX
         TLv5TdkLE9WTsu/fjfEGswmGSW9YcYTM2pI+nvi63aXIzWoSgAW7CoN/iqklflwX+2GB
         5/hEKtounYZxJbIq3hof8hjhugEI5JnYSelJ1ZG9yy97OuurDX4f+I9VbotZ8npd/0cy
         f2oyH4pYZU1NsbV6fJrXL9ewA5FfWNtRXrNqXJVf9UPHp8zKXcnlWPZzUUUs6hGO4s3B
         2REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779175824; x=1779780624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0yD7Ov4S/iFthQxZco1gvVMz6aNPT7+SQbTZFwmogE=;
        b=IsSXSfBLQGgopXeG0rJujKgePyHV5gBIGOpiEeNZo60eLvbAG37kaTy9e396BWtLVb
         LhUPrHhuHP3ZfwrF4jDGA0QwjOhsmwarBbxL5hzcfoufhu+8upiywU+WbSy4yfNPT5jZ
         uWWI8ewF41vgmvYEb+NSPjpRZJshNrxTSXAQcU4wLHTgnyvSTgoIFNi0N5vJ0262zxmc
         J8C6tpITnFBjeEpUlvYp+iIGBWXJeIQ/hsjW7q+FqRiF3OT8ktwPbUtbTEqS69rY1HzM
         Z2ULck8nlluJYxCar1SlPJpEzrCoYqcF99JLMHKdxr1JCFLqilewxO0ZJ+h3M7MYNYQl
         f3BQ==
X-Forwarded-Encrypted: i=1; AFNElJ+oU0LcMBqQxmFbJEO3Ne0oyABb+4a5NvWEA8Ou/dInG0XsoMI/TT16ciSYd/01ttJrumbLsm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhMl3pF3PY+G3loCCwvydJlM+6VoZ8KVAtcUU1xmlyXbKPzYKe
	VFCOGDeOglnhHEaekbiN0ivXxIGWZEukdLJpOi1x/nH7FC9gR+EzAVqH
X-Gm-Gg: Acq92OFxFMs41OZZmx/3BYk0G2k1jNlfI2se2SPUe+IhRGYXcNAeeBbKLEkstHwzIO3
	Owr3JM4rQBczxFiVTYtBeP5jFrieLANrt9IehY/exH5nBNyRiamTSb+UmyBebIXOZoMhyKZRxQq
	WBGUfBOTeyogBcBXLdS9/jjFoODyqM+BvoBrEoHIcdZ2KtwiS98ckWmmOvX9WAoySYH4UhQbfwE
	jL+QJA8qw5cGmXgrUAovG3SJRsaw8/ctMDh+HsUjBvspDdyqIGzQ6iLUACfsYUOe8OjhyGI6QeM
	D8MtSaoiJxOMjkwnKlE/jhLMrT5MIqRNuWhwfHmlSGqiq3yosOGm5xi6CC54WHyaTWWt0+5e3Wg
	rPqqPyQL6BG1bk51/xitv6uWWlmnopbnzEg0L/oJs28+VedTKXq+AiNzToQQ2B4QfVvAk1ldj6S
	ivQsRgQlslGymwqKwNucfLUN2i3uGdFQtZ9KpCSE6K3BIp2jYbLwqZ4Ih2xloDwYwyHUjH2nNEI
	JZp9FHu6wbaAaatJFtuCvE=
X-Received: by 2002:a05:6000:2503:b0:43d:6a0c:9571 with SMTP id ffacd0b85a97d-45e5c36bafdmr29954236f8f.11.1779175823595;
        Tue, 19 May 2026 00:30:23 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767cb9sm41776680f8f.2.2026.05.19.00.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:30:23 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	kees@kernel.org,
	kuba@kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
Date: Tue, 19 May 2026 03:30:03 -0400
Message-ID: <20260519073003.34206-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-249482-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 695C5579328
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr * and
immediately dereferences hdr->addr and hdr->ctrl without first
validating that skb->len is large enough to hold the header. A
remote device can send a crafted short RFCOMM frame over L2CAP to
trigger an out-of-bounds read before any session state is checked.

The FCS trimming code that follows compounds the problem:

skb->len--; skb->tail--;

If skb->len is already zero the decrement wraps to UINT_MAX, causing
skb_tail_pointer() to return a pointer far outside the skb and
producing a second out-of-bounds read when the FCS byte is consumed.

Add a minimum length check before the header pointer is assigned. A
well-formed RFCOMM frame requires at least addr(1) + ctrl(1) +
len(1) + fcs(1) = sizeof(struct rfcomm_hdr) + 1 bytes. This single
guard prevents both the header out-of-bounds read and the skb->len
integer underflow.

Note: SeungJu Cheon posted a related patch that adds equivalent
length checks inside the individual MCC sub-handlers
(rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
rfcomm_recv_mcc). That fix and this one are complementary and
independent; neither subsumes the other.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/rfcomm/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337..6b300237c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1741,7 +1741,7 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 						struct sk_buff *skb)
 {
-	struct rfcomm_hdr *hdr = (void *) skb->data;
+	struct rfcomm_hdr *hdr;
 	u8 type, dlci, fcs;
 
 	if (!s) {
@@ -1750,10 +1750,17 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 		return s;
 	}
 
+	/* Minimum valid frame: addr(1) + ctrl(1) + len(1) + fcs(1) */
+	if (skb->len < sizeof(*hdr) + 1) {
+		kfree_skb(skb);
+		return s;
+	}
+
+	hdr = (void *) skb->data;
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
-	/* Trim FCS */
+	/* Trim FCS - safe: skb->len >= sizeof(*hdr) + 1 >= 1 */
 	skb->len--; skb->tail--;
 	fcs = *(u8 *)skb_tail_pointer(skb);
 
-- 
2.54.0


