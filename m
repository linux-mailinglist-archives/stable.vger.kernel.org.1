Return-Path: <stable+bounces-83922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF599CD32
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93992832A7
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF951AB52D;
	Mon, 14 Oct 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yqJk6uAD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63E1AB508;
	Mon, 14 Oct 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916202; cv=none; b=c03rbgo8AAiYMJA4U5+72YRht76VdS3y/cLjzekwr4T+nNdvKuguK0bBegEL+VHBYNS93Q5dboFHruHYAEnZjUwaMbRY8+wDagFb4n5TCBpp8bW+NhiwQmu00AHzLWD8HxR+zAP7Y/pcPoaEoi4kSYZz7Aw5s5YSrfB4HvgH+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916202; c=relaxed/simple;
	bh=qK6xoJ2Js2EWwXJH2co2dlroukkwgtzF3HdV11jB+D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRJYjkU98k770znMA5vvOejLGiNRwxM4tJOKhUF++cDfF78eOuGWT/3fFgZGNRBcI8xKkTzywKOXkexm0M15IxLKyhttEvXTluci8ytMrhe7463TFoMur3dIQILjKv2QWTPh6H+Jgjm7MjNwXFrBgn8teEiWTOplXXEPMBudnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yqJk6uAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE9FC4CEC3;
	Mon, 14 Oct 2024 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916202;
	bh=qK6xoJ2Js2EWwXJH2co2dlroukkwgtzF3HdV11jB+D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yqJk6uADxT9ZfxH0rwsgxK0UwYsKuiCDl4ZV8B2Pl9YbWx54cXcSSqQnlAuoNwdLr
	 xL4nxNVitnsD8oua0GtCIPRRSbrNQEnVneo4cZ5hlAnpawNoyFwFShfiLVTLoDqGOM
	 OH+R7KmPL52t48Tst8O1QAM9BXdQatvnv+4WjOzI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 112/214] net: dsa: b53: allow lower MTUs on BCM5325/5365
Date: Mon, 14 Oct 2024 16:19:35 +0200
Message-ID: <20241014141049.365833678@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit e4b294f88a32438baf31762441f3dd1c996778be ]

While BCM5325/5365 do not support jumbo frames, they do support slightly
oversized frames, so do not error out if requesting a supported MTU for
them.

Fixes: 6ae5834b983a ("net: dsa: b53: add MTU configuration support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/b53/b53_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index e8b20bfa8b83e..5b83f9b6cdac3 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2258,7 +2258,7 @@ static int b53_change_mtu(struct dsa_switch *ds, int port, int mtu)
 	bool allow_10_100;
 
 	if (is5325(dev) || is5365(dev))
-		return -EOPNOTSUPP;
+		return 0;
 
 	if (!dsa_is_cpu_port(ds, port))
 		return 0;
-- 
2.43.0




