Return-Path: <stable+bounces-273905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RPBHKykhVWozkQAAu9opvQ
	(envelope-from <stable+bounces-273905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:32:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C27374E095
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:32:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=FD7eTgtL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273905-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273905-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93468303C2A9
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0315348C42;
	Mon, 13 Jul 2026 17:30:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0EF348C6A
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:30:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963836; cv=none; b=hFSxZ3N/t1dVqiUlSv1dJWtzMHkaVzCE6mxkCtdig/0+sQj2cIBNXRTh99Z5oyaerJzSIFFztaq6lKNal7XDKy9fO5T7WszjVszR1H+1LxtXURPz6IMO88b8lblIRRAwtdj0qezLF1d1pdjdKaVOAswmMCdRujKAZKLgNL+dHBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963836; c=relaxed/simple;
	bh=PcyM4CQHbO5KMJ3N1bAHLttCr4/v1lxQVOiHVJpdnVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDiicGHfaKJywAOh8Uryl79MAQlfG7gzF4HwEBWaP5+IHxOlTguxW0JIXTfE5kUPk0G/fOcAiWnSW4o3rxCNRfIL41JRRHI8F0xX/I24Dszorqfd+Sjwfd2cQg7mL/QQZ/CwXOKPMFcd6kZzdRMkHTwdF4LpgNisbEU6qSVABG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=FD7eTgtL; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso13570725e9.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783963833; x=1784568633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h1VuKaNm+FCqQ0Qgm5d1hgzA1jRjKkQpwwjQu1kdhRU=;
        b=FD7eTgtLx1xYBziB8cjCjHw76SBRlr5EkIuG2xN13drGz1IXuwzxKPCctip4XpOXV4
         aZBb0cyoeQQzQUCQERwH4bn8alBHKHeFxDyMnlyKIW9IM3qfRUV27WsfDV0j7yd6K5Nd
         jlDiXOzuyaCqZiMsBEnCUtBxqhW1JKlibPJvHBBNU34T4Ac4mYTWxjLwZ4G0hbMeH62i
         tJbrphRTxiee6IAjM1IBZod6woMIaw89z/YHTXkPkLoJWhMJ8czVxl7TeSVrUaVGCQ51
         5ukff30spfuF/bm6ueEPVvfuHjInhSpsdUOI3dKrI811q/CAtqsfRz0snTHMMsYGRMn2
         UfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783963833; x=1784568633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h1VuKaNm+FCqQ0Qgm5d1hgzA1jRjKkQpwwjQu1kdhRU=;
        b=CKvkQ9wJ8CfEEXcAKDa6zmLZwPCcSwJCpdENN0ru45Z1BYiuX216cTYIB1XcP+WEAu
         Yz972BwJlbqRABHJSPmufpQzk9tVg9A1k/ARmmBfIeOE9i4/1a1ROsnXPHag2kTeuOxs
         gg2Ba2RF+1FmKlq4xxIWFmJhixBDLyM/rPXo8uZbgP2VfjejUcfxe87B+wWbAh98yD2I
         Kw9x/R97egIkPLlAfRiKl7hihVQW+neTj7NyZXvb9h3tN6V5Mskm/otidiyTGxxKDmof
         VbFp8RkOTcpTWTsdWUlVESLYD+MhgIAo1NfYqnAFcpLfRXkEa9S2AClii5nSJjftRB0l
         w0EQ==
X-Forwarded-Encrypted: i=1; AHgh+RoRdQfwKKK1ttqS8eRxO7FX60R8qb70UOwybM+g1VuNvQGeA5NQPcMUgZPDSIyOBwBaOlslQ8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEIXvNFm6Dviik2A22iToDlGkKBUsxpkhkkotDzuj9CupJIOOa
	e9BCqZLFrqxhDku71wOuEgHS8kw/2KUWW8kUUlTyZRUptJGEGX4UAW1fNc7jJKS5CWzO
X-Gm-Gg: AfdE7cnakvDEHFhJnwIuQtTEZdacmFZWzMHDTcnpXOCjiwQGPwJ0W7Hd9bYPZsHGLDK
	1P21gwPURmMjrJ54CDWF5nlvDyyd/5fycx5lqvdwiDVcgx8vb2CAzneY4wx70dFnGdxY/AfQZLh
	MnJ1NjUiAtyP6KGwG25mEhGxEkIV+JmigzFk7WMMzMZpjNVoeGTeGJtmhqCNy9B3VS/ESEBs8iW
	gz6bi2MGE1vgvO9NhBr5pU9WpJed9nZYldnz4tIZdl6fEZ6s0YOyuZIP7kYUkaDtBGgBYnuYDl0
	pEH6Ea7qPr6wxApGMx6EyPjkCgbSDXbrCp3LnoAo6wZCXZ1ES1mSZ1P99KZuNWwKvli1JfIPx0+
	mRB3v1A7ePAoHgXPU3jrs3jfWnrKbLSr8cDzN9Gtj1pcRfkkt22LUeX5VqVec2v4Gf3UikNtUev
	t/+4G/Ge5sAs4ErAt6y+L2ktdlQd/q2YdDYVD9ICYByb9MysokT48rhFjTeD47WpsVPHcyaLct3
	t19QmkaCAcPy7ntGovTDBUyidZXUE9ur//c5m/hKzVjrw==
X-Received: by 2002:a05:600c:6303:b0:493:cfe8:5b36 with SMTP id 5b1f17b1804b1-495158c6a1bmr3362305e9.8.1783963833325;
        Mon, 13 Jul 2026 10:30:33 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f3a60404sm260075855e9.1.2026.07.13.10.30.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 10:30:32 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] accel/amdxdna: reject user command submission without a command BO
