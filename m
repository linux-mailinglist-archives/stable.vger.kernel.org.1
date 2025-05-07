Return-Path: <stable+bounces-142615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B52AAEB81
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C401A1B673DC
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E433528DF4F;
	Wed,  7 May 2025 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w0u1D+Xj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5228C845;
	Wed,  7 May 2025 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644799; cv=none; b=u3c2O5j/yBoNUB37mYrvweY0/acHg0yieq9lMzWwTpDMQQPDdw2ub27XUtHBvXCAMJOFfGbP7ScLxlj1QWVbKaOe0SMo9rjVooQ/UdjyhDZJ4/Z8CGL2+Y6UcOFiTMWFV0AewjjipeL7fTm3Tb8Kp7dL7I9smpwDP2zuSWyHKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644799; c=relaxed/simple;
	bh=qRfEYaBUbQ23BQOWox9uL7pkBow2+uBjskgU+PW23J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pV3bqzwZ1fK7zWt5DQAmIq6o+NO5V+2+4IL1i/W5ckVxrDus0IywutdGi+p/gzF9JaIp6ftCdvjOJNv/Y4QYxJl/JgSiUtt4SjANZO8vAfkuEtRAXpKmlEim31rbpAtX3j5L7UkkXhq6Am4AmybbVC7RVp1xQzTuT52VOZ2Xv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w0u1D+Xj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C92C4CEEB;
	Wed,  7 May 2025 19:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644799;
	bh=qRfEYaBUbQ23BQOWox9uL7pkBow2+uBjskgU+PW23J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w0u1D+Xje0yis0ozOr+R6u/Us1Vy5ms5cax1BEVisVPj2EtCCJ2BxlyqQ6RFqd3Vb
	 W/d05Q+HfFrEtW1QPaFNjXHxUj0jZelh81iTFEdHNjH21bL2RxsyimoriXuKMdPQ9K
	 k9zRcbKHCatBBaSbuPrM3lgEOigtmEgnveVwYUUw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alice Ryhl <aliceryhl@google.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 153/164] firmware: arm_scmi: Balance device refcount when destroying devices
Date: Wed,  7 May 2025 20:40:38 +0200
Message-ID: <20250507183827.164207443@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183820.781599563@linuxfoundation.org>
References: <20250507183820.781599563@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Marussi <cristian.marussi@arm.com>

[ Upstream commit 9ca67840c0ddf3f39407339624cef824a4f27599 ]

Using device_find_child() to lookup the proper SCMI device to destroy
causes an unbalance in device refcount, since device_find_child() calls an
implicit get_device(): this, in turns, inhibits the call of the provided
release methods upon devices destruction.

As a consequence, one of the structures that is not freed properly upon
destruction is the internal struct device_private dev->p populated by the
drivers subsystem core.

KMemleak detects this situation since loading/unloding some SCMI driver
causes related devices to be created/destroyed without calling any
device_release method.

unreferenced object 0xffff00000f583800 (size 512):
  comm "insmod", pid 227, jiffies 4294912190
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff 60 36 1d 8a 00 80 ff ff  ........`6......
  backtrace (crc 114e2eed):
    kmemleak_alloc+0xbc/0xd8
    __kmalloc_cache_noprof+0x2dc/0x398
    device_add+0x954/0x12d0
    device_register+0x28/0x40
    __scmi_device_create.part.0+0x1bc/0x380
    scmi_device_create+0x2d0/0x390
    scmi_create_protocol_devices+0x74/0xf8
    scmi_device_request_notifier+0x1f8/0x2a8
    notifier_call_chain+0x110/0x3b0
    blocking_notifier_call_chain+0x70/0xb0
    scmi_driver_register+0x350/0x7f0
    0xffff80000a3b3038
    do_one_initcall+0x12c/0x730
    do_init_module+0x1dc/0x640
    load_module+0x4b20/0x5b70
    init_module_from_file+0xec/0x158

$ ./scripts/faddr2line ./vmlinux device_add+0x954/0x12d0
device_add+0x954/0x12d0:
kmalloc_noprof at include/linux/slab.h:901
(inlined by) kzalloc_noprof at include/linux/slab.h:1037
(inlined by) device_private_init at drivers/base/core.c:3510
(inlined by) device_add at drivers/base/core.c:3561

Balance device refcount by issuing a put_device() on devices found via
device_find_child().

Reported-by: Alice Ryhl <aliceryhl@google.com>
Closes: https://lore.kernel.org/linux-arm-kernel/Z8nK3uFkspy61yjP@arm.com/T/#mc1f73a0ea5e41014fa145147b7b839fc988ada8f
CC: Sudeep Holla <sudeep.holla@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
Fixes: d4f9dddd21f3 ("firmware: arm_scmi: Add dynamic scmi devices creation")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Message-Id: <20250306185447.2039336-1-cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_scmi/bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 157172a5f2b57..782c9bec8361c 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -260,6 +260,9 @@ static struct scmi_device *scmi_child_dev_find(struct device *parent,
 	if (!dev)
 		return NULL;
 
+	/* Drop the refcnt bumped implicitly by device_find_child */
+	put_device(dev);
+
 	return to_scmi_dev(dev);
 }
 
-- 
2.39.5




