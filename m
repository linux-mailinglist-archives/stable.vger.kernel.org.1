Return-Path: <stable+bounces-258229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDmbD5AkG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-258229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:55:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD95610A79
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E1013018D74
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BC13C0A02;
	Sat, 30 May 2026 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XPjMxFA7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C133C1963;
	Sat, 30 May 2026 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163647; cv=none; b=mbRaCr84lPSI3Fh4oMTf+gDrTT6lwTQPo5rCOc20rQ2DD6RaCBwz0leFvT+y99GnsZjL1/pXDcVagdXQvVUpDd+Clz1G2WeUaoQ4s3wY6Gm+GgSfMT3WwvoDOIKeohQY9Q7RsB6YuE2fNRy+fFocI92hPNOxMgvrtKQXPqrkwCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163647; c=relaxed/simple;
	bh=BV4cMwoO7/UCtpYYFs9Kl/Q47Wssj4gTTpgP3j2TV58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSzOMDPoGMQu4XhsbseCJB8S7MuH11ptCPYqhIKUJdXipk9ju76suXPFPsnzz760bmD7zBQz06mso5iQwPyF4uROqKkIR74ebq4gzrpeZe7ngDJTAS0P8h2fj3QUb9Q67IVL3Wpo4fNpDLrg9joPPSB9rour8DvKRTRc1pvdFkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XPjMxFA7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A5F1F00893;
	Sat, 30 May 2026 17:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163646;
	bh=noQW+Ym3HzSPNYxIucAgXwh8J79FIx1asGKaw2A/0hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XPjMxFA7mUOgzkjrFlb3XKKDzJRS0zOD2+SMPUVekc6mi1EcE5vSyPKLtQAbIrkQw
	 m16JgBOANvpZGueRPM+SZdqzlIe2LqvZHFgpZ22yjP0S2CsmDqPlP7xHq5AV6kV/QV
	 UTehWJ1fG4YlTvGcQQngf4qn6fveI6VejlDJnyoI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 5.15 320/776] udf: reject descriptors with oversized CRC length
Date: Sat, 30 May 2026 18:00:34 +0200
Message-ID: <20260530160248.840113961@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258229-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.cz:email]
X-Rspamd-Queue-Id: 4CD95610A79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit 55d41b0a20128e86b9e960dd2e3f0a2d69a18df7 upstream.

udf_read_tagged() skips CRC verification when descCRCLength +
sizeof(struct tag) exceeds the block size.  A crafted UDF image can
set descCRCLength to an oversized value to bypass CRC validation
entirely; the descriptor is then accepted based solely on the 8-bit
tag checksum, which is trivially recomputable.

Reject such descriptors instead of silently accepting them.  A
legitimate single-block descriptor should never have a CRC length that
exceeds the block.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://patch.msgid.link/20260413211240.853662-1-michael.bommarito@gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/udf/misc.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/udf/misc.c
+++ b/fs/udf/misc.c
@@ -250,8 +250,12 @@ struct buffer_head *udf_read_tagged(stru
 	}
 
 	/* Verify the descriptor CRC */
-	if (le16_to_cpu(tag_p->descCRCLength) + sizeof(struct tag) > sb->s_blocksize ||
-	    le16_to_cpu(tag_p->descCRC) == crc_itu_t(0,
+	if (le16_to_cpu(tag_p->descCRCLength) + sizeof(struct tag) > sb->s_blocksize) {
+		udf_err(sb, "block %u: CRC length %u exceeds block size\n",
+			block, le16_to_cpu(tag_p->descCRCLength));
+		goto error_out;
+	}
+	if (le16_to_cpu(tag_p->descCRC) == crc_itu_t(0,
 					bh->b_data + sizeof(struct tag),
 					le16_to_cpu(tag_p->descCRCLength)))
 		return bh;



