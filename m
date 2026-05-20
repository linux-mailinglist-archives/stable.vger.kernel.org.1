Return-Path: <stable+bounces-250290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MxtE7rmDWqm4gUAu9opvQ
	(envelope-from <stable+bounces-250290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:52:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2685928E7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0E3330AF6F0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C6F370AF4;
	Wed, 20 May 2026 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1lIyZBEE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538263D7D74;
	Wed, 20 May 2026 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295027; cv=none; b=Gr2IoOLVU/vsE0By0zxvEndflimjLt1gNOS/Z9Dty2t9UXoErpOaN01ez6noadYZSLtv/NilCJdupYGcaXnc5SvZCHrKLwpjk/md3OXIH4C8/5VXHpNQwx5BO6/EmSJ2JCoKfWKhpKIUwWV3kwQm6//mgQQQF8HSZVXPAPHYuCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295027; c=relaxed/simple;
	bh=scpvrgMIWN3IpmKYp4b6T/vpkZufXP2CxfGFvLyRqus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je1FGSMDwJ8wxWqE+6oaiGVrk2AQZXuLe0MAMbzT7ZV5iNj/Jo3PW1usp9au1zegaArr8iRXT5pFtxUSoWguByxYdVIRc6TidxUbOAWoQMbBykLLwgiQuQyF49tOKR0MRHwNrRHYmNbr8w/9/bWV1AYya39FAvey7kXzEeZ15aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1lIyZBEE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41C41F00894;
	Wed, 20 May 2026 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295024;
	bh=XZovqm+oL6yE9cqmjPSWkkXM2PzkiEwDXZ7fYk5Uat8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1lIyZBEEXaCFjcGFUOsvBtVIu8pb2wYVt55LBWEnHgRFIExvQg+CoK8BJYIv7kxh5
	 aXLsPFzAdFAG1B/82adHmWLjx2gWNyQEcKTSsBpXRN3TSFQVvHj0aG3yxIHkB9g8eS
	 IFAVXuKn2TS1LMDAN1NCHd36A0yi7I+bTVICDk+o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eliot Courtney <ecourtney@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0263/1146] gpu: nova-core: falcon: rename load parameters to reflect DMA dependency
Date: Wed, 20 May 2026 18:08:33 +0200
Message-ID: <20260520162154.179430568@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250290-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 1D2685928E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Courbot <acourbot@nvidia.com>

[ Upstream commit 8a623869b8269dbf52d52711cd7b9355044b6b53 ]

The current `FalconLoadParams` and `FalconLoadTarget` types are fit for
DMA loading, but not so much for PIO loading which will require its own
types. Start by renaming them to something that indicates that they are
indeed DMA-related.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patch.msgid.link/20260306-turing_prep-v11-3-8f0042c5d026@nvidia.com
[acourbot@nvidia.com: fixup order of import items.]
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Stable-dep-of: 17d7c97f73c7 ("gpu: nova-core: firmware: fix and explain v2 header offsets computations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/nova-core/falcon.rs          | 19 +++++++-------
 drivers/gpu/nova-core/firmware.rs        | 32 ++++++++++++------------
 drivers/gpu/nova-core/firmware/booter.rs | 26 +++++++++----------
 drivers/gpu/nova-core/firmware/fwsec.rs  | 14 +++++------
 4 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 8d444cf9d55c1..808c17e981d19 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -326,9 +326,10 @@ pub(crate) trait FalconEngine:
     const ID: Self;
 }
 
-/// Represents a portion of the firmware to be loaded into a particular memory (e.g. IMEM or DMEM).
+/// Represents a portion of the firmware to be loaded into a particular memory (e.g. IMEM or DMEM)
+/// using DMA.
 #[derive(Debug, Clone)]
