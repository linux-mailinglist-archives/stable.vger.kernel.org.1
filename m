Return-Path: <stable+bounces-232273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLN5NNL+y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-232273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:05:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F3836DD54
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 781A830A587A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCAF425CD2;
	Tue, 31 Mar 2026 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K45d2xG9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F122423A9D;
	Tue, 31 Mar 2026 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976323; cv=none; b=Zjbm9k0MP9q+RzloIypSTMV+cH5reNxX9E5GRFL83dfaP+Z5lH0SbAdZQwIhiIrlPXQxMyJ2sTuLpmyX5MPmAiN1Wb6j2vhJNw4rptnvcgd4koGYrkJg+AlSbKskCPIsu5ArUr/0J7AOe7JzuXPNNrR9vcGsK7SNGhpD9S7JRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976323; c=relaxed/simple;
	bh=h9ag9SSiuUbhQbjuuAgPmrCVMs8JdnMUt50zIIGepDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2Hb9dwYlVy5G+cUclWjxl8HDqTXcY10T+Achf2/Cvjhj0xBTy1RVRLt1iI0xAR2ysG96eob92gtm6WUtK2UCotUNlFOcrm680OFIafORCWvZWDKrg5ODFBdoAmla33xZ5RRZztABwg5udQaHEK+2QkPJPUnrgi0trV0G2b+uPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K45d2xG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17418C19423;
	Tue, 31 Mar 2026 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976323;
	bh=h9ag9SSiuUbhQbjuuAgPmrCVMs8JdnMUt50zIIGepDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K45d2xG965XG9UpsyRzgwqTCcbCeJo5cKIenOj7OqZA9yPz6VI/+84/ABNeDOauLg
	 0i++T0vJH7hA98i5f+AnK+Q/+5hvnqtNyALixyeozKWEvm56zkYpGJDSrbqzCnQMiH
	 9mVXeOONwtPH0lmHF7Go13UcC1AwRkoK8Gd99VxM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Isaac J. Manjarres" <isaacmanjarres@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 048/309] dma-buf: Include ioctl.h in UAPI header
Date: Tue, 31 Mar 2026 18:19:11 +0200
Message-ID: <20260331161755.253751667@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232273-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 61F3836DD54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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




