Return-Path: <stable+bounces-253597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKr4J201D2qSHgYAu9opvQ
	(envelope-from <stable+bounces-253597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:40:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CF95A9753
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 501BD32DADFC
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DE330B508;
	Thu, 21 May 2026 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPQKIZbk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E103112C0
	for <stable@vger.kernel.org>; Thu, 21 May 2026 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376315; cv=none; b=OFCyT6rbk0N17C2hcAGFe15tea8Tbil05uDYCv8KYotfdiMANVcER/3zdXIEkp0hbMlufxMyaQ1e4SsTjvPhi7hi/2cswDQfq25gAE2OTPyEmXJBHAI0x9u+OEUpjx9imUIEStpCxwpYy/CUld7iLoIGzF6u1EqBT9GD4l/bVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376315; c=relaxed/simple;
	bh=RU6oU5V9Jd55+3BhZdYaEx6qEvtKNNlahl3xWR6s8Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uH9Qjaf3l+lRIxtxholNW71laRMP4HLrAxA7mdqU+nwaapOs5VvS0/8CAzU3IsrUPlkJOb2OVmQFZ3x6gfDI3GmzGFIO6HMZ1clRE1etlc4u+jo73UuRK4mfrq2pmhFpdYg6fB5eQcYHW+zcEH1+pvHuBxNiKra8jI8MJUEvx2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPQKIZbk; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67c2b4809baso13473329a12.3
        for <stable@vger.kernel.org>; Thu, 21 May 2026 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779376312; x=1779981112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7tUwlivnxdHdof7RvuWQ2n+t4BjAy5qaJWU1MgyZM/w=;
        b=sPQKIZbko+1GhnUwrlZA854tY9cal++hxEWrT3N9sG4EeAiXUDWQw/P3tdTO4b+5Kz
         dD3mm9ALgzWtRFVERTRuB/jggsCFUlVZzz/rFjU2E3j2eGnkIHblc/Fr1cxBq1RlHxwl
         a9Igg2pxZ/cwgTlsrpCP/Rtg8r1vhJFF1zcHbHHwBrjf9Oi2/jCv8tIvNIJUWuTyXjNd
         3AkRZJtwsfgPu1pAPFcgsgRnxU4xX5rGQUEeZCKX86290f7jlLK/SdvAzMZkpLe1p0nk
         8vcmq5yhpaM5th6qj6ED+XWB67M20z0BFbUgJfe9G8wVdBWTdsdF2nd/wT9NZUQ820vI
         LbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779376312; x=1779981112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tUwlivnxdHdof7RvuWQ2n+t4BjAy5qaJWU1MgyZM/w=;
        b=CziWMX8VkSuP0qXTdDSrftbPTZoax0nmvex3F2TfBcqhPHF5KvzjDqk/edbMTZs5Fx
         EV0aLNKy5q9/mwSIfV8HH5oF6dmLbbd18KzYM+ocMI9/I9vktCbHfVfMFRT4DOG8GV2J
         OtgRLZXh22GlK4rP/1exAzyHNRyuQSteZsgz6Y1sfZrurMRyG1zRr8h3e8HByGcI7Bnn
         W8Zz81TccvivpFpZ1zLNpsN0oUv7n8Jeq8yh3cBejjf5dfs1nXB34AbGENwpri9Nce2v
         N9W3GMLASa3AeHmyQcGNTtyMAlYSMKWvZDSvRl9Pf3s8WTqNelI3EIMmjmTa6zkWWR+Z
         kcrg==
X-Forwarded-Encrypted: i=1; AFNElJ8qwpwg+DmARyscvCX75Kg1mwjwJu68SkNsh32gMGs6UR8qpWI8eoYUqmNqV6/8rF76PUm3quE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOBtZpajfcSz8hpKjeWy5kj6/VMW9VxpuR4UwOz8KbnideCx8z
	qJcAoxgx/M5OFApbvcPb1ym+T4J/AVPNf7JXfLpdMdPNFSmZDtLJ2C1Z
X-Gm-Gg: Acq92OFKbA94rWOX6Wl69fXZ01KrbkeYzihTUfFGvAYejw1YJZqIbmL2zCH63NwzHcr
	QU+yiDEKnirZzpPm2lRqKAF67qtyeLKvykAMbq6fs7lry3HD0ebPjx5bUy1+oBIeiN2kxCAul1S
	EsMsZCWxzcuoNL32mCCvLzooEuYfVoOUAg2s7Hx7qADxNB7keSol/fTFAXiTYoQhPaQwXJM1Gnj
	rjUay8hJUEOCyWyssiHuicmB4n4F3pHmRCn+cBw7aihUGn48HXZrUwFEgWKezqcCJKU6mHoDUst
	zFI9RKdwgFhqFBITas9I5dYlnaQ3MkVxO9dhU/ecyTpHiDIdKaYkI1qcDDOmSInWVaDhrW4qCJ/
	B1qz0MDyayadlxiC0mwrZsdxA2IqF6V4G4vJcvdvw4GT/6Sr9WdecdKp7Q51DBuJYE4h/CxkH4B
	AKHoRIKKqK+Q12gcy+KPekLA02iPSub4glYVXgdKhN3oWkfBkUEb0ymxxpJvo1Pm/7C4Aq15BeV
	1ClgbYLgy52K01nJyq9Zw61dl1RCAxSLDkfZclCbHxE8ekhtAZYM1ryBA6uK7K37vmhg8ixBUgS
	VWxatBZECmjU0bWUXp+maIXxJw5X
X-Received: by 2002:a17:907:784:b0:bcb:98cf:1a82 with SMTP id a640c23a62f3a-bdc12f8637fmr174232466b.14.1779376312188;
        Thu, 21 May 2026 08:11:52 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8aef5459sm59846966b.59.2026.05.21.08.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:11:51 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: martin.petersen@oracle.com
Cc: bvanassche@acm.org,
	mlombard@arkamax.eu,
	ddiss@suse.de,
	target-devel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	stable@vger.kernel.org,
	hossu.alexandru@gmail.com
Subject: [PATCH v4] scsi: target: iscsi: validate CHAP_R length before base64 decode
Date: Thu, 21 May 2026 17:11:21 +0200
Message-ID: <20260521151121.808477-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[acm.org,arkamax.eu,suse.de,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253597-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 17CF95A9753
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
up front. Apply the same approach to the BASE64 branch: strip trailing
base64 padding characters, then reject any input whose data length
exceeds DIV_ROUND_UP(digest_size * 4, 3) before calling the decoder.

Stripping trailing '=' before the comparison handles both padded and
unpadded encodings. chap_base64_decode() already returns early on '=',
so the full original string is still passed to the decoder unchanged.

The mutual CHAP path decodes CHAP_C into initiatorchg_binhex, which is
kzalloc(CHAP_CHALLENGE_STR_LEN). extract_param() caps initiatorchg at
CHAP_CHALLENGE_STR_LEN characters, so at most CHAP_CHALLENGE_STR_LEN-1
base64 characters reach the decoder. The maximum decoded size,
DIV_ROUND_UP((CHAP_CHALLENGE_STR_LEN-1) * 3, 4), is less than
CHAP_CHALLENGE_STR_LEN, so no overflow is possible there. A comment is
added at the call site to document this.

Fixes: 1e5733883421 ("scsi: target: iscsi: Support base64 in CHAP")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
v4: add comment in mutual CHAP BASE64 path explaining why no overflow
    check is needed there (David Disseldorp)
v3: strip trailing '=' before length check to handle padded encodings
    (Maurizio Lombardi)
v2: use DIV_ROUND_UP(digest_size * 4, 3) as suggested by David Disseldorp

v3: https://lore.kernel.org/r/20260520165259.272808-1-hossu.alexandru@gmail.com
v2: https://lore.kernel.org/r/20260519015100.837422-1-hossu.alexandru@gmail.com
v1: https://lore.kernel.org/r/20260518121811.385350-1-hossu.alexandru@gmail.com

 drivers/target/iscsi/iscsi_target_auth.c | 19 ++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
index c46c69a28e97..a3ad2d244dbe 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -340,13 +340,22 @@ static int chap_server_compute_hash(
 			goto out;
 		}
 		break;
-	case BASE64:
+	case BASE64: {
+		size_t r_len = strlen(chap_r);
+
+		while (r_len > 0 && chap_r[r_len - 1] == '=')
+			r_len--;
+		if (r_len > DIV_ROUND_UP(chap->digest_size * 4, 3)) {
+			pr_err("Malformed CHAP_R: base64 payload too long\n");
+			goto out;
+		}
 		if (chap_base64_decode(client_digest, chap_r, strlen(chap_r)) !=
 		    chap->digest_size) {
 			pr_err("Malformed CHAP_R: invalid BASE64\n");
 			goto out;
 		}
 		break;
+	}
 	default:
 		pr_err("Could not find CHAP_R\n");
 		goto out;
@@ -473,6 +482,14 @@ static int chap_server_compute_hash(
 		}
 		break;
 	case BASE64:
+		/*
+		 * No overflow check needed: initiatorchg_binhex is
+		 * CHAP_CHALLENGE_STR_LEN bytes and extract_param() caps
+		 * initiatorchg at CHAP_CHALLENGE_STR_LEN characters, so
+		 * the decoded output is at most DIV_ROUND_UP(
+		 * (CHAP_CHALLENGE_STR_LEN - 1) * 3, 4) bytes, which is
+		 * less than CHAP_CHALLENGE_STR_LEN.
+		 */
 		initiatorchg_len = chap_base64_decode(initiatorchg_binhex,
 						      initiatorchg,
 						      strlen(initiatorchg));
--
2.54.0


