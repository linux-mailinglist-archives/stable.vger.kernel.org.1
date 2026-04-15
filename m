Return-Path: <stable+bounces-238138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBFhOjyb32kKWwAAu9opvQ
	(envelope-from <stable+bounces-238138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:05:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBA44051FC
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE56A3009890
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68DC2459CF;
	Wed, 15 Apr 2026 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Td8TkdgN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE4244694
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261944; cv=none; b=bkUuaEKBAYf1CSL4g6LjEkJTAZzrmyqYX1POpFmsNqphRW4xVJa/SPvRYasuIYBU2kW1yZ/oW/0Xb/usUjzTexoBnpR3SCVZ/Q5GCmAwZ/selYPYS42t9E/WR4s3UExfHNl1M3XW2AlJx2BGSVMCaBm8IbEE35k7A9xpp7bFuD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261944; c=relaxed/simple;
	bh=GinynodeLSk9D94lObdTgdnoKuabwLn1gG9SeHBc73g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrLPYLJBfmlQPM4UduDgg+5qiU8BAJ7IEgbgfAjhFiMghrOV0vxy01M9HRGc9QnqLeASvk3lzstdhLjvrWEwQOa6TKg2bIj1536dFCaMsU/5Aa0FgQM5/WfvQ/I6+TqOXRMWbPqixEzn50tHVQ5RCjcWsrKi6MlaXKJM6+SgUsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Td8TkdgN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f1f6103afso2123883b3a.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776261943; x=1776866743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JhMXx7gXY1dD+D+IXaFNdkEaadu4kqcUrwYP3v202/0=;
        b=Td8TkdgNUL3S2728oWs8+JT4U4ja7+cgoXTOZKIi/pW5txfPDOVcPZpjbHLt89RbKY
         0ZZYk/f0l1U+pbWJ3SuvBVm+rwluRqfDj/2zNE0vHKPv3PvXziEjo1Csy/3inLDp9F1n
         KL6tvxSvMK2yFqrrKVpZIqTA/X+LDkTMV5kIjJk22GG/b9e8dwq9cv3LhuMY4RL5FTuz
         SZ6kZrFVJb3aBuc2hqQuW2YO4dGxhBBj/W+rZsSzyk06OqCmRkNVXy7tQyGQ7QOVYLgB
         UaM4M2fYFdQ/rJfDHXEQzSCqTTAPpAj57rxawq9DEkS0yN6grmfDq7TokzYW+TM9/us3
         oPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776261943; x=1776866743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhMXx7gXY1dD+D+IXaFNdkEaadu4kqcUrwYP3v202/0=;
        b=UV2F0O7oej10yQyLZkwlEXRrLbUgm5eU1e0UqoFTrbiOEQdQhuseDddfeAo5VjR8mG
         IkBiUujZlKW5KbbMXdBPP9C6cUHjzBCKpubrgbFUFDCdz3+o5kChrfc0rVVIWGlHilwn
         OKks0L2iBskqc/qYwNEv0ipHHGn7imtAbaK5jyjfZLRmYNSQT9lkeWh7vO1sBHCgBVRG
         AjpPNLdbRzfjihtY/4mnS3B7881lEACs40odRUp7iv4ak7FdAHne/NHH7FAlZB0B3GSK
         q/f8L6aK8UCuaRi/Lh9jUoqLK6YjKwYFcJsMZmFVbzvvCGnfIsCgSIDL+v6DWHJK/O35
         XyZw==
X-Forwarded-Encrypted: i=1; AFNElJ97joNubITbIatJ7rkqnXZ0zdQVFU1Aa3x/YbrXZqlWeybSDP5Zt9tYGpjp2gpP+4FOhj3juPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznkKO+F3XpZiZ2wrj+YV0QrvtxxnhL3i5do7GOlp66rs/bYbv9
	OKiIyRQWWH5C5/G+0I3aAoUB6bxep2d55Fz42gVnzOS6rURAuTD+eM4w
X-Gm-Gg: AeBDievBIWrB1DpuNuNyVZUI/Jf+Oy0OZBpX5fsM5mM1ndfxRZqdsJTU15TU5NcVMcr
	SsmqFd7qOaerkQn6Dha5miT4hCsWazbnzxUIe3sT5GQJjDpTR7aj+HhQE0uSzfa+abrb58iitf8
	WatuwuQm0/Zme9fgzz9MPcxeO3zuKNn1I7vqK5HGfI+xOuskR9bzD/eCZQublYCsN+nfSY8WTbq
	eUlQcVXkgpEeEfXnHSEM/jTm6ygJov8+ys6Y7IktWwisLpuT4I7q8l60KlwlKDo9k4X5Up2lQ/s
	FPupfpBWJfFEgmfWXo/zWIVpZan1OnsBoJgpYUIvrbPJFYSw5sqwE0XEP7wzXVq9DbLs2MsYLHh
	deoqWZsIx0470QXcdK5AuVQhzMu8omb7UwInnCsEzaAHW+C4jHsXvTBb3ETsW2HZE9WbPDRDOgh
	SHX13mp+FSvGY4ySatVqSgz2I6GpoewF4=
X-Received: by 2002:a05:6a00:ace:b0:82c:e775:d43a with SMTP id d2e1a72fcca58-82f0c3562camr23289124b3a.35.1776261942884;
        Wed, 15 Apr 2026 07:05:42 -0700 (PDT)
Received: from lgs.. ([223.80.110.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67416319sm2178857b3a.46.2026.04.15.07.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:05:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform: fix reference leak in platform_add_devices() on register failure
Date: Wed, 15 Apr 2026 22:05:26 +0800
Message-ID: <20260415140526.3290729-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238138-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CBA44051FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in platform_add_devices(), the
embedded struct device in devs[i] has already been initialized by
device_initialize(), but the failure path only unregisters previously
registered platform devices and does not drop the device reference for
the current one.

Previously registered platform devices are cleaned up in the rollback
loop, but the platform device that fails registration is not, leading to
a reference leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review. Fix this by calling platform_device_put()
for the current platform device before unregistering the previously
registered ones.

Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/base/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 75b4698d0e58..9a4ae2100401 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -548,6 +548,7 @@ int platform_add_devices(struct platform_device **devs, int num)
 
 	for (i = 0; i < num; i++) {
 		ret = platform_device_register(devs[i]);
+		platform_device_put(devs[i]);
 		if (ret) {
 			while (--i >= 0)
 				platform_device_unregister(devs[i]);
-- 
2.43.0


