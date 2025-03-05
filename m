Return-Path: <stable+bounces-120527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC96CA50734
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F697A8DB6
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB932250BE9;
	Wed,  5 Mar 2025 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="weXUBei/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624BF250BE2;
	Wed,  5 Mar 2025 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197219; cv=none; b=C1K8SCS842XAEl4xDksDZe7kKbAE3smlpDhmnIKY0CBm9OFw39UWh5bpgdw8YnfFylCLXlhvHxQ90ffnMNszuhaXs6NiZdGgsNVAOaMY4uk7BzW3iyaIjNW1YjzPBCD4W2oYm1lLq/MehQDqW+Vo4igjIt0agauIaJMpnCgDD9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197219; c=relaxed/simple;
	bh=LoUrU+2OcStw02D9xzUVpCC2HjuwN+pJ41hPECvvTG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpjBYTG5h3hvzmMCUXzkdXJa7Dg3qMTOQIIXCZVICg+PhOk4OZ+02z9q8cvftMobqjx4/6DLEGE8LBDNXWBpJiTHsHcDVmJhSE1qXJKIVOI2Fb8XO3goMZ/CJUALauGFhACdgDuQFsszkdmnB0Lybmqo3K8XqkV0L3jD0i/lux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=weXUBei/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C33C4CED1;
	Wed,  5 Mar 2025 17:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197218;
	bh=LoUrU+2OcStw02D9xzUVpCC2HjuwN+pJ41hPECvvTG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=weXUBei/P24nDRoDg1NqWCq2ILbe8mg6zd16/6JzrM318mD7GdU9uv1cykAoaHyET
	 HeicSeCcVPrkvOIdl8hXx883PgJ9Bw0XWQqAE0SqXHBdP3oQmis/eScCjRKNOiBrjr
	 K7jeWsiCrRFlR7FW5Tm65noB0YtqauMI5bVZKgT0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Zicheng Qu <quzicheng@huawei.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.1 081/176] acct: block access to kernel internal filesystems
Date: Wed,  5 Mar 2025 18:47:30 +0100
Message-ID: <20250305174508.719086372@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

commit 890ed45bde808c422c3c27d3285fc45affa0f930 upstream.

There's no point in allowing anything kernel internal nor procfs or
sysfs.

Link: https://lore.kernel.org/r/20250127091811.3183623-1-quzicheng@huawei.com
Link: https://lore.kernel.org/r/20250211-work-acct-v1-2-1c16aecab8b3@kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reported-by: Zicheng Qu <quzicheng@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/acct.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -244,6 +244,20 @@ static int acct_on(struct filename *path
 		return -EACCES;
 	}
 
+	/* Exclude kernel kernel internal filesystems. */
+	if (file_inode(file)->i_sb->s_flags & (SB_NOUSER | SB_KERNMOUNT)) {
+		kfree(acct);
+		filp_close(file, NULL);
+		return -EINVAL;
+	}
+
+	/* Exclude procfs and sysfs. */
+	if (file_inode(file)->i_sb->s_iflags & SB_I_USERNS_VISIBLE) {
+		kfree(acct);
+		filp_close(file, NULL);
+		return -EINVAL;
+	}
+
 	if (!(file->f_mode & FMODE_CAN_WRITE)) {
 		kfree(acct);
 		filp_close(file, NULL);



