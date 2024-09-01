Return-Path: <stable+bounces-72030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CD39678E2
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2A628204A
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E9617DFFC;
	Sun,  1 Sep 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VRLynRt+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE7537FF;
	Sun,  1 Sep 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208611; cv=none; b=sYGi6sTOG2RAdZyh9L3Zw0ofZKcCI3ndyTN7RVVnF5D0hdorWpVjMCSG9I1NaDPli7t6JUj/LU2JEkYRS2a4IiI0zUUx6CXlPwo/6nIS9t/N+n1x1nvscgntjR1U8kkYY2xky+Xoz3sfTMkNYACzUuWvVpNCabqgDMFkdVj5/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208611; c=relaxed/simple;
	bh=xrxce+bHGoxv66bs6QOR7SunB0xwxLAMsUJNpXMIlxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jt4L63r5pysBnKchS5ECNClm9ij8qzCgyCfRu37iI5w1j9UFstM15YkU5vLwuj04NE4bj7RsT/xnV1KmJ3dtJcXimNr5uOhs8pDrgTS/UMMu0MWT2RUCtftaosOjzXsJwxbQ+0vhLZAiRTmrPo/z+YSz/tNgCz1G7ftlX3RtrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VRLynRt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C88C4CEC3;
	Sun,  1 Sep 2024 16:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208611;
	bh=xrxce+bHGoxv66bs6QOR7SunB0xwxLAMsUJNpXMIlxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VRLynRt+XjyccWUVLkv5lzsQYtFWbqAwUZ461i6nUmtmctW/pbCTAGPoUR17rqrpV
	 RWnvFK0Y+cpdvTBNbbJVMn+tqClIVDXart8GUqetcm3NmQqwKUR5+3jYZR7trGlgAO
	 0NJZWzndQrZEv5y96VhoN/PBt8hdkcDw7SzzWj8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH 6.10 136/149] usb: core: sysfs: Unmerge @usb3_hardware_lpm_attr_group in remove_power_attributes()
Date: Sun,  1 Sep 2024 18:17:27 +0200
Message-ID: <20240901160822.563845516@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
References: <20240901160817.461957599@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -670,6 +670,7 @@ static int add_power_attributes(struct d
 
 static void remove_power_attributes(struct device *dev)
 {
+	sysfs_unmerge_group(&dev->kobj, &usb3_hardware_lpm_attr_group);
 	sysfs_unmerge_group(&dev->kobj, &usb2_hardware_lpm_attr_group);
 	sysfs_unmerge_group(&dev->kobj, &power_attr_group);
 }



