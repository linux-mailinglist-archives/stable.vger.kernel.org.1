Return-Path: <stable+bounces-238671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPVLAORm5WlDjgEAu9opvQ
	(envelope-from <stable+bounces-238671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 01:36:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B35C1425C27
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 01:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 910B63009B21
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 23:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FE42DCBFC;
	Sun, 19 Apr 2026 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak8EB9YW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1CF24E4C6
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776641757; cv=none; b=CBe276wyQRcVKEduJIrEI22W7oIL4zSle79eZYAg5MebIWjv2qwVHeW5MDESRsSI5dR6mnibj0HTdvdgYeddkT+y/65fKU+IyTi2w/yzjfkj8VDp17zCs3IVZOuBG87e9IY+jArgBOJBNbr5wXMMblbfzWV9G9B6l7IiV2BSEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776641757; c=relaxed/simple;
	bh=n+/9oE8TaB93W1IqyEWeYZPZfGQ+zJkX0tDzr2hV0CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwB4kdMyBnff6rYKC5mIuZRbK9kR5OM4RdDzUE/Or42UXzwhhy7xJHHAUHdqlXEwFWqZQBND9xumU00d8hUqZ4o9dAkZb1gZAuj76CQraATHdjs+4Q0umKpLAcxcJHKVVg/rxEYgM5lwaLvsN9quXGGC3zRw1sT659rGewpHoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak8EB9YW; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e5b55062fso3800831cf.2
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 16:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776641755; x=1777246555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vOx1KMOCIDqbwM807GVLF8N7abkefceoi6Jbuerw0w=;
        b=ak8EB9YW6n10p8HH/GaaQWjn91f6vcyynGVLv1mESkHC7ar93gHnbtOGDlf6Dmp6Yj
         b0jDDKCZy1s4QGQg9l590jRCMuRUJ3o1w9VemWH1gCb64JK/qAsAw4QBHRjArjrOO5tG
         1KgX69s8iTYYm8iz/0GjKEEcU/P5747eMi9mQzL3Ms8v3EkrO2SRdAGChCP4TEhilm5x
         2uJEKJbDuevErxfnvFk/TSDbvTA2BM0jvmwRFTGL1ioXgKsqVfGWqZsdTPQvZI0fpOOC
         t0NJtMm8ssOB2XZZambyy8YsucY04Ldc5Mrz6z+VEAJWKVMpeu21K1Mm5oICxa+3+k2s
         CepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776641755; x=1777246555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0vOx1KMOCIDqbwM807GVLF8N7abkefceoi6Jbuerw0w=;
        b=lTTD2kv3Efr7sxWF3J8GJOyxOG7+ySzC1v68NK906LdCIFtxa16z5Jb303x/dbQkAs
         dBQxa9qNER0P7rSsmaLnp+2eB5l738egox1oh9OEkUS7GhVnCtftJB6qJAfIsa8NDF4e
         iXxVvK16yt6JFDoUS1x/D5mLPszAZo/PSkbLW+Hn7ES8gLgDJAzzPH5aYFg+UkE+LrXw
         nLNKjxhGHyQ9HkC0Jfe+LC7YQWlQPUyZVFo30wFRKZ3IwCCt6VCXFMWxjKmInja1pGAL
         hLGR/QkQ1IFWBxJb3fRnLlmQDuX/31Ue3WC6sKGlYseE6/RsSMWFjsDaFV7CKJ/ko9iG
         jc7A==
X-Forwarded-Encrypted: i=1; AFNElJ/GX5lbU3qJdHlB0YVfYYNXqzc5EEKonco5lNzLv2ClMFiQmQGDrem1k9VkldvMuC0sEKfmIe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj55AKnRL/Hd6OVn2SEtaP6Kp37eAYO0BT3xKcDS4Wz6zNIxJN
	QB50+kEgEMajfDRARLs8VTr7UzpjuLp5q9bP4wl5Xv9a3qaQLU6WhsB0
X-Gm-Gg: AeBDietPpf7Bab5VadGIN9zK3XKWaKhr8ruefl2vCojaeto1xc3+IFeD1hCwcAXEKr/
	mYa/a82QgBXfMxLUsrmdPx2pull+qRk302U+Wwl1LrbWwYf1rBy4lDCtaVPXG/Ru+jQTrGMh+t9
	fYw7GM/rZCm11AisrrqKzXXVVUEihtVVKPKns0H9Twk/HDp7md/WEcN4dOsio9W/8diaRfFbUGK
	59bDQfN7tnLRnlzVFAQtV1bsRXmGEJQVz4pRPho08R4hRDzv48GbznzUUhjAOJUAa58DDonnIVs
	WmrIv6yyok/gum010ic+kAIHXZjofUDsUydblJWttof365BaxxONQk5jElM13MoCpx7BEg8sbGY
	NxA+8PYa6VebQTTwndscYW4+3z2lDoHuHIcOCxDMFgT/yMtpWJx7OMq5wltyWFftIfV6ijHVsn7
	jzb5HgbVQEv3jUcSG1s8qQsazrmyGMeBSgjGaCPQvXHukKwOcE177gAcS7DQB/JUQSHdFvU+eTn
	6UEZBiHmAnP2k7lTop9+AbKuh6tFRE=
X-Received: by 2002:a05:622a:120d:b0:50d:8b40:d97b with SMTP id d75a77b69052e-50e36bd318cmr180439941cf.17.1776641755202;
        Sun, 19 Apr 2026 16:35:55 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3945ae5bsm70011581cf.23.2026.04.19.16.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 16:35:54 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-cifs@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] smb: client: fix OOB read in smb2_ioctl_query_info QUERY_INFO path
