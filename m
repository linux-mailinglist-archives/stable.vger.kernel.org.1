Return-Path: <stable+bounces-244274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIt0Ie9u+mnJOwMAu9opvQ
	(envelope-from <stable+bounces-244274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:27:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E01A4D44EC
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7A9C303ACD0
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 22:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3060494A1D;
	Tue,  5 May 2026 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O3BiqMzp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6A48B362
	for <stable@vger.kernel.org>; Tue,  5 May 2026 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020073; cv=none; b=Jf30Quc//zLl/vFzZa7prwrAaF9tNytlaMRXOQ5mEYjS/aNrP1mpMzwUCJPPyIylAHIM71bxk2fJ9+2lR+1nv8cP0IjgmU8aZQjDiYGPrSuBuUfPal4OwSWhkF1U2iRevVX82PYVGVxe2NWl3HgXzIkklCuNoPtiW+OLaYmCw/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020073; c=relaxed/simple;
	bh=6ElAwqAYGnTZd8Glj0oiwZd+BCgi/w96WOF9bPgn3vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpKVWvasHvknhO07EymG+g0XRGO3hy8lHVDB15mx43auOK1jH52cDMjtQuv9CRCt7u2hIN9cbX0V0+JbevO+Tb1jkNoBGwwyeT8ueXScXgWHOFJ3cHuA27G9i+XY205Fb+ScMpgFpNa7gpTwI/H6BD86Z4aw4IqZDp7jw04bKcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O3BiqMzp; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso2051812a12.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020072; x=1778624872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUzPAGUmnW9nuYsWnE/ryysW/QEIR4wcMfsbCfzx84w=;
        b=IlQGkxveEigjVBnJBToxEsJ5zSN/6XPFY7/vk1e13Z0FmtFGkVWFgZQ5fDK2BGnsy+
         NTq/6HYgk1p1RiWGaEk8vQikwG15psE4z8H9XFZ1Y0GzH7JNAkLtOMCbKDSuPP+/ICmW
         pBvdKs4gKEzUDtgkqyAxtTSnFHeLMnr3lQHdsuzlzp74xCCJd8GdSdThNbzdjmTpNYXS
         rKIVGVfybqSxURWo1UArXVAah7TCLI0GMUrKYSFzC212qOARWMBve3eiV4zHBo8aBYVk
         VLok6sRk6bPYRTtdZUnav12+tdXVyA4MXLGjH1eaa1XbPtVAH4skB2qpoMmxuL6jHOUW
         uHCA==
X-Forwarded-Encrypted: i=1; AFNElJ/QlCBDcZh7jc0WFH4hQvg42F7HIO2omckvCVjE3cQ0vS86LD7OmAkBK1AgxYJC2M3lnv32/Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpzglFBce22RdWZPf6iki0XltO5yKRgnfs0HdyP60zQNbVvInY
	qhrAbRA0byOpVflMZPsbLOeydeoZQZ6RKJ+hf+DxE0D2LFSRINIayBJmXM2wqaZaS00aXMfEDR9
	pm1xJWJ4Apqx+d8qpbY/cLIOQWnU/JrwDLD1kzXqicGJL+hxWQxM4Lfl1eLsYxZzFEP68FM+uzW
	N5UF010HYPnHk0jYmy68oJJSDSKg+b5ayWqpcjGljV3z7qItPPGadPmRKXlFW+f5TCpnYuHPJFr
	txd5FV5
X-Gm-Gg: AeBDievcVVOwoon2MkrUwRssKqC7jKnSTMFa7a6+cA0E9+zEiwk30QIVwuyLEJQsTfg
	hlEj43AmWpSqfp0/dXKM7apgQs+Yyu2mucZ+DYvaHY4zOHLzQWUYcx836YH1sbMa+pM9tinq1Fl
	74pR8SPdPOIoO2IFiB8YR10PRsCQFVpCtUEcIQzCpc3MIY+5ICAX2QTof0lE8kch+0zK6k46/MQ
	vAmIJG1Pjf8uQRIa0xLw0teWY5p1wq+zKdR/kXo6AnDOMo2+pIRMu66nNxwptsdYTEoR/wjcjWr
	95BvQo/FXeDs3MqlApfLBjoCT8F4wQDFLYZmZ3KmibrSYNFS//o9aqQZYjCN5mUcmYMEJooOYrA
	pTwJBWCoGuBtWI/jC256zm/Uc2S92Y+GG6IKWr2wKsUppyNcH3rGIm4dOrpy9H1qnY6Qqyaekeg
	KmKVglIz1aYv2l1nD+5bW0NWph7MPqdc2OFNJ+6r5ODnr5wcu1EJ/D2jRQNWyp+AgHo6g=
X-Received: by 2002:a05:6a21:328e:b0:3a3:a5cd:560d with SMTP id adf61e73a8af0-3aa5a903f41mr721174637.9.1778020071550;
        Tue, 05 May 2026 15:27:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c8242bbe61bsm24923a12.7.2026.05.05.15.27.48
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 15:27:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8aca14d1faaso223880656d6.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778020068; x=1778624868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUzPAGUmnW9nuYsWnE/ryysW/QEIR4wcMfsbCfzx84w=;
        b=O3BiqMzpHLHY7+FBJ0FTJ4ElYIjDTAwug6E+c5yzdh8XHPb1OidF5dzR6FvuuiZyTo
         jPsPgw9FU2EBfdaSfwf6ll1Tv4EfM9nDkFIC4cI+82oHHhbTTWnPgx0G0Uqbej5zw6LX
         p/GazB7QNv/Nm0AJ22r6wPxsrgs7zUbVjZcEw=
X-Forwarded-Encrypted: i=1; AFNElJ8jfI+n/Fz7ponlpbE4RQ4nO8Xl8eHvn5zYKjF5qq0lHjLRk1Huug+rfHm6vIBVgmFfUQXPfUM=@vger.kernel.org
X-Received: by 2002:a05:6214:450c:b0:8a1:478a:e580 with SMTP id 6a1803df08f44-8bc422a64f8mr10868246d6.8.1778020067960;
        Tue, 05 May 2026 15:27:47 -0700 (PDT)
X-Received: by 2002:a05:6214:450c:b0:8a1:478a:e580 with SMTP id 6a1803df08f44-8bc422a64f8mr10867776d6.8.1778020067409;
        Tue, 05 May 2026 15:27:47 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:27:46 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 03/12] drm/vmwgfx: clamp dirty-page range with min, not max
