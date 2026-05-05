Return-Path: <stable+bounces-244276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNe/I/Ru+mngOwMAu9opvQ
	(envelope-from <stable+bounces-244276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:28:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EAF4D4511
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B896C301AA88
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 22:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4434921B0;
	Tue,  5 May 2026 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U0tzTvjt"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF0934BA5B
	for <stable@vger.kernel.org>; Tue,  5 May 2026 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020078; cv=none; b=EMEO+bW5s97cYxO2a4N2C2iNahGayVV+0nszGJtz3SfFcYiBT4ChIEU9EKpd9J59/UXIjU2RIu+x0Rri6n71ay5XVtx+K5wznE+BV+HBCgl55wF1Tv1/F/hcMLba/n0YASyZgU/rTPAQDF8Q/KDSKc33S0Txm3i484FANGBS0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020078; c=relaxed/simple;
	bh=yK0baXeyMLqlataSh/s6apZTX+N4yLOtJZH2kv12Qrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNmNBxmzUeGcN+lpuTh4aIR4EVPI5aAGmTILWMDgpsmpxNsd9lZuRYHLhxiWQitgj6MsJ6wVOp5bBQEyG0kIRgTFRxiO3J5fdVtAMtqlBAc44wRmd39OT/qTJiOeMxzHbS12/UMLUf4xVVXcMIiWZlarOZd3b4iMWd/PetDilU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U0tzTvjt; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-612d8a59cc0so1998029137.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020076; x=1778624876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4laXKsJghpQ0NzWYTQfDQ/6AR2f8qW64EMi9UHORnXY=;
        b=XutVJ7+n0HfXr7kVF2eSn8BwAQWq7qNSFYg1Va5jPU5G0trQnLmC6rD2uJ+zWPD//B
         i3+3LNgWCPasXupiiPpl2MiXiKLXHhJkTJAUiEgXk5/H0TOTQXb52uDf0xG7XzCpZ4FY
         Lu3wWomqJa2rTc67EVu0Tct1vDcPXO3SVss/1T8/vb9nBH970jmukGcuYDiuqQ4/je/r
         ExFVuopFeKve420P4X100M5NcgpiIMc7ESdNSYlKFYNcKtD1elu4+6ceA5I/x4kr7dOT
         sPO12te1GRmH92keRs400grFzbXdDQ+pew5bvhnT/b2wA10D9coFahxE1s8TuysbRxgg
         x9bQ==
X-Forwarded-Encrypted: i=1; AFNElJ/obg2eJ2Dq4zLnuq1thJcj8EMVq1Ix7xJliaeIcF373xJO2XbSR/GgedoQmvU6vMwxhCOKRBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF+j0BED9J4ZrTBv6soyvBF+KrgRragOUcpllbD15hb6hsSAbX
	cqKIvt76sEyHEuUSEY8en7Zw6j8RrI1kW598rahIPyMz/uLn9w5OhgXjJsY7oOgoAJjM3uB5Od1
	TNQPY7vhaUpUn7xBaVn9XSHJNgrQZdTSk9g+FWAgFNSWyGNS73utcTBuxN0AASYC0PBU01YGefN
	TR1PJSrTB4zAAn9RHGP8F+sasgFRPMenqMtZroCZAOKX9nOl8UVOkGezF2TOw9bwLW5XrwjOcm8
	2H3Dnd4
X-Gm-Gg: AeBDietEIGhOpBOb9rou6L7ZEEpGYUuP3k7FqqfsIKNIblAvx1XvYx+BV5WcHWKFd1J
	D0yoMA4cxt1ydqtROfPqMl20CSN7pNmKoV+K//YWqpn2PDiqV1lKyY6DALkBZgBg4uOSeGA3wS8
	X5dS93XuTy4nXh1QA13HK+ZDqSqoU5yq3rMQAql4YJ3MP3x4WFLelL+T8wSAlFUX3o4W0fAzANe
	+WQpQPSbh3NXqHwE/ml1ruBZoA1Aix6Ajc6xJcWGVxx6RLWls9PB5iyG65KcLdGS26j4Cy1aLSu
	t7GFkGte3Eoe4PRKTTNbxPW+dCkZCPIGrnkNh2BRUFZuiRauw32ukrBDsvKjFZ04oZa9aVK8yZw
	gKsz+g7cD8K9md8qvgGLcV2QNQbXuqifG2XmpYr4G3GnfDCzAa7dYWG/Fj2iYxdO0plNN1j86+x
	A1/Ss5MEqdc3BAPMJREhjcSx0=
X-Received: by 2002:a05:6102:84d2:b0:612:c135:1b77 with SMTP id ada2fe7eead31-630f90610d0mr246756137.27.1778020076131;
        Tue, 05 May 2026 15:27:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-62bfe8c613fsm1083130137.21.2026.05.05.15.27.54
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 15:27:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8aca29dcd69so156369886d6.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778020074; x=1778624874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4laXKsJghpQ0NzWYTQfDQ/6AR2f8qW64EMi9UHORnXY=;
        b=U0tzTvjtnzkpGclpEaw41OOE2FBsienJyTOpIjWceOnYhGviTD7PoUrs0vKsqYiBPr
         uCpDAnclvUEhYVvCrNpNNL4uMR/0CqZuMdwH7o2Bq/0jwdjZG5rRzikWGekuFDNHnltx
         uU+I91zOLFlXzSuTz1/DT/XSQe/V6fgAIhFr0=
X-Forwarded-Encrypted: i=1; AFNElJ+mQmTUKFUJtRh/vrzsCL8kqsYEIq66muH/6MmD1tGhocBHVXuJiJPBMp+OPvz4xwf2kQr3dVI=@vger.kernel.org
X-Received: by 2002:a05:6214:cc5:b0:8b5:6654:7556 with SMTP id 6a1803df08f44-8bc45b31797mr11258496d6.42.1778020074318;
        Tue, 05 May 2026 15:27:54 -0700 (PDT)
X-Received: by 2002:a05:6214:cc5:b0:8b5:6654:7556 with SMTP id 6a1803df08f44-8bc45b31797mr11258186d6.42.1778020073857;
        Tue, 05 May 2026 15:27:53 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:27:53 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 07/12] drm/vmwgfx: bound DMA command body size against suffix pointer
