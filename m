Return-Path: <stable+bounces-137561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1724AA1416
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFED95A540E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1CD24728A;
	Tue, 29 Apr 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="McTBNgSX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3423F413;
	Tue, 29 Apr 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946436; cv=none; b=BO/PKtHdywkjE8B9acsxbXuVVn18RP0qY1H5+8LilY1BLL/6WxUtDebM6/1o5+blXkAlssMeuxFT/HTRV42G4ypy09sHoWg/H1aJ2dDBlTaWtvC5db4VfVRTEWz62jcEVBrIP0N+XEvYPqxBl3t+zLo5YyBYvuXjYypdB5wsjOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946436; c=relaxed/simple;
	bh=4BJ6s/YR51Mdmcu6rOHuM3nrHkHMYfQug1A9DnXCaFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srmrRZuY1RBnCWsJZxrMAND/LGFmsispW9hH+kuQIDrHAl6rsQacPYnxE+VWov/ZEU/jPpbQoxBClqoQp68Zl5bGoRUNqdBrDqMEvD8dwEfzYq9aOKU3U8Y5KbdwJt471QNyMxr4FDfUipeke1k1sMA9Tm+aSnQdURKve8S/R9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=McTBNgSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7368C4CEE3;
	Tue, 29 Apr 2025 17:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946436;
	bh=4BJ6s/YR51Mdmcu6rOHuM3nrHkHMYfQug1A9DnXCaFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=McTBNgSXgya+XoMu3j4V0GMe91g5lKgACkXMAiCVzji9G6fqb2z1siZgs5+cg19Hw
	 TD09POjiROw2/ujfmNOyZxrhf+yosT1lBp3JwI1Mji/oN8nlUdvdi/IFh7uu/qFrIV
	 RG5+py8fRTnZ+I5sJfgHbp9pp5CUODVgC1I3SCZ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 266/311] cifs: Fix querying of WSL CHR and BLK reparse points over SMB1
Date: Tue, 29 Apr 2025 18:41:43 +0200
Message-ID: <20250429161131.925387299@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pali Rohár <pali@kernel.org>

[ Upstream commit ef86ab131d9127dfbfa8f06e12441d05fdfb090b ]

When reparse point in SMB1 query_path_info() callback was detected then
query also for EA $LXDEV. In this EA are stored device major and minor
numbers used by WSL CHR and BLK reparse points. Without major and minor
numbers, stat() syscall does not work for char and block devices.

Similar code is already in SMB2+ query_path_info() callback function.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb1ops.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index d6e2fb669c401..808970e4a7142 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -573,6 +573,42 @@ static int cifs_query_path_info(const unsigned int xid,
 		data->reparse_point = le32_to_cpu(fi.Attributes) & ATTR_REPARSE;
 	}
 
+#ifdef CONFIG_CIFS_XATTR
+	/*
+	 * For WSL CHR and BLK reparse points it is required to fetch
+	 * EA $LXDEV which contains major and minor device numbers.
+	 */
+	if (!rc && data->reparse_point) {
+		struct smb2_file_full_ea_info *ea;
+
+		ea = (struct smb2_file_full_ea_info *)data->wsl.eas;
+		rc = CIFSSMBQAllEAs(xid, tcon, full_path, SMB2_WSL_XATTR_DEV,
+				    &ea->ea_data[SMB2_WSL_XATTR_NAME_LEN + 1],
+				    SMB2_WSL_XATTR_DEV_SIZE, cifs_sb);
+		if (rc == SMB2_WSL_XATTR_DEV_SIZE) {
+			ea->next_entry_offset = cpu_to_le32(0);
+			ea->flags = 0;
+			ea->ea_name_length = SMB2_WSL_XATTR_NAME_LEN;
+			ea->ea_value_length = cpu_to_le16(SMB2_WSL_XATTR_DEV_SIZE);
+			memcpy(&ea->ea_data[0], SMB2_WSL_XATTR_DEV, SMB2_WSL_XATTR_NAME_LEN + 1);
+			data->wsl.eas_len = sizeof(*ea) + SMB2_WSL_XATTR_NAME_LEN + 1 +
+					    SMB2_WSL_XATTR_DEV_SIZE;
+			rc = 0;
+		} else if (rc >= 0) {
+			/* It is an error if EA $LXDEV has wrong size. */
+			rc = -EINVAL;
+		} else {
+			/*
+			 * In all other cases ignore error if fetching
+			 * of EA $LXDEV failed. It is needed only for
+			 * WSL CHR and BLK reparse points and wsl_to_fattr()
+			 * handle the case when EA is missing.
+			 */
+			rc = 0;
+		}
+	}
+#endif
+
 	return rc;
 }
 
-- 
2.39.5