Date: Tue,  5 May 2026 18:22:24 -0400
Message-ID: <20260505222728.519626-4-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 3E01A4D44EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244274-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

vmw_bo_dirty_transfer_to_res() and vmw_bo_dirty_clear() compute the
intersection of a resource's page range with the BO's tracked dirty
range, but clamp res_end against dirty->end with max() instead of
min().  When dirty->end exceeds the resource end, the loop walks past
the resource's pages, calls vmw_resource_dirty_update() for ranges
owned by other resources sharing the same backing MOB and clears
their pending dirty bits via bitmap_clear().  The result is silent
loss of writeback for unrelated resources whenever two resources
share a MOB.

Use min() in both functions so the loop is bounded to the
intersection of the resource and dirty ranges.

Fixes: b7468b15d271 ("drm/vmwgfx: Implement an infrastructure for write-coherent resources")
Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index 45561bc1c9ef..8ab88f388652 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -311,7 +311,7 @@ void vmw_bo_dirty_transfer_to_res(struct vmw_resource *res)
 		return;
 
 	cur = max(res_start, dirty->start);
-	res_end = max(res_end, dirty->end);
+	res_end = min(res_end, dirty->end);
 	while (cur < res_end) {
 		unsigned long num;
 
@@ -347,7 +347,7 @@ void vmw_bo_dirty_clear(struct vmw_bo *vbo)
 		return;
 
 	cur = max(res_start, dirty->start);
-	res_end = max(res_end, dirty->end);
+	res_end = min(res_end, dirty->end);
 	while (cur < res_end) {
 		unsigned long num;
 
-- 
2.51.0