Date: Tue,  5 May 2026 18:22:28 -0400
Message-ID: <20260505222728.519626-8-zack.rusin@broadcom.com>
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
X-Rspamd-Queue-Id: 12EAF4D4511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244276-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

vmw_cmd_dma() locates the DMA suffix at

	(unsigned long) &cmd->body + header->size - sizeof(*suffix)

without checking that header->size is large enough to contain both
cmd->body and the suffix.  An undersized header makes the suffix
pointer underflow back into the previous command in the bounce
buffer.  The verifier later writes suffix->maximumOffset, clobbering
verified fields of an already-relocated earlier command -- a TOCTOU
on the device-visible command stream that lets one command rewrite
another's GMR id, surface id, or other authenticated fields.

Reject the command if the body is too small for the suffix to fit.

Fixes: 4e4ddd477743 ("drm/vmwgfx: Fix queries if no dma buffer thrashing is occuring.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 2410d53a75aa..a9136a6523cb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1510,6 +1510,12 @@ static int vmw_cmd_dma(struct vmw_private *dev_priv,
 	bool dirty;
 
 	cmd = container_of(header, typeof(*cmd), header);
+
+	if (unlikely(header->size < sizeof(cmd->body) + sizeof(*suffix))) {
+		VMW_DEBUG_USER("Illegal SVGA_3D_CMD_SURFACE_DMA size.\n");
+		return -EINVAL;
+	}
+
 	suffix = (SVGA3dCmdSurfaceDMASuffix *)((unsigned long) &cmd->body +
 					       header->size - sizeof(*suffix));
 
-- 
2.51.0


