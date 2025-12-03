Return-Path: <stable+bounces-199286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9720ACA0CE2
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22694329ADD8
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCB535F8D3;
	Wed,  3 Dec 2025 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wekWjTBX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D335FF79;
	Wed,  3 Dec 2025 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779293; cv=none; b=tqMVrNXsaqbCErRVsUNQStOeAw9irupE7LAWrwzd5gtw9aumM2i5TiWQ2lFjLupTNJqbJbqJPneqcBMdA59clLPTsCMiFvKZ4/mqX1jD1QXYgQyWu96c1rNbhIjrS3tq6hecYWZ1LwjWH418LxXY+Ddc6UfhtSvFbn6p0vj0E1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779293; c=relaxed/simple;
	bh=HmY9HLe85FohmJiSiMsWustC9UOEMC/oPv2kWHdZbFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgl/qJ0GZS51hcF/jE1P2MjH9JtwaTiYCJcMPkvs8CQTjwwm561hfyl9tcVyw348ghj3PCIjCJ7Oz1CoMfbJRT9v8NSUUnyzBs3lisdPnePw6OP0CsT1ocOyYvD8wCly1yU3qCt/SmRSn+497T+Hl/PSEdJp9ab+admNa/11rm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wekWjTBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1658C4CEF5;
	Wed,  3 Dec 2025 16:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764779293;
	bh=HmY9HLe85FohmJiSiMsWustC9UOEMC/oPv2kWHdZbFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wekWjTBXZsjUCaGbx7OnNLzKUcS1mMpgaelICzbfUguRaIowSa439yR6Jk6pf3nzY
	 qawkTA3gK6kpDUHQIwEMvD1GTM3gIsJ7mxa7/sQkgQTltCbZBwdskWvmJmf2Eo/MmP
	 B82gzgPqYYzCgOm1tEBoQiX8spC+QlRc+FNT34Wk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 181/568] scsi: pm8001: Use int instead of u32 to store error codes
Date: Wed,  3 Dec 2025 16:23:03 +0100
Message-ID: <20251203152447.358220058@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
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

From: Qianfeng Rong <rongqianfeng@vivo.com>

[ Upstream commit bee3554d1a4efbce91d6eca732f41b97272213a5 ]

Use int instead of u32 for 'ret' variable to store negative error codes
returned by PM8001_CHIP_DISP->set_nvmd_req().

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Link: https://lore.kernel.org/r/20250826093242.230344-1-rongqianfeng@vivo.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm8001_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index 2f67f51785e64..3ac6b564a664a 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -686,7 +686,7 @@ static int pm8001_set_nvmd(struct pm8001_hba_info *pm8001_ha)
 	struct pm8001_ioctl_payload	*payload;
 	DECLARE_COMPLETION_ONSTACK(completion);
 	u8		*ioctlbuffer;
-	u32		ret;
+	int		ret;
 	u32		length = 1024 * 5 + sizeof(*payload) - 1;
 
 	if (pm8001_ha->fw_image->size > 4096) {
-- 
2.51.0




