Return-Path: <stable+bounces-213062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH7mNfOMgGkl+wIAu9opvQ
	(envelope-from <stable+bounces-213062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 12:39:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEE8CBD2C
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 12:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6013130675A7
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 11:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AEB35C197;
	Mon,  2 Feb 2026 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlTxjbn4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A755F34EF01
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031968; cv=none; b=t+PMgQmNi9bqRU74tkGyfSwN0l/7KRyUOqUgImeH55QB3RA+OaQ2qY4Mkry7pPc6yflmA7oHgLAfJEL1K3MmAPWap9SkbhWm1eT0oKpbsTdL2lwmoVEG1+Upa9KrvWrhx90hg9gEBAm5BnOiB8vK6XHl2BC57yBHqvwcqXH10ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031968; c=relaxed/simple;
	bh=NR6eDPn5SFX41KdRMAwfZgHQYuJFBYzjsakfWJLLEsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZOt815rwO4XzuVWxbwmELi+Ri9CVqPligXZ+I9gxPI2CzD4wMCFnpzsI7EDrMShh9rYjUo6FqxBjqHOdScuWa8yGt+alZ45BXe6xq895vY5kIhwws6Jjcp2ReFF+J9tSSZsxl2jDBFBzn/Yc1sTITuKnwb2q+B+th+4fHadT2TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlTxjbn4; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso2906273a12.1
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 03:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770031967; x=1770636767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIhY4QZTPPdLq2TRpxo21LNBMq6aPIcLWQcnhCbf1Bo=;
        b=VlTxjbn413Wcg/5t9WaxzuKc807qJT2yfGDZ7aJZeaiwbxHX4kLgjhRW9tRBLLdsPp
         7GK6ssVzPuXE/TecoIjj/i/ZGrHAEk2yS1WUqFHnsSsKgpSLcI3O1CWdR+HyOW9edlDb
         SEDMZqj5E/X0JWNs/kPgLwPLiH3MocrwJCCsOiMxpofwPVzO0pS0AXPiqvWGaFfVGska
         4HPKjBBxzjdZg/P+9HCYoE0nsL9PSUPfeHs1pBGmGQ2F/4P2E8bfD4KhJrv73KEAJ0tz
         5QYZRbcudcR698ATxaVg+aJt/70hQZ9xWgfH13ppJEdZ7WBj7B4p8jzEq/Yf3UJuekmF
         Zj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770031967; x=1770636767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iIhY4QZTPPdLq2TRpxo21LNBMq6aPIcLWQcnhCbf1Bo=;
        b=Ici7kO6qYhQ6FeFl0FgD5wnVk8CHeXkkgjobrfKtgMPKdgkGhKpImXQIUD72Lu/Ubt
         UFIj0ABW5KoMO0CiOWxJJB7Q94xAOZGhRN07kBaGIKyMlgW9eTGMw0f38cpoUAArVVvA
         jckh2mo1XgRgh4kSFE4/flh24PdacSo8enieQSUT4bxIKRssHf/RiCAemRK46oR+ar5E
         D0uy261Uo+GSs5NlX3plbUZ2GESiOxW0y/zRt+kUOQ0TDKeN7kFPs+4AcSBYOp5KtFQS
         Xdm8OaQl+iIPe6orunPlC/RJ1MuWruESBB2DDOUATSu5jkZohQNBB++RiT1EfAX/t7Ou
         xbhA==
X-Forwarded-Encrypted: i=1; AJvYcCW5pNN+5PsQoQ0NcE/wJJrZtQSW29bjkSxjD4VHL7DXRophTI+Hn7d0q2hNJgkFtzQqV13cnic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVP+WmmKktJFMkdGViPR++MQsHU9L2tf8ne22YKQKNzH5re+lC
	VCWA7M+/y8gysaGxOf8ii1eSfLrsiEgWQj5msz0wUjmqniYKA4ExAHp2
X-Gm-Gg: AZuq6aK7rKhgVMRyZsBZqOHTu0z+WPjBlgtQ6GQwoZxObJvzwy4wgU3tpUOdH7N4CfL
	GNWmw7UMpLg2C+XI+V00MmZGpok4otskMqkuPBwpSn2YzMws+IxKKb7k31QtB7OjwCHBr1lbRAM
	tcpfFim+ODpLcA8QNRZvpmNVY+6PTy8nkYad1r+NSnIpE0zI3LJuOQ19Gkhk4YDut3QPIN2TQtC
	WRJe9cGgyl+1gDg6/L6gb3PQwkEslNJHtzRsdF8+2kkU4I4jAAWyXrekvuqbD5Jl36cfvcUo7l+
	xZfxLOde8HACD9emZkMEH7i+6buzYwhkpoZudTuqHLtwIpE5psaU9OrJsg3/KOh1Wu8FoolRnv4
	80H+Rexone896Mi4uDOVyPYtiq/rv/fymHU+y3+Ft/Ol+MUVaWxUB6lfXqZ2CFoOj3Q/qXc3pIk
	qRZEqbhUVS8DbAfdfwjtDvb33GFEk8jDD5yU93Jo3y9t2drnKR
X-Received: by 2002:a17:90b:2e10:b0:32d:a0f7:fa19 with SMTP id 98e67ed59e1d1-3543b39c961mr12734825a91.17.1770031967103;
        Mon, 02 Feb 2026 03:32:47 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f539dsm13743190a12.26.2026.02.02.03.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 03:32:46 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 2/3 v2] drm/exynos: vidi: fix to avoid directly dereferencing user pointer
Date: Mon,  2 Feb 2026 20:32:33 +0900
Message-Id: <20260202113234.183393-3-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202113234.183393-1-aha310510@gmail.com>
References: <20260202113234.183393-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,kernel.org,samsung.com,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-213062-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FEE8CBD2C
X-Rspamd-Action: no action

In vidi_connection_ioctl(), vidi->edid(user pointer) is directly
dereferenced in the kernel.

This allows arbitrary kernel memory access from the user space, so instead
of directly accessing the user pointer in the kernel, we should modify it
to copy edid to kernel memory using copy_from_user() and use it.

Cc: <stable@vger.kernel.org>
Fixes: 221009347844 ("drm/exynos/vidi: convert to struct drm_edid")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 1fe297d512e7..601406b640c7 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -251,13 +251,27 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 
 	if (vidi->connection) {
 		const struct drm_edid *drm_edid;
-		const struct edid *raw_edid;
+		const void __user *edid_userptr = u64_to_user_ptr(vidi->edid);
+		void *edid_buf;
+		struct edid hdr;
 		size_t size;
 
-		raw_edid = (const struct edid *)(unsigned long)vidi->edid;
-		size = (raw_edid->extensions + 1) * EDID_LENGTH;
+		if (copy_from_user(&hdr, edid_userptr, sizeof(hdr)))
+			return -EFAULT;
 
-		drm_edid = drm_edid_alloc(raw_edid, size);
+		size = (hdr.extensions + 1) * EDID_LENGTH;
+
+		edid_buf = kmalloc(size, GFP_KERNEL);
+		if (!edid_buf)
+			return -ENOMEM;
+
+		if (copy_from_user(edid_buf, edid_userptr, size)) {
+			kfree(edid_buf);
+			return -EFAULT;
+		}
+
+		drm_edid = drm_edid_alloc(edid_buf, size);
+		kfree(edid_buf);
 		if (!drm_edid)
 			return -ENOMEM;
 
--

