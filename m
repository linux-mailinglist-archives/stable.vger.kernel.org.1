Return-Path: <stable+bounces-210868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODumBMsvcWmcfAAAu9opvQ
	(envelope-from <stable+bounces-210868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:58:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9132A5CB1C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EC42B2721C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBD439E171;
	Wed, 21 Jan 2026 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F93rlHcD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425FE315D48;
	Wed, 21 Jan 2026 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019657; cv=none; b=oYTU94MDdGSg8is06QpDbRiGnGtgOF0fcOD/6v1dea/jBtuZQlPTAH0Gv9kZT+cOPPnpxCAc9InbjapMVZBRQedHGLtB5MC78QYwyZBRD6l5RNZ7qmOY+BkWO9ul067TTUc2zaP3ykZEpJNF+ggE5Maj7J1Zi/9wWA8DxH0xX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019657; c=relaxed/simple;
	bh=CW64UFivDkPTDultkNbw45YzVtHIa5/avhvLOxkTy4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ex/X8zIj6u7E1XK2e62LCuUyFSmzYJM1TYnhfoXajr0+h2eRICtHTMulGVE7wmuoyLA+HeZ3l4/AK2IYbty8j/HWD/qCIPYo2T3uTs6pHqjJebCWo7DlkbWFqsCpHkIuwN4Km+lRIzTpsuhZeafc3A51ohouoi+WWdiqnfmpkoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F93rlHcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6ABAC4CEF1;
	Wed, 21 Jan 2026 18:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019657;
	bh=CW64UFivDkPTDultkNbw45YzVtHIa5/avhvLOxkTy4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F93rlHcDR2tuAUrEU/CDdUA8haP6f/XztUG6FdW1n1s/9yggK+0tDDZ1EcwOvAfwY
	 OwczPXa3u6iXVIISTvJRTTiQd06mqMZf+C1txAdgvhkn9LumyJLmsdZhqjxLgwt8yi
	 MPwaccsSk14foSx1YhramBk9GC4DITHWgQ0DJdRY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.12 070/139] xfs: Fix the return value of xfs_rtcopy_summary()
Date: Wed, 21 Jan 2026 19:15:18 +0100
Message-ID: <20260121181413.974179703@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,lst.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210868-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,lst.de:email]
X-Rspamd-Queue-Id: 9132A5CB1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

commit 6b2d155366581705a848833a9b626bfea41d5a8d upstream.

xfs_rtcopy_summary() should return the appropriate error code
instead of always returning 0. The caller of this function which is
xfs_growfs_rt_bmblock() is already handling the error.

Fixes: e94b53ff699c ("xfs: cache last bitmap block in realtime allocator")
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org # v6.7
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_rtalloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -118,7 +118,7 @@ xfs_rtcopy_summary(
 	error = 0;
 out:
 	xfs_rtbuf_cache_relse(oargs);
-	return 0;
+	return error;
 }
 /*
  * Mark an extent specified by start and len allocated.



