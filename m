Return-Path: <stable+bounces-249411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDwtBwGmC2ozKgUAu9opvQ
	(envelope-from <stable+bounces-249411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 01:51:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0DF575309
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 01:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA9A83023D98
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 23:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236F2F8EAF;
	Mon, 18 May 2026 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkHko9ir"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E431E85C
	for <stable@vger.kernel.org>; Mon, 18 May 2026 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148273; cv=none; b=oZPv4svRLrLvceb4+dq2MRsvlC1uOr47kbHyZ9avoV77/SweZL06Wqq6h4EtsoyVEk7obOVdpSpA+q5cxymKE/SE1r9opjZXebov+LokYa0AFSsondzf3fzVDIaQsEkTDQ9igBz6YVEwZdMv9gxiB0i7szMqohgY3oAPA3CMATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148273; c=relaxed/simple;
	bh=QZTNJBwcxlSR1s5+g7hU+ux3gb0rozt/TN57Pvqn538=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTwoe3JUgHpBia7QEhsRemV5JD+xswypENm3gu7Ha1FcJcFaCsA2Bsl+Ljr1hDrmjylwh+yfosEl0aIOBYzjdXEZMNVYqMGx4vXPFRQSkKH+nlMykXmJuGCxIwqhjsGleAMNeKD/oDLcpm71b/J25TG7FIuT7vIH3GV8I4nnSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkHko9ir; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6802f9c5debso7040796a12.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 16:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779148270; x=1779753070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8DlE+6jvZdiiNMn1OqACkTYheqqIJEpS4FWOTKGk4M=;
        b=fkHko9irbYkcZffZyG5xvAyDjWQ+satbceYT91V8ojTCkJRJlq4LXsSPHGrE4A0j+r
         yJ6JthZ3BiBTN2YQh0fuPqZcC1RWcTk0xK+3+oCiPSVJhZ7wVZoJqcbi88krDQLKBgq/
         WZIctzMkPG1h4bJz6L7WG1nj7mW1FImXqU7BZGWsW2PLOI2wkfH9kCvm3BXFuxHT9onD
         fS2767ZDOL/kGf4jum4QWhPcno8BGZ22Bafo4Mi6wfK1Dw3pSBJ2fl+KK+s7hDDSzCkp
         VI8Km27i0E7YHG1oOPODvPeYYPAvbAbGhpoi6Zh9j4NVgPaIFpn3QdpwIPuw/NAlj6Yg
         lJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779148270; x=1779753070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T8DlE+6jvZdiiNMn1OqACkTYheqqIJEpS4FWOTKGk4M=;
        b=lSz3dq3eccbeKyCxImhH1gSwLm1ljihiudOaspg8NqZVmImOFJjOHyHbSsyurCzhZO
         597v6XjC1sHSFoaIBTzDWo3XSHFNcv6Vk9pkPMmR0nN71biJo7BmtzuH3AT99Se4nWF+
         xhDOjMC4bqNdrYR2sRx3w+m8CO3mSevZfF0CJdc7ZfgLgOk2Uh7YC1GGYhNIK/wcWyhL
         +6texTXEDZa8GGSsxHbUV3J2xGiBRn4V2XB9JYfSj1XsA9mAVKo50FNLJv/P18mXtyDl
         5FWzvqneY++w5p8g2Wqqc6VIWhFlltEnG0FHlPAhpMX0yQs2CVQ14I61Gk7KWMGC9FQK
         YgKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+k7n725SzpzPXmuGpn9ANv2KZV0phVI4byX9S1SyziSzSrypGvVbQV3F3amiqnzh7E7BP8iL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfLUa7x4M3mVKUXgazSig1e4CjMVHns2licZuJ8oatG3RDKA9E
	nL0P7r0iZs4msJTPSS6P3WS8bb6duH69oeAdpMTtsF5idHeatESEnEG9
X-Gm-Gg: Acq92OFutPAsmwbbf0HywqAzYNUsh63fLvQPLJWjUR0AJ2YPApdSLlCtgrCG0TgMdKp
	ddvW978IZq3rLBj6/hUwdodVTJTCVPZtveN0Ijrw+H1VK+dHSMu1VCVXCmPG3abFOaKPzAfCL+N
	s4XDJoEK2MPt1MFYrEPsZsexL2dxlHjOB2/eG2T1tlEcgELctyF/RadaeS/2WXVG5CyjneW5UHP
	nQHtW94QEa1J+ZPD7Lefc+Y2Xuw0jJmPVy3j7/s6xz7Ze8pNqR6z9RuEpfWI3O/PByZMAPlUK19
	JuEHhQF7NTSV8U7tZxdq8SBLZgt5Dg2DYpgnrzx8oae9xqZjPlw0k/11kuYpnwM50Q9bPZ7mm9j
	EvhctQaeEeCMCKE/QQ2KeIhPcKGK14AIUpQ+BvGwlsjDc7RVNzfP9hesR0NQtXOoF5i/4dTSAAd
	+0opomT97PJHWl26iiJ706TyQ2QV6qax4F8jp0TKvrK699J7Ssa9cIDfvRhGtCsbtZoW/YPEB1K
	2kZBYpydPbzvO/oM+1u+Vglx7KxnpMhBZxSFCAKBZHwnLQk4RI8O/e+lJGRqo7U+oPUn5OSGtZN
	s7D4hzLCvzd3dLH4+VAB/DOawk1P
X-Received: by 2002:a17:906:5193:20b0:bd4:7cec:1066 with SMTP id a640c23a62f3a-bd517acd5e6mr680008466b.44.1779148269993;
        Mon, 18 May 2026 16:51:09 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ec6548sm621858266b.62.2026.05.18.16.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 16:51:09 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: martin.petersen@oracle.com
Cc: bvanassche@acm.org,
	target-devel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	stable@vger.kernel.org,
	hossu.alexandru@gmail.com
Subject: [PATCH v2] scsi: target: iscsi: validate CHAP_R length before base64 decode
Date: Tue, 19 May 2026 01:50:40 +0200
Message-ID: <20260518235040.48647-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518121811.385350-1-hossu.alexandru@gmail.com>
References: <20260518121811.385350-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249411-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[acm.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AB0DF575309
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

chap_server_compute_hash() allocates client_digest as
kzalloc(chap->digest_size) and then, for BASE64-encoded responses,
passes chap_r directly to chap_base64_decode() without checking whether
the input length could produce more than digest_size bytes of output.

chap_base64_decode() writes to the destination unconditionally as long
as there is input to consume. With MAX_RESPONSE_LENGTH set to 128 and
the "0b" prefix stripped by extract_param(), up to 127 base64 characters
can reach the decoder. 127 characters decode to 95 bytes. For SHA-256
(digest_size=32) this overflows client_digest by 63 bytes; for MD5
(digest_size=16) the overflow is 79 bytes.

The length check at line 344 fires after the write has already happened.

The HEX branch in the same switch statement already validates the length
up front. Apply the same approach to the BASE64 branch: reject any input
whose maximum decoded length exceeds digest_size before calling the
decoder.

DIV_ROUND_UP(digest_size * 4, 3) is the maximum number of base64
characters that can decode to exactly digest_size bytes, matching the
convention used in base64.h BASE64_CHARS().

Fixes: 1e5733883421 ("scsi: target: iscsi: Support base64 in CHAP")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
v2: use DIV_ROUND_UP(digest_size * 4, 3) as suggested by David Disseldorp

 drivers/target/iscsi/iscsi_target_auth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
index c46c69a..50eeded 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -341,6 +341,10 @@ static int chap_server_compute_hash(
 		}
 		break;
 	case BASE64:
+		if (strlen(chap_r) > DIV_ROUND_UP(chap->digest_size * 4, 3)) {
+			pr_err("Malformed CHAP_R: base64 payload too long\n");
+			goto out;
+		}
 		if (chap_base64_decode(client_digest, chap_r, strlen(chap_r)) !=
 		    chap->digest_size) {
 			pr_err("Malformed CHAP_R: invalid BASE64\n");
-- 
2.54.0


