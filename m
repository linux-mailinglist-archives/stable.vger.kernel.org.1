Return-Path: <stable+bounces-103519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E429EF763
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9225128CABC
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596D022333F;
	Thu, 12 Dec 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQ1yPhVb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157AE22331C;
	Thu, 12 Dec 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024814; cv=none; b=kdBONsVnx20fUJ66ryYGUIgXo9MJ6ZFJ1Oy74/MTM4SGpkZU1ChVeqLoiJwfAm2723yEA8240EVnU/a2CZT1Sjove46h0vNhDf8Wc0kElI6AHdRlRJjqzw0kcfjY9TxIXxMaw/DBwomZpKsWrK9UmTJfy3SVM5bDVH3ZiBQRk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024814; c=relaxed/simple;
	bh=53lp1t5acgZ5LUDI/fZKihkSuY+IJn3xd5SBlPVhCHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Loq3qH5ZMIFpf+/F5S89O4BpJ2BWgigZhwm/uC4E9+5WDFtBIBmP09P2AA3JxfNGwIJdDnu4RtxGrZVYt12CdEFY3csUnG+xZGv01JogrVBvyDmKnZyL88fueQzDf+d/ERY0HT+xC0cNmITs90kJnHEpB6WUq/8LcjYIILQuz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RQ1yPhVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA8BC4CECE;
	Thu, 12 Dec 2024 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024814;
	bh=53lp1t5acgZ5LUDI/fZKihkSuY+IJn3xd5SBlPVhCHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQ1yPhVb7sG2cxIxc1VvMD3ZvULrz4swVbMj4Lv1LxpKTIFu3xvwkpvIFB/hWlTjZ
	 uiP8cUJ0OaOKCEZe8H3zwxfTlwp875oa/hD8aUH37jj2WbNmy09XN8q8rw5RnVpb4C
	 h4KqXhZpscjRT1gPSiCcPAJCcZ4NUvIP3HuTOif0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
	John Meneghini <jmeneghi@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 421/459] scsi: st: Dont modify unknown block number in MTIOCGET
Date: Thu, 12 Dec 2024 16:02:39 +0100
Message-ID: <20241212144310.393501299@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 19bc8c923fce5..c08518258f001 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -3755,7 +3755,7 @@ static long st_ioctl_common(struct file *file, unsigned int cmd_in, void __user
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




