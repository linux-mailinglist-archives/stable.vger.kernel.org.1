Return-Path: <stable+bounces-244281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCY2LwBv+mnJOwMAu9opvQ
	(envelope-from <stable+bounces-244281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:28:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 081004D4553
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 651F8304A08A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 22:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BA5495502;
	Tue,  5 May 2026 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AYcZMdpC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D0C494A1D
	for <stable@vger.kernel.org>; Tue,  5 May 2026 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020085; cv=none; b=iWLB5PFRLRWhA/veN8DdDyt2Z54SRWM5MTXK+G/8DH2D9NHXCNK/oZpvrud6UTRnQEzmXrmynyTTYAX2dtZH5vHJXvc0p0j01Da5hS2/UrWDx8PBoPUZnp4mnFgq1l3Myw0PP2VC+8OKTN3u1MT3jxW7oxgGNPx1QPrvtuxi2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020085; c=relaxed/simple;
	bh=yIJMCIe+vxIsL/QxZVL9/bTxhMYCGSvyI+hrHgfPiMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7snY+ZUszdWAG/iOCC2ogsLizei9zq++PNob0gS/7R6FrO+uK1KOsaKxU905qwx2nzQJDFDp4SqgD3Y1be380dckW2qmTkmVfk/UzjUyYTx/8xXirCezU3vWt54hs6+7qrBtM9y/60gqSu2teeazXrNEO8YISoDvrbckPj1HXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AYcZMdpC; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2ba0714574fso16521875ad.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020082; x=1778624882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eh3U9SlhYUGj63M8IEARCrtNxYnzXaqY5JKgDVp0rlc=;
        b=pLjskF5Sul0Yirbd+ZQ01VmT1+K4EeB08KslVGpJsXRaIzggSRtKKaqz9P+GyHkcd0
         K9sKQ+w6l3DfrP9mFlx7tnDwOL82rNvTpttc0+zeGo8E2I3yUV2R/7ZbgjdolPHGyStb
         XQ/bOTXcHvLQw/O7LjAvB5owlU8SRGR+hVdRE5tJ6iJ2LU3BrAqGs89gaZaey9ioo8IE
         Q0bH5+vix4Dh8P4+QTS4L8MG+aYQGX5DrDvDQiwe0d3f+SD3at5g1CUdwMEs21JSK7jA
         qOlWRFU7731XAAWgpyGyeJTj9eMR+fSu2wvB7iprxP2FKV8JFfZCjK0JTzkv4hF8Du4j
         tCbw==
X-Forwarded-Encrypted: i=1; AFNElJ9xj4vLLw5rDwEKry8xFqGffXgDtcwoiXJCBKbISN+4zveZGOlZ5ivwjskoRYY4Bkw4rj6KphA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTvOkMzm7ITuFApvhjw8Ewxg2io8STMwO/B74BfQbGDQthXChS
	UJQW4EmfL9mr5xxrJ1a7ygqcp/3nyLssdqCg/wGu0oHxprwCNnnvgxAuLc4nVU2bD0O+V6QK/QU
	Yrv2Nl5/OP1xUb/2LBLyACcN8xt0c98iPveJijHEzWNy9sOgjQUN3dOnxpzaopVkUDvzFjXIw3K
	PsSt1ejr1pvYInp1LZRdL/4ycGhU4C1/IJVuxPyeLctIlRepdhRZNkhTqdtIOoNKiyUBYxbOpX/
	ySeT1UD
X-Gm-Gg: AeBDietd+g7uVoLTdsnn/4S8f99ZwjNibPznGdtZiexlzWWWHnW3fi824vsylh4qK25
	KI8Oj1813sgrFPHEVuBpO9eAa7rGnFYiz/xWvBp/npFlYigaGB+QWIhFNOYOjAxeybIR4dbfLMe
	nLtlmYoZ3XAiPOmOu4k2Dr7MLt1Bg1bPOydD82i1TysQrpm0gsDAzPk3m4NH5M4gCK6URPHnsDr
	Lotvx/6irx8JlWTZVdB1Tk4WQ0o9MbAUJa2WPJBPnujCPFcZebKaUtRGkUjrCobXzbZJnxukxa5
	yssVAPzYv8WmDSwXLpTu66HEDn/Id19JZmsjMhh3al+VDdRdxI/nqmI23K1xwjo9iFI+9ReEMTW
	fCi+9va6A2Wk2YMT4bEGj5HEDEE4ycGWw/X1bEo9fpZwZuvQTGVooLxoq36qM+qjlAMgNO6pjci
	+rvb2M3VU0VY3aMKGmFQe7tIGsHvg09LbEe4QkVh1G8oeJ2bTWD7BNNH1Q0PjsO4y2
X-Received: by 2002:a17:903:b46:b0:2b2:eb9d:1648 with SMTP id d9443c01a7336-2ba79c25ad9mr7311445ad.37.1778020082381;
        Tue, 05 May 2026 15:28:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ba7ca17f44sm386995ad.51.2026.05.05.15.28.01
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 15:28:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8b49424ad88so138039616d6.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778020081; x=1778624881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh3U9SlhYUGj63M8IEARCrtNxYnzXaqY5JKgDVp0rlc=;
        b=AYcZMdpCZmXQ9A7tFzNaSMRH4FkfxZ9ybi24EH3gPJOyznbjgKvYXi0ZD8AKGY3K+U
         TxbIXs72tI+B+LHwMFM9FPtBdDReS1iWeDGKaVhF0bbwQUuqWQWHzrmxIsNswAG07ST2
         +++hAIGdwebqGWggZTG4i6B4KYehRyoiuVoI0=
X-Forwarded-Encrypted: i=1; AFNElJ+oXn/sYf+nhueY4kuib2KkoWA5Blp56sOvTnWS9ohlTEf7up6yYAlYga6fi9N1JgWjrSoO+e0=@vger.kernel.org
X-Received: by 2002:a05:6214:451b:b0:8ac:800f:10da with SMTP id 6a1803df08f44-8bc422a64abmr12547116d6.4.1778020080939;
        Tue, 05 May 2026 15:28:00 -0700 (PDT)
X-Received: by 2002:a05:6214:451b:b0:8ac:800f:10da with SMTP id 6a1803df08f44-8bc422a64abmr12546696d6.4.1778020080483;
        Tue, 05 May 2026 15:28:00 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:27:59 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 11/12] drm/vmwgfx: use check_add_overflow for shader size+offset bound
