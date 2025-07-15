Return-Path: <stable+bounces-162296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA418B05D79
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3DF7BF85D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1073B2EBB84;
	Tue, 15 Jul 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JU9WtwX4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1622E6D24;
	Tue, 15 Jul 2025 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586181; cv=none; b=R838Wf6tX2Aa7flpI+lRgsz67A86dDRWk0bpHrqHJvtJg9LIHfRgqUnlGf/gKac6Wv6qrWzBHkBe/itZeYQ9o+oujK02Vub+JpoWS3WdUKDWF6hqWiW1gtCNsQjX4j3FQxgKZJm7ib7xWl+53hv05kf9ew6/oylvS49G5T3xHYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586181; c=relaxed/simple;
	bh=OKJMXrAbFegNni1hHNkDyK1Xeb4eDVLvFb274mxkvf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htKUBcIUYwPZxQusXr32TRBfWvJN7JcUXXP21cd4TTK2gppbnXCCFqjIZn0kaZxUAIWrmG/hEeGoaUoAUJp85XrBGec9RQzvtGP0/InlVcaRdNm26wwBOPxVIZDOV+TiGk+rdyeXVwCBcMoCgvqTWmHTklT1O3K4RzDLdY0e8+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JU9WtwX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D75C4CEE3;
	Tue, 15 Jul 2025 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586181;
	bh=OKJMXrAbFegNni1hHNkDyK1Xeb4eDVLvFb274mxkvf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JU9WtwX4d6FPL7UK0v3j1ooCuu8MSa/hZ4qjjcpkbhGq+LLJtO6pVVXwGSNpE4eo1
	 BU8fT8iWYbC/4gtenjNoCb2ZHo8h4HNCO4sL7QKVxyvrdamlsC+SEBo6Ek1HsyUw/D
	 m29Fo+rdvkGX6fnFX+aatI+tbgb0l1twpH4ZZVCo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pawel Laszczak <pawell@cadence.com>,
	linux-usb@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 47/77] usb: cdnsp: Replace snprintf() with the safer scnprintf() variant
Date: Tue, 15 Jul 2025 15:13:46 +0200
Message-ID: <20250715130753.602000789@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130751.668489382@linuxfoundation.org>
References: <20250715130751.668489382@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Lee Jones <lee@kernel.org>

[ Upstream commit b385ef088c7aab20a2c0dc20d390d69a6620f0f3 ]

There is a general misunderstanding amongst engineers that {v}snprintf()
returns the length of the data *actually* encoded into the destination
array.  However, as per the C99 standard {v}snprintf() really returns
the length of the data that *would have been* written if there were
enough space for it.  This misunderstanding has led to buffer-overruns
in the past.  It's generally considered safer to use the {v}scnprintf()
variants in their place (or even sprintf() in simple cases).  So let's
do that.

The uses in this file all seem to assume that data *has been* written!

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20231130105459.3208986-3-lee@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 2831a81077f5 ("usb: cdnsp: Fix issue with CV Bad Descriptor test")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/cdnsp-debug.h | 354 ++++++++++++++++----------------
 1 file changed, 177 insertions(+), 177 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debug.h
