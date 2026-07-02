Return-Path: <stable+bounces-270720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eHF3IfaeRmphaQsAu9opvQ
	(envelope-from <stable+bounces-270720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:25:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D183D6FB4EE
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:25:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=m3UjHGsN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270720-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270720-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C8E131BAFF1
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284EF414DDC;
	Thu,  2 Jul 2026 16:27:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287EF39D6D9;
	Thu,  2 Jul 2026 16:27:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009677; cv=none; b=PF678tXgMw1+kw0fEWHy9vwZTlw7v312FNIWUW+wsHH7qZhnwU0esxCJvSo0EhLJNvcFrHwlEGXBRBl8wUI7XeguPyN6LN4UyhSQPXkrNP97NWNeD7D+rssFI4WGmba7fjvyiAkVUkwRqmO97rkyLDkySC+9k5J0mELHvrlHVm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009677; c=relaxed/simple;
	bh=t4zk2nn0Bxvo3qmbaWWp+2nei8vP2i3FZ1XA2yoAEYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKOaiR6Od0kITpCs6somlipfpIa+2ZBwv+/bj2XFBqDT01fJU4BaNyNB6Z0eichHW3XY+/LtfZcschXEaeHJZ630iOGbItAIq/Py6FB3qyzWKZpeL8zDB+lFSbkYnveX8hdDV+pXwqKx8KdPq3khF8u4M+HR4c0OrjpehIPSl5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m3UjHGsN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B3F1F000E9;
	Thu,  2 Jul 2026 16:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009672;
	bh=JmkcUI7LXYRQNPxqp/j+S+QpVw7/18rj/SwKh4Fp1L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m3UjHGsNMbWmd0vh2bxS+7Ip3g47S2A/LX1qEsSKm1+aEK2a+nIz1F9uD7NpKHZZG
	 LbiID6qDZB91sb5dIt091m2lLGsA+HKo2Kd+JcPMQNpqIUUNkqQGU831E8ogkQg16F
	 gDtLJcvdxOWg8Sp2f7t2tfvamKLBZp7hO1xVsrHI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 06/95] drm/amd/display: Bound VBIOS record-chain walk loops
Date: Thu,  2 Jul 2026 18:19:09 +0200
Message-ID: <20260702155109.343119025@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155109.196223802@linuxfoundation.org>
References: <20260702155109.196223802@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270720-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:alex.hung@amd.com,m:harry.wentland@amd.com,m:ray.wu@amd.com,m:daniel.wheeler@amd.com,m:alexander.deucher@amd.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D183D6FB4EE

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Wentland <harry.wentland@amd.com>

[ Upstream commit ff287df16a1a58aca78b08d1f3ee09fc44da0351 ]

[Why & How]
All record-chain walk loops in bios_parser.c and bios_parser2.c use
for(;;) and only terminate on a 0xFF record_type sentinel or zero
record_size. A malformed VBIOS image missing the terminator record
causes unbounded iteration at probe time, potentially hundreds of
thousands of iterations with record_size=1. In the final iterations
near the BIOS image boundary, struct casts beyond the 2-byte header
validated by GET_IMAGE can also read out of bounds.

Cap all 14 record-chain walk loops to BIOS_MAX_NUM_RECORD (256)
iterations. The atombios.h defines up to 22 distinct record types
and atomfirmware.h has 13. Assuming an average of less than 10
records per type (which is reasonable since most are connector-
based) 256 is a generous upper bound.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Assisted-by: Copilot:claude-opus-4.6 Mythos
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 95700a3d660287ed657d6892f7be9ffc0e294a93)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 15 ++++++++++-----
 .../gpu/drm/amd/display/dc/bios/bios_parser2.c    | 15 ++++++++++-----
 .../drm/amd/display/dc/bios/bios_parser_helper.h  |  5 +++++
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index d8982aca8ef680..d2730af8e8030f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -223,6 +223,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	ATOM_COMMON_RECORD_HEADER *header;
 	ATOM_I2C_RECORD *record;
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	int i;
 
 	if (!info)
 		return BP_RESULT_BADINPUT;
