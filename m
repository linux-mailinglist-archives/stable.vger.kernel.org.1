Return-Path: <stable+bounces-253893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iACOFlU2EWpeiwYAu9opvQ
	(envelope-from <stable+bounces-253893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:08:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6EC5BD383
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCB61301A2E8
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F04D183CC3;
	Sat, 23 May 2026 05:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afTTDxB2"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417D332918
	for <stable@vger.kernel.org>; Sat, 23 May 2026 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512817; cv=none; b=LO6iLuiSnxrMW5ibVwVJm1RPZSBjKgt0wy9ajnPpyGQmCGKs4Maw9LkwYjAt5x7UczB/VCQBJ/eAICE1+xNP0N+AxnY9EleeyisTEy8Tvsw2J9mc8yKlE5/fv8VRpqEfI3LDGrCp8UOPqO9IO/fquuryDkzVQYqPYwcz99Qj4AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512817; c=relaxed/simple;
	bh=MDzmd62AJTHlHIH2co8oyK9ZcbspJpvz8LerLf4ymA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrR9QjDoHZrF8mv/X5walPBwcetJ1FgFTrrEFx3K9GnMk56EyEBhdAV8w09lH4huj/9MZebt1taNOXUeBta1q51Vgt4xh9y5XuzDqq5LgvCNklgps9bnShFjqjPLliCDokDg76rabtWiftIRtyNgkuFZlnGT3X6/gTAtz/AYxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afTTDxB2; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-303dbfbec77so9147536eec.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 22:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512812; x=1780117612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a+I4YbWgCb4RQjRS7D/qsAOOz1ec58M0Yo5rgLJumw=;
        b=afTTDxB2Xq526omDABUSUXns0HCOROZV3Jxfag825q9srUzG50RiBkLZ8UqbZ691LI
         MZbwc+EnXOFpp/IVjigEsdzvt8WmmSrhFpDi+SlUeV+Ie9JOo+vK3vNr6y/IOIrzosUQ
         cYA7zVRf2ro1AXdqdE8CJCLRyohLS/wfyEMKIsPfSXqj66x086rQRlmWO2C6jg2Dn+Qs
         n0Pbvxs8AWEdSeOrkuuDJTmY2xdBhc/49x7sYhixxdLMQ7MsSflwYuAU4ammqS7WH3W1
         7PDBevQhJVTdCDrnYQSAHy70xbP9CBPFDgcpkHIrJw50e+Tu3rCB+JqrhpP34blUUiJq
         S7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512812; x=1780117612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7a+I4YbWgCb4RQjRS7D/qsAOOz1ec58M0Yo5rgLJumw=;
        b=alupZfyutlBL/m8cTkN/C6oBC2FD6dvxAdCjvJATZuXcO1alipRj2RgC6A/3Cyspv3
         KV0kvl6ztml/TrJ92NSpBaloxQSLEcteOjoAKCwOZjatGUKccg26MtFCjsTYnp32gjW/
         vTSRpWT8gxw4G7nYpJiulWSCRP97y2Os27d/N67hdqKYuPzHlYPS8BiB7XDjFtkx2IFQ
         TxoC9tAZZC92UD0dlvQSgGxm4/AC+do7A+5ye3k1Y1LPusLeIw5YaHj3/QKiqiPF0L31
         1cjpEvGZ6w81N7t6M/w8asvCqBhgSUvFx+Wxu7GMVLXXAqM1oaxefp905tbQrynDQYTL
         zWhA==
X-Forwarded-Encrypted: i=1; AFNElJ9I+hTfWjVkRsJkSyuuiluyYub6jhjGe1AxGfm2IxKPWMCneZ76Ow2m+iTL+TOuxgljbFZIDrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo7DM0lVuyiq6ONShxfG0KgfNzdYgvIriPAlB28+o6aR0cQ/P3
	P7WUVtt7fGo05dLwvMfNqeAWBBad/K5+KpzPxDDl3gIggdUKxZJj8s28
X-Gm-Gg: Acq92OFRozyLhryo3ZwdbbZ/glTPebXx2t5a0pu1fh7/O8cwkZwwnoiH+IZjtp/EeA2
	Au0b3iT0SoHtuQbJrlAccA/HkEZxwIX5OmYkhCj3cbbKevJRtMHrsYn4npYJnpwC8qiHBZoRa+2
	guf0vdPvKCDeapSekzkpRkJmd1WsJeoIrU9XkjPsWdrB816wUswxELEK4X9tmRf5I3z6ST8Ntut
	juStf0FsOqDdRfc1jCiDJ7av4bUu11JnkwS93eifw66Rdf5jtMCoWFpxEHJtum+f3PwvwXLaOtO
	dvZnBLVrpk2jCf/A+ejaSKf5C/KzbIrVnVdHR6rrkHznaQjZVZDvCnH1SApVo4zRAkD5o9PaXyj
	bE9Hd/cT614fbEh+uKuJKaXJuoqgt5K83e2nJNXYucovpyAUTOreyvXJZhfkDs+TvJtSeOJl546
	22fzEYbOwxStLEpeGq4rb0ybZsGyNxuLAQ4JGWrQymfjJxgcB7lkYk6Ses8MZegv44gnwLcNybL
	CHC2zXUTYMVQw==
X-Received: by 2002:a05:7301:198a:b0:2d8:7302:d3d with SMTP id 5a478bee46e88-30448f4b600mr3397307eec.8.1779512812030;
        Fri, 22 May 2026 22:06:52 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:49 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 07/11] Input: ims-pcu - fix logic error in packet reset
Date: Fri, 22 May 2026 22:06:25 -0700
Message-ID: <20260523050634.501509-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253893-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9F6EC5BD383
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ims_pcu_reset_packet() incorrectly sets have_stx to true, which implies
that the start-of-packet delimiter has already been received. This
causes the protocol parser to skip waiting for the next STX byte and
potentially process garbage data.

Correctly set have_stx to false when resetting the packet state.

Fixes: 875115b82c29 ("Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 0e7a783526e6..cdb46b2297a2 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -440,7 +440,7 @@ static void ims_pcu_handle_response(struct ims_pcu *pcu)
 
 static void ims_pcu_reset_packet(struct ims_pcu *pcu)
 {
-	pcu->have_stx = true;
+	pcu->have_stx = false;
 	pcu->have_dle = false;
 	pcu->read_pos = 0;
 	pcu->check_sum = 0;
-- 
2.54.0.746.g67dd491aae-goog


