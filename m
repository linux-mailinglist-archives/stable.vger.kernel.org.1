Return-Path: <stable+bounces-230823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pM6tDHajyGnBoAUAu9opvQ
	(envelope-from <stable+bounces-230823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 05:58:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB1035097B
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 05:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1A58300690B
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 03:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161DA155A5D;
	Sun, 29 Mar 2026 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8+ZxyG2"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E804315F
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 03:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774756717; cv=none; b=bl3cRpPdncJocuidU2HpRR8+0MfDsCLW8E3O2bJjAo2EqJsc0HFDWbSKVVcau1vQmnm4rBfyg0oysSD+jpiEYma1lM6GAqFrHxyH2FIL5KxJt1nY0qvTr7obBlWABIhHok0q1qtv2qNAtrxkzBDvT6tlglVMpePNFgS3dgZhQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774756717; c=relaxed/simple;
	bh=m13dAnHvCjRVWpQPODuv4jW4BoL6/LAEJeHjTAxVUxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFMGJuKCCGPUNpjh9ah+DS0lOVtQktCE0CaOmMJvrqT8dzKFjgceOZKdAjLQnRVP1bj/LWr/rxIaOLWpjTWA/7mC5/rf8m9EceveJqihevtyy5UWF1EO+z+ZjqDuLAi80zLdYxInnHe+nmAS1YWvBgpPl6hZIv9/jXW1M3JJCh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8+ZxyG2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a12c19affeso5752873e87.1
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 20:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774756714; x=1775361514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZjD1xkwL8SGkzTUDkV4tP8IGubH08Om/grBGg4rNaE=;
        b=g8+ZxyG2qDKYbvCL0ktDcoEJDACNla4/vioBoAWj8qtWqm1fVootvlOORKky8XfXIY
         p6xJ/xs8oU1Fje90pYA4cpPyN5dfj7dmuhGzDoh41Qi+6DXWY5vS73q4ib/vnYnEbk6W
         EGi77RHkUTzBvqj5/p40wZMpe56wqCv7wDVUOErspV8zgZf4NjOHC1MnFy0hchxoriz5
         /n4L/8jPuhUE5yVPJ2LsB7MYc0MLpCoguKWTzHP4hj10B8QOmuR1qVFyku71C8RryFf8
         ajhywHG6B5RwNSgpSCmtScdoJ3b6bvEKOXjhU6Ig7XzKxk9Z9fQOjyknT0bN4AJ1xP53
         6hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774756714; x=1775361514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ZjD1xkwL8SGkzTUDkV4tP8IGubH08Om/grBGg4rNaE=;
        b=p0QAEJly6YE67NUUwaCKlU3yYpqK2Jzh4gmUdK310L1EV0BtbxUKFxZgF8pqV22NO4
         BPAw1bgqsMs1sZCqp3xg5ACPtpCaa84wyOihUigM/1zYu+rziRPNintzFfJq8NrR+Bv8
         Gx4R2fEnsZPKkh18J9Alj6ockPwTSxz92T+gzKArfqBYbTDgHhu/JHfrr5TkNZsAnGYR
         XKXj2jVW5vRGiSe+9gLVtsOnN8HO3eGAO/rwmhviduZpxYMVLjN4mh2zMV1zWEXIc9i8
         WKN3fhiSR5dL9pFMfHlSCWAwLCi29j5y2hMYMFW1EDDfwv7ZZqOcxFSw3anCCZS1HZ+N
         Jkyw==
X-Forwarded-Encrypted: i=1; AJvYcCWumXepqslysUmuQyOM2nWKBAFWAmXPgyKbtGbeMIGnR4ff8NpescpWVBsNqgIzm4qEgcXVvYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGLhSAZvH22GlcvicqIQQpcpUpKr4Ree8qlSEpopsrc0q/FPfG
	Ppvyjq3VpAYwYAOagKeqjiA27ObsZhXwfIdVTxMB5lcdsFN/EUinODE=
X-Gm-Gg: ATEYQzxRyPvQFTYUIkCtMXMj9XrgYTUuH4Ip45gKdr1j6i0kepGLJA5/Cf6qAWu8ECE
	FyTff92Ci91Pw9CFvq+Tx1uiBH0mlYQjGa/1jB1NCWo30iTrgywNjKsc0GfrdZi2SfWcaJtXVlB
	s8QIfRsPPU0Mn1U5EZ34VgTP69XT9rwkLh/rUrzNUhwwb27W17WjoiA/R1jDgSXvmMM8M2zpmRo
	I0V4Ugr44xsmGt5NqCxpBH1IMpG2fIyQOF+1Jo+lJ/jIqN5ITtdi243u2R1hy3oTeN6gIZF2N9N
	nbs0QWS6FuYsG/9r9yedo5iR/LM+3jEDdE9Vth6X+7ZA7PMQB6yD5kh/WqXENut4KXQHefZHxxr
	Jj5rQzd7IvlNsmDdNqxaDRz+ol5sZHItiygyg7Ie6PvAzsiMlliKJsAVOeUXgdYzGRG1AJUrYlU
	jK6L/fuZqcg8pLQ9IH1aZqv6Xz8YU=
X-Received: by 2002:a05:6512:10cf:b0:5a1:56e4:1c80 with SMTP id 2adb3069b0e04-5a2a504a61fmr4593860e87.4.1774756714319;
        Sat, 28 Mar 2026 20:58:34 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b13f41f4sm806136e87.13.2026.03.28.20.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 20:58:34 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	alex.deucher@amd.com,
	tom.chung@amd.com,
	Sbenazar <voroninan95ton@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] drm/amd/display: reset sr_skip_count on non-fast updates
Date: Sun, 29 Mar 2026 06:58:27 +0300
Message-ID: <20260329035830.21953-2-voroninan95ton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329035830.21953-1-voroninan95ton@gmail.com>
References: <20260329035830.21953-1-voroninan95ton@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-230823-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[voroninan95ton@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 1BB1035097B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sr_skip_count is initialized to AMDGPU_DM_PSR_ENTRY_DELAY (5) at stream
creation time but is never reset when a non-fast (MEDIUM/FULL) update
occurs. After the first 5 fast commits following stream creation, the
counter permanently stays at 0.

This means that after any full-frame update that disables Panel Replay
(e.g., a workspace switch), the very next fast update will set
allow_sr_entry = true (because !0 == true), allowing Panel Replay to be
re-enabled immediately — potentially in the middle of an ongoing
animation.

Fix this by resetting sr_skip_count to AMDGPU_DM_PSR_ENTRY_DELAY
whenever a non-fast update occurs, ensuring that at least 5 fast commits
must happen before self-refresh features are re-enabled.

Cc: stable@vger.kernel.org
Signed-off-by: Sbenazar <voroninan95ton@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9854,6 +9854,12 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 	bool vrr_active = amdgpu_dm_crtc_vrr_active(acrtc_state);

 	if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
+		/*
+		 * Reset skip count after non-fast updates to prevent
+		 * self-refresh from being re-enabled too soon during
+		 * ongoing animations (e.g., workspace switch).
+		 */
+		aconn->sr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 		if (pr->config.replay_supported && !pr->replay_feature_enabled)
 			amdgpu_dm_link_setup_replay(acrtc_state->stream->link, aconn);
 		else if (psr->psr_version != DC_PSR_VERSION_UNSUPPORTED &&
--
2.48.1


