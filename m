Return-Path: <stable+bounces-101391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41619EEC2A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEEB11886980
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6186E20969B;
	Thu, 12 Dec 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pwNo82pe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3001487CD;
	Thu, 12 Dec 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017393; cv=none; b=qsbBGl3N76DEUs74KdK0eDpBGuix4DYAnnnNhNkoMvJvqGHFJMQG6yM2e45RF86Wd3T1RUw3Sck9wxhd29nBz0NThQJ2SvNc0ggBPxQ4jqxVr27ZPkIJZv1ZE9qGMInUfuk2Dr6vOTV4XOWUEVpxItPCxTF8v4Of45700HAB7yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017393; c=relaxed/simple;
	bh=6DYEJjS3Wq9dA3bMwkLcNacnE62oOXLUz7PNhHuQdtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMczst/Vsk477ebbe4hv0DTjxRQDE6Ca1el4Xa8FfI8LhlIHK8QGYBA5eFPJmban1sK0+96IvE0GRbLZGlkfyNI1pTyvRnNhFwqFSUxR89L5JcjvAjkskovOxTe2h95DxTw4BB2Lppah8dxvtoodKuN6tFbliL8sEWwwL1gGkjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pwNo82pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBA4C4CECE;
	Thu, 12 Dec 2024 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017393;
	bh=6DYEJjS3Wq9dA3bMwkLcNacnE62oOXLUz7PNhHuQdtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwNo82peu9ON8UTqlW1VIxgReF7BSE+hq9fEtmuToIz+M5OpZND+N5DWGh0QTS46D
	 AklyET/SfUJK3f7qu9febSgv3zmHUWzd7xRv15h9CK/z+qU8F9kdVrNPXgg4reT14q
	 CfSR/DGwjWWhrrZINBXOs1/EvHfGlmWY7OgnZ8y0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kinsey Moore <kinsey.moore@oarcorp.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 6.12 455/466] jffs2: Prevent rtime decompress memory corruption
Date: Thu, 12 Dec 2024 16:00:24 +0100
Message-ID: <20241212144324.847378288@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kinsey Moore <kinsey.moore@oarcorp.com>

commit fe051552f5078fa02d593847529a3884305a6ffe upstream.

The rtime decompression routine does not fully check bounds during the
entirety of the decompression pass and can corrupt memory outside the
decompression buffer if the compressed data is corrupted. This adds the
required check to prevent this failure mode.

Cc: stable@vger.kernel.org
Signed-off-by: Kinsey Moore <kinsey.moore@oarcorp.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jffs2/compr_rtime.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/jffs2/compr_rtime.c
+++ b/fs/jffs2/compr_rtime.c
@@ -95,6 +95,9 @@ static int jffs2_rtime_decompress(unsign
 
 		positions[value]=outpos;
 		if (repeat) {
+			if ((outpos + repeat) >= destlen) {
+				return 1;
+			}
 			if (backoffs + repeat >= outpos) {
 				while(repeat) {
 					cpage_out[outpos++] = cpage_out[backoffs++];



