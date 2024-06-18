Return-Path: <stable+bounces-52710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D425C90CC42
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B301C22477
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10DC15F31D;
	Tue, 18 Jun 2024 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHDLUeUc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712115F303;
	Tue, 18 Jun 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714263; cv=none; b=DgfPqmrKtqm1T9MqnHkwNcbBWTttP8UE1/fPI8OitxJkOasswz8sfRgWJJIZd6YxgTZtC5+H6ux5BAmtc3R2yraN66YpjfDvrf8E0URW2M8LH54+LHRY0i1wH8h+3cSv4FL5DKhsilkhaMJi6LPS3znLC6K9wQFTsTQaMAZs5ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714263; c=relaxed/simple;
	bh=X0tAiBJPBMS2Sym2Di+jZS/UBuaLHIAG8Kf/jbT6/5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHRtqMiwsd3E1mgV2GrIgFcf+Qz+N/PUiLnVbx2xR9wgPVZBGKqDMZu03q5AE6AfLuXU65oZEvB1Gk/s/NxWK2ZeHg7ozGl6qPv5dj2k3cDv0nr/UopmIpemTVEoj/V9cgBLu/+Mc4PSOpmVg+2kfowegEvKUzMyTh8TGOd5oSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHDLUeUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A59C3277B;
	Tue, 18 Jun 2024 12:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714262;
	bh=X0tAiBJPBMS2Sym2Di+jZS/UBuaLHIAG8Kf/jbT6/5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHDLUeUcZtWz2MRt3r/FDbEwhSXvTX6b0bjQO1ghJXVHCm2z3zapYs1Z1zwGO8ROl
	 qxSfetY/lsN8zlYkuEgcc9XyJ55W2OXWyksudQebPigvWisPOmyZW/ozHrllpC7va0
	 SwF9m0swpdvHR/gYx7jYiwKYFVPD8TiOZepNE2qm8PAvRS4EuPtpBNiWj2gFKFyoCq
	 cekm0f/4WFPviSPc9nGC9d0er8zeX5RXOQ9zkQvQlywbx1A3W/Rh2+mmxz1p1lYxU+
	 il1uvjGUn5g8xmVngsmIzrBD8ZMBD2DlnusIYiUz5XnCoPc7nhlGZLxNolPNjPoWxZ
	 BiuoE6XcfIRJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tasos Sahanidis <tasos@tasossah.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	lijo.lazar@amd.com,
	mario.limonciello@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 38/44] drm/amdgpu/pptable: Fix UBSAN array-index-out-of-bounds
Date: Tue, 18 Jun 2024 08:35:19 -0400
Message-ID: <20240618123611.3301370-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit

From: Tasos Sahanidis <tasos@tasossah.com>

[ Upstream commit c6c4dd54012551cce5cde408b35468f2c62b0cce ]

Flexible arrays used [1] instead of []. Replace the former with the latter
to resolve multiple UBSAN warnings observed on boot with a BONAIRE card.

In addition, use the __counted_by attribute where possible to hint the
length of the arrays to the compiler and any sanitizers.

Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/include/pptable.h | 91 ++++++++++++++-------------
 1 file changed, 49 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
index 2e8e6c9875f6c..f83ace2d7ec30 100644
--- a/drivers/gpu/drm/amd/include/pptable.h
+++ b/drivers/gpu/drm/amd/include/pptable.h
@@ -477,31 +477,30 @@ typedef struct _ATOM_PPLIB_STATE_V2
 } ATOM_PPLIB_STATE_V2;
 
 typedef struct _StateArray{
-    //how many states we have 
-    UCHAR ucNumEntries;
-    
-    ATOM_PPLIB_STATE_V2 states[1];
+	//how many states we have
+	UCHAR ucNumEntries;
+
+	ATOM_PPLIB_STATE_V2 states[] /* __counted_by(ucNumEntries) */;
 }StateArray;
 
 
 typedef struct _ClockInfoArray{
-    //how many clock levels we have
-    UCHAR ucNumEntries;
-    
-    //sizeof(ATOM_PPLIB_CLOCK_INFO)
-    UCHAR ucEntrySize;
-    
-    UCHAR clockInfo[];
+	//how many clock levels we have
+	UCHAR ucNumEntries;
+
+	//sizeof(ATOM_PPLIB_CLOCK_INFO)
+	UCHAR ucEntrySize;
+
+	UCHAR clockInfo[];
 }ClockInfoArray;
 
 typedef struct _NonClockInfoArray{
+	//how many non-clock levels we have. normally should be same as number of states
+	UCHAR ucNumEntries;
+	//sizeof(ATOM_PPLIB_NONCLOCK_INFO)
+	UCHAR ucEntrySize;
 
-    //how many non-clock levels we have. normally should be same as number of states
-    UCHAR ucNumEntries;
-    //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
-    UCHAR ucEntrySize;
-    
-    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[];
+	ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[] __counted_by(ucNumEntries);
 }NonClockInfoArray;
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
@@ -513,8 +512,10 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Table
 {
-    UCHAR ucNumEntries;                                                // Number of entries.
-    ATOM_PPLIB_Clock_Voltage_Dependency_Record entries[1];             // Dynamically allocate entries.
+	// Number of entries.
+	UCHAR ucNumEntries;
+	// Dynamically allocate entries.
+	ATOM_PPLIB_Clock_Voltage_Dependency_Record entries[] __counted_by(ucNumEntries);
 }ATOM_PPLIB_Clock_Voltage_Dependency_Table;
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
@@ -529,8 +530,10 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Table
 {
-    UCHAR ucNumEntries;                                                // Number of entries.
-    ATOM_PPLIB_Clock_Voltage_Limit_Record entries[1];                  // Dynamically allocate entries.
+	// Number of entries.
+	UCHAR ucNumEntries;
+	// Dynamically allocate entries.
+	ATOM_PPLIB_Clock_Voltage_Limit_Record entries[] __counted_by(ucNumEntries);
 }ATOM_PPLIB_Clock_Voltage_Limit_Table;
 
 union _ATOM_PPLIB_CAC_Leakage_Record
