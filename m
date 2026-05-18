Return-Path: <stable+bounces-249269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMyKNiEGC2rd/QQAu9opvQ
	(envelope-from <stable+bounces-249269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:29:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B2856CA53
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C432E3010DD0
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 12:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA43540243C;
	Mon, 18 May 2026 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNHR5HHi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC103264FA
	for <stable@vger.kernel.org>; Mon, 18 May 2026 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106717; cv=none; b=P0VqEPw0nFep8mEwExPTWvNtMCe64bHOI1ei8o5dRVXsozoQXhPEFWOmy810wI5t2JGH1mTr+OKt/o/HtUK1KpofG2JxCUzwD7aAggtdSa/dXIVRJ0gyWmNbaP4p4iX1rVhKYgoGi3qpnG69+UldyUOZ8hznsfsnVWI27cKDLg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106717; c=relaxed/simple;
	bh=4Uh3eQNG1AzQ8+Z/3G2EaHP2yuu8tI/1ewQgpcXwoSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uyZPOKBl9/267iTbi3F0tM1hVESQpkGWreKeN8B1Iaoc6Fyfik9ybHK39OjzsW108kZOyt81SmagmOlH2yO0brIn5H1EikPNxsXtws5b+qfkjU3K4go5kL778FMPpTA58xcMUAhCozATFEkB0vuqe4REGBlyhd6883nNn3H++Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNHR5HHi; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd2087858c4so533581366b.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779106714; x=1779711514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUmwK/E8k0/+bmmnitAn3thbhE/x2wsT2IrX01fre1Y=;
        b=XNHR5HHiAin54LUGTCXqPOGiCVfjzXfUfv9IkxU8pnXfYfY96DkGw8aQG3nXhzEAwj
         +eczCJmsg+NQNbCg5opZN6BLAJ8SQZYVjg4kVN3Wf/rQtZpVLe4nKk3KC1quH0WTOC5m
         rzZ1FYohAIrjDCC0Owln6/cl3cL6ctTHJORLoSorM5Cm/lDaPc9eeQJICOx6kR7FgJLf
         SGTFvW87eXDavUi7+PjVduuhLlVJVSCxyV8cKsCtjnXhFQZJgZMieC4AtaouvRx7eSNh
         uxVW0kzDTgaZWHkhhxva82iiisMLRiR3Um7WVtEO9fsqzAh+//ByPsopqn3YutA9Wr9O
         0pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106714; x=1779711514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUmwK/E8k0/+bmmnitAn3thbhE/x2wsT2IrX01fre1Y=;
        b=qkn5BiX7bZx3LMx8JW7Qd/r3fDcdaUw5uSKqOvWxNlwhWknvbj75Y7GdpuFgtcJ5Um
         +cQSO5yG9BlgU3PNH17MPkiqHpwZUU1t9JihPOOhfcrGNpfwkzbHrN9q0e+LYqBv2w2x
         M4VM4IIUkVROtE5LKwJuEd6IMBA3ekd3yweLSKNvw6JBtzEFS8BINQiypBla4txAkLY9
         r3aDoUKB4NGG4TbfcCrmCks6dfYb2XRc7nOGBXv6tPM7NZCbf7evduJOMXzq+h7dgQnl
         5EUerNaQtDNb2Ma0snoltfYGj5yv86yw8+A2Y3tGhv1OuoDJquDwutZjUB1vjamj6ALa
         cJ4g==
X-Forwarded-Encrypted: i=1; AFNElJ+funhIIZGDePoPncP+eztkWyPqB79zqzTQvgl6ZE0/kw/okD3JLk5K3/UdT8HR8bwcg3UJ4Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0J7rN55FC2oPircNPZtgBBGO24vbB+ufcV4xYmb5HMHgLVOiD
	SDsemXfhqHnUyBQjOTGaNlsx0JxqMHKygh9efCdUedQEeeTALjFmUEQqCitQeszC
X-Gm-Gg: Acq92OEejHmj3Y/D8bIlVT5ABNFkh5bwjdKrcongEDaslQ23oNmMjCsEDtS6WnXMhT4
	O614H8ezVA5ICoChxCU10YmXxG3xmkwGkS1O943Sp5Q4xWxEVxox01CRFG4DLzBYaYrZ2zq3aos
	D+LcyQZ3zMr6FAa/6Az6RKMSNjs6/x6Z4UjhcKjI9Y7apirZ67w3eBsFeQYBpqw3a2LyvInq5Wl
	2h3KVI4anoFxpoZAtm7Z17n61vjIrrJ0Lya/jgkvCaORo4f3H7gTbYu9XIDaG3Ij/PzPvcNtPSf
	ivbhY59yx6JF8IybF+wWrkj4AucGCcPUUKDUfKnGgKIrAT2vPtW7RlyXQxf14RYVfdSp+AvgVUf
	0e9rrIJ2er0X99K9ri276agA10W26FeenAb8JS02NPNQhKQ5Qo3/wtWi0Jk6ARZBFyi0Yil2qif
	oAE1aBkRu7RJXLIwYvhXjHwVi30ljzc7NKSlbRcA9o5WJCVGwMrDakOY3O6dEg742mTQsxFu0ja
	ZkQBX7XbR2Q9QbC0BMzXhdqpJAM9NovoAsqKb7bX8k4VgDg1c87Oi1rTTdUwz9QVeBP/Y46CtEq
	jIL8UcNKSreh45zXuSWKIMSRY1nC
X-Received: by 2002:a17:906:5189:10b0:bd4:f814:efe8 with SMTP id a640c23a62f3a-bd5177ee44amr557710666b.18.1779106714108;
        Mon, 18 May 2026 05:18:34 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c631e2sm547638066b.28.2026.05.18.05.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:18:33 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	target-devel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	hossu.alexandru@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] scsi: target: iscsi: validate CHAP_R length before base64 decode
Date: Mon, 18 May 2026 14:18:11 +0200
Message-ID: <20260518121811.385350-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E2B2856CA53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-249269-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[acm.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

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

The formula (digest_size * 4 + 2) / 3 is the ceiling of digest_size *
4/3, i.e. the maximum number of base64 characters that can decode to
exactly digest_size bytes.

Fixes: 1e5733883421 ("scsi: target: iscsi: Support base64 in CHAP")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/target/iscsi/iscsi_target_auth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
index c46c69a..653be1a 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -341,6 +341,10 @@ static int chap_server_compute_hash(
 		}
 		break;
 	case BASE64:
+		if (strlen(chap_r) > (chap->digest_size * 4 + 2) / 3) {
+			pr_err("Malformed CHAP_R: base64 payload too long\n");
+			goto out;
+		}
 		if (chap_base64_decode(client_digest, chap_r, strlen(chap_r)) !=
 		    chap->digest_size) {
 			pr_err("Malformed CHAP_R: invalid BASE64\n");
-- 
2.54.0


