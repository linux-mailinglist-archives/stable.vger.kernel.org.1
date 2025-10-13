Return-Path: <stable+bounces-185313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9D9BD52D8
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F228C5071FE
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B43330CD94;
	Mon, 13 Oct 2025 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vxO+ACb+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC9030CDA8;
	Mon, 13 Oct 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369939; cv=none; b=Tt2DZzPvpC66XU2JcRovxODbssAn5gyDfapK2sTS0u2TsmzVKouWH9j8lS8zA62Yr316W9w7i/NZBuYcfd7sYae39zZqdyKgJ6WcQ0bDB70Oa3bnCGEu6HOu70KXnSBMkrhRfzh6HOMUsPJUdW8c1z7wkdFUrdg1lK2y1R4PMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369939; c=relaxed/simple;
	bh=zSOtMheqU5Yrv8HlrbzX9rTLkf08ERMNOGWfqAvsPJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcHplKt1vCBX8f+LxQU1GqUYXM4L36HS07GPpC3/IVzGHG44y/LH+DtmjxoF49ZValADagtjmy3zyj87zKWbg1EPzhHupDdIT23lXcIjD/srLvABgUb+y6mQ9MYXyjotaWCS/sK1py3lyTqdgooCBVmEdX0ybEsIC+UNa+XFsqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vxO+ACb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48205C4CEE7;
	Mon, 13 Oct 2025 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369938;
	bh=zSOtMheqU5Yrv8HlrbzX9rTLkf08ERMNOGWfqAvsPJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vxO+ACb+GivuGrjSGKWcqkz0nONBLH616rNnJfBGHaEvbpbFHuaQ7jVwk30zsPMd8
	 /6cuzi0dyI61PywaTGE5YbQnLRI1wVz68XWECFjyt2Do2eo/2O6WL2dFJLBb1LtWK8
	 VMwEj/Tx1DYeqy9JXY6Buf2C1fPtb9IQXH/Xh2fU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Abramov <i.abramov@mt-integration.ru>,
	Matthew Sakai <msakai@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 422/563] dm vdo: return error on corrupted metadata in start_restoring_volume functions
Date: Mon, 13 Oct 2025 16:44:43 +0200
Message-ID: <20251013144426.576578652@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Abramov <i.abramov@mt-integration.ru>

[ Upstream commit 9ddf6d3fcbe0b96e318da364cf7e6b59cd4cb5a2 ]

The return values of VDO_ASSERT calls that validate metadata are not acted
upon.

Return UDS_CORRUPT_DATA in case of an error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a4eb7e255517 ("dm vdo: implement the volume index")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
Reviewed-by: Matthew Sakai <msakai@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-vdo/indexer/volume-index.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-vdo/indexer/volume-index.c b/drivers/md/dm-vdo/indexer/volume-index.c
index 12f954a0c5325..afb062e1f1fb4 100644
--- a/drivers/md/dm-vdo/indexer/volume-index.c
+++ b/drivers/md/dm-vdo/indexer/volume-index.c
@@ -836,7 +836,7 @@ static int start_restoring_volume_sub_index(struct volume_sub_index *sub_index,
 				    "%zu bytes decoded of %zu expected", offset,
 				    sizeof(buffer));
 		if (result != VDO_SUCCESS)
-			result = UDS_CORRUPT_DATA;
+			return UDS_CORRUPT_DATA;
 
 		if (memcmp(header.magic, MAGIC_START_5, MAGIC_SIZE) != 0) {
 			return vdo_log_warning_strerror(UDS_CORRUPT_DATA,
@@ -928,7 +928,7 @@ static int start_restoring_volume_index(struct volume_index *volume_index,
 				    "%zu bytes decoded of %zu expected", offset,
 				    sizeof(buffer));
 		if (result != VDO_SUCCESS)
-			result = UDS_CORRUPT_DATA;
+			return UDS_CORRUPT_DATA;
 
 		if (memcmp(header.magic, MAGIC_START_6, MAGIC_SIZE) != 0)
 			return vdo_log_warning_strerror(UDS_CORRUPT_DATA,
-- 
2.51.0




