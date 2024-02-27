Return-Path: <stable+bounces-23989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B1869222
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972EC1F2B6D4
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C680614534C;
	Tue, 27 Feb 2024 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aqQST3Zd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849FD13B7AA;
	Tue, 27 Feb 2024 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040716; cv=none; b=N23Ji5mZFWzNoIBcu3UlD4WiOJhtdkwu88dPtBL+RMRrR1eU5reX4j2+FS9eAuY9jfpjBKhv+ru2g+HELCjAIoyjuVc+mtgcf77eqFDF3HgneCUkJgRZGpnPN0vpsVD2L8VMOsUOs4fW+lTl4PvI3kdBzLa5rOY7H+6BGlj1YxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040716; c=relaxed/simple;
	bh=TkSHgm4JEk5Qff7d85JVfkHtuGGysnuu24VUWAcQ7yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phCnySfUjx61CjNFdwCMSmoeB3G/134UafP/8kWsG7MylB8WfU07cArs+4xEh9x5rCWSV6gOnleyFmFIRnf16PJvLayhSoSrq+L1q0pdTfAsbmaeyDIeDrGSDgcaTXP8IYUM6lBkV9rMpca19/hgLRFPJaXPUF1yiqBmeNuglcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aqQST3Zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10931C43394;
	Tue, 27 Feb 2024 13:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040716;
	bh=TkSHgm4JEk5Qff7d85JVfkHtuGGysnuu24VUWAcQ7yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aqQST3ZdmxC3cvTzv3fDPyl3cfRvMGc24rFkGdRVDRCDOPMefDbYXooeIF7T6Va10
	 Tf7vItPFSp+Ll9ZlXvejD2t8fIwvlF1iuavXaox+uAX9pWqve0uHMtukvyBiaY0gGW
	 lfSS7Bf6fzAJmlYAmeJsoNPDGw+Ph6/oNIRItce8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 083/334] fs/ntfs3: Fix detected field-spanning write (size 8) of single field "le->name"
Date: Tue, 27 Feb 2024 14:19:01 +0100
Message-ID: <20240227131633.210658951@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit d155617006ebc172a80d3eb013c4b867f9a8ada4 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/ntfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 86aecbb01a92f..13e96fc63dae5 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -523,7 +523,7 @@ struct ATTR_LIST_ENTRY {
 	__le64 vcn;		// 0x08: Starting VCN of this attribute.
 	struct MFT_REF ref;	// 0x10: MFT record number with attribute.
 	__le16 id;		// 0x18: struct ATTRIB ID.
-	__le16 name[3];		// 0x1A: Just to align. To get real name can use bNameOffset.
+	__le16 name[];		// 0x1A: Just to align. To get real name can use name_off.
 
 }; // sizeof(0x20)
 
-- 
2.43.0




