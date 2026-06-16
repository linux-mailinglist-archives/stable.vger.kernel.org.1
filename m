Return-Path: <stable+bounces-264973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZCS3CWmAMWomlAUAu9opvQ
	(envelope-from <stable+bounces-264973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:57:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FE96929BF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:57:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=y9Zo8sD9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264973-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264973-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B4693058884
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC6D478E39;
	Tue, 16 Jun 2026 16:54:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD154502F;
	Tue, 16 Jun 2026 16:54:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628866; cv=none; b=egKkMIJRl9NthFsNG2Z8kLGkAGgDODvIMuSKS63l0kJByRVPj11msfnq+16OK9i2/cvsLpkLiK0Pzf+oqdHCkSo5EpuVfWNGNPCVv9xCBgDWxgOXxIfSPW+B4qK9sug1esDVbmybGhZQURtxPBQ/98/x5hmpwYYupd4hGsrErKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628866; c=relaxed/simple;
	bh=jGHrcqvzNjlyrxPEebr5giDjGZPFS0ySfzx9jksid5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkEG0qKXZ6gmwfgDy08YhQfpXXxk/joM1kBsB7iYQeznVkvleXWO3hcH0SY6RUu4WHvUoAVJS7pspBN6SkfisYShJ0VEaO0dhnhiXHk5BuPyFSmQhjmTY1Y0W9K4IVHNIzuqwYnX670UwPHhZ8IvaHQL2TGtrgwxZRuFkt5OXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y9Zo8sD9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EAD1F000E9;
	Tue, 16 Jun 2026 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628864;
	bh=nHF7M+gY4JS7zboJFE5h1zxjYVMI/iCpctJn0q3/4xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=y9Zo8sD9SjC8OIR2EuOpaUzsCS/0dWmzTcASCe/AsEO02KUaDLqExrOxdPPVcjS4n
	 077s836cvBN9ZPvVL3Wfax6UNBtWQAj6dTeRAd9oKCKVO8S60UGMRuMLpHi8QhrSz2
	 duOQQXHegajIuVyAnqvI3PNqvq4zFOspMr/0M4+o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	David Disseldorp <ddiss@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 175/452] scsi: target: iscsi: Validate CHAP_R length before base64 decode
Date: Tue, 16 Jun 2026 20:26:42 +0530
Message-ID: <20260616145127.074475162@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264973-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de,oracle.com];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:hossu.alexandru@gmail.com,m:ddiss@suse.de,m:martin.petersen@oracle.com,m:hossualexandru@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81FE96929BF

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandru Hossu <hossu.alexandru@gmail.com>

commit 85db7391310b1304d2dc8ae3b0b12105a9567147 upstream.

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
Reviewed-by: David Disseldorp <ddiss@suse.de>
Link: https://patch.msgid.link/20260521151121.808477-1-hossu.alexandru@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/iscsi/iscsi_target_auth.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -339,13 +339,22 @@ static int chap_server_compute_hash(
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
@@ -472,6 +481,14 @@ static int chap_server_compute_hash(
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



