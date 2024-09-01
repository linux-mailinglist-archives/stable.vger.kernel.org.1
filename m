Return-Path: <stable+bounces-71883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E2596782F
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AE4281297
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDB2183CCA;
	Sun,  1 Sep 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QW3twAj/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B7183CD8;
	Sun,  1 Sep 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208130; cv=none; b=MPfP39jS1WGlSGaiN+Q8QTrSUZfK28yQfbc3LuFWUG8ONY7WXn5ChXcdVU9tFnvuU81w1ZgwQ27fTV44JsPrFi/Z4f3Gx/UuekAq7llnYjXvlG0DoGzyDgXzGtNVGNwrD2EeBp0AD6odhtjsaAi7FoN1AIl4Y//O8CyrcbK7vVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208130; c=relaxed/simple;
	bh=NhswI00BNejjWFrpLKFFOkJslFdubdImJn+hgsMWAxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5WxoWbMMBEmwObC4QMZJrMlxqHuvtOCuTZU5mmB3oJMyWXE7XJt9JgjzNksq8HJzIvXpcD6gwKLk3z1KXvx9xeoCSIpEVjMYkL7/edFYmjiifg6lsurqUhgzR3fhWadlHYXX9z7rT5gs+ImqV4C6kCxO9tqmvSpWGx3af8mPyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QW3twAj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376F0C4CEC3;
	Sun,  1 Sep 2024 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208130;
	bh=NhswI00BNejjWFrpLKFFOkJslFdubdImJn+hgsMWAxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QW3twAj/OFmHxYTTJ2PizXZfiprA17bOWs1mTZ4GRncokZkMdWW8ut9+ziaGMQJKn
	 DpTFfW+2+zcVDz+UK/tveZQ4Td2PJbHUVS1Qi20EBdZlboEQDxzsAXZbpRKFGg9Hlg
	 I73W4Tw33fmPhLGA8cc3KzP5clwCEj1GRNW9VFso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH 6.6 82/93] usb: core: sysfs: Unmerge @usb3_hardware_lpm_attr_group in remove_power_attributes()
Date: Sun,  1 Sep 2024 18:17:09 +0200
Message-ID: <20240901160810.822209140@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160807.346406833@linuxfoundation.org>
References: <20240901160807.346406833@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Zijun Hu <quic_zijuhu@quicinc.com>

commit 3a8839bbb86da7968a792123ed2296d063871a52 upstream.

Device attribute group @usb3_hardware_lpm_attr_group is merged by
add_power_attributes(), but it is not unmerged explicitly, fixed by
unmerging it in remove_power_attributes().

Fixes: 655fe4effe0f ("usbcore: add sysfs support to xHCI usb3 hardware LPM")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20240820-sysfs_fix-v2-1-a9441487077e@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/sysfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -668,6 +668,7 @@ static int add_power_attributes(struct d
 
 static void remove_power_attributes(struct device *dev)
 {
+	sysfs_unmerge_group(&dev->kobj, &usb3_hardware_lpm_attr_group);
 	sysfs_unmerge_group(&dev->kobj, &usb2_hardware_lpm_attr_group);
 	sysfs_unmerge_group(&dev->kobj, &power_attr_group);
 }