-pub(crate) struct FalconLoadTarget {
+pub(crate) struct FalconDmaLoadTarget {
     /// Offset from the start of the source object to copy from.
     pub(crate) src_start: u32,
     /// Offset from the start of the destination memory to copy into.
@@ -348,20 +349,20 @@ pub(crate) struct FalconBromParams {
     pub(crate) ucode_id: u8,
 }
 
-/// Trait for providing load parameters of falcon firmwares.
-pub(crate) trait FalconLoadParams {
+/// Trait implemented by falcon firmwares that can be loaded using DMA.
+pub(crate) trait FalconDmaLoadable {
     /// Returns the firmware data as a slice of bytes.
     fn as_slice(&self) -> &[u8];
 
     /// Returns the load parameters for Secure `IMEM`.
-    fn imem_sec_load_params(&self) -> FalconLoadTarget;
+    fn imem_sec_load_params(&self) -> FalconDmaLoadTarget;
 
     /// Returns the load parameters for Non-Secure `IMEM`,
     /// used only on Turing and GA100.
-    fn imem_ns_load_params(&self) -> Option<FalconLoadTarget>;
+    fn imem_ns_load_params(&self) -> Option<FalconDmaLoadTarget>;
 
     /// Returns the load parameters for `DMEM`.
-    fn dmem_load_params(&self) -> FalconLoadTarget;
+    fn dmem_load_params(&self) -> FalconDmaLoadTarget;
 
     /// Returns the parameters to write into the BROM registers.
     fn brom_params(&self) -> FalconBromParams;
@@ -373,7 +374,7 @@ pub(crate) trait FalconLoadParams {
 /// Trait for a falcon firmware.
 ///
 /// A falcon firmware can be loaded on a given engine.
-pub(crate) trait FalconFirmware: FalconLoadParams {
+pub(crate) trait FalconFirmware: FalconDmaLoadable {
     /// Engine on which this firmware is to be loaded.
     type Target: FalconEngine;
 }
@@ -421,7 +422,7 @@ impl<E: FalconEngine + 'static> Falcon<E> {
         bar: &Bar0,
         dma_obj: &DmaObject,
         target_mem: FalconMem,
-        load_offsets: FalconLoadTarget,
+        load_offsets: FalconDmaLoadTarget,
     ) -> Result {
         const DMA_LEN: u32 = 256;
 
diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index be911d0a38276..186f166564651 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -16,8 +16,8 @@ use kernel::{
 
 use crate::{
     falcon::{
-        FalconFirmware,
-        FalconLoadTarget, //
+        FalconDmaLoadTarget,
+        FalconFirmware, //
     },
     gpu,
     num::{
@@ -170,9 +170,9 @@ pub(crate) trait FalconUCodeDescriptor {
         ((hdr & HDR_SIZE_MASK) >> HDR_SIZE_SHIFT).into_safe_cast()
     }
 
-    fn imem_sec_load_params(&self) -> FalconLoadTarget;
-    fn imem_ns_load_params(&self) -> Option<FalconLoadTarget>;
-    fn dmem_load_params(&self) -> FalconLoadTarget;
+    fn imem_sec_load_params(&self) -> FalconDmaLoadTarget;
+    fn imem_ns_load_params(&self) -> Option<FalconDmaLoadTarget>;
+    fn dmem_load_params(&self) -> FalconDmaLoadTarget;
 }
 
 impl FalconUCodeDescriptor for FalconUCodeDescV2 {
@@ -204,24 +204,24 @@ impl FalconUCodeDescriptor for FalconUCodeDescV2 {
         0
     }
 
-    fn imem_sec_load_params(&self) -> FalconLoadTarget {
-        FalconLoadTarget {
+    fn imem_sec_load_params(&self) -> FalconDmaLoadTarget {
+        FalconDmaLoadTarget {
             src_start: 0,
             dst_start: self.imem_sec_base,
             len: self.imem_sec_size,
         }
     }
 
-    fn imem_ns_load_params(&self) -> Option<FalconLoadTarget> {
-        Some(FalconLoadTarget {
+    fn imem_ns_load_params(&self) -> Option<FalconDmaLoadTarget> {
+        Some(FalconDmaLoadTarget {
             src_start: 0,
             dst_start: self.imem_phys_base,
             len: self.imem_load_size.checked_sub(self.imem_sec_size)?,
         })
     }
 
-    fn dmem_load_params(&self) -> FalconLoadTarget {
-        FalconLoadTarget {
+    fn dmem_load_params(&self) -> FalconDmaLoadTarget {
+        FalconDmaLoadTarget {
             src_start: self.dmem_offset,
             dst_start: self.dmem_phys_base,
             len: self.dmem_load_size,
@@ -258,21 +258,21 @@ impl FalconUCodeDescriptor for FalconUCodeDescV3 {
         self.signature_versions
     }
 
-    fn imem_sec_load_params(&self) -> FalconLoadTarget {
-        FalconLoadTarget {
+    fn imem_sec_load_params(&self) -> FalconDmaLoadTarget {
+        FalconDmaLoadTarget {
             src_start: 0,
             dst_start: self.imem_phys_base,
             len: self.imem_load_size,
         }
     }
 
-    fn imem_ns_load_params(&self) -> Option<FalconLoadTarget> {
+    fn imem_ns_load_params(&self) -> Option<FalconDmaLoadTarget> {
         // Not used on V3 platforms
         None
     }
 
-    fn dmem_load_params(&self) -> FalconLoadTarget {
-        FalconLoadTarget {
+    fn dmem_load_params(&self) -> FalconDmaLoadTarget {
+        FalconDmaLoadTarget {
             src_start: self.imem_load_size,
             dst_start: self.dmem_phys_base,
             len: self.dmem_load_size,
diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index ab7956602e758..1a6b2a7e17906 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -18,9 +18,9 @@ use crate::{
         sec2::Sec2,
         Falcon,
         FalconBromParams,
-        FalconFirmware,
-        FalconLoadParams,
-        FalconLoadTarget, //
+        FalconDmaLoadTarget,
+        FalconDmaLoadable,
+        FalconFirmware, //
     },
     firmware::{
         BinFirmware,
@@ -248,12 +248,12 @@ impl<'a> FirmwareSignature<BooterFirmware> for BooterSignature<'a> {}
 /// The `Booter` loader firmware, responsible for loading the GSP.
 pub(crate) struct BooterFirmware {
     // Load parameters for Secure `IMEM` falcon memory.
-    imem_sec_load_target: FalconLoadTarget,
+    imem_sec_load_target: FalconDmaLoadTarget,
     // Load parameters for Non-Secure `IMEM` falcon memory,
     // used only on Turing and GA100
-    imem_ns_load_target: Option<FalconLoadTarget>,
+    imem_ns_load_target: Option<FalconDmaLoadTarget>,
     // Load parameters for `DMEM` falcon memory.
-    dmem_load_target: FalconLoadTarget,
+    dmem_load_target: FalconDmaLoadTarget,
     // BROM falcon parameters.
     brom_params: FalconBromParams,
     // Device-mapped firmware image.
@@ -362,7 +362,7 @@ impl BooterFirmware {
         let (imem_sec_dst_start, imem_ns_load_target) = if chipset <= Chipset::GA100 {
             (
                 app0.offset,
-                Some(FalconLoadTarget {
+                Some(FalconDmaLoadTarget {
                     src_start: 0,
                     dst_start: load_hdr.os_code_offset,
                     len: load_hdr.os_code_size,
@@ -373,13 +373,13 @@ impl BooterFirmware {
         };
 
         Ok(Self {
-            imem_sec_load_target: FalconLoadTarget {
+            imem_sec_load_target: FalconDmaLoadTarget {
                 src_start: app0.offset,
                 dst_start: imem_sec_dst_start,
                 len: app0.len,
             },
             imem_ns_load_target,
-            dmem_load_target: FalconLoadTarget {
+            dmem_load_target: FalconDmaLoadTarget {
                 src_start: load_hdr.os_data_offset,
                 dst_start: 0,
                 len: load_hdr.os_data_size,
@@ -390,20 +390,20 @@ impl BooterFirmware {
     }
 }
 
-impl FalconLoadParams for BooterFirmware {
+impl FalconDmaLoadable for BooterFirmware {
     fn as_slice(&self) -> &[u8] {
         self.ucode.0.as_slice()
     }
 
-    fn imem_sec_load_params(&self) -> FalconLoadTarget {
+    fn imem_sec_load_params(&self) -> FalconDmaLoadTarget {
         self.imem_sec_load_target.clone()
     }
 
-    fn imem_ns_load_params(&self) -> Option<FalconLoadTarget> {
+    fn imem_ns_load_params(&self) -> Option<FalconDmaLoadTarget> {
         self.imem_ns_load_target.clone()
     }
 
-    fn dmem_load_params(&self) -> FalconLoadTarget {
+    fn dmem_load_params(&self) -> FalconDmaLoadTarget {
         self.dmem_load_target.clone()
     }
 
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 7fff3acdaa735..7ac5cfeb594d4 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -30,9 +30,9 @@ use crate::{
         gsp::Gsp,
         Falcon,
         FalconBromParams,
-        FalconFirmware,
-        FalconLoadParams,
-        FalconLoadTarget, //
+        FalconDmaLoadTarget,
+        FalconDmaLoadable,
+        FalconFirmware, //
     },
     firmware::{
         FalconUCodeDesc,
@@ -180,20 +180,20 @@ pub(crate) struct FwsecFirmware {
     ucode: FirmwareObject<Self, Signed>,
 }
 
-impl FalconLoadParams for FwsecFirmware {
+impl FalconDmaLoadable for FwsecFirmware {
     fn as_slice(&self) -> &[u8] {
         self.ucode.0.as_slice()
     }
 
-    fn imem_sec_load_params(&self) -> FalconLoadTarget {
+    fn imem_sec_load_params(&self) -> FalconDmaLoadTarget {
         self.desc.imem_sec_load_params()
     }
 
-    fn imem_ns_load_params(&self) -> Option<FalconLoadTarget> {
+    fn imem_ns_load_params(&self) -> Option<FalconDmaLoadTarget> {
         self.desc.imem_ns_load_params()
     }
 
-    fn dmem_load_params(&self) -> FalconLoadTarget {
+    fn dmem_load_params(&self) -> FalconDmaLoadTarget {
         self.desc.dmem_load_params()
     }
 
-- 
2.53.0




