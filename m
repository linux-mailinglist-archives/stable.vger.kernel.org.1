Return-Path: <stable+bounces-250671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJhJMroSDmoW6AUAu9opvQ
	(envelope-from <stable+bounces-250671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:59:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8DF598FD7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DD2D3143D2C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8C336CDE9;
	Wed, 20 May 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkU4GBL/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5E2701C4
	for <stable@vger.kernel.org>; Wed, 20 May 2026 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296013; cv=none; b=P0n+dLYlbVzrjK9Fmyu83NbL7hjnFCCRVDL1jR7m3nzmYpnKgs1bkppwo9HEDPjGzPD/wPTJFk1Og5xygsy3wd2Ql1ywnB0m7K2qNohCrbaWBqK5sCj+G8dagDFJCWhg0f6bdoCt5eURyP5up00Y0jgIFNhYKZThKAadjfPafss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296013; c=relaxed/simple;
	bh=OqrZM/EZQoDxpdqsw83Tctk6QvpP+RDSvRPve3kZib4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAg0YZyyNG2lFGB5g5tGbWVgzK83OP7Ii/GIuIGpUW2EbhI/83BE194USxAyTeRvRLty8i23X00GlHNBbYLuQz3RSDPhsdDOR6+4WP8xvrvizD9LiPiGZpoBiWWHNoeRIUPGxt5AZqBjHF6xyVF7u65QXVtlOvasCBi2N8QtrLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkU4GBL/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso9193632a12.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779296011; x=1779900811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKcl0f+YiSx0kT0A06n+DmaHMn0z0MjpQEGjfw2KSV8=;
        b=JkU4GBL/LH8SDTqhqu2PMj/k2XBBu/ZymgoIeyqLDzs6PDk+Rjb8URfzCw/X4fEo4Y
         mjzq4W6gOob6o8+/kl3IAwkel7yQDIg+Ohu+KCBSsciZ6ewBj8U9ieMmGdOyFf9DgZxT
         uPR1MU23R1mOWxe74+LzQLz0KcAZnj7mIKtXgOfRz8R/LKaIn4nNuvFUb8JM9TZ5g3me
         BXbRy6vnk2N7wScACVRVHEUX5jRVj5CLu1Pf2x8/QIKw+YLf3guPazizAtlQQIbKjlzR
         aUD++Oztv4iRHkPIyckIwwwLik0fdmIOZqrFGBKPHavtt2ZKY+VnPTNa3Tkb91Oh+8Wm
         sjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779296011; x=1779900811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kKcl0f+YiSx0kT0A06n+DmaHMn0z0MjpQEGjfw2KSV8=;
        b=jL1xEDSztVCGyjSq6TkkTxRsrNZg5V2EIcC1/4I3CDmXAR5U1YDa436dcNd557/oI6
         YOAk6JfRK8WLDrvx2H9bUH1rs7ZzrBX41+kykOm3tGCBgqUdCH5g2JQU0ZzjCnyNYDC9
         6OZGUI5jB9NNtsprKwJ1COLIkxIBx/gbbi87euOE+2uk700GQSKUf7q/yUPDBiZWQzy1
         AsEA37yx9QIQe/qTeZnCcN0Uo926qqaekNTO3opLRkCORwmMP7nD7ah2HPTYdHUZA0ad
         HCOy1q9muO25w5T1NAdPgRKtjx39UZlVQeHZ9nrs27zPtTyYKYCkf139F8KtmPxQXc0V
         L2Dg==
X-Forwarded-Encrypted: i=1; AFNElJ8KKXDvqtoQn2NR1Sd6iv7EvkRa/Hw684GVLxC71JZ91PR1oGqFv0yBfY87faWgdyoXxvbsDIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9jCEmaeyrfksWBu7uSLpxNu32QRF6TviSvdTLAnbNd3PcctHP
	QK48zZkiAJxSBlXsNRrFjfZnRoq25JTuhE6x2HPbI2j6ppsP1S2FeVjd
X-Gm-Gg: Acq92OHJBO8MDOPiBjZKbcLq9Kph8TAWfY4kvgio6KYQ1X9Pnexy+y3tWGccKXf5E8e
	yqU62mrtLzM+g3NVjOB3CKX9RBBiAironQl+uasviEorpHaS2xRTR8JdCkl7FPx5t6wezSKENR0
	ck9KwmpP+NRtbnkyBCRtcJCbEn3R1+41vxzlhuDI3qLkA5m8fV5L++7/ceJh9BtN28j7xzvPdLP
	A7ZtV1X5PFTtGvgoi4yls1LlqA7SDxscM20UL+OneLZkVHI4RGJeVBUCti1lb6qTqn3n49En9v+
	FjDhmCc9bCRx5g9UtT4fK9DRCr2NtOzdftHddDMxwDuhRgolIC9Mip9J0ATabaVTNBqTv/cK29Y
	hreufuXLtPGmE+FeB4Bx1U6iQqBdsfZ4KRORsXLAkvSuX2i72Pp6uAhos6w0FgGz7C8y5JtJJdL
	ZN3Oi/wLSlvEZ0KgCfqFfQI+1Y4jvbPO4VzqTnl79eJmfTAzpBLowM+BFG2gEkeygpXdnQzRgqT
	R+56iCfLnNYPlBsFy03wDhy1YVSg0kIjBiGjEMlBxNakqv0Q5bSTfi5/misWTuLiTwn024mGfou
	LR3pOMQozVFUMwW85rVlO16P771E
X-Received: by 2002:aa7:d14f:0:b0:674:7363:3e91 with SMTP id 4fb4d7f45d1cf-683bce9cec6mr9495273a12.12.1779296010835;
        Wed, 20 May 2026 09:53:30 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6831187ecb7sm7966009a12.29.2026.05.20.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:53:29 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: martin.petersen@oracle.com
Cc: bvanassche@acm.org,
	mlombard@arkamax.eu,
	ddiss@suse.de,
	target-devel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	stable@vger.kernel.org,
	hossu.alexandru@gmail.com
Subject: [PATCH v3] scsi: target: iscsi: validate CHAP_R length before base64 decode
Date: Wed, 20 May 2026 18:52:59 +0200
Message-ID: <20260520165259.272808-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518121811.385350-1-hossu.alexandru@gmail.com>
References: 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[acm.org,arkamax.eu,suse.de,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-250671-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5A8DF598FD7
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

Fixes: 1e5733883421 ("scsi: target: iscsi: Support base64 in CHAP")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
v3: strip trailing '=' before length check to handle padded encodings
    (reported by Maurizio Lombardi)
v2: use DIV_ROUND_UP(digest_size * 4, 3) as suggested by David Disseldorp

 drivers/target/iscsi/iscsi_target_auth.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
index c46c69a..00487d0 100644
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
-- 
2.54.0


