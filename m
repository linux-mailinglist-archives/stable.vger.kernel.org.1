Return-Path: <stable+bounces-102094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D73D9EEFFB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06DD28D978
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D743423E6C2;
	Thu, 12 Dec 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tilSJIdj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA223DEB9;
	Thu, 12 Dec 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019948; cv=none; b=btRuJ/rg7ebFfJVYmXpxqeL44D98p2qpsL35yD8OnpFk63VaDAY5Jv0jahugdpYXGPWmA+vaLHzx2jm2yPqmmPMlW18+QBg9nhr3tlQdDB9Bv76GUclcNg+CnFjaZPC5tabVkKx46m2JILgdRpAHkNf5vQtF430nkeKKsSqHTYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019948; c=relaxed/simple;
	bh=UR1n2SNN2/BSCRn77xD/X1E8lD630wGmhSYefoiNbDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/xfVSbunwzcBlM2xyuduXIYu6Y4A1X/B5HirlcDIWHOQimLlsye3eE+e7qkYBcHCZgU7Pz56yv5V+/+5T1nmYJblLvM81ZSOtagGdysHuy+iqvOhhNaBN96jGFIsph3oeqrofwoPLUXEN0gytZ88lamLNX8TmPPNfNYmyjeqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tilSJIdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7006C4CECE;
	Thu, 12 Dec 2024 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019948;
	bh=UR1n2SNN2/BSCRn77xD/X1E8lD630wGmhSYefoiNbDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tilSJIdjUBs2sYsdHwpgut+dgs7vG5riwrWoY5GIGVbyrrj3nTHrT09jcJAHC0Wql
	 +DnUjEGBBG3tF7VoZXWAHByEfZ9V/386dDIiqf0JbTcnRIQUFg2MO7jrytyJCBFfQX
	 kLYQMUoYQkjR7rvGOsU5yL9xR5BpCW9aXNKyPUQc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	lei lu <llfamsec@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Bin Lan <bin.lan.cn@windriver.com>
Subject: [PATCH 6.1 339/772] ntfs3: Add bounds checking to mi_enum_attr()
Date: Thu, 12 Dec 2024 15:54:44 +0100
Message-ID: <20241212144403.919775495@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: lei lu <llfamsec@gmail.com>

commit 556bdf27c2dd5c74a9caacbe524b943a6cd42d99 upstream.

Added bounds checking to make sure that every attr don't stray beyond
valid memory region.

Signed-off-by: lei lu <llfamsec@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/record.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -217,28 +217,19 @@ struct ATTRIB *mi_enum_attr(struct mft_i
 		prev_type = 0;
 		attr = Add2Ptr(rec, off);
 	} else {
-		/* Check if input attr inside record. */
+		/*
+		 * We don't need to check previous attr here. There is
+		 * a bounds checking in the previous round.
+		 */
 		off = PtrOffset(rec, attr);
-		if (off >= used)
-			return NULL;
 
 		asize = le32_to_cpu(attr->size);
-		if (asize < SIZEOF_RESIDENT) {
-			/* Impossible 'cause we should not return such attribute. */
-			return NULL;
-		}
-
-		/* Overflow check. */
-		if (off + asize < off)
-			return NULL;
 
 		prev_type = le32_to_cpu(attr->type);
 		attr = Add2Ptr(attr, asize);
 		off += asize;
 	}
 
-	asize = le32_to_cpu(attr->size);
-
 	/* Can we use the first field (attr->type). */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
@@ -259,6 +250,12 @@ struct ATTRIB *mi_enum_attr(struct mft_i
 	if (t32 < prev_type)
 		return NULL;
 
+	asize = le32_to_cpu(attr->size);
+	if (asize < SIZEOF_RESIDENT) {
+		/* Impossible 'cause we should not return such attribute. */
+		return NULL;
+	}
+
 	/* Check overflow and boundary. */
 	if (off + asize < off || off + asize > used)
 		return NULL;



