Return-Path: <stable+bounces-140678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3442AAAAB8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2273B86CC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393222E3364;
	Mon,  5 May 2025 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfCKhlns"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A2E3703CD;
	Mon,  5 May 2025 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485896; cv=none; b=K1+oeCw+q4Se7KKZ6cVJm/ys1PBgdLnBVGxrCFeHovLt7VUaw+tr3CWGsmC5jSno5bjUXv4hfh9yWpLDADqjyj6X/9j6IXTP8XzZ8Q9uyUheMvG289xw3MKOwfgEjc+n5+6BtRV7reRx1oxQOpwwRn45w/WBLRSj5LiLsP/DkMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485896; c=relaxed/simple;
	bh=iS17x7C6Yv5Pzl69bAuVAl+QGDqZ/gO3MdHxIcG6fw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g9hzvHKbri0tMIBLKOum27mkaeZvWJhQJeIE0V4YI9wQ4vK2Bmx+/q7Bk8ZeZoLaecPLqz+yyE/16dVmxhrkivFkRpf7Q/v3tf94WKIOsv+Eg64wMczeW5VcbQocspHZJwqrlyTuupl6reayr5VX+9+Ar66nZJAWxCtLxlNrF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfCKhlns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4170C4CEED;
	Mon,  5 May 2025 22:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485895;
	bh=iS17x7C6Yv5Pzl69bAuVAl+QGDqZ/gO3MdHxIcG6fw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tfCKhlnsEEPICzsfpKVNqo+3893UZqvnBDNYktXrBBt5d1BO2GB711K4p5YH2Tun9
	 bnf45VdSjA8YO2t8fYfF7TpQ+XLQ5nC6VeZ2tff7Nmep8RIJGxY2MO/M10U9/JSqJO
	 ZxZuxU75zr6eRF0cvqbPRWT3o3NOif8uoi9QbMdGCELhWKEFsz3tXfCpFoedwMU9ol
	 UB5ODqsGM3YB8Am05KmkP/FfPiWLZIfiDY+bGRPspVTR0tikrm5cuRPY3fjN6KyPj2
	 t7XzcfIoLJgGVMxnmm4vMJJ1s7AaVJ/HNQgUQzsZUeeSEoAjMZvgddq6qvn6uyW/nc
	 M22MZSafE36DA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heming Zhao <heming.zhao@suse.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 053/294] dlm: make tcp still work in multi-link env
Date: Mon,  5 May 2025 18:52:33 -0400
Message-Id: <20250505225634.2688578-53-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Heming Zhao <heming.zhao@suse.com>

[ Upstream commit 03d2b62208a336a3bb984b9465ef6d89a046ea22 ]

This patch bypasses multi-link errors in TCP mode, allowing dlm
to operate on the first tcp link.

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lowcomms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 0618af36f5506..3c9ab6461579c 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1826,8 +1826,8 @@ static int dlm_tcp_listen_validate(void)
 {
 	/* We don't support multi-homed hosts */
 	if (dlm_local_count > 1) {
-		log_print("TCP protocol can't handle multi-homed hosts, try SCTP");
-		return -EINVAL;
+		log_print("Detect multi-homed hosts but use only the first IP address.");
+		log_print("Try SCTP, if you want to enable multi-link.");
 	}
 
 	return 0;
-- 
2.39.5


