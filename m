Return-Path: <stable+bounces-246209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBGxLcZrA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:04:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE6F526B06
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB94A31A4332
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A103BB117;
	Tue, 12 May 2026 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d8ByHXmJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4993955D2;
	Tue, 12 May 2026 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608639; cv=none; b=ptjlAvlKOa/T2o0JzvlbV9Pb3ryzRifPnhK9/5EA7RdR/X0TTLslsJ7eZMHL9s8vc+3a9rmjimzIbp7i5oGLFsshD2oeC54ZWeiJqYuQ51SZ7LrNezXIIYyyRTwMvbGoy8rDDzfFHomCXxPpiIbOzXnXY3XG+V087TSloM88nKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608639; c=relaxed/simple;
	bh=Kr/7rT/tPu+AakJBfh8RGSPSRr/eDom5mjmrmfbvBFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UADBapdCW/UB+SCvRGdpNWbhLb3nSEKaYolPQiNAXtvVJE/q8ikGNISco6mIjfM51Fx7Q8cS9UHtqsUDP1r2VUKFGMlEKJ7RVQcHiwOC2jpe2fY1zbPiWIoSnL3vRNlDbK2D+V1Z2lXNkcIqhSu2YzKQEiIyIwlkdWIk2Y92vg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d8ByHXmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66D2C2BCB0;
	Tue, 12 May 2026 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608639;
	bh=Kr/7rT/tPu+AakJBfh8RGSPSRr/eDom5mjmrmfbvBFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8ByHXmJaTfSmGu5YYULpBRDcKoRqIYPcedoNZ4IgA7zBUOxfHDKnVJwoAX+8hEPl
	 IzGwcnzu7ShR4JvCbk7OhCT82RnMbT8hjGdR1XnCiudy1kJoyTerrUfuZLjComQdEf
	 ktfTeFH8i//OmEK2gBPBBpXEUcBGKoSgPODU0KtA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 6.18 156/270] isofs: validate Rock Ridge CE continuation extent against volume size
Date: Tue, 12 May 2026 19:39:17 +0200
Message-ID: <20260512173941.733203084@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 4AE6F526B06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-246209-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit a36d990f591320e9dd379ab30063ebfe91d47e1f upstream.

rock_continue() reads rs->cont_extent verbatim from the Rock Ridge CE
record and passes it to sb_bread() without checking that the block
number is within the mounted ISO 9660 volume.  commit e595447e177b
("[PATCH] rock.c: handle corrupted directories") added cont_offset
and cont_size rejection for the CE continuation but did not validate
the extent block number itself.  commit f54e18f1b831 ("isofs: Fix
infinite looping over CE entries") later capped the CE chain length
at RR_MAX_CE_ENTRIES = 32 but again left the block number unchecked.

With a crafted ISO mounted via udisks2 (desktop optical auto-mount)
or via CAP_SYS_ADMIN mount, rs->cont_extent can therefore point at
an out-of-range block or at blocks belonging to an adjacent
filesystem on the same block device.  sb_bread() on an out-of-range
block returns NULL cleanly via the block layer EIO path, so there
is no memory-safety violation.  For in-range reads of adjacent-
filesystem data, the CE buffer is parsed as Rock Ridge records and
only the text of SL sub-records reaches userspace through
readlink(), which makes the info-leak channel narrow and difficult
to exploit; still, rejecting the malformed CE outright matches the
rejection shape already present in the same function for
cont_offset and cont_size.

Add an ISOFS_SB(sb)->s_nzones bounds check to rock_continue() next
to the existing offset/size rejection, printing the same
corrupted-directory-entry notice.

Fixes: f54e18f1b831 ("isofs: Fix infinite looping over CE entries")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://patch.msgid.link/20260419212155.2169382-2-michael.bommarito@gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/isofs/rock.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -101,6 +101,15 @@ static int rock_continue(struct rock_sta
 		goto out;
 	}
 
+	if ((unsigned)rs->cont_extent >= ISOFS_SB(rs->inode->i_sb)->s_nzones) {
+		printk(KERN_NOTICE "rock: corrupted directory entry. "
+			"extent=%u out of volume (nzones=%lu)\n",
+			(unsigned)rs->cont_extent,
+			ISOFS_SB(rs->inode->i_sb)->s_nzones);
+		ret = -EIO;
+		goto out;
+	}
+
 	if (rs->cont_extent) {
 		struct buffer_head *bh;
 



