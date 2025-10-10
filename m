Return-Path: <stable+bounces-183998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D04BCD3E3
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB48540DEF
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BD02F0688;
	Fri, 10 Oct 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RyDT/wAH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB22F3C16;
	Fri, 10 Oct 2025 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102585; cv=none; b=pofCmbn63aRHbo6hml99eMQWSYdDApsGoEx9wRCz6evBq1WmQ9eZ0UASsY/TAIgbKXAkBYOis7H/rLbK8MwdNvYRbK3aTjefnspn+fXlbLiy023/+AbPCSvCi7+TtMqZAav9MlsSvOsAeRF/zCGOeO5C0z6ONvTy0I1Ua75jVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102585; c=relaxed/simple;
	bh=s6IUjy/KpN8xNzkJQITUgcHoJz7oDsRGCAKwzDq+6EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyuH9I+04i7O95fdN830Tk5WmfpLaiJmfeu6Sk2FPSZHBzOeRqCeFJOmb6mtjNqNJmsDe5tH3KwuOIl1NEoKeUghCjF7gtzEmY0mSoIK4PsWHq/g+u4gW9xVHUcVl6KKe35vD3m7+tvA69eZZ2RQSpgYQ/kUoTpf0+Yij+Z9BQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RyDT/wAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7008BC4CEF1;
	Fri, 10 Oct 2025 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760102584;
	bh=s6IUjy/KpN8xNzkJQITUgcHoJz7oDsRGCAKwzDq+6EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyDT/wAHKFm0AjObpRThTOfmtpF366i24YAZldEAIbvXTzXtzuLii21DqS5hmiL/W
	 evoiqxDUoFdv9kGXHfMZ2ufN2SYfPAxEmyzc+RdewH8w1dn0rUlUTHiz5HCQDWz2AK
	 fKJFOrzNZmIvbp+q+/Ly8DtxZIOSJV/Cin+pL6EQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 08/28] dm-integrity: limit MAX_TAG_SIZE to 255
Date: Fri, 10 Oct 2025 15:16:26 +0200
Message-ID: <20251010131330.666372080@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010131330.355311487@linuxfoundation.org>
References: <20251010131330.355311487@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 77b8e6fbf9848d651f5cb7508f18ad0971f3ffdb ]

MAX_TAG_SIZE was 0x1a8 and it may be truncated in the "bi->metadata_size
= ic->tag_size" assignment. We need to limit it to 255.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 0bd76f8d4dc6b..6442d41622eff 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -129,7 +129,7 @@ struct journal_sector {
 	commit_id_t commit_id;
 };
 
-#define MAX_TAG_SIZE			(JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR - offsetof(struct journal_entry, last_bytes[MAX_SECTORS_PER_BLOCK]))
+#define MAX_TAG_SIZE			255
 
 #define METADATA_PADDING_SECTORS	8
 
-- 
2.51.0




