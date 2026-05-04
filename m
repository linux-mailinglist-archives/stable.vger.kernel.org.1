Return-Path: <stable+bounces-242937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I7QCeNe+GlJtgIAu9opvQ
	(envelope-from <stable+bounces-242937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:54:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A52E4BA9EC
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 734943082B3B
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F5D34CFC6;
	Mon,  4 May 2026 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0O+BFN6X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD6234C826
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884607; cv=none; b=KIkWLnHq/vDas2Mf+UrIvNby7HOEFy8L1XxQS1zFRxKTjodJrU6Smrg4yXhH2VnHw+UFy7H3quJ3VxlyZMcevDxk/7jVg45JUBPEy0a4Q8woYS4xbA1dLY/pqiy0sbHAn+A93bhtEavPyss87929rZOYigJ73yq7B7d3v0qSSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884607; c=relaxed/simple;
	bh=QIJvTtd0KA1wxtQv/E4iNWpJcqFtCv4HL0wHpplC1Qw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fdHyNLtZ0lsRXRzP50uslb9zWrW2jSMlzpAHwbkSOV8Pcl2yGCzIUgZoyVkCW17qs3cnR+zmoymlCXeZ3K2x3NDrsgkEEpCuHxdvZbTDUUOmNYS99/A1k/JUvK/9xD7IT6CZktZ+odDiu4JXYYMEC+PtaEBzOX6FT+F+4XCChb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0O+BFN6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07418C2BCF4;
	Mon,  4 May 2026 08:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777884607;
	bh=QIJvTtd0KA1wxtQv/E4iNWpJcqFtCv4HL0wHpplC1Qw=;
	h=Subject:To:Cc:From:Date:From;
	b=0O+BFN6X7O7eQ0KvZCNsP8Ozx6jPr8y0s/gclwa0Orozikg5fjaVRAxb1BASy3vNz
	 omyBEn7ib58R2DdMkPaB/dOvY6gLErjqGBJ6WO69c3hBDEBOiS0Qsw3vh95D2xN9MA
	 5MGoGc/4yuHJV3Q0U/qmhfPVjTSQbYd3qQn9AsDI=
Subject: FAILED: patch "[PATCH] ceph: fix num_ops off-by-one when crypto allocation fails" failed to apply to 6.6-stable tree
To: cfsworks@gmail.com,CFSworks@gmail.com,Slava.Dubeyko@ibm.com,idryomov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:49:55 +0200
Message-ID: <2026050455-worry-catalog-1445@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9A52E4BA9EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242937-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ibm.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a0d9555bf9eaeba34fe6b6bb86f442fe08ba3842
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050455-worry-catalog-1445@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a0d9555bf9eaeba34fe6b6bb86f442fe08ba3842 Mon Sep 17 00:00:00 2001
From: Sam Edwards <cfsworks@gmail.com>
Date: Tue, 17 Mar 2026 19:37:33 -0700
Subject: [PATCH] ceph: fix num_ops off-by-one when crypto allocation fails

move_dirty_folio_in_page_array() may fail if the file is encrypted, the
dirty folio is not the first in the batch, and it fails to allocate a
bounce buffer to hold the ciphertext. When that happens,
ceph_process_folio_batch() simply redirties the folio and flushes the
current batch -- it can retry that folio in a future batch.

However, if this failed folio is not contiguous with the last folio that
did make it into the batch, then ceph_process_folio_batch() has already
incremented `ceph_wbc->num_ops`; because it doesn't follow through and
add the discontiguous folio to the array, ceph_submit_write() -- which
expects that `ceph_wbc->num_ops` accurately reflects the number of
contiguous ranges (and therefore the required number of "write extent"
ops) in the writeback -- will panic the kernel:

    BUG_ON(ceph_wbc->op_idx + 1 != req->r_num_ops);

This issue can be reproduced on affected kernels by writing to
fscrypt-enabled CephFS file(s) with a 4KiB-written/4KiB-skipped/repeat
pattern (total filesize should not matter) and gradually increasing the
system's memory pressure until a bounce buffer allocation fails.

Fix this crash by decrementing `ceph_wbc->num_ops` back to the correct
value when move_dirty_folio_in_page_array() fails, but the folio already
started counting a new (i.e. still-empty) extent.

The defect corrected by this patch has existed since 2022 (see first
`Fixes:`), but another bug blocked multi-folio encrypted writeback until
recently (see second `Fixes:`). The second commit made it into 6.18.16,
6.19.6, and 7.0-rc1, unmasking the panic in those versions. This patch
therefore fixes a regression (panic) introduced by cac190c7674f.

Cc: stable@vger.kernel.org
Fixes: d55207717ded ("ceph: add encryption support to writepage and writepages")
Fixes: cac190c7674f ("ceph: fix write storm on fscrypted files")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2090fc78529c..44553556ac74 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1365,6 +1365,10 @@ void ceph_process_folio_batch(struct address_space *mapping,
 		rc = move_dirty_folio_in_page_array(mapping, wbc, ceph_wbc,
 				folio);
 		if (rc) {
+			/* Did we just begin a new contiguous op? Nevermind! */
+			if (ceph_wbc->len == 0)
+				ceph_wbc->num_ops--;
+
 			folio_redirty_for_writepage(wbc, folio);
 			folio_unlock(folio);
 			break;


