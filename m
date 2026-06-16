Return-Path: <stable+bounces-264085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U6BFOnxuMWqujAUAu9opvQ
	(envelope-from <stable+bounces-264085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:40:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C204C69146B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:40:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="NT6D/9Vx";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264085-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264085-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28876303C9BA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E894418FF;
	Tue, 16 Jun 2026 15:34:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B50357D14;
	Tue, 16 Jun 2026 15:34:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624046; cv=none; b=T2iia+H313CYIV09GoTVeWLArK5zAVmQYpnzgy91oeQDXRGdahAQ6KhZkf+tkf1UofhXLqRUqSIAoaPCkzZxR0UipRSdyJk11lzc0+S2NufFB2V+DW+QqifTMIkXREn1kdNtX5FrpLgzgk48GhPZM763i/QIvisIGg/gMB+9ryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624046; c=relaxed/simple;
	bh=TL8Mc6lBoAY9ZOZADBWPl+8Y0AJ3ly2OU1NSgptwews=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjh/tbOFtUBRs6SUejimCVkOy4Gz6ll4sOEwHmk4f049ETSgR3pegVq9oy1i8jFnkY53RlHSJasm7UvMQOOuQd1ShHECdWFpu44bTWWzfZ2tTmMszAZwzBHdfd4PIlSFHZed7qJhSEiPYLq5HudFrnjVCNmhzexGezugf0Q5a8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NT6D/9Vx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884F31F000E9;
	Tue, 16 Jun 2026 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624045;
	bh=asbK8KrDReSafn65c3e9QEjvUnAg1bCbXjJTyJX2nc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NT6D/9Vxz11KCQpKcXysauI9lnTFw0Z1M3zFnD8rcfqA9z3bXFw0xGBnT9MuZ43bd
	 OY/WKpmz8m8ZHwSymRxUUATVLQEKC4wu8XtT4zEu7LYKHF+xIKAZbxqJUx6LqP/5eR
	 L4sYhjdLxBllBRUJuZhpO9Gg175iWvgmhUSV25gg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Bilal <meatuni001@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 7.0 262/378] accel/ethosu: fix arithmetic issues in dma_length()
Date: Tue, 16 Jun 2026 20:28:13 +0530
Message-ID: <20260616145123.879389195@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264085-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:meatuni001@gmail.com,m:robh@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C204C69146B

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Muhammad Bilal <meatuni001@gmail.com>

commit ee6d9b6e51626f259c6f0e38d94f91be4fd14754 upstream.

dma_length() derives DMA region usage from command stream values and
updates region_size[]:

    len = ((len + stride[0]) * size0 + stride[1]) * size1
    region_size[region] = max(..., len + dma->offset)

Several arithmetic issues can corrupt the derived region size:

- signed stride values may underflow when added to len
- intermediate multiplications may overflow
- len + dma->offset may overflow during region_size updates
- dma_length() error returns were not validated by the caller

region_size[] is later used by ethosu_job.c to validate command stream
accesses against GEM buffer sizes. Arithmetic wraparound can therefore
under-report region usage and bypass the bounds validation.

Fix by validating signed additions, using overflow helpers for
multiplications and offset updates, and propagating dma_length()
failures to the caller.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Link: https://patch.msgid.link/20260524103710.47397-1-meatuni001@gmail.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ethosu/ethosu_gem.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -2,6 +2,7 @@
 /* Copyright 2025 Arm, Ltd. */
 
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include <drm/ethosu_accel.h>
@@ -164,16 +165,26 @@ static u64 dma_length(struct ethosu_vali
 	u64 len = dma->len;
 
 	if (mode >= 1) {
+		if (dma->stride[0] < 0 && (u64)(-dma->stride[0]) > len)
+			return U64_MAX;
 		len += dma->stride[0];
-		len *= dma_st->size0;
+		if (check_mul_overflow(len, (u64)dma_st->size0, &len))
+			return U64_MAX;
 	}
 	if (mode == 2) {
+		if (dma->stride[1] < 0 && (u64)(-dma->stride[1]) > len)
+			return U64_MAX;
 		len += dma->stride[1];
-		len *= dma_st->size1;
+		if (check_mul_overflow(len, (u64)dma_st->size1, &len))
+			return U64_MAX;
+	}
+	if (dma->region >= 0) {
+		u64 end;
+
+		if (check_add_overflow(len, dma->offset, &end))
+			return U64_MAX;
+		info->region_size[dma->region] = max(info->region_size[dma->region], end);
 	}
-	if (dma->region >= 0)
-		info->region_size[dma->region] = max(info->region_size[dma->region],
-						     len + dma->offset);
 
 	return len;
 }
@@ -397,6 +408,8 @@ static int ethosu_gem_cmdstream_copy_and
 		case NPU_OP_DMA_START:
 			srclen = dma_length(info, &st.dma, &st.dma.src);
 			dstlen = dma_length(info, &st.dma, &st.dma.dst);
+			if (srclen == U64_MAX || dstlen == U64_MAX)
+				return -EINVAL;
 
 			if (st.dma.dst.region >= 0)
 				info->output_region[st.dma.dst.region] = true;