@@ -553,8 +556,10 @@ typedef union _ATOM_PPLIB_CAC_Leakage_Record ATOM_PPLIB_CAC_Leakage_Record;
 
 typedef struct _ATOM_PPLIB_CAC_Leakage_Table
 {
-    UCHAR ucNumEntries;                                                 // Number of entries.
-    ATOM_PPLIB_CAC_Leakage_Record entries[1];                           // Dynamically allocate entries.
+	// Number of entries.
+	UCHAR ucNumEntries;
+	// Dynamically allocate entries.
+	ATOM_PPLIB_CAC_Leakage_Record entries[] __counted_by(ucNumEntries);
 }ATOM_PPLIB_CAC_Leakage_Table;
 
 typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
@@ -568,8 +573,10 @@ typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
 
 typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Table
 {
-    UCHAR ucNumEntries;                                                 // Number of entries.
-    ATOM_PPLIB_PhaseSheddingLimits_Record entries[1];                   // Dynamically allocate entries.
+	// Number of entries.
+	UCHAR ucNumEntries;
+	// Dynamically allocate entries.
+	ATOM_PPLIB_PhaseSheddingLimits_Record entries[] __counted_by(ucNumEntries);
 }ATOM_PPLIB_PhaseSheddingLimits_Table;
 
 typedef struct _VCEClockInfo{
@@ -580,8 +587,8 @@ typedef struct _VCEClockInfo{
 }VCEClockInfo;
 
 typedef struct _VCEClockInfoArray{
-    UCHAR ucNumEntries;
-    VCEClockInfo entries[1];
+	UCHAR ucNumEntries;
+	VCEClockInfo entries[] __counted_by(ucNumEntries);
 }VCEClockInfoArray;
 
 typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
@@ -592,8 +599,8 @@ typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
 
 typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table
 {
-    UCHAR numEntries;
-    ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[1];
+	UCHAR numEntries;
+	ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_VCE_State_Record
@@ -604,8 +611,8 @@ typedef struct _ATOM_PPLIB_VCE_State_Record
 
 typedef struct _ATOM_PPLIB_VCE_State_Table
 {
-    UCHAR numEntries;
-    ATOM_PPLIB_VCE_State_Record entries[1];
+	UCHAR numEntries;
+	ATOM_PPLIB_VCE_State_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_VCE_State_Table;
 
 
@@ -626,8 +633,8 @@ typedef struct _UVDClockInfo{
 }UVDClockInfo;
 
 typedef struct _UVDClockInfoArray{
-    UCHAR ucNumEntries;
-    UVDClockInfo entries[1];
+	UCHAR ucNumEntries;
+	UVDClockInfo entries[] __counted_by(ucNumEntries);
 }UVDClockInfoArray;
 
 typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record
@@ -638,8 +645,8 @@ typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record
 
 typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table
 {
-    UCHAR numEntries;
-    ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record entries[1];
+	UCHAR numEntries;
+	ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_UVD_Table
@@ -657,8 +664,8 @@ typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Record
 }ATOM_PPLIB_SAMClk_Voltage_Limit_Record;
 
 typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Table{
-    UCHAR numEntries;
-    ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[];
+	UCHAR numEntries;
+	ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_SAMClk_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_SAMU_Table
@@ -675,8 +682,8 @@ typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Record
 }ATOM_PPLIB_ACPClk_Voltage_Limit_Record;
 
 typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Table{
-    UCHAR numEntries;
-    ATOM_PPLIB_ACPClk_Voltage_Limit_Record entries[1];
+	UCHAR numEntries;
+	ATOM_PPLIB_ACPClk_Voltage_Limit_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_ACPClk_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_ACP_Table
@@ -743,9 +750,9 @@ typedef struct ATOM_PPLIB_VQ_Budgeting_Record{
 } ATOM_PPLIB_VQ_Budgeting_Record;
 
 typedef struct ATOM_PPLIB_VQ_Budgeting_Table {
-    UCHAR revid;
-    UCHAR numEntries;
-    ATOM_PPLIB_VQ_Budgeting_Record         entries[1];
+	UCHAR revid;
+	UCHAR numEntries;
+	ATOM_PPLIB_VQ_Budgeting_Record entries[] __counted_by(numEntries);
 } ATOM_PPLIB_VQ_Budgeting_Table;
 
 #pragma pack()
-- 
2.43.0