Date: Sun, 19 Apr 2026 19:35:19 -0400
Message-ID: <20260419233519.2777046-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416213716.3118443-1-michael.bommarito@gmail.com>
References: <20260416213716.3118443-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238671-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B35C1425C27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

smb2_ioctl_query_info() has two response-copy branches: PASSTHRU_FSCTL
and the default QUERY_INFO path.  The QUERY_INFO branch clamps
qi.input_buffer_length to the server-reported OutputBufferLength and then
copies qi.input_buffer_length bytes from qi_rsp->Buffer to userspace, but
it never verifies that the flexible-array payload actually fits within
rsp_iov[1].iov_len.

A malicious server can return OutputBufferLength larger than the actual
QUERY_INFO response, causing copy_to_user() to walk past the response
buffer and expose adjacent kernel heap to userspace.

Guard the QUERY_INFO copy with a bounds check on the actual Buffer
payload.  Use struct_size(qi_rsp, Buffer, qi.input_buffer_length)
rather than an open-coded addition so the guard cannot overflow on
32-bit builds.

Fixes: f5778c398713 ("SMB3: Allow SMB3 FSCTL queries to be sent to server from tools")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
---
Changes in v2:
Use struct_size() for the new QUERY_INFO bound so the guard cannot wrap
on 32-bit builds.
Keep the check anchored to qi_rsp->Buffer, since that is what the
current copy_to_user() actually reads; OutputBufferOffset would only
matter if the copy site changed too.
Also reran the synthetic 73-byte post-fix case under UML and confirmed
the new guard still rejects it cleanly.

 fs/smb/client/smb2ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 509fcea28a42..3600705255f8 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1783,6 +1783,12 @@ smb2_ioctl_query_info(const unsigned int xid,
 		qi_rsp = (struct smb2_query_info_rsp *)rsp_iov[1].iov_base;
 		if (le32_to_cpu(qi_rsp->OutputBufferLength) < qi.input_buffer_length)
 			qi.input_buffer_length = le32_to_cpu(qi_rsp->OutputBufferLength);
+		if (qi.input_buffer_length > 0 &&
+		    struct_size(qi_rsp, Buffer, qi.input_buffer_length) >
+		    rsp_iov[1].iov_len) {
+			rc = -EFAULT;
+			goto out;
+		}
 		if (copy_to_user(&pqi->input_buffer_length,
 				 &qi.input_buffer_length,
 				 sizeof(qi.input_buffer_length))) {
-- 
2.53.0

