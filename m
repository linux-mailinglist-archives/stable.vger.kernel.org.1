Return-Path: <stable+bounces-237959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDVzKByT3mnZFwAAu9opvQ
	(envelope-from <stable+bounces-237959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:18:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FA53FDF95
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D48F304C623
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C31299A8F;
	Tue, 14 Apr 2026 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX7CsWco"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B73282F25
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194141; cv=none; b=gRhyI2CjEAbaAF0R9d3GQPrTdPORavWaNhQzGUU82NCZIJurmIjuw4vcgvSL9/kO8AogTA4pTBpa4Z38KZ+lm6h0NIm7VXIMxoIdPMfvd4nA4wjmxB6gFh0kdQNenI9rpbis1q7Yl0131LMThnmI4WNVkjBkN6+1foLiPrS1uJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194141; c=relaxed/simple;
	bh=I7ZPd6BYpji+HeA0FutzbeEHhoDVteznmPpu9gEGUHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pT8TEw6RrZrmdabxWLHpII70Q6kzwDxS1xJIR0sXR5uuR29KshLW7Bo0x3vQQRUAWOgXxOq1I3VFTGZhqy3ONepLbNoHBXTeYWLX5gNSiUxVFI/p5ios+ktrolO3Z6SiCZmuZdHsd/xcbPbN8PojmrsfdLCK8L8LOlH8+fW++1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX7CsWco; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8a093c784b0so73589556d6.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 12:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776194139; x=1776798939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koYFiagrEfQMs7bgNuUQ21Zxibgpf6kYEiIIemViCQ8=;
        b=FX7CsWcoYyxjgsun6VL7si4tj/S0zOFXJyksWA662F2hblqvLBemKSOlOyCrOVpDs2
         b79AWQ9PKXnHoXSH0wrvoJBFfH+ZMUa3KSYDSQ+6yI0YmTHyHhBwT3tVyaTUy8DYp4qC
         cv1Unpn+sVaDXZHgeddXHKv4RClt12GVRJAZRoELhMZogWrWTItY3gUGYH1gEV1SzPUV
         W+UL+O2950oHh6wn+KaUMQH4a0TsDmFavoVSq8nY0vQvqUMFQ4L/WzFqPTlazNx1FKMD
         ruCAukqxIfAfbL+a3aL92+qLBKpKuUC0nSenPC/nGYKmQjhqqZ9so0Ds6jGJuQUIM9aE
         EvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194139; x=1776798939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=koYFiagrEfQMs7bgNuUQ21Zxibgpf6kYEiIIemViCQ8=;
        b=MHn86jYVeWX8ICRXEmGWrqk9aAFc05T58eRSPu+c3Utlp+EK4pFzVmOpxEUHno/hu+
         7hy4g9bZm7sfCzpSO/i5RT/jdcsqfPBQQQYirOrwF5XxqeS01jnNCr95ymIzwxeOT52O
         YX0O1T/12nSSJJ51ZAvfpD3nFOf4EvlcUfHiUp06FIh7MZq7ft9YMigIYWk8D0mTYlp3
         i9C4gd1AzypTKDmlOM8gQAz5WCQ1GGLHxyv/k1Cwi23GHFNuyzb1anZvCHLq2AmeFRqx
         Tjyvke+oRIMoXjtL/1K4FpVh5PRdTk5szFnoOGG/DWG28NUHvjae/oqD+S7Y3DIc1gHF
         HCtg==
X-Forwarded-Encrypted: i=1; AFNElJ+ThmDBU/JRmx+a1f5IWgcszpYAob/suCJX8lHEI22gHb+DhySNjMFbublJVTdraW7rTHFJREE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjnahaNFiozwFxvzC8zkSBV2rxghEUb5X72EVxsg3uyXV9Ij1C
	f6OkySegIpjrjPSJQTvrCp/wOfsWpp1nuqOqBQ7f1VZaiX8Z2rDMVygc
X-Gm-Gg: AeBDieuG+cTA/x/yXzmQ7O9LbuR1IK4XDu0EGTEy1uYS/TgzuqtzKZmJDTzlkGUkDH4
	qTsgcxqVuYFNvgFHYoD2HIlBmZ9yfxvU3sIMG8N9ANdlAEWZ1If7zPLjaSsTSOcAgOeC7obvRj8
	X7HLzTdtA/1bPxTq6XlTF9g8a8BM/AGMCQQWg7ZeIs/t81KVivydxq7hy3IDvdBfZiDzLozyz5q
	RvzPdUxlzbNHToM4hkZKyFVgxeBowRkIMFrKbke3hasm+0hAfecoPGb9ErAmzYM+qbyZeZJDUHZ
	TknBlhHsw0BcLWUT6kFISrq3xlDLOLb2yeAZsrtpaYtunzWEFDmc02kS5j/4HHYiPm6qo5B2W0f
	DkoFYXRC8a/QIYIA6sdSgF1BySHN62SJVs7LEgknaY8QfRp0viqwP7Q9TQ5rVxLjz/zxRjhvYVw
	AbM0s7J7Q3W1aADAip1W8Be870fgCVTnXSSsxiGIcj5YpjOkaYW5hZyv40JwZ7bvjHxgwsAyKFy
	12AkjtjGIFrFb3fLTCE48tJ4UyUOZ4=
X-Received: by 2002:ad4:5d47:0:b0:8ae:64c0:c922 with SMTP id 6a1803df08f44-8ae64c0ccd2mr36692696d6.46.1776194138726;
        Tue, 14 Apr 2026 12:15:38 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aca478a70csm77229126d6.27.2026.04.14.12.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:15:38 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-cifs@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] ksmbd: reject negative ngroups in ksmbd_alloc_user()
Date: Tue, 14 Apr 2026 15:15:32 -0400
Message-ID: <20260414191533.1467353-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414191533.1467353-1-michael.bommarito@gmail.com>
References: <20260414191533.1467353-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237959-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40FA53FDF95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

resp_ext->ngroups is __s32.  ksmbd_alloc_user() guards against
oversized group counts with

	if (resp_ext->ngroups > NGROUPS_MAX)
		goto err_free;

but the signed comparison does not catch negative values.  A
negative ngroups passes through into the subsequent multiplication

	resp_ext->ngroups * sizeof(gid_t)

where signed-to-size_t conversion turns e.g. -1 into SIZE_MAX, and
kmemdup() is handed an absurd size.  In practice kmemdup() fails
gracefully on the huge allocation, but the intent of the guard is
to reject out-of-range values up front, not rely on the allocator
to notice.

Reject negative ngroups explicitly so the check reflects the actual
valid range, and switch the log format for ngroups from %u to %d so
the bad signed value is printed correctly.

Fixes: a77e0e02af1c ("ksmbd: add support for supplementary groups")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

fs/smb/server/mgmt/user_config.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/mgmt/user_config.c b/fs/smb/server/mgmt/user_config.c
index a3183fe5c536..c62e2bf0ebef 100644
--- a/fs/smb/server/mgmt/user_config.c
+++ b/fs/smb/server/mgmt/user_config.c
@@ -56,8 +56,8 @@ struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp,
 		goto err_free;
 
 	if (resp_ext) {
-		if (resp_ext->ngroups > NGROUPS_MAX) {
-			pr_err("ngroups(%u) from login response exceeds max groups(%d)\n",
+		if (resp_ext->ngroups < 0 || resp_ext->ngroups > NGROUPS_MAX) {
+			pr_err("ngroups(%d) from login response exceeds max groups(%d)\n",
 					resp_ext->ngroups, NGROUPS_MAX);
 			goto err_free;
 		}
--
2.53.0

