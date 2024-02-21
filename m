Return-Path: <stable+bounces-22741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0265085DD93
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9021F21330
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0437F466;
	Wed, 21 Feb 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xsH2GZec"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88197E78B;
	Wed, 21 Feb 2024 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524361; cv=none; b=jB4SKxcOeEEN5kLS/GRHoNYSrUaqqfVW05rZnI/vp79KKXgvjYQ5ET+clDak6lRsEMVji1d6ZSsxvCgHJGeISZpyvt0h6BUliKqwuAikQ+FQOlRG1NhwnYD5Wwmif2iDnFWtfN68yiDbya9+gFDz4d3FktkwUigwNP/US8Yq/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524361; c=relaxed/simple;
	bh=lr5jFC954+OZ9Uelll8UC1XrTvpj6D+UWnP/d1SKeYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tu+Qdcgj9X6B7ghinOwY3mp2iXnNYSF6VAvdwNv+5z0c2sSdKhxb+QUmosbFLNRLRB+6Z34PLEzxl4yPLZ4TjJeFegaq4338EJ60bbUmUO8lUTQvPDAc3WjKtdIEkdml8eRaGutnftm1+jtW6fklLcd2pHTS9m88A4okunVnHig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xsH2GZec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4323FC43390;
	Wed, 21 Feb 2024 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708524361;
	bh=lr5jFC954+OZ9Uelll8UC1XrTvpj6D+UWnP/d1SKeYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xsH2GZecvYb4x3XVSiksavOt23xYZ0SAMess6LpYJX3vFmipWOmInYvyMEujf+Wma
	 SG5gnKpb6RbzI3gn0hyqqP6xkydsNLzvwhyXcCnMzWymN+RrNRyJ2IZ2DhVrC1d9cC
	 n+HUec/yjk8bwR7iC693hRFt7bV2KXjh8XlMIpLk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 192/379] media: ddbridge: fix an error code problem in ddb_probe
Date: Wed, 21 Feb 2024 14:06:11 +0100
Message-ID: <20240221130000.587336489@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Hui <suhui@nfschina.com>

[ Upstream commit 09b4195021be69af1e1936cca995712a6d0f2562 ]

Error code is assigned to 'stat', return 'stat' rather than '-1'.

Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ddbridge/ddbridge-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index 03dc9924fa2c..bb7fb6402d6e 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -247,7 +247,7 @@ static int ddb_probe(struct pci_dev *pdev,
 	ddb_unmap(dev);
 	pci_set_drvdata(pdev, NULL);
 	pci_disable_device(pdev);
-	return -1;
+	return stat;
 }
 
 /****************************************************************************/
-- 
2.43.0




