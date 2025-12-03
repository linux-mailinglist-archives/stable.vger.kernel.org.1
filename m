Return-Path: <stable+bounces-198773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B34BCA067C
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5C7E312C02A
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED35349AE5;
	Wed,  3 Dec 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qhouETtI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D4B34887C;
	Wed,  3 Dec 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777637; cv=none; b=hAq0aMlBRH8tw7TAenaXoLsV5fwO4qctD5UoRGh0ncdueomNj+3sVxP0rSbYht4vlGuMvxft++IqpSz3OrN6QL3pRQVR+E2v3LvkvuwC7ed9UKEE6vAywNfC2gVeTRB/03nVS1zc1dWEjyUBxwI4iWkwlxUl0HRmxiotmnBKlAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777637; c=relaxed/simple;
	bh=gHeQljv4VUMqtC4FK5hknlN7AXer1/6H0R4zWi8VQQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjyGTDpK+9CdWdN1A4qV95ezvvlvPC5xV/wlr34IfWXYOWPUtP3j8y/p8AbtStYROjRhFg8DiBIH8Vxa+ljteP/bvgrlpilTpwnwKN4Xpe3JxAf9VTzSPGkiUV0d+/PNW9T2RJ9G7mk4gCEHT36o8qQ+Up4mbzNNSYGyVtNPDSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qhouETtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6820C4CEF5;
	Wed,  3 Dec 2025 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777637;
	bh=gHeQljv4VUMqtC4FK5hknlN7AXer1/6H0R4zWi8VQQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhouETtItW0Cmh8hS3sdArkUHqodUVdP6K8k6pJpGFEO1GBvcbDd3K3qhkzo8KMNc
	 A4LWSNOH3hZ+Yx2IV+XUKL4RRSFgaM5kRnnnnS17bve3OHcOxKEmRZ4u6pXpT+M4Rx
	 mjCg+HaIMag0QxX2pLLUAhgChDoLm9mznFReKvuk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Shang song (Lenovo)" <shangsong2@foxmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 066/392] ACPI: PRM: Skip handlers with NULL handler_address or NULL VA
Date: Wed,  3 Dec 2025 16:23:36 +0100
Message-ID: <20251203152416.539049391@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shang song (Lenovo) <shangsong2@foxmail.com>

[ Upstream commit 311942ce763e21dacef7e53996d5a1e19b8adab1 ]

If handler_address or mapped VA is NULL, the related buffer address and
VA can be ignored, so make acpi_parse_prmt() skip the current handler
in those cases.

Signed-off-by: Shang song (Lenovo) <shangsong2@foxmail.com>
Link: https://patch.msgid.link/20250826030229.834901-1-shangsong2@foxmail.com
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/prmt.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 6290ed84c5950..04228582a1f56 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -138,15 +138,28 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		th = &tm->handlers[cur_handler];
 
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
+
+		/*
+		 * Print an error message if handler_address is NULL, the parse of VA also
+		 * can be skipped.
+		 */
+		if (unlikely(!handler_info->handler_address)) {
+			pr_info("Skipping handler with NULL address for GUID: %pUL",
+					(guid_t *)handler_info->handler_guid);
+			continue;
+		}
+
 		th->handler_addr =
 			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
 		/*
-		 * Print a warning message if handler_addr is zero which is not expected to
-		 * ever happen.
+		 * Print a warning message and skip the parse of VA if handler_addr is zero
+		 * which is not expected to ever happen.
 		 */
-		if (unlikely(!th->handler_addr))
+		if (unlikely(!th->handler_addr)) {
 			pr_warn("Failed to find VA of handler for GUID: %pUL, PA: 0x%llx",
 				&th->guid, handler_info->handler_address);
+			continue;
+		}
 
 		th->static_data_buffer_addr =
 			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
-- 
2.51.0




