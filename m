Return-Path: <stable+bounces-240613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJqCLXI762mMKAAAu9opvQ
	(envelope-from <stable+bounces-240613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:44:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2138745C69C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3A183016817
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341FD38B131;
	Fri, 24 Apr 2026 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mYxJcsLC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC45638AC78
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023828; cv=none; b=a7JJC8j//JgoErQ5T2b7ncx/iRzzAOPLGHnoc0jvc0Vb9lnNKGUcKSempQ6s2ua7+i5ly7hBg5P9DA4+tplEoITD6RYIKjc69g8n6fplMFjJ9wmF+JbvwbAu9rW289rHjJb9Q7zYuKV/GmrS0FykjKNoAdG0MAvjKw/uaqW9QoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023828; c=relaxed/simple;
	bh=8ijfs4JrcQUm7sL313cmniq1HKSyJv9mFRWV23iH3l8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Oj1lpZpD+c+JWklgZc5aVztnf2ke+khmCR0cl2Dr98lOoBPIHxeqxUgWL5ag6FngdKdUMHfLxkoghMZCLsBryc2B9/zP95VivcM7umbtiB0P9FRVViaM72kI7Wv4DUqEXJk0lD5IAh9QjNVlrMak8UMya8+C3YRlGL/hz1MtkaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mYxJcsLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8204BC19425;
	Fri, 24 Apr 2026 09:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777023827;
	bh=8ijfs4JrcQUm7sL313cmniq1HKSyJv9mFRWV23iH3l8=;
	h=Subject:To:Cc:From:Date:From;
	b=mYxJcsLCnZQMwyuQQ46ki3d7d5zRHfsGArmIFowaOjrZBuVquaiJCYBYYmp6464Du
	 9cigtUc6ctyqlb3o8uBOfPe0jWl/CWK4fX9JwlOosXoJIO+I2tw5HT5itx2dL7pqn+
	 tGFAZIYnp/M1f8dfRzre4STVr5nSsPeHd74oh4K8=
Subject: FAILED: patch "[PATCH] ksmbd: fix out-of-bounds write in smb2_get_ea() EA alignment" failed to apply to 5.15-stable tree
To: tristan@talencesecurity.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Apr 2026 11:43:45 +0200
Message-ID: <2026042445-graduate-unvaried-2a31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2138745C69C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240613-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,talencesecurity.com:email,gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 30010c952077a1c89ecdd71fc4d574c75a8f5617
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042445-graduate-unvaried-2a31@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30010c952077a1c89ecdd71fc4d574c75a8f5617 Mon Sep 17 00:00:00 2001
From: Tristan Madani <tristan@talencesecurity.com>
Date: Fri, 17 Apr 2026 19:33:17 +0000
Subject: [PATCH] ksmbd: fix out-of-bounds write in smb2_get_ea() EA alignment

smb2_get_ea() applies 4-byte alignment padding via memset() after
writing each EA entry. The bounds check on buf_free_len is performed
before the value memcpy, but the alignment memset fires unconditionally
afterward with no check on remaining space.

When the EA value exactly fills the remaining buffer (buf_free_len == 0
after value subtraction), the alignment memset writes 1-3 NUL bytes
past the buf_free_len boundary. In compound requests where the response
buffer is shared across commands, the first command (e.g., READ) can
consume most of the buffer, leaving a tight remainder for the QUERY_INFO
EA response. The alignment memset then overwrites past the physical
kvmalloc allocation into adjacent kernel heap memory.

Add a bounds check before the alignment memset to ensure buf_free_len
can accommodate the padding bytes.

This is the same bug pattern fixed by commit beef2634f81f ("ksmbd: fix
potencial OOB in get_file_all_info() for compound requests") and
commit fda9522ed6af ("ksmbd: fix OOB write in QUERY_INFO for compound
requests"), both of which added bounds checks before unconditional
writes in QUERY_INFO response handlers.

Cc: stable@vger.kernel.org
Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 395007c82831..652b6771ccaf 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4818,6 +4818,8 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 		/* align next xattr entry at 4 byte bundary */
 		alignment_bytes = ((next_offset + 3) & ~3) - next_offset;
 		if (alignment_bytes) {
+			if (buf_free_len < alignment_bytes)
+				break;
 			memset(ptr, '\0', alignment_bytes);
 			ptr += alignment_bytes;
 			next_offset += alignment_bytes;


