Return-Path: <stable+bounces-244277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOUzF/du+mnJOwMAu9opvQ
	(envelope-from <stable+bounces-244277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:28:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ED24D451F
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C907301C88E
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 22:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0862A48C8C1;
	Tue,  5 May 2026 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GzYtfSdF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162E3ED5A7
	for <stable@vger.kernel.org>; Tue,  5 May 2026 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020079; cv=none; b=a9tITtbVQYwlBmCdzS6dTThrpt/VDPaFsTdoe4H2anbsjIh67zIJjnWkru9wFdWSK2p+oB/deRPFclUnyClZMX8czqy368839FUOz3qyohM2eD4D3kSDprqBMuMJ4E9Amam18NF5IeMV2iUqzZfmIuqGVPOkXW8al+xBAhxycDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020079; c=relaxed/simple;
	bh=iP8Z6aS3jWYwsoNHn+ZLd4kSc3HoRstSzuTfrylVckw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzHjPtQR0J6fPBgz/I6IbAleInyOZ/uDfgVb6eYIsPKMwoJWg9IVLZOYqJHe1FYtRg+bzr5LQXOnri558DIKrdpRSZYL86nX3tVx//Bg1WDC5N26bRe+b5GyZgHwD+vlL6fYdVqmVomJI7W7cT6ilpZUs+eunw5nkaFb7VAPUAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GzYtfSdF; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-7b37d84a6b3so60785297b3.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020076; x=1778624876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2hbQneUJWNpYNXnzo7++xJZc6uJ9kixg0kEf8k1k0U=;
        b=i7hRuu5feoHPsK8BxFnJJ6SeWZae9sn+7NOtWWY1ttbO6aAOrgksmTD6jUp/V2QGa+
         DqCEj9hTy0c4FEX7cugEPwjFJ+6eP2jffJYwQGv4Rtw30njxzjr/jk7ADyb4u4knptKW
         MEjwGYQ8+HBesac1n399Y9aJWMBHhL47iR6zglQQwOovllNqhhgGOy2+AAwLibHGiPal
         HGV8KJhq/w/dgIx8x0rum9pr120quZfG3xPv7yoRj47zgrpMbIejSgAH5wcL0Of6b0Yh
         yriAR2NEeUnoDjJa8u8qJA5aNfkgeq1zCrNIWcPGhwiiKHO5eNeb8F/vLLeJiFWHSqG5
         jKXw==
X-Forwarded-Encrypted: i=1; AFNElJ8bAVhe2u2wWMa6JWiGFSyR+uJrN1QHr7x8O25j+6RdRGaeUMrjFMd59NqbbwjmkDEcUxyZEFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFHnsHFQeGSKGuePMw6sp3JP6vvlA4/ZAPUS0DUYqglGa6TF9r
	IlPkTrljGXPFKMrK5jqtKxzgIhGG7EDJ4nkAbUyo3jB1uSWAiPQtFGDysB91raZrM6cKcV3LHW1
	DhwD6v/TIGQWxB5Mpi9ZtC8AHXu7JttT3TkzwoWn+ut7ndlx3gRFWvjnnSE0LoVOwmCloluSWbI
	4j6WjSJVmUTmMwAS7Zqf6ndUJf4wiNyo894joEO8rscf/Gzf3Fc2g0KVJUbZG005O3h3KnXZ6R3
	USOUKHy
X-Gm-Gg: AeBDievmZG2w1ImqFIfxo3dTCbo/YF95mp0V44wlLQbEsoMSSK6TrTUZ2WU9fzSQC0v
	WsFirZKPQpDx9MAfAOEaB02zrfPnpDDfe4cPc0I6daRTEUuZ3BatipaBQ7irDYMA7wN8ofVn3R6
	4ReUl3LQOIlkdRqoCT7XgfNtkD/S6LI/23qLaWjoF418iry9uGsFFlbyKKq1J0HK3sCTmnoPI9y
	6vQ9mzRhpj1dIh1ee9qCjaUgJRKf1k9m2i/CiHxxKsid/H9+acG5SjNeSM1JdJYG7KoUw1RKOkx
	nHlTc6Bt6gD4Etwi1ZNTpRwOpM5G2Bu9Danlz/wnE6vqp8uRMTgokp0ChbqDZUblDdzRktmAAUp
	aOYX+acf3zrNawmAllAGIpFMuz8SMla+lDcoCPCSvfO+aOGIQcEu/qdyRE4JeKBSpEQV1FNt7QL
	/TJO6gbCmjAP5d
X-Received: by 2002:a05:690c:4d83:b0:7b2:136d:240a with SMTP id 00721157ae682-7bdf5d657a9mr14888327b3.9.1778020076143;
        Tue, 05 May 2026 15:27:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-65c7b00875dsm22490d50.15.2026.05.05.15.27.53
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 15:27:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8bc140520c7so13626626d6.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778020073; x=1778624873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2hbQneUJWNpYNXnzo7++xJZc6uJ9kixg0kEf8k1k0U=;
        b=GzYtfSdFhoT+TRYZEsiTTzZIxjAOeCksBTaezVxRnGp+VBIutjZ2dPB8K71y4eYWSW
         +szOY+Nffip5cjI4guRJWS1Zal+7Tn1OxDU7R4VwJa+UXV93vfvUYFAP51NgSrzrsEqi
         jTkjsLTdQ7wX6eOx5QYoB5Ryee+A1KGG0SIcw=
X-Forwarded-Encrypted: i=1; AFNElJ+j0tvn/3N6fdoDEwD7SFNU+YMztYmfXA2FH8beSUaSZMoXn+8GFudRMvOFEDHFWnsvwdjqh8M=@vger.kernel.org
X-Received: by 2002:ad4:5d4a:0:b0:8ac:a553:529d with SMTP id 6a1803df08f44-8bc43df5d35mr11704136d6.23.1778020073313;
        Tue, 05 May 2026 15:27:53 -0700 (PDT)
X-Received: by 2002:ad4:5d4a:0:b0:8ac:a553:529d with SMTP id 6a1803df08f44-8bc43df5d35mr11703676d6.23.1778020072755;
        Tue, 05 May 2026 15:27:52 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:27:51 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 06/12] drm/vmwgfx: validate DRAW_PRIMITIVES header size before division
