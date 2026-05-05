Return-Path: <stable+bounces-244272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAoZF+pu+mnJOwMAu9opvQ
	(envelope-from <stable+bounces-244272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:27:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C61304D44B7
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE1FC3024286
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 22:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49309494A1D;
	Tue,  5 May 2026 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gx9Bc2co"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA52C48B362
	for <stable@vger.kernel.org>; Tue,  5 May 2026 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020070; cv=none; b=LhwFGvk3P/eU+aZNGeMn0eFuVsNxU2Zy07QwuRzu9E0jdn7pMFCZGp9jwHSkIGq8yWZTZTgRUWYAT8XLmssZLfpYPtE9O2GjbQ+j8UX5BZNkgVRlsfKmJgVeKg/xuU8GeFr83n4dq5ALWIzI6uNdQvU4wlYDi6h1n5DrtxpMaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020070; c=relaxed/simple;
	bh=2/8FfO3GqvBYQ4gQmnKFP7trLnUxdWBsrFyIDjRM2LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S064WIQ34Z/be38VEc0ZuMaIOXEMeSgPk3PEmF8EXt2PgYYAtxnepBE3XK/Iy1yuWJG2yLGhvO7RvAd40Sw906VjkN7xGs23FuTm64Re/YK1QSCMPrruZBuWwsZ7prXGccXPazoYZOPPruiSPrRAepzBhUv59/A1Fqw0MAJLROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Gx9Bc2co; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-62e902f69e4so2281443137.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020067; x=1778624867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RkYkweVqiLjHd6nDA8uZMmZt+cHr4cYV5wff2Vr4jcU=;
        b=jJGfs2j3WTpWdNoazVQWhKAUL7kpnfK1W76Tbd4IfuANEL40BLjQxW88PmZp4oZ+Ua
         jkZD+eDSs3uT8EOIKT20dGPBsbSw0EKxnLrCw0WNZ3y2BMPoDXB6Gb3SrhSq7iA9Cl3s
         8jXExD8g2uox4g3YNZN2QiDJ50eowjvB4lB2VS0XE9BodWe1XurtNKdxJhefPhS5qp7S
         5/t0OwMqMrox4KA9IgSmT+tPna85ikLhdYNTj6oGRPmJjr1k18E37zDQwxDmb7a2htOs
         gJ54sS1BjvUNFbf6NnapmNSCnAamBdNDbWn7hN2k6+XhXyr8aV1eKFQ2Nq7BI0vJPWwv
         k55Q==
X-Forwarded-Encrypted: i=1; AFNElJ+vaaY8mPnRP0I+Cs5xx1ySDn/9IFXsWIFG0pdEUm2gRSP4qMSRFXZPNqYaFsrTVFRr+Ptf5ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdHYwTXOBGl7SB2/2ijab5fydwd+vqlkHI99EsmlFuezJ+gCYb
	wR/zZ3Ccm9OtqyFpDUFJEMnrcr41/i76H4j9MAZBxyJdaWkz1hyQwnsQ4yWkytGZYEHieCFFJZq
	tswZp/0wE5AIUe/Zvc0S3tVskgNbOAfHmMdYThbGqik5VwGS4dn16s3Wie77DoY0p+OHVutOlqM
	OasI2rvL7WikR/asJ1lTnPQXOv13iQMFStfMjVg77ZqxWFDi/tM1pJd+cmSyOavrFpXH9q7TK9s
	Owj2vUJ
X-Gm-Gg: AeBDievHawgM6rr1T7sA+KKAk7pnSvTHR7mXywOaav8YuI5jfquH3bzmLNu1apmqVA9
	D2ASBzzIAThxdqZTKoDu9G0a6nVoS+VfTiYfPMyFDli2awpKHCjQsUoRkTM9yTOskNGpRYRIsTz
	l+NEkZJ25AmH+E1+l0axY1bdAhHQN8Ixj7lvve13u44SWASYT+qQSTlBvIsQr2c8SRqxjE6eeiL
	bzbhMQY5Cm82lUWPaCtqz6RXrdcayFuG9zl1Ucpkvg34I24FR0vzJkNchgbmpb8PNKRIp+scMIr
	WdZ3q77QDUgJA7AoHw7ruhvFxGSu4+oaPe9m3vxjzbfr61CxSGeAWBBPUmBwRmLlRY0nckRpfFp
	Mp8fB+7T7fIu+loWYEHKblQq5u4wq1BQJ1hbeu5JH7fD8HtyVaqjUL6NfNBAe9IOUwlRRATwtZG
	BpojVXhPsLBbtpe/HoEY/Et6NgGQZernEKX1FMBq9pt9XQeyJ4SQYFJpZ3UFVocWrA
X-Received: by 2002:a05:6102:4429:b0:62f:9d2:a4f3 with SMTP id ada2fe7eead31-630f8fdeb80mr377265137.15.1778020067539;
        Tue, 05 May 2026 15:27:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-62bfbc7cc20sm1141607137.4.2026.05.05.15.27.47
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 15:27:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8b1f4478ca7so157417916d6.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778020067; x=1778624867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkYkweVqiLjHd6nDA8uZMmZt+cHr4cYV5wff2Vr4jcU=;
        b=Gx9Bc2coSVtJDNG/Gk2Vpp+06A0oVELHuGmFYpVDfJVjb/GVEsLuoCyb4IBjT34NbN
         NQXxzUWqzqC9CgPlPrDODOtEwd5ALByqZawFKhgRL/39OFcD+oP+ihKrRD6l5aSuEbL0
         PlH5bi2rZNuKo/uQZJ6icJOYrEo2wqQ7RNJoA=
X-Forwarded-Encrypted: i=1; AFNElJ+5vnetep9t/eiG7Lx93gfzjFS4iWLWoZWTHepUvsalwyg31GtERnRNNqM3CiTPbawQ49LBR1s=@vger.kernel.org
X-Received: by 2002:a0c:e01a:0:b0:89c:6bc6:e4fd with SMTP id 6a1803df08f44-8bc43cfdc0fmr10093136d6.19.1778020066867;
        Tue, 05 May 2026 15:27:46 -0700 (PDT)
X-Received: by 2002:a0c:e01a:0:b0:89c:6bc6:e4fd with SMTP id 6a1803df08f44-8bc43cfdc0fmr10092836d6.19.1778020066420;
        Tue, 05 May 2026 15:27:46 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:27:44 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 02/12] drm/vmwgfx: reject DX_BIND_QUERY without a DX context
