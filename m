Return-Path: <stable+bounces-243541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOpFF4mt+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:30:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F10E4BF93F
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4B9F30356DE
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5A23DE428;
	Mon,  4 May 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TIDVEkNh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1903D6484;
	Mon,  4 May 2026 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904150; cv=none; b=QY59goze7i2BHg2cySGElDiI3mq893z8uWEZB6q+itAdvFPDHhCz9RYLmqnhVHznDkY1ZKLbTFvNudVCYriqHV3b+V37kuu1ezcd8OwTMLqtlxg8KYNY/1EfH1JYsPfNfVGSq29SXyl5KzmhMylmorhImDRSKpett2hungNyQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904150; c=relaxed/simple;
	bh=LUPxkiIiiR1KKTjEBeiK5Z2EgqwA7iA3LSnoC8D6ORA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJzoOkvskfR4dWxmBEkGXOFRq3FS6uAZ5vPMttb4lTUfFj2lnPn0qrUgfMKClSt3afvS88P85AsKzThI0DPw0uo9wxibG7y77THIfbTjjIiUm96IHCCEKIRN3xEYNhy8yFHw42XOJLJsdvv/8qoOc5GU5+jPsKFAiub6lxEbClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TIDVEkNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F16C2BCB8;
	Mon,  4 May 2026 14:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904149;
	bh=LUPxkiIiiR1KKTjEBeiK5Z2EgqwA7iA3LSnoC8D6ORA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TIDVEkNhPopSFLET4R78kJcrbLtt74kodMtOXVYl2d3Ydq5Jop9oShHaNcPM079LK
	 V8842hvmKEuKVlVCE3HIUZnr0U8Ay+ahRk596Xn8uYvjFqpci+no22SDPMswFHWPJ+
	 Zs6QJ2LPYrpSGNK4skyZewFqxFZwIDnPQIE7RGlA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai@fnnas.com>
Subject: [PATCH 6.18 203/275] md/md-llbitmap: raise barrier before state machine transition
Date: Mon,  4 May 2026 15:52:23 +0200
Message-ID: <20260504135150.614607427@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 2F10E4BF93F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243541-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,fnnas.com:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai@fnnas.com>

commit ef4ca3d4bf09716cff9ba00eb0351deadc8417ab upstream.

Move the barrier raise operation before calling llbitmap_state_machine()
in both llbitmap_start_write() and llbitmap_start_discard(). This
ensures the barrier is in place before any state transitions occur,
preventing potential race conditions where the state machine could
complete before the barrier is properly raised.

Cc: stable@vger.kernel.org
Fixes: 5ab829f1971d ("md/md-llbitmap: introduce new lockless bitmap")
Link: https://lore.kernel.org/linux-raid/20260223024038.3084853-3-yukuai@fnnas.com
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md-llbitmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md-llbitmap.c b/drivers/md/md-llbitmap.c
index 6b2d27de1528..cdfecaca216b 100644
--- a/drivers/md/md-llbitmap.c
+++ b/drivers/md/md-llbitmap.c
@@ -1070,12 +1070,12 @@ static void llbitmap_start_write(struct mddev *mddev, sector_t offset,
 	int page_start = (start + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
 	int page_end = (end + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
 
-	llbitmap_state_machine(llbitmap, start, end, BitmapActionStartwrite);
-
 	while (page_start <= page_end) {
 		llbitmap_raise_barrier(llbitmap, page_start);
 		page_start++;
 	}
+
+	llbitmap_state_machine(llbitmap, start, end, BitmapActionStartwrite);
 }
 
 static void llbitmap_end_write(struct mddev *mddev, sector_t offset,
@@ -1102,12 +1102,12 @@ static void llbitmap_start_discard(struct mddev *mddev, sector_t offset,
 	int page_start = (start + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
 	int page_end = (end + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
 
-	llbitmap_state_machine(llbitmap, start, end, BitmapActionDiscard);
-
 	while (page_start <= page_end) {
 		llbitmap_raise_barrier(llbitmap, page_start);
 		page_start++;
 	}
+
+	llbitmap_state_machine(llbitmap, start, end, BitmapActionDiscard);
 }
 
 static void llbitmap_end_discard(struct mddev *mddev, sector_t offset,
-- 
2.54.0




