Return-Path: <stable+bounces-149215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37739ACB1AB
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C6A19412D2
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55742576;
	Mon,  2 Jun 2025 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qJgGzcsE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80295221558;
	Mon,  2 Jun 2025 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873268; cv=none; b=YVIUoDO2r4W6U3xHahlsDThlqCweKiRjqkaPt5EgubdiTWrgZERRZzWK6HebaQMZHp4d6MIe9gUEpSnnQvObTB5viRTkuIMLVj9sjWaJwEmgQPWjb6fbWAN5jy3Btqk/Dk1uePiaNzVKEPyIYU9ZN+oJQYtjetlbr6Bc525z0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873268; c=relaxed/simple;
	bh=Il0kF/iHsvLKQe7pp/y+iPNrs/DFd287pREHJiUhjr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuZ60Vj52/X4qQiuoxPKVzFcTMKhb7cSiGfFDMEID2zbGxXZt5YztzsKk31/tZQ2p68IJT0TjETPz/Wt9tUa/JjEqhN0pHDdIgX2hA1lOU9e7ZQolAO3i9BQ97NKgXNJQ4MV6i4j+jv+F1EiszvktLnrHydz50Iu62Ih51ld74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qJgGzcsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C859AC4CEEB;
	Mon,  2 Jun 2025 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873268;
	bh=Il0kF/iHsvLKQe7pp/y+iPNrs/DFd287pREHJiUhjr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJgGzcsEcTnOFj1h28BEX/HicYGm+TOI2lTvNE0PU6SFihAuXK+fJKZtnMSQDJ8yz
	 jLiNSZcseIfSqjNcsteDIh2eIa7jWw6vscf44q78+IHaQ+7fkeZWqcKCtF8+YnMBS2
	 WnkHftmwy7AxTQiYFdibRNm3TyEngw6eLTm/EhVY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 089/444] scsi: st: ERASE does not change tape location
Date: Mon,  2 Jun 2025 15:42:33 +0200
Message-ID: <20250602134344.504675909@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai Mäkisara <Kai.Makisara@kolumbus.fi>

[ Upstream commit ad77cebf97bd42c93ab4e3bffd09f2b905c1959a ]

The SCSI ERASE command erases from the current position onwards.  Don't
clear the position variables.

Signed-off-by: Kai Mäkisara <Kai.Makisara@kolumbus.fi>
Link: https://lore.kernel.org/r/20250311112516.5548-3-Kai.Makisara@kolumbus.fi
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/st.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 293074f30906f..fb193caa4a3fa 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -2895,7 +2895,6 @@ static int st_int_ioctl(struct scsi_tape *STp, unsigned int cmd_in, unsigned lon
 			timeout = STp->long_timeout * 8;
 
 		DEBC_printk(STp, "Erasing tape.\n");
-		fileno = blkno = at_sm = 0;
 		break;
 	case MTSETBLK:		/* Set block length */
 	case MTSETDENSITY:	/* Set tape density */
-- 
2.39.5




