Return-Path: <stable+bounces-253975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODo+BJIXEmo+vAYAu9opvQ
	(envelope-from <stable+bounces-253975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 23:09:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7633D5C0CC4
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 23:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 728733012CE1
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 21:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC78F2D8364;
	Sat, 23 May 2026 21:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+EyJyQJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2A304972
	for <stable@vger.kernel.org>; Sat, 23 May 2026 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779570573; cv=none; b=U7IS3qqygkoj0iEp5rdqQDKk4/v8uWHpFfei+rsTHT4/ObugGDbO06xKZpPR7hEloXJ4vOntq4JEeOXA3M/hVCzTHd/zmFBM7+OuWMaHGU5Xo4kelYj1KgNoPPMbXGxBCg7rJZf54+p6LhqjjOsN0uwCDGSX8oego9slR2Cq1PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779570573; c=relaxed/simple;
	bh=+lRJD2b0ZjqK9badvBf2tzZfwwSC1/C8unjjkSYiDBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGlIcv8yDkUJOu4hsj6eVZFOJsmaC+gS/pgY3pQ3OwXnWSeXw4Wrp+8wCzEu1xTA9KnoR4p6tsrf8Thtg8YDGy40kfZcCQHlFQ7eBtnK0YURsSN3UhLMm7FrHO8isw+C+mbbieiBcXcxE1yI9Lg+QWiKwSOMcdY7BAOQmY/JJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+EyJyQJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-835b78c3797so3714343b3a.2
        for <stable@vger.kernel.org>; Sat, 23 May 2026 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779570571; x=1780175371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lm8UJ4hOarUlviQr2levKNdmrXnb21bQJ59ovlralbM=;
        b=f+EyJyQJdl0ZTXVsdg31I5sGl8ZoIclMJIBzV1wntWRZ87wAHg7wSy1GbEMl0AXRkq
         1jejAYx7axBYLo1dkPWTo+ofYn+iNnCHXFbtDHCTbq5esHlxS9btYrSmsCnVjVJI3pTB
         5XHN1249BUcsj73JMcWV9BTXc0EU5CM4BA6UefpgpdEqXptOafEuMetNEZgZo5RRtap1
         QEJwmZV4I/U8TkONt+P/z9Z53QfbYkjPY8eCVqoO2aXLht+bZq/FEdX3HBC7uYveZPOV
         JdAQH6U36mqKmmLIaf/dEWgfFDfR2wzM5B/fYu49kyFzrIbt6DgFzae5lzZwD8M7p/0P
         JenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779570571; x=1780175371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lm8UJ4hOarUlviQr2levKNdmrXnb21bQJ59ovlralbM=;
        b=qWeo8vHjD6WoFZl8m828y61QMoJg0f+7esDC6+S53Mmqdhs78d5yQd4qG2RAbPutaA
         2LVCiakbxL6ghOeUVkRvSga9dU5P31iKe0qBnXUDRWWCMpee3ZoIRJdf8sxWOfCh4BdI
         LcwLGQLUYwW+DMEa747RsCqJtQ+4rmwNX9nt5xdh/PtFZyy9HvU7J06T1mXvuM5KWyGU
         S1gps8MjUYHMc1tOQIQPFFlgTxu8haBb83GUI8mP5DOX+U8cBbA9zIB7HwUhYMDLp/dM
         LFp+4AeHfHc4nE/bmaw34tVyHHPXIrwDX3L75evHDcvUpZGaUe6QZvkxDHIaHW+3O/zj
         smFg==
X-Forwarded-Encrypted: i=1; AFNElJ+UywbA3tcjnIbzKbnhQuWr6fK6INGEnUuGzpLQ+2VUBCyHqL/xTgf5tP86pUCFDGmsaev1BkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQeDe9TX3wplu1efptKhEK40vYwBD6Ol0kE8WjNHAfQBH0+z3H
	syv6E4KiAy50/z1SRBmuPZqfAOblXaxoWXbc1OwQFRKtVt9mrg6aCTLH
X-Gm-Gg: Acq92OHTH5KQo7TT3hz/V9ENxsJYBFX4hty+UwroiFIbJveJ8mkiqSBuRU0E4pr7g41
	FqTVecErXiC14mvaladjUt+41AzyYFXF3/GA4CHZe9jXnzAzo2jY4Tp1XVHNRNmzgfgebvNHEY2
	Kjo49sOePT6450Rc63SN5uCiUSkswPCNKMdJ3uWIPYlEMuhJpPn9UittoaC4GH15evAH1YeBpeb
	3lD140+ATMnLpJEWOSxUGcxcXESmb/Pe63sTlhJ2IEE/Uw9WnWmIpaZs36h/lsBfFSiwe+5vnsB
	tzop0UMWGupAfi7WKhfBi+GcjGxJCS8uRjHdEsCDTg9vAvKIaunONcln2wUVdFSCnqDIEeuVATc
	artDNhbi74wzogZcWDzNgcubgl6pBKXs84lOVFpK88T3s95MIAxUtLpCzaeeWgmdP75ac6cCcSX
	mex3SBT233DsuPSCEsiYvpzYj6MckDB/qc4vjauPqILQUHSSwtmHKredUed9eIP8K9FeqD7meet
	sP3dyrRYXm17EuPZ4N04d3QL5BQfdPvaJiw5UQ2y6gtAU/SpOWrY6EGEKF9Re56UBGb98OYUkH6
	9RDfFIAEWoo=
X-Received: by 2002:a05:6a00:2d90:b0:82c:eb46:acb9 with SMTP id d2e1a72fcca58-8415f308ba8mr8634533b3a.24.1779570571492;
        Sat, 23 May 2026 14:09:31 -0700 (PDT)
Received: from codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fc646bsm5406884b3a.46.2026.05.23.14.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 14:09:29 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	tzimmermann@suse.de,
	Frank.Li@nxp.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 1/2] accel/ethosu: reject NPU_OP_RESIZE commands from userspace
Date: Sat, 23 May 2026 21:07:52 +0000
Message-ID: <20260523210840.92039-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523210840.92039-1-meatuni001@gmail.com>
References: <20260523210840.92039-1-meatuni001@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[tomeuvizoso.net,kernel.org,suse.de,nxp.com,lists.freedesktop.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253975-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7633D5C0CC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NPU_OP_RESIZE is a U85-only command that the driver does not yet
implement. The existing WARN_ON(1) placeholder fires unconditionally
whenever userspace submits this command via DRM_IOCTL_ETHOSU_GEM_CREATE,
causing unbounded kernel log spam.

If panic_on_warn is set the kernel panics, giving any unprivileged user
with access to the DRM device a trivial denial-of-service primitive.

Replace the WARN_ON(1) with an explicit -EINVAL return so the ioctl
rejects the command before it reaches hardware.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 80d4bc21c28f..043541407a8f 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -433,8 +433,7 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 				return ret;
 			break;
 		case NPU_OP_RESIZE: // U85 only
-			WARN_ON(1); // TODO
-			break;
+			return -EINVAL;
 		case NPU_SET_KERNEL_WIDTH_M1:
 			st.ifm.width = param;
 			break;
-- 
2.53.0


