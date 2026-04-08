Return-Path: <stable+bounces-234000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM0QMruZ1mmTGggAu9opvQ
	(envelope-from <stable+bounces-234000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:08:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E739A3C003A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E8C33008478
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D333D890E;
	Wed,  8 Apr 2026 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hWmlRc+o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400553D47A5;
	Wed,  8 Apr 2026 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671727; cv=none; b=s/wpnG0n8+ZZAdLTz90NUB2Jbv3Rhng+CN8PxjKTq1AiUM3mIfO4TYwDAiU0w6glScXL6b1gRhC8K47Cbb+sqtuRwgJH6qV7w5NwRPev5JZWLSCPuyUzSOMFUkigLmERjrBYpFuBiP5V6JY1qZ+7jBvkLnqjTb0+ljUkrk0RTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671727; c=relaxed/simple;
	bh=cOj3HOIhVtSkZrKg3nRCWxkUp0cFBbwlbhU+kKj2OXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSce6+ogbO9aItPovNVvVXy/N0D+YLVBCWnq54NicqssQRm6YL8B3xJJYzxOWc+X8wNr208kc2Zxq+amaxjac3DpBJw+WlpTikkdgJtPsWPj9DM1X2JN7KTMyRbc0LK2nm0IMozmugo3oDxhuwQw3o7XkiL7ry8cxciLmij84Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hWmlRc+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C943AC19421;
	Wed,  8 Apr 2026 18:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775671727;
	bh=cOj3HOIhVtSkZrKg3nRCWxkUp0cFBbwlbhU+kKj2OXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hWmlRc+ol7ClU3H8p1k0Rp3XY8o984gPimrDZjS1ixDfE1bL6zy6ejwHMqrOyg9hz
	 2pdWOH5Td33cm5VZIMN9FSL6Ta7Ea+Wrphgm08vY+fUWukLsAQJtDvQFIkOsETOFmo
	 CStD5YYVrReMrW2L35N2jO/+AGlDAXvEHex7/fgM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Isaac J. Manjarres" <isaacmanjarres@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 017/312] dma-buf: Include ioctl.h in UAPI header
Date: Wed,  8 Apr 2026 19:58:54 +0200
Message-ID: <20260408175934.374791285@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234000-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: E739A3C003A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Isaac J. Manjarres <isaacmanjarres@google.com>

[ Upstream commit a116bac87118903925108e57781bbfc7a7eea27b ]

include/uapi/linux/dma-buf.h uses several macros from ioctl.h to define
its ioctl commands. However, it does not include ioctl.h itself. So,
if userspace source code tries to include the dma-buf.h file without
including ioctl.h, it can result in build failures.

Therefore, include ioctl.h in the dma-buf UAPI header.

Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/20260303002309.1401849-1-isaacmanjarres@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/dma-buf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
index 5a6fda66d9adf..e827c9d20c5d3 100644
--- a/include/uapi/linux/dma-buf.h
+++ b/include/uapi/linux/dma-buf.h
@@ -20,6 +20,7 @@
 #ifndef _DMA_BUF_UAPI_H_
 #define _DMA_BUF_UAPI_H_
 
+#include <linux/ioctl.h>
 #include <linux/types.h>
 
 /**
-- 
2.51.0