Date: Mon, 13 Jul 2026 19:30:28 +0200
Message-ID: <20260713173030.87541-2-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713173030.87541-1-doruk@0sec.ai>
References: <20260713173030.87541-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mamin506@gmail.com,m:lizhi.hou@amd.com,m:ogabbay@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:doruk@0sec.ai,m:stable@vger.kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273905-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,amd.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,0sec.ai:email,0sec.ai:dkim,0sec.ai:url,0sec.ai:from_mime,0sec.ai:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C27374E095

amdxdna_drm_submit_execbuf() passes the user-supplied command BO handle
straight into amdxdna_cmd_submit() with drv_cmd == NULL. When the handle
is AMDXDNA_INVALID_BO_HANDLE (0), the block that fetches job->cmd_bo is
skipped, leaving it NULL, and no check rejects it on the user path (the
!job->cmd_bo guard lives inside the != INVALID branch).

The job is then armed and pushed to the DRM scheduler.
aie2_sched_job_run() takes the drv_cmd == NULL path and calls
amdxdna_cmd_set_state(job->cmd_bo) -> amdxdna_gem_vmap(NULL) ->
to_gobj(NULL)->dev, a NULL pointer dereference in the drm_sched worker.
A process with access to the accel node on a system with a probed AMD NPU
can trigger a kernel oops with a single AMDXDNA_EXEC_CMD ioctl
(cmd_handles = 0).

Only internal driver commands (SYNC_DEBUG_BO / ATTACH_DEBUG_BO)
legitimately pass AMDXDNA_INVALID_BO_HANDLE, and they always set drv_cmd.
Reject the invalid handle for user submissions (drv_cmd == NULL) at the
submit choke point so every user path is covered.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 8f8df9d04ec5..a5c8c2c4de6d 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -603,6 +603,16 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 			ret = -EINVAL;
 			goto free_job;
 		}
+	} else if (!drv_cmd) {
+		/*
+		 * Only internal driver commands (drv_cmd != NULL) may omit a
+		 * command BO. A user command submission with the invalid handle
+		 * would leave job->cmd_bo NULL and later fault when the scheduler
+		 * dereferences it in amdxdna_cmd_set_state().
+		 */
+		XDNA_DBG(xdna, "Command BO handle required for user submission");
+		ret = -EINVAL;
+		goto free_job;
 	}
 
 	ret = amdxdna_arg_bos_lookup(client, job, arg_bo_hdls, arg_bo_cnt);
-- 
2.43.0