Date: Tue,  5 May 2026 18:22:32 -0400
Message-ID: <20260505222728.519626-12-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 081004D4553
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244281-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

vmw_shader_define() validates the user-supplied shader window against
its backing buffer with

	(u64)buffer->tbo.base.size < (u64)size + (u64)offset

drm_vmw_shader_create_arg::offset is __u64 in the uapi; when it is
near U64_MAX the unsigned addition wraps and the resulting tiny value
passes the check.  The unbounded offset is then stored in
res->guest_memory_offset and forwarded to host SVGA shader-create
commands.

Use check_add_overflow() to detect the wrap and compare the resulting
endpoint against the buffer size.

Fixes: 668b206601c5 ("drm/vmwgfx: Stop using raw ttm_buffer_object's")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index eca4e3e97eb4..39811cf19db1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -25,6 +25,8 @@
  *
  **************************************************************************/
 
+#include <linux/overflow.h>
+
 #include <drm/ttm/ttm_placement.h>
 
 #include "vmwgfx_binding.h"
@@ -685,7 +687,7 @@ int vmw_shader_destroy_ioctl(struct drm_device *dev, void *data,
 static int vmw_user_shader_alloc(struct vmw_private *dev_priv,
 				 struct vmw_bo *buffer,
 				 size_t shader_size,
-				 size_t offset,
+				 u64 offset,
 				 SVGA3dShaderType shader_type,
 				 uint8_t num_input_sig,
 				 uint8_t num_output_sig,
@@ -739,7 +741,7 @@ static int vmw_user_shader_alloc(struct vmw_private *dev_priv,
 static struct vmw_resource *vmw_shader_alloc(struct vmw_private *dev_priv,
 					     struct vmw_bo *buffer,
 					     size_t shader_size,
-					     size_t offset,
+					     u64 offset,
 					     SVGA3dShaderType shader_type)
 {
 	struct vmw_shader *shader;
@@ -768,7 +770,7 @@ static struct vmw_resource *vmw_shader_alloc(struct vmw_private *dev_priv,
 
 static int vmw_shader_define(struct drm_device *dev, struct drm_file *file_priv,
 			     enum drm_vmw_shader_type shader_type_drm,
-			     u32 buffer_handle, size_t size, size_t offset,
+			     u32 buffer_handle, size_t size, u64 offset,
 			     uint8_t num_input_sig, uint8_t num_output_sig,
 			     uint32_t *shader_handle)
 {
@@ -779,13 +781,16 @@ static int vmw_shader_define(struct drm_device *dev, struct drm_file *file_priv,
 	int ret;
 
 	if (buffer_handle != SVGA3D_INVALID_ID) {
+		u64 end;
+
 		ret = vmw_user_bo_lookup(file_priv, buffer_handle, &buffer);
 		if (unlikely(ret != 0)) {
 			VMW_DEBUG_USER("Couldn't find buffer for shader creation.\n");
 			return ret;
 		}
 
-		if ((u64)buffer->tbo.base.size < (u64)size + (u64)offset) {
+		if (check_add_overflow((u64)size, (u64)offset, &end) ||
+		    end > buffer->tbo.base.size) {
 			VMW_DEBUG_USER("Illegal buffer- or shader size.\n");
 			ret = -EINVAL;
 			goto out_bad_arg;
-- 
2.51.0


