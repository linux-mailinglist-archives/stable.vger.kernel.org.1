Return-Path: <stable+bounces-94217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF84D9D3B96
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A18E1F217CC
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804AE1A9B5A;
	Wed, 20 Nov 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GendONh2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECD51AB6C0;
	Wed, 20 Nov 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107563; cv=none; b=rHgRxv7O3RvjQC3iGcrdnh6q9qilReR0l8uJanilXziYgHsRjcn22cnb/vxj2BLM11U+K5OSZlUuDZ6cSqfOkDVO4WtQ9nL1P/EoRMEfBbmViM2W9vP+IHsYmQxFUkHIhrMzEicYyXDK7p+1875J1Q1q9v5sC/NFz4LqkMzsl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107563; c=relaxed/simple;
	bh=pDp8YanFZw3P0XeyWsg6trq9PKahdKJlm5h5fV9f6G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVWjHXXszxQOANfpQHDxyq+k1illW90dHsKthLbMBx31dkVh5pgBr2SgIlC9F48TcPGdKgHd+7FQEdRYGzS/knuA6MPVjhvlbjux7r87W5RCNNQlTqPPl8sk/iV4/p9Z47eUaDWP+2oxf276uY/JI4RP377FeVfYMI+U/eXO5ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GendONh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10593C4CED6;
	Wed, 20 Nov 2024 12:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732107563;
	bh=pDp8YanFZw3P0XeyWsg6trq9PKahdKJlm5h5fV9f6G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GendONh2aLLLt9fZlICMKXnMvIrBDn4buyKIcWchqHYet8XpJhum14VNo0znbjTL2
	 hoOqt0tLMNzMFWzR2IBsECNpLqheI1KhkL5R4//ff90EdzMy/+Pk/fgU5As7+WB4mX
	 inhmssMqoBu5t+Gc/CXE3vMn1P/rlrGvT391vilo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.11 105/107] lib/buildid: Fix build ID parsing logic
Date: Wed, 20 Nov 2024 13:57:20 +0100
Message-ID: <20241120125632.103560619@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120125629.681745345@linuxfoundation.org>
References: <20241120125629.681745345@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

The parse_build_id_buf does not account Elf32_Nhdr header size
when getting the build id data pointer and returns wrong build
id data as result.

This is problem only for stable trees that merged 768d731b8a0d
fix, the upstream build id code was refactored and returns proper
build id.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Fixes: 768d731b8a0d ("lib/buildid: harden build ID parsing logic")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/buildid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -40,7 +40,7 @@ static int parse_build_id_buf(unsigned c
 		    name_sz == note_name_sz &&
 		    memcmp(nhdr + 1, note_name, note_name_sz) == 0 &&
 		    desc_sz > 0 && desc_sz <= BUILD_ID_SIZE_MAX) {
-			data = note_start + note_off + ALIGN(note_name_sz, 4);
+			data = note_start + note_off + sizeof(Elf32_Nhdr) + ALIGN(note_name_sz, 4);
 			memcpy(build_id, data, desc_sz);
 			memset(build_id + desc_sz, 0, BUILD_ID_SIZE_MAX - desc_sz);
 			if (size)



