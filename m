Return-Path: <stable+bounces-245944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDN/Fq1oA2qa5gEAu9opvQ
	(envelope-from <stable+bounces-245944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:51:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8985263A5
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B300B30FBAEF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F2921FF21;
	Tue, 12 May 2026 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mChtL9QA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403E3D9693;
	Tue, 12 May 2026 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607957; cv=none; b=HWDFAQhg0RNEe3N2LbdCsPXQW6jQkVxwe+wVnOwF41MubeiIXsZSnIAqrVLwwgcuXB84885oWbo/GVZdknEYZAICyUqJSsqqoSZkKvmv9Z9P6eQ26Z992guJszqKAwjNocmnIx+plsTEY9+1R0vYODviqAwv+kEEd7BF4EZHxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607957; c=relaxed/simple;
	bh=kZnrlTl5U2zDjPl+Dao4Yb13ghNl3NfxmMuyFyb5hek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIxLl6nDy2/pOxFaiNetnBhEIQvFbfhwBTfx03AmMqlvQHBfC3xnpB5Yq7tQNeDAM6sNwtn6nVPHRMG562TTCUwsMvygMfV9R/A+Kboz9HGCN6pf8/A6hWVsC7/2SiJ337RNQd7yaMw91Ng76jb8BpuBzKuH9+k5X9E4mUfgDBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mChtL9QA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5D9C2BCB0;
	Tue, 12 May 2026 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607957;
	bh=kZnrlTl5U2zDjPl+Dao4Yb13ghNl3NfxmMuyFyb5hek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mChtL9QA0CaiM9IwzREpEi5iVbI50n9ANRpPoipQE0uGC9XIw3tcGkcqQ6B3YqG4i
	 kw7+RPW3PK+Ud6CHiEDREMvDCzs7oPHur3/1O7Gsi/6AKpFbC3oYSg2tarX62izad1
	 hVQXpsCCfRt/A0YwuUOf79qo12RtgpTEbOahfXFg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 6.12 099/206] udf: reject descriptors with oversized CRC length
Date: Tue, 12 May 2026 19:39:11 +0200
Message-ID: <20260512173934.955487124@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: EA8985263A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-245944-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.cz:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -230,8 +230,12 @@ struct buffer_head *udf_read_tagged(stru
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



