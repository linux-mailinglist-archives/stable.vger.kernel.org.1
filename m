Return-Path: <stable+bounces-207582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0890D0A0B1
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30EAD303EEF2
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D03A35BDD8;
	Fri,  9 Jan 2026 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mkB+QL7/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB6535B15C;
	Fri,  9 Jan 2026 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962465; cv=none; b=g0H9ZQaBQgXCtrt7ZpzaBfFjjroX6gO/8qUh1n2I1Xsw8FnsrFQYuIwnpbIeFvyD98xJGdEeVE1ecPtBEoh5555Uy5sa9q+2SySEAj91w3ZI9qEJyj0+rB+7wsi9Q3rYeD+Aqss395Tn4wcuC7iYhebUc51lMLIgHoVFt3y9Xcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962465; c=relaxed/simple;
	bh=9QcYY1CoNVPMgSRS1qbYwDEnC8AuuY8k+rTO0AzVLv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnFyqh75LLLz6R3LEL0uMZHQK9A4T1tuAmEjd/ghmukpEgYy4DmJ596LxRcbGdJjNwQL9keNCC5d6YawC/xZpE8z5eg59lIxRMoRl1N40pvuHmThiQow7OJ5rbnzIEiOoVHMR57aFU13i9bFcjm70RB4zAlYZy5V0B3CmZl9JcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mkB+QL7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA0DC4CEF1;
	Fri,  9 Jan 2026 12:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767962465;
	bh=9QcYY1CoNVPMgSRS1qbYwDEnC8AuuY8k+rTO0AzVLv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mkB+QL7/tWQ9SSYPh6qphDcYl+83J92zMA2bueO182In0DDA2BdCWo5vr0reOyp0X
	 MvIT8PKRif8430zc83N1nfCmzgCt/K0Cs9mqPUud86i6q7DXBQAyRJ/FSLksjp6Ny+
	 gVrkuutsFycCwdmn3OAttlXtU5gAa4yXahiY/5ng=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joshua Rogers <linux@joshua.hu>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1 374/634] svcrdma: return 0 on success from svc_rdma_copy_inline_range
Date: Fri,  9 Jan 2026 12:40:52 +0100
Message-ID: <20260109112131.603629400@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joshua Rogers <linux@joshua.hu>

commit 94972027ab55b200e031059fd6c7a649f8248020 upstream.

The function comment specifies 0 on success and -EINVAL on invalid
parameters. Make the tail return 0 after a successful copy loop.

Fixes: d7cc73972661 ("svcrdma: support multiple Read chunks per RPC")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -830,7 +830,7 @@ static int svc_rdma_copy_inline_range(st
 		offset += page_len;
 	}
 
-	return -EINVAL;
+	return 0;
 }
 
 /**



