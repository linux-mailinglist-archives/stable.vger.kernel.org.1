Return-Path: <stable+bounces-37513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF9289C52E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C05028410F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A71174BF5;
	Mon,  8 Apr 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o2SVQbNg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB76EB72;
	Mon,  8 Apr 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584454; cv=none; b=Nv7iOQux+yI2ShFB2wjqLNxMbx7PskU9gdVtvhWlbsrBXoQTJjow6dfsxr+KdcL2RwKDgY8t7zlIP9PdqzZbHo7F2/L0xNh5B9LJBoPeCRDyfEmQpRY4DRX3HWKeADow3dCcLBsdxmlLqxviQJ1Hih+/xDSiDT5TDhGfTRLNeFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584454; c=relaxed/simple;
	bh=DR+C/O0RfWtla/eAWXjuZPwPm1ukHIQjuVmtaNyjGHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eljJ1NUTAq2MKc6TQZs5Le2H3V8lzZ/UdObeF9H9uZCd0GR9VltPeDkFXp1NFBWj5ALZebyFWE/LsBwY+t7E+ZcQJvFjAVtP+1MDgwbZDG43UxCN/sqMSdhG0q8CzGUIB4r8TGpCyRoHN0aEzonEryWGYtzWix/hrKc/VkkFSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o2SVQbNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E86C433F1;
	Mon,  8 Apr 2024 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584454;
	bh=DR+C/O0RfWtla/eAWXjuZPwPm1ukHIQjuVmtaNyjGHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2SVQbNgMz4Czvfma91uiMTrCMy7WYgzLoALIEMIiLCntKsmc91KraOQyhqL2zwWR
	 P/3y7OOb0FDmHisWRbwx18dFK+DT9+xDDcgWhnPowxCd4bAm91xMqIox8rhJnfTYbH
	 pO6LJD+JrUHrJzanpX24yvUt8cbIW/eHUMG5I2pg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 443/690] NFSD: Remove unused nfsd4_compoundargs::cachetype field
Date: Mon,  8 Apr 2024 14:55:09 +0200
Message-ID: <20240408125415.695298746@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 77e378cf2a595d8e39cddf28a31efe6afd9394a0 ]

This field was added by commit 1091006c5eb1 ("nfsd: turn on reply
cache for NFSv4") but was never put to use.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/xdr4.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 7fcbc7a46c157..b2bc85421b507 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -724,7 +724,6 @@ struct nfsd4_compoundargs {
 	u32				opcnt;
 	struct nfsd4_op			*ops;
 	struct nfsd4_op			iops[8];
-	int				cachetype;
 };
 
 struct nfsd4_compoundres {
-- 
2.43.0




