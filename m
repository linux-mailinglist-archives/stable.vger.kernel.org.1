Return-Path: <stable+bounces-178045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E522CB47BE7
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 16:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04623BA8ED
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 14:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF24F26E6FF;
	Sun,  7 Sep 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6LupHcw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCDF1A0BD0
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757257097; cv=none; b=a6RpvV0cxRiK/RQ/C+43Zv0cHXXtNLM/mOrRS10cEosA0XB6Fy4Ta0Y2SfLCl1UU0HEKy21kuNQduJRXzNQUOi34kmMqFVyJ9ADdhu4tGsMAx82Yke2AK7DL/LoNjJ64l7KhC+WLHO8z1RJSa51RDPijiKKXuzcA0G8UQwGQAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757257097; c=relaxed/simple;
	bh=kdvlffME5iCfRo5GlNwUpJUM2z++oGufwG64qiHLfTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJ8abCaqWQ5yka1axZjywQYK65s5fB21etLpfTCNhWTYZGrHT1IXVnZ9c8mkYnXqi4bc64H0jOSlbxMSTctVCmLpZNnm4qWNJLfLM3DFCXqnWK+FrDOQF+1HUUZD87Kp1mPvUs1wxiWTy6hvYEeplnhmUv7WYhCBpT3T8Q+E4dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6LupHcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E262FC4CEF0;
	Sun,  7 Sep 2025 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757257096;
	bh=kdvlffME5iCfRo5GlNwUpJUM2z++oGufwG64qiHLfTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6LupHcw4XbETyh/R4+zOtTpBkVgODlYIW0xRGXRc9HoprbnlQ2hWsQkC2CKUO9w9
	 8KQIGCmBK+c4nimIKzBJyOsaJA3tyNl/TCqBm1nneSt9FIDeMVpr7gEQIQRo8TlEak
	 BgAq3Uab3h3VPPCHBbim7id9Ovb8/2LgAB7b9BLuErT2pxsmLcUF4ZT28Vg8KQkbp4
	 LSs/Wp+vxQmMeKDHq3hNIoT5UKMO3b7inQy4O5cxyD3XuE9DOEOpe1EpFpbjTyf5oM
	 wcamXiklRR93dU3P3ulaIkBZZaRkyjj7m2Ouy1jzsWIJiwkxYKQYF6Jg31nZ0mmvDs
	 iRaQykTzg+iDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] cifs: fix integer overflow in match_server()
Date: Sun,  7 Sep 2025 10:58:14 -0400
Message-ID: <20250907145814.636984-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041700-valuables-hardened-45b4@gregkh>
References: <2025041700-valuables-hardened-45b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roman Smirnov <r.smirnov@omp.ru>

[ Upstream commit 2510859475d7f46ed7940db0853f3342bf1b65ee ]

The echo_interval is not limited in any way during mounting,
which makes it possible to write a large number to it. This can
cause an overflow when multiplying ctx->echo_interval by HZ in
match_server().

Add constraints for echo_interval to smb3_fs_context_parse_param().

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: adfeb3e00e8e1 ("cifs: Make echo interval tunable")
Cc: stable@vger.kernel.org
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ Adapted to older CIFS filesystem structure and mount option parsing ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 2c0522d97e037..5fc418f9210a5 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1915,6 +1915,11 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 					 __func__);
 				goto cifs_parse_mount_err;
 			}
+			if (option < SMB_ECHO_INTERVAL_MIN ||
+			    option > SMB_ECHO_INTERVAL_MAX) {
+				cifs_dbg(VFS, "echo interval is out of bounds\n");
+				goto cifs_parse_mount_err;
+			}
 			vol->echo_interval = option;
 			break;
 		case Opt_snapshot:
-- 
2.51.0


