Return-Path: <stable+bounces-237714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA2JNAa43WnciAkAu9opvQ
	(envelope-from <stable+bounces-237714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:44:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FF63F5546
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C47543037E52
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C73731326C;
	Tue, 14 Apr 2026 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaeDvez/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F0883F
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 03:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776138170; cv=none; b=I/zaSa7ZKf+Tj3/JrdkheHjSrYxKWBipxnPoDLOsgoSBPUfGEtDy6AbUXcOcDYeU3vbF49OMVH4dtG32sdxq6fYdaHwx2rR9HUcVVE8yz6y1DRqG+c1gyHByvZ308ZkRn7HGCOISPVEQ26sGAj6t+n/jrd/Q0lypTAEq/PC2/o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776138170; c=relaxed/simple;
	bh=G1zkKB5J/ZwwzO57UPK0AFrN20hSeHo66GZs4YUYlKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rgSPSQ6/hxwYW1t8Pxqe7wPkKbWlqxJyJBWQxBf1+VUi9BY12s8FkNxgA78GXwkk08ilO0hfBdiUMDQOWsJBYL6S1aiGgc4RKY6HqBrsK6K7radA/9Xa5AbOyBdayQXXoPp/QkuQ69dBYMsgGzZjWcpjpNkDYKI9rXLCu/4Hmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaeDvez/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2adbfab4501so21667195ad.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 20:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776138168; x=1776742968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxcVRDBQYoEvUjV/D/PMX40SNzPhQnuxj7fjLILYmjM=;
        b=TaeDvez/GmrmfSWFW3V/GjcP2XU9KuVw3/oeBDDh4qIwoY14//41gQpW65X0sD1oBh
         UDaIe8fCiSGJ+ElO/6ejZVSA8nQXsMy6EHU3PG8xiY+otbYDJL+/rcwx2tV0aEi/eCj3
         gnwzAeOKwpO42r3mGlz+plFKwALfWRZZoKtQ8xjM8mZJ0dNiE/Ebh+Le7C7Au7dbldJb
         5kVhCkB4Eun1cA22p0nBbNQKzCprkuvpveWaE0G8X8j+NxONWa6JTXXouUS9QnF9TMX5
         ZCy+mlOvcbfDzMRZCu43NXxdl9VseMMk4t9otQYW2qzQiTOn73AtGb4jhqc5SS+7YyEC
         bcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776138168; x=1776742968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxcVRDBQYoEvUjV/D/PMX40SNzPhQnuxj7fjLILYmjM=;
        b=XJKWYTFK/OmZh4btlKTwQi8kQwfEBe0FdELZdjEH4waR0uPeZ3fFRPzt2Q2HOTU+xk
         tajAU+9DnUDDJb+IWP5Q/bZGcLuOq/hMk+NHkpxoaC/nXpPAcNDmzRMVN+PHIs0URu9a
         40uC4FFrrK/XDIT/C+8KmeIW/dXz2fwRMzPTNYXeA0WpnlJdBFSVuOjTWsI4iCNiqu30
         B/4GgxI2IxhTkcG01d2QwBYBBVgs3h4LQQSjptvhVnGvrxu7GkU5B2TdqyBoVDsYh0Nv
         e2gyZpB8BB1qrYgKVnxsQa0fQpGwKZsG83kj6Lmm+AL9liPm5kJ0/o2D3OccePANV8gM
         qDyw==
X-Forwarded-Encrypted: i=1; AFNElJ81jkBIDt1Qib9lKqfOvHijtdVN+mNIAw/j3Qx8ws7TkJK29+kXgxl+VomLfJ11q3AhP9hJyGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLnd3V1Qmk8zWD3t8CCw8luPjftl92AjZDb7aCpN2kW63PaycU
	QTeLd1IIcnkIalEE9WkUrVPr0lHVaCgt13SsxonbgJ/3mY2EFuZiMJgH
X-Gm-Gg: AeBDievWHsJ8WB7YldJUWCLIdK+dAtUnyCpecZZ1BRMgWd5bmyo7azvemOTNFShzBq8
	d/oQP6ri1gyTI9s6LGluFOXbycGxJQ6p0LrMJNDuuPy0oQf60Z1o5S2H3i9INFrwKOhssVCMH88
	OBVnANZdsMZ36PUOFhLoEHkCXILjpaGRL9zcH1GCd5wfs6yvzDRJ7luRapafDfpGuf/DoEPlNyQ
	7MfWvUrnGvIpCUdZDSBgnIQPrBnwzUphVgc3335h1ffwFsiEc9VSHooL6F/k737hmifBpGImJQy
	sjsZLfwej9xsJp5whEeat8WGzR7IiYzMCOWu7b4QhCn8Xj7/HGv0UFrq1rod1SQ47wOaOsCAcAK
	OWI1bj8iKALLmXpZv4v9Dtix98J2qzKKlMW2WqcN7DLXdwMokhUz+AZoc5lpP9cXKHzzN934Da9
	q9gOAUTkhcf7pGbKn/XzIerS88GbYP
X-Received: by 2002:a17:903:2286:b0:2b2:dca5:101b with SMTP id d9443c01a7336-2b2dca51487mr136688535ad.12.1776138168289;
        Mon, 13 Apr 2026 20:42:48 -0700 (PDT)
Received: from zenbook ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45e949464sm63079895ad.24.2026.04.13.20.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 20:42:48 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Alistair Francis <alistair.francis@wdc.com>,
	Carlos Maiolino <cem@kernel.org>,
	Hans Holmberg <hans.holmberg@wdc.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfs: fix memory leak on error in xfs_alloc_zone_info()
Date: Tue, 14 Apr 2026 13:41:51 +1000
Message-ID: <20260414034149.1116281-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237714-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wilfredopensource@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:email]
X-Rspamd-Queue-Id: 57FF63F5546
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Currently, the 0th index of the zi_used_bucket_bitmap array is not freed on
error due to the pre-decrement then evaluate semantic of this while loop used
in xfs_alloc_zone_info(). Fix it by allowing for the i == 0 case to be covered.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Fixes: 080d01c41d44 ("xfs: implement zoned garbage collection")
Cc: stable@vger.kernel.org
---
 fs/xfs/xfs_zone_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index a851b98143c0..c64f9ab743a6 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -1217,7 +1217,7 @@ xfs_alloc_zone_info(
 	return zi;
 
 out_free_bitmaps:
-	while (--i > 0)
+	while (--i >= 0)
 		kvfree(zi->zi_used_bucket_bitmap[i]);
 	kfree(zi);
 	return NULL;
-- 
2.53.0