@@ -235,7 +236,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	offset = le16_to_cpu(object->usRecordOffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -294,11 +295,12 @@ static enum bp_result bios_parser_get_device_tag_record(
 {
 	ATOM_COMMON_RECORD_HEADER *header;
 	uint32_t offset;
+	int i;
 
 	offset = le16_to_cpu(object->usRecordOffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -870,6 +872,7 @@ static ATOM_HPD_INT_RECORD *get_hpd_record(struct bios_parser *bp,
 {
 	ATOM_COMMON_RECORD_HEADER *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -879,7 +882,7 @@ static ATOM_HPD_INT_RECORD *get_hpd_record(struct bios_parser *bp,
 	offset = le16_to_cpu(object->usRecordOffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -1572,6 +1575,7 @@ static ATOM_ENCODER_CAP_RECORD_V2 *get_encoder_cap_record(
 {
 	ATOM_COMMON_RECORD_HEADER *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -1581,7 +1585,7 @@ static ATOM_ENCODER_CAP_RECORD_V2 *get_encoder_cap_record(
 	offset = le16_to_cpu(object->usRecordOffset)
 					+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -2665,6 +2669,7 @@ static enum bp_result update_slot_layout_info(
 	unsigned int record_offset)
 {
 	unsigned int j;
+	unsigned int n;
 	struct bios_parser *bp;
 	ATOM_BRACKET_LAYOUT_RECORD *record;
 	ATOM_COMMON_RECORD_HEADER *record_header;
@@ -2674,7 +2679,7 @@ static enum bp_result update_slot_layout_info(
 	record = NULL;
 	record_header = NULL;
 
-	for (;;) {
+	for (n = 0; n < BIOS_MAX_NUM_RECORD; n++) {
 
 		record_header = (ATOM_COMMON_RECORD_HEADER *)
 			GET_IMAGE(ATOM_COMMON_RECORD_HEADER, record_offset);
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index e186d4daae55b6..2192b2597edbc3 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -296,6 +296,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	struct atom_i2c_record *record;
 	struct atom_i2c_record dummy_record = {0};
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	int i;
 
 	if (!info)
 		return BP_RESULT_BADINPUT;
@@ -316,7 +317,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 
 	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -446,6 +447,7 @@ static struct atom_hpd_int_record *get_hpd_record(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -455,7 +457,7 @@ static struct atom_hpd_int_record *get_hpd_record(
 	offset = le16_to_cpu(object->disp_recordoffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -1614,6 +1616,7 @@ static struct atom_encoder_caps_record *get_encoder_cap_record(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -1622,7 +1625,7 @@ static struct atom_encoder_caps_record *get_encoder_cap_record(
 
 	offset = object->encoder_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -1651,6 +1654,7 @@ static struct atom_disp_connector_caps_record *get_disp_connector_caps_record(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -1659,7 +1663,7 @@ static struct atom_disp_connector_caps_record *get_disp_connector_caps_record(
 
 	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -2420,6 +2424,7 @@ static enum bp_result update_slot_layout_info(
 {
 	unsigned int record_offset;
 	unsigned int j;
+	unsigned int n;
 	struct atom_display_object_path_v2 *object;
 	struct atom_bracket_layout_record *record;
 	struct atom_common_record_header *record_header;
@@ -2441,7 +2446,7 @@ static enum bp_result update_slot_layout_info(
 		(object->disp_recordoffset) +
 		(unsigned int)(bp->object_info_tbl_offset);
 
-	for (;;) {
+	for (n = 0; n < BIOS_MAX_NUM_RECORD; n++) {
 
 		record_header = (struct atom_common_record_header *)
 			GET_IMAGE(struct atom_common_record_header,
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
index e1b4a40a353db1..da1e30de3c59a0 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
@@ -38,4 +38,9 @@ uint32_t bios_get_vga_enabled_displays(struct dc_bios *bios);
 
 #define GET_IMAGE(type, offset) ((type *) bios_get_image(&bp->base, offset, sizeof(type)))
 
+/* Upper bound on the number of records in a VBIOS record chain. Prevents
+ * unbounded looping if the VBIOS image is malformed and lacks a terminator.
+ */
+#define BIOS_MAX_NUM_RECORD 256
+
 #endif
-- 
2.53.0




