Return-Path: <stable+bounces-63297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8C9941846
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2B71F21A2C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94FF184547;
	Tue, 30 Jul 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vCGJv7xY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A471A6185;
	Tue, 30 Jul 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356371; cv=none; b=RDTMunnI68DkbDbOAF+LzG732VvK239F15t3jwbQMOhvCUdjJy+fhzhQHUTc6Z8k3l98YhLfaW0C8UToqgX4WusXgFcV1Bku/If/fqK+PUW2mouCqdGdHAGTwV8vZ6ynRo29ggGGCN5gHQMNybMDRkuGCNxlDVy6Ppx78z8Plo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356371; c=relaxed/simple;
	bh=yQ857CmxLALKYfrcWa4YSux65iHW2KghG6Zn8SDxzlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzFO8PaZqBSJzEewT7YQR/w9dtDce3fkf+q8jUJSYHoRMhCBF2JUub3EmcKn7cT80ekiLeyyOHnj2l6nocYszle2Be4OkwjP5EYjGla9XJ4Doymqu4UWOeCwFnNBR/Wzbqb3J7NY8LOnnLbB7UrZT01CpTbyg/DIMH+ZU9UPSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vCGJv7xY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5DDC32782;
	Tue, 30 Jul 2024 16:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356371;
	bh=yQ857CmxLALKYfrcWa4YSux65iHW2KghG6Zn8SDxzlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vCGJv7xY6RSohraZjuRsMntE9nxS3AgPBHP1sHuxqKvem+WVCcUDSRwvpV6bSZJqF
	 jakq3ja2aSzZqIT4Yw+RT/r9c3MgmpCkOhHnJhvC6WQN1nI9wl0arickQH1SeXJiLt
	 IFedsDqNGEoGCXOHYLUIpnCrjumbYD6D7b94biDU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 142/568] netfilter: nf_tables: rise cap on SELinux secmark context
Date: Tue, 30 Jul 2024 17:44:09 +0200
Message-ID: <20240730151645.428919143@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit e29630247be24c3987e2b048f8e152771b32d38b ]

secmark context is artificially limited 256 bytes, rise it to 4Kbytes.

Fixes: fb961945457f ("netfilter: nf_tables: add SECMARK support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/netfilter/nf_tables.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 117c6a9b845b1..621e3035145eb 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1372,7 +1372,7 @@ enum nft_secmark_attributes {
 #define NFTA_SECMARK_MAX	(__NFTA_SECMARK_MAX - 1)
 
 /* Max security context length */
-#define NFT_SECMARK_CTX_MAXLEN		256
+#define NFT_SECMARK_CTX_MAXLEN		4096
 
 /**
  * enum nft_reject_types - nf_tables reject expression reject types
-- 
2.43.0