Date: Tue,  5 May 2026 18:22:23 -0400
Message-ID: <20260505222728.519626-3-zack.rusin@broadcom.com>
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
X-Rspamd-Queue-Id: C61304D44B7
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
	TAGGED_FROM(0.00)[bounces-244272-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

vmw_cmd_dx_bind_query() unconditionally dereferences
sw_context->dx_ctx_node->ctx.  Userspace can trigger a NULL pointer
dereference from any render-node fd by submitting an execbuf with
dx_context_handle == SVGA3D_INVALID_ID and a SVGA_3D_CMD_DX_BIND_QUERY
opcode in the command stream: dx_ctx_node is left NULL and the kernel
oopses on the assignment.  The same NULL is then re-read in
vmw_resources_reserve() via vmw_context_get_dx_query_mob().

All sibling DX handlers fail-close on a missing dx_ctx_node using
VMW_GET_CTX_NODE().  Use the same pattern here, returning -EINVAL up
front before any relocation state is published.

Fixes: 9c079b8ce8bf ("drm/vmwgfx: Adapt execbuf to the new validation api")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index e1f18020170a..b07f052474d0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1272,9 +1272,13 @@ static int vmw_cmd_dx_bind_query(struct vmw_private *dev_priv,
 				 SVGA3dCmdHeader *header)
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXBindQuery);
+	struct vmw_ctx_validation_info *ctx_node = VMW_GET_CTX_NODE(sw_context);
 	struct vmw_bo *vmw_bo;
 	int ret;
 
+	if (!ctx_node)
+		return -EINVAL;
+
 	cmd = container_of(header, typeof(*cmd), header);
 
 	/*
@@ -1288,7 +1292,7 @@ static int vmw_cmd_dx_bind_query(struct vmw_private *dev_priv,
 		return ret;
 
 	sw_context->dx_query_mob = vmw_bo;
-	sw_context->dx_query_ctx = sw_context->dx_ctx_node->ctx;
+	sw_context->dx_query_ctx = ctx_node->ctx;
 	return 0;
 }
 
-- 
2.51.0


