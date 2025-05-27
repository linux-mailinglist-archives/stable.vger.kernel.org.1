Return-Path: <stable+bounces-146578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7DAAC53C3
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B808A1ACF
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9227FB0C;
	Tue, 27 May 2025 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DjUP/33B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089251D63EF;
	Tue, 27 May 2025 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364658; cv=none; b=iFLNI+i8lq8RjKsO0fSbdW3FwyXRdL4c0PrJfFuMNLAajWPXAqxncbz9gw5WEo7l4c3LeevIs2j0NUEsesA9WVe6Wh11sbO5zypJX9dQQ5z0iuBxiSeCYcVPFOEkzSs8v6cbJ7IWn6aT7Qv8dAqBBRqPWs5+nXkzFLapaZWZKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364658; c=relaxed/simple;
	bh=65JKhIMaOAz4TlcPdT4z1sqTMkbW7KrsVg2SxHAsU28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8/hSbxGvaa+DBlkQ0w/eD50OGmgBISQuWppEsd5O8iAvhQA3mfP5jmSM1OXLZJXfxcoQLdYMZgBmefON0TYSb4YbL53eP9Kc3ZmUCZAnYzAlPs4rZ89vNdbweXx1jtm1xFW6RTYadwpY3SqPy4tIivhwhLqVTR8hsVcXAVwjMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DjUP/33B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72048C4CEE9;
	Tue, 27 May 2025 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748364657;
	bh=65JKhIMaOAz4TlcPdT4z1sqTMkbW7KrsVg2SxHAsU28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DjUP/33BBKSPFjGWVPOGCqskJRELmDaFzCneLBZhXv3pJOgjoWB5m2WUCxgnRL1wR
	 bUG2YznkkC1SJAvyZOBhNbdDP21gTEsKBnYYKeIPfedOtyrq2PsURgXWZrn1/Vjb2H
	 2+HMPtcKHmZzMtz8V4ZPY5FtsHe5TMokFrjC/tXw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heming Zhao <heming.zhao@suse.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 126/626] dlm: make tcp still work in multi-link env
Date: Tue, 27 May 2025 18:20:19 +0200
Message-ID: <20250527162450.150324751@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
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
index f2d88a3581695..10461451185e8 100644
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