Date: Tue,  5 May 2026 18:22:27 -0400
Message-ID: <20260505222728.519626-7-zack.rusin@broadcom.com>
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
X-Rspamd-Queue-Id: 87ED24D451F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244277-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

vmw_cmd_draw() computes

	maxnum = (header->size - sizeof(cmd->body)) / sizeof(*decl);

where header->size is u32 and is taken straight from the user-supplied
command stream.  When header->size is less than sizeof(cmd->body) the
unsigned subtraction wraps to nearly 4 GiB, producing a huge maxnum.
Any user-controlled cmd->body.numVertexDecls then passes the bound and
the loop dereferences decl[i] far past the end of the kernel command
bounce buffer, producing an out-of-bounds read of kernel memory.

Reject undersized headers up front.

Fixes: 7a73ba7469cb ("drm/vmwgfx: Use TTM handles instead of SIDs as user-space surface handles.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index b07f052474d0..2410d53a75aa 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1571,11 +1571,17 @@ static int vmw_cmd_draw(struct vmw_private *dev_priv,
 	uint32_t maxnum;
 	int ret;
 
+	cmd = container_of(header, typeof(*cmd), header);
+
+	if (unlikely(header->size < sizeof(cmd->body))) {
+		VMW_DEBUG_USER("Illegal DRAW_PRIMITIVES header size.\n");
+		return -EINVAL;
+	}
+
 	ret = vmw_cmd_cid_check(dev_priv, sw_context, header);
 	if (unlikely(ret != 0))
 		return ret;
 
-	cmd = container_of(header, typeof(*cmd), header);
 	maxnum = (header->size - sizeof(cmd->body)) / sizeof(*decl);
 
 	if (unlikely(cmd->body.numVertexDecls > maxnum)) {
-- 
2.51.0