index ad617b7455b9c..cd138acdcce16 100644
--- a/drivers/usb/cdns3/cdnsp-debug.h
+++ b/drivers/usb/cdns3/cdnsp-debug.h
@@ -187,202 +187,202 @@ static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
 
 	switch (type) {
 	case TRB_LINK:
-		ret = snprintf(str, size,
-			       "LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
-			       field1, field0, GET_INTR_TARGET(field2),
-			       cdnsp_trb_type_string(type),
-			       field3 & TRB_IOC ? 'I' : 'i',
-			       field3 & TRB_CHAIN ? 'C' : 'c',
-			       field3 & TRB_TC ? 'T' : 't',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
+				field1, field0, GET_INTR_TARGET(field2),
+				cdnsp_trb_type_string(type),
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_TC ? 'T' : 't',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_TRANSFER:
 	case TRB_COMPLETION:
 	case TRB_PORT_STATUS:
 	case TRB_HC_EVENT:
-		ret = snprintf(str, size,
-			       "ep%d%s(%d) type '%s' TRB %08x%08x status '%s'"
-			       " len %ld slot %ld flags %c:%c",
-			       ep_num, ep_id % 2 ? "out" : "in",
-			       TRB_TO_EP_INDEX(field3),
-			       cdnsp_trb_type_string(type), field1, field0,
-			       cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
-			       EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
-			       field3 & EVENT_DATA ? 'E' : 'e',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"ep%d%s(%d) type '%s' TRB %08x%08x status '%s'"
+				" len %ld slot %ld flags %c:%c",
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3),
+				cdnsp_trb_type_string(type), field1, field0,
+				cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
+				EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
+				field3 & EVENT_DATA ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_MFINDEX_WRAP:
-		ret = snprintf(str, size, "%s: flags %c",
-			       cdnsp_trb_type_string(type),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size, "%s: flags %c",
+				cdnsp_trb_type_string(type),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_SETUP:
-		ret = snprintf(str, size,
-			       "type '%s' bRequestType %02x bRequest %02x "
-			       "wValue %02x%02x wIndex %02x%02x wLength %d "
-			       "length %ld TD size %ld intr %ld Setup ID %ld "
-			       "flags %c:%c:%c",
-			       cdnsp_trb_type_string(type),
-			       field0 & 0xff,
-			       (field0 & 0xff00) >> 8,
-			       (field0 & 0xff000000) >> 24,
-			       (field0 & 0xff0000) >> 16,
-			       (field1 & 0xff00) >> 8,
-			       field1 & 0xff,
-			       (field1 & 0xff000000) >> 16 |
-			       (field1 & 0xff0000) >> 16,
-			       TRB_LEN(field2), GET_TD_SIZE(field2),
-			       GET_INTR_TARGET(field2),
-			       TRB_SETUPID_TO_TYPE(field3),
-			       field3 & TRB_IDT ? 'D' : 'd',
-			       field3 & TRB_IOC ? 'I' : 'i',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"type '%s' bRequestType %02x bRequest %02x "
+				"wValue %02x%02x wIndex %02x%02x wLength %d "
+				"length %ld TD size %ld intr %ld Setup ID %ld "
+				"flags %c:%c:%c",
+				cdnsp_trb_type_string(type),
+				field0 & 0xff,
+				(field0 & 0xff00) >> 8,
+				(field0 & 0xff000000) >> 24,
+				(field0 & 0xff0000) >> 16,
+				(field1 & 0xff00) >> 8,
+				field1 & 0xff,
+				(field1 & 0xff000000) >> 16 |
+				(field1 & 0xff0000) >> 16,
+				TRB_LEN(field2), GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				TRB_SETUPID_TO_TYPE(field3),
+				field3 & TRB_IDT ? 'D' : 'd',
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_DATA:
-		ret = snprintf(str, size,
-			       "type '%s' Buffer %08x%08x length %ld TD size %ld "
-			       "intr %ld flags %c:%c:%c:%c:%c:%c:%c",
-			       cdnsp_trb_type_string(type),
-			       field1, field0, TRB_LEN(field2),
-			       GET_TD_SIZE(field2),
-			       GET_INTR_TARGET(field2),
-			       field3 & TRB_IDT ? 'D' : 'i',
-			       field3 & TRB_IOC ? 'I' : 'i',
-			       field3 & TRB_CHAIN ? 'C' : 'c',
-			       field3 & TRB_NO_SNOOP ? 'S' : 's',
-			       field3 & TRB_ISP ? 'I' : 'i',
-			       field3 & TRB_ENT ? 'E' : 'e',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"type '%s' Buffer %08x%08x length %ld TD size %ld "
+				"intr %ld flags %c:%c:%c:%c:%c:%c:%c",
+				cdnsp_trb_type_string(type),
+				field1, field0, TRB_LEN(field2),
+				GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				field3 & TRB_IDT ? 'D' : 'i',
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_NO_SNOOP ? 'S' : 's',
+				field3 & TRB_ISP ? 'I' : 'i',
+				field3 & TRB_ENT ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_STATUS:
-		ret = snprintf(str, size,
-			       "Buffer %08x%08x length %ld TD size %ld intr"
-			       "%ld type '%s' flags %c:%c:%c:%c",
-			       field1, field0, TRB_LEN(field2),
-			       GET_TD_SIZE(field2),
-			       GET_INTR_TARGET(field2),
-			       cdnsp_trb_type_string(type),
-			       field3 & TRB_IOC ? 'I' : 'i',
-			       field3 & TRB_CHAIN ? 'C' : 'c',
-			       field3 & TRB_ENT ? 'E' : 'e',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"Buffer %08x%08x length %ld TD size %ld intr"
+				"%ld type '%s' flags %c:%c:%c:%c",
+				field1, field0, TRB_LEN(field2),
+				GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				cdnsp_trb_type_string(type),
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_ENT ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_NORMAL:
 	case TRB_ISOC:
 	case TRB_EVENT_DATA:
 	case TRB_TR_NOOP:
-		ret = snprintf(str, size,
-			       "type '%s' Buffer %08x%08x length %ld "
-			       "TD size %ld intr %ld "
-			       "flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
-			       cdnsp_trb_type_string(type),
-			       field1, field0, TRB_LEN(field2),
-			       GET_TD_SIZE(field2),
-			       GET_INTR_TARGET(field2),
-			       field3 & TRB_BEI ? 'B' : 'b',
-			       field3 & TRB_IDT ? 'T' : 't',
-			       field3 & TRB_IOC ? 'I' : 'i',
-			       field3 & TRB_CHAIN ? 'C' : 'c',
-			       field3 & TRB_NO_SNOOP ? 'S' : 's',
-			       field3 & TRB_ISP ? 'I' : 'i',
-			       field3 & TRB_ENT ? 'E' : 'e',
-			       field3 & TRB_CYCLE ? 'C' : 'c',
-			       !(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
+		ret = scnprintf(str, size,
+				"type '%s' Buffer %08x%08x length %ld "
+				"TD size %ld intr %ld "
+				"flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
+				cdnsp_trb_type_string(type),
+				field1, field0, TRB_LEN(field2),
+				GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				field3 & TRB_BEI ? 'B' : 'b',
+				field3 & TRB_IDT ? 'T' : 't',
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_NO_SNOOP ? 'S' : 's',
+				field3 & TRB_ISP ? 'I' : 'i',
+				field3 & TRB_ENT ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c',
+				!(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
 		break;
 	case TRB_CMD_NOOP:
 	case TRB_ENABLE_SLOT:
-		ret = snprintf(str, size, "%s: flags %c",
-			       cdnsp_trb_type_string(type),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size, "%s: flags %c",
+				cdnsp_trb_type_string(type),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_DISABLE_SLOT:
-		ret = snprintf(str, size, "%s: slot %ld flags %c",
-			       cdnsp_trb_type_string(type),
-			       TRB_TO_SLOT_ID(field3),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size, "%s: slot %ld flags %c",
+				cdnsp_trb_type_string(type),
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_ADDR_DEV:
-		ret = snprintf(str, size,
-			       "%s: ctx %08x%08x slot %ld flags %c:%c",
-			       cdnsp_trb_type_string(type), field1, field0,
-			       TRB_TO_SLOT_ID(field3),
-			       field3 & TRB_BSR ? 'B' : 'b',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"%s: ctx %08x%08x slot %ld flags %c:%c",
+				cdnsp_trb_type_string(type), field1, field0,
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_BSR ? 'B' : 'b',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_CONFIG_EP:
-		ret = snprintf(str, size,
-			       "%s: ctx %08x%08x slot %ld flags %c:%c",
-			       cdnsp_trb_type_string(type), field1, field0,
-			       TRB_TO_SLOT_ID(field3),
-			       field3 & TRB_DC ? 'D' : 'd',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"%s: ctx %08x%08x slot %ld flags %c:%c",
+				cdnsp_trb_type_string(type), field1, field0,
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_DC ? 'D' : 'd',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_EVAL_CONTEXT:
-		ret = snprintf(str, size,
-			       "%s: ctx %08x%08x slot %ld flags %c",
-			       cdnsp_trb_type_string(type), field1, field0,
-			       TRB_TO_SLOT_ID(field3),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"%s: ctx %08x%08x slot %ld flags %c",
+				cdnsp_trb_type_string(type), field1, field0,
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_RESET_EP:
 	case TRB_HALT_ENDPOINT:
-		ret = snprintf(str, size,
-			       "%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
-			       cdnsp_trb_type_string(type),
-			       ep_num, ep_id % 2 ? "out" : "in",
-			       TRB_TO_EP_INDEX(field3), field1, field0,
-			       TRB_TO_SLOT_ID(field3),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
+				cdnsp_trb_type_string(type),
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3), field1, field0,
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_STOP_RING:
-		ret = snprintf(str, size,
-			       "%s: ep%d%s(%d) slot %ld sp %d flags %c",
-			       cdnsp_trb_type_string(type),
-			       ep_num, ep_id % 2 ? "out" : "in",
-			       TRB_TO_EP_INDEX(field3),
-			       TRB_TO_SLOT_ID(field3),
-			       TRB_TO_SUSPEND_PORT(field3),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"%s: ep%d%s(%d) slot %ld sp %d flags %c",
+				cdnsp_trb_type_string(type),
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3),
+				TRB_TO_SLOT_ID(field3),
+				TRB_TO_SUSPEND_PORT(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_SET_DEQ:
-		ret = snprintf(str, size,
-			       "%s: ep%d%s(%d) deq %08x%08x stream %ld slot %ld  flags %c",
-			       cdnsp_trb_type_string(type),
-			       ep_num, ep_id % 2 ? "out" : "in",
-			       TRB_TO_EP_INDEX(field3), field1, field0,
-			       TRB_TO_STREAM_ID(field2),
-			       TRB_TO_SLOT_ID(field3),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"%s: ep%d%s(%d) deq %08x%08x stream %ld slot %ld  flags %c",
+				cdnsp_trb_type_string(type),
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3), field1, field0,
+				TRB_TO_STREAM_ID(field2),
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_RESET_DEV:
-		ret = snprintf(str, size, "%s: slot %ld flags %c",
-			       cdnsp_trb_type_string(type),
-			       TRB_TO_SLOT_ID(field3),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size, "%s: slot %ld flags %c",
+				cdnsp_trb_type_string(type),
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_ENDPOINT_NRDY:
 		temp = TRB_TO_HOST_STREAM(field2);
 
-		ret = snprintf(str, size,
-			       "%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
-			       cdnsp_trb_type_string(type),
-			       ep_num, ep_id % 2 ? "out" : "in",
-			       TRB_TO_EP_INDEX(field3), temp,
-			       temp == STREAM_PRIME_ACK ? "(PRIME)" : "",
-			       temp == STREAM_REJECTED ? "(REJECTED)" : "",
-			       TRB_TO_DEV_STREAM(field0),
-			       field3 & TRB_STAT ? 'S' : 's',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
+				cdnsp_trb_type_string(type),
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3), temp,
+				temp == STREAM_PRIME_ACK ? "(PRIME)" : "",
+				temp == STREAM_REJECTED ? "(REJECTED)" : "",
+				TRB_TO_DEV_STREAM(field0),
+				field3 & TRB_STAT ? 'S' : 's',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	default:
-		ret = snprintf(str, size,
-			       "type '%s' -> raw %08x %08x %08x %08x",
-			       cdnsp_trb_type_string(type),
-			       field0, field1, field2, field3);
+		ret = scnprintf(str, size,
+				"type '%s' -> raw %08x %08x %08x %08x",
+				cdnsp_trb_type_string(type),
+				field0, field1, field2, field3);
 	}
 
-	if (ret >= size)
-		pr_info("CDNSP: buffer overflowed.\n");
+	if (ret == size - 1)
+		pr_info("CDNSP: buffer may be truncated.\n");
 
 	return str;
 }
@@ -465,32 +465,32 @@ static inline const char *cdnsp_decode_portsc(char *str, size_t size,
 {
 	int ret;
 
-	ret = snprintf(str, size, "%s %s %s Link:%s PortSpeed:%d ",
-		       portsc & PORT_POWER ? "Powered" : "Powered-off",
-		       portsc & PORT_CONNECT ? "Connected" : "Not-connected",
-		       portsc & PORT_PED ? "Enabled" : "Disabled",
-		       cdnsp_portsc_link_state_string(portsc),
-		       DEV_PORT_SPEED(portsc));
+	ret = scnprintf(str, size, "%s %s %s Link:%s PortSpeed:%d ",
+			portsc & PORT_POWER ? "Powered" : "Powered-off",
+			portsc & PORT_CONNECT ? "Connected" : "Not-connected",
+			portsc & PORT_PED ? "Enabled" : "Disabled",
+			cdnsp_portsc_link_state_string(portsc),
+			DEV_PORT_SPEED(portsc));
 
 	if (portsc & PORT_RESET)
-		ret += snprintf(str + ret, size - ret, "In-Reset ");
+		ret += scnprintf(str + ret, size - ret, "In-Reset ");
 
-	ret += snprintf(str + ret, size - ret, "Change: ");
+	ret += scnprintf(str + ret, size - ret, "Change: ");
 	if (portsc & PORT_CSC)
-		ret += snprintf(str + ret, size - ret, "CSC ");
+		ret += scnprintf(str + ret, size - ret, "CSC ");
 	if (portsc & PORT_WRC)
-		ret += snprintf(str + ret, size - ret, "WRC ");
+		ret += scnprintf(str + ret, size - ret, "WRC ");
 	if (portsc & PORT_RC)
-		ret += snprintf(str + ret, size - ret, "PRC ");
+		ret += scnprintf(str + ret, size - ret, "PRC ");
 	if (portsc & PORT_PLC)
-		ret += snprintf(str + ret, size - ret, "PLC ");
+		ret += scnprintf(str + ret, size - ret, "PLC ");
 	if (portsc & PORT_CEC)
-		ret += snprintf(str + ret, size - ret, "CEC ");
-	ret += snprintf(str + ret, size - ret, "Wake: ");
+		ret += scnprintf(str + ret, size - ret, "CEC ");
+	ret += scnprintf(str + ret, size - ret, "Wake: ");
 	if (portsc & PORT_WKCONN_E)
-		ret += snprintf(str + ret, size - ret, "WCE ");
+		ret += scnprintf(str + ret, size - ret, "WCE ");
 	if (portsc & PORT_WKDISC_E)
-		ret += snprintf(str + ret, size - ret, "WDE ");
+		ret += scnprintf(str + ret, size - ret, "WDE ");
 
 	return str;
 }
@@ -562,20 +562,20 @@ static inline const char *cdnsp_decode_ep_context(char *str, size_t size,
 
 	avg = EP_AVG_TRB_LENGTH(tx_info);
 
-	ret = snprintf(str, size, "State %s mult %d max P. Streams %d %s",
-		       cdnsp_ep_state_string(ep_state), mult,
-		       max_pstr, lsa ? "LSA " : "");
+	ret = scnprintf(str, size, "State %s mult %d max P. Streams %d %s",
+			cdnsp_ep_state_string(ep_state), mult,
+			max_pstr, lsa ? "LSA " : "");
 
-	ret += snprintf(str + ret, size - ret,
-			"interval %d us max ESIT payload %d CErr %d ",
-			(1 << interval) * 125, esit, cerr);
+	ret += scnprintf(str + ret, size - ret,
+			 "interval %d us max ESIT payload %d CErr %d ",
+			 (1 << interval) * 125, esit, cerr);
 
-	ret += snprintf(str + ret, size - ret,
-			"Type %s %sburst %d maxp %d deq %016llx ",
-			cdnsp_ep_type_string(ep_type), hid ? "HID" : "",
-			burst, maxp, deq);
+	ret += scnprintf(str + ret, size - ret,
+			 "Type %s %sburst %d maxp %d deq %016llx ",
+			 cdnsp_ep_type_string(ep_type), hid ? "HID" : "",
+			 burst, maxp, deq);
 
-	ret += snprintf(str + ret, size - ret, "avg trb len %d", avg);
+	ret += scnprintf(str + ret, size - ret, "avg trb len %d", avg);
 
 	return str;
 }
-- 
2.39.5




