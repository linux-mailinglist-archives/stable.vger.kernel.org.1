Return-Path: <stable+bounces-103859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4AE9EF964
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C06D288DB5
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBCC222D67;
	Thu, 12 Dec 2024 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WOFSExml"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C994209F58;
	Thu, 12 Dec 2024 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025816; cv=none; b=WWxJQzGM/R1a56qatKTi/ck8gIIav7w0bAKFdTv1wt/ZdXi0QNBRyy/S+yTW1Yk6nyc6UUf06dJNi/a6XRqtL6NTjgwd6dgCIhhll4zTFxdcSIgeWyuGPcg4+EH3UatCPf2viRzLJ43vuNSqhD9PDlcYw3/C7qGgFiEsJi2yqxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025816; c=relaxed/simple;
	bh=2FHFF6gt+/uTuKm7H1kHP2VMfjdllwWyz8aETjdSOTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bj49XuZfZAWGZx64ujwZKDy47a7CcAtBt+0AHsqVKCq5uv1XUZFgmqwpjraxE9dLaFjRahBAdTb4gUx4b64w8zrXrhUEJa7xIVSy+zmxGyP0VXQ/YPbim6hETSilvKuQdpdekQOR5d+FaHORuWfoHwFtVKnTf/C1xG5LxbT5vkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WOFSExml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26DAC4CECE;
	Thu, 12 Dec 2024 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025816;
	bh=2FHFF6gt+/uTuKm7H1kHP2VMfjdllwWyz8aETjdSOTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOFSExmlhGdB3IVriDGbZ4nokfe3DwxbS1av3zjlijtdNZTdp7jI9jBj/g2TtA8Hz
	 zcuGQJQdV890Uqc4txelepQ7gNqzFkAp5Vo//swN5FSYNnGFfO3NhksyOwewu0LZea
	 tqjuPmQSgCKvy/l7P5+0Hxn4mbz4EkCg+OZjSP/Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
	John Meneghini <jmeneghi@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 296/321] scsi: st: Dont modify unknown block number in MTIOCGET
Date: Thu, 12 Dec 2024 16:03:34 +0100
Message-ID: <20241212144241.671230993@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
User-Agent: quilt/0.67
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai Mäkisara <Kai.Makisara@kolumbus.fi>

[ Upstream commit 5bb2d6179d1a8039236237e1e94cfbda3be1ed9e ]

Struct mtget field mt_blkno -1 means it is unknown. Don't add anything to
it.

Signed-off-by: Kai Mäkisara <Kai.Makisara@kolumbus.fi>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219419#c14
Link: https://lore.kernel.org/r/20241106095723.63254-2-Kai.Makisara@kolumbus.fi
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 2121e44c342f8..4e0737c25fbdf 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -3756,7 +3756,7 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 		    ((STp->density << MT_ST_DENSITY_SHIFT) & MT_ST_DENSITY_MASK);
 		mt_status.mt_blkno = STps->drv_block;
 		mt_status.mt_fileno = STps->drv_file;
-		if (STp->block_size != 0) {
+		if (STp->block_size != 0 && mt_status.mt_blkno >= 0) {
 			if (STps->rw == ST_WRITING)
 				mt_status.mt_blkno +=
 				    (STp->buffer)->buffer_bytes / STp->block_size;
-- 
2.43.0




