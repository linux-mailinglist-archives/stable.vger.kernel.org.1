Return-Path: <stable+bounces-142724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5AAAAEBEC
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1AD07ABDA1
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B3028DF1F;
	Wed,  7 May 2025 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sVfmtgnA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639928B419;
	Wed,  7 May 2025 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645135; cv=none; b=YJra6J2nVx/gOSQHmbB2QzKCCFbM8CXet+2nPBDdiCLWb3D9iGsKBCPvyZpUgU9l7Lm8eRw9lueKGwwImn6jvhHX8wdUeffkcqXppdHW9ittj5y1yp1FL0BA9e8H62hI+ema0IL1pkwnewLos7Xn1bHV0lB/sHmZAvvCaWJwO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645135; c=relaxed/simple;
	bh=jchfiaik0GZ6RCUmewhHtkLj0J/4J+CvhdU0lTMJYmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcZWvtocyFmzBeW+0iCutSJ4Vy4apZJbY/3hlUgOUXh+VHMfDEdrJ0/CrnfPbrwt8g9HzyTGLPzSuelZ+NyxcvvEEhLJ3nIuwmhdPkIiZr3/USI+N7jw2MNjH3BnhRDiw6ZrZ/pjp043pSbOmZVKa/XA0c056yrmtbM+RZvsCVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sVfmtgnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0C0C4CEE2;
	Wed,  7 May 2025 19:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746645134;
	bh=jchfiaik0GZ6RCUmewhHtkLj0J/4J+CvhdU0lTMJYmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sVfmtgnAhXUaUuut8yQrlz7kz3QtUXVl3L42B/TrResKj/OlHOb7y5V02+FRWqY8I
	 CCAt+OqDz5EuBkNB0OavasmD//AKi9IZlKj55HJoe1Dh44MRhcTN3+aBqSnYjwfpuo
	 j+2J9ylF+yIF6kb89ENG8V40qrw04w9YE4yioMe0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alice Ryhl <aliceryhl@google.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 104/129] firmware: arm_scmi: Balance device refcount when destroying devices
Date: Wed,  7 May 2025 20:40:40 +0200
Message-ID: <20250507183817.711944559@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183813.500572371@linuxfoundation.org>
References: <20250507183813.500572371@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index dcf774d3edfe4..51eeaf14367da 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -240,6 +240,9 @@ static struct scmi_device *scmi_child_dev_find(struct device *parent,
 	if (!dev)
 		return NULL;
 
+	/* Drop the refcnt bumped implicitly by device_find_child */
+	put_device(dev);
+
 	return to_scmi_dev(dev);
 }
 
-- 
2.39.5




