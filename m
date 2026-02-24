Return-Path: <stable+bounces-217936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Y8V8A534nWmeSwQAu9opvQ
	(envelope-from <stable+bounces-217936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 20:14:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A50D18BBD5
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 20:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F0BA30DE195
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 19:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ED83016E3;
	Tue, 24 Feb 2026 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jWU5McBO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67890301474;
	Tue, 24 Feb 2026 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960442; cv=none; b=ts/rN26RP6CmXHJaV7l8b/+qglBi3FH4rbkgw8NGTRjObGH3EyEqqLzTw5ObQFwepD3bY77SeMTBi/ASKi3M0++117snVScRHidIlwIfWAfWP3gKahq9CM5Nkx/C9QSKXqyJi4iYNfp6GXCAsLPrWd0rrX9QldKkqEV2szOEOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960442; c=relaxed/simple;
	bh=vi7AgGJDUh3IHs6cGHUTUeu+POD5YJvP1x+mCLjs7qk=;
	h=Date:To:From:Subject:Message-Id; b=mq13qpOp7LfAdA/8+tf+40yPvU8xmbWAw/OhCZxO93jNWLjFZRm67JikC7iev52cneKvD1XoX5Ydpl5qb2+NkyyWVqBxOoJa8eiWD+wobid/sODmSTsgGJBTfI0ej4s2lwrlLrZQfRN7W/qeHH4xqIc3D8dbK9eXIY6ocXVR0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jWU5McBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03263C116D0;
	Tue, 24 Feb 2026 19:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1771960442;
	bh=vi7AgGJDUh3IHs6cGHUTUeu+POD5YJvP1x+mCLjs7qk=;
	h=Date:To:From:Subject:From;
	b=jWU5McBOqlnZykHuX17BIMDUxMLv+O3k/rFkYHLCEf6TgM6sn84hgrQfEA2YIRCuX
	 zigCztsxeZMlNx4wYd4xTJvEWJO+it7GVn2jetsc/Zggh3Ak6ESTvGeeSXMP/9aKIf
	 wGVVw4G+n821PgSbqBVHo2BU3vjTRfZYFpuTv9sI=
Date: Tue, 24 Feb 2026 11:14:01 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,rppt@kernel.org,pasha.tatashin@soleen.com,pratyush@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] liveupdate-luo_file-remember-retrieve-status.patch removed from -mm tree
Message-Id: <20260224191402.03263C116D0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217936-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,soleen.com:email]
X-Rspamd-Queue-Id: 6A50D18BBD5
X-Rspamd-Action: no action


The quilt patch titled
     Subject: liveupdate: luo_file: remember retrieve() status
has been removed from the -mm tree.  Its filename was
     liveupdate-luo_file-remember-retrieve-status.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
Subject: liveupdate: luo_file: remember retrieve() status
Date: Mon, 16 Feb 2026 14:22:19 +0100

LUO keeps track of successful retrieve attempts on a LUO file.  It does so
to avoid multiple retrievals of the same file.  Multiple retrievals cause
problems because once the file is retrieved, the serialized data
structures are likely freed and the file is likely in a very different
state from what the code expects.

The retrieve boolean in struct luo_file keeps track of this, and is passed
to the finish callback so it knows what work was already done and what it
has left to do.

All this works well when retrieve succeeds.  When it fails,
luo_retrieve_file() returns the error immediately, without ever storing
anywhere that a retrieve was attempted or what its error code was.  This
results in an errored LIVEUPDATE_SESSION_RETRIEVE_FD ioctl to userspace,
but nothing prevents it from trying this again.

The retry is problematic for much of the same reasons listed above.  The
file is likely in a very different state than what the retrieve logic
normally expects, and it might even have freed some serialization data
structures.  Attempting to access them or free them again is going to
break things.

For example, if memfd managed to restore 8 of its 10 folios, but fails on
the 9th, a subsequent retrieve attempt will try to call
kho_restore_folio() on the first folio again, and that will fail with a
warning since it is an invalid operation.

Apart from the retry, finish() also breaks.  Since on failure the
retrieved bool in luo_file is never touched, the finish() call on session
close will tell the file handler that retrieve was never attempted, and it
will try to access or free the data structures that might not exist, much
in the same way as the retry attempt.

There is no sane way of attempting the retrieve again.  Remember the error
retrieve returned and directly return it on a retry.  Also pass this
status code to finish() so it can make the right decision on the work it
needs to do.

This is done by changing the bool to an integer.  A value of 0 means
retrieve was never attempted, a positive value means it succeeded, and a
negative value means it failed and the error code is the value.

Link: https://lkml.kernel.org/r/20260216132221.987987-1-pratyush@kernel.org
Fixes: 7c722a7f44e0 ("liveupdate: luo_file: implement file systems callbacks")
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/liveupdate.h   |    9 ++++---
 kernel/liveupdate/luo_file.c |   41 ++++++++++++++++++++-------------
 mm/memfd_luo.c               |    7 ++++-
 3 files changed, 37 insertions(+), 20 deletions(-)

--- a/include/linux/liveupdate.h~liveupdate-luo_file-remember-retrieve-status
+++ a/include/linux/liveupdate.h
@@ -23,8 +23,11 @@ struct file;
 /**
  * struct liveupdate_file_op_args - Arguments for file operation callbacks.
  * @handler:          The file handler being called.
- * @retrieved:        The retrieve status for the 'can_finish / finish'
- *                    operation.
+ * @retrieve_status:  The retrieve status for the 'can_finish / finish'
+ *                    operation. A value of 0 means the retrieve has not been
+ *                    attempted, a positive value means the retrieve was
+ *                    successful, and a negative value means the retrieve failed,
+ *                    and the value is the error code of the call.
  * @file:             The file object. For retrieve: [OUT] The callback sets
  *                    this to the new file. For other ops: [IN] The caller sets
  *                    this to the file being operated on.
@@ -40,7 +43,7 @@ struct file;
  */
 struct liveupdate_file_op_args {
 	struct liveupdate_file_handler *handler;
-	bool retrieved;
+	int retrieve_status;
 	struct file *file;
 	u64 serialized_data;
 	void *private_data;
--- a/kernel/liveupdate/luo_file.c~liveupdate-luo_file-remember-retrieve-status
+++ a/kernel/liveupdate/luo_file.c
@@ -134,9 +134,12 @@ static LIST_HEAD(luo_file_handler_list);
  *                 state that is not preserved. Set by the handler's .preserve()
  *                 callback, and must be freed in the handler's .unpreserve()
  *                 callback.
- * @retrieved:     A flag indicating whether a user/kernel in the new kernel has
+ * @retrieve_status: Status code indicating whether a user/kernel in the new kernel has
  *                 successfully called retrieve() on this file. This prevents
- *                 multiple retrieval attempts.
+ *                 multiple retrieval attempts. A value of 0 means a retrieve()
+ *                 has not been attempted, a positive value means the retrieve()
+ *                 was successful, and a negative value means the retrieve()
+ *                 failed, and the value is the error code of the call.
  * @mutex:         A mutex that protects the fields of this specific instance
  *                 (e.g., @retrieved, @file), ensuring that operations like
  *                 retrieving or finishing a file are atomic.
@@ -161,7 +164,7 @@ struct luo_file {
 	struct file *file;
 	u64 serialized_data;
 	void *private_data;
-	bool retrieved;
+	int retrieve_status;
 	struct mutex mutex;
 	struct list_head list;
 	u64 token;
@@ -298,7 +301,6 @@ int luo_preserve_file(struct luo_file_se
 	luo_file->file = file;
 	luo_file->fh = fh;
 	luo_file->token = token;
-	luo_file->retrieved = false;
 	mutex_init(&luo_file->mutex);
 
 	args.handler = fh;
@@ -577,7 +579,12 @@ int luo_retrieve_file(struct luo_file_se
 		return -ENOENT;
 
 	guard(mutex)(&luo_file->mutex);
-	if (luo_file->retrieved) {
+	if (luo_file->retrieve_status < 0) {
+		/* Retrieve was attempted and it failed. Return the error code. */
+		return luo_file->retrieve_status;
+	}
+
+	if (luo_file->retrieve_status > 0) {
 		/*
 		 * Someone is asking for this file again, so get a reference
 		 * for them.
@@ -590,16 +597,19 @@ int luo_retrieve_file(struct luo_file_se
 	args.handler = luo_file->fh;
 	args.serialized_data = luo_file->serialized_data;
 	err = luo_file->fh->ops->retrieve(&args);
-	if (!err) {
-		luo_file->file = args.file;
-
-		/* Get reference so we can keep this file in LUO until finish */
-		get_file(luo_file->file);
-		*filep = luo_file->file;
-		luo_file->retrieved = true;
+	if (err) {
+		/* Keep the error code for later use. */
+		luo_file->retrieve_status = err;
+		return err;
 	}
 
-	return err;
+	luo_file->file = args.file;
+	/* Get reference so we can keep this file in LUO until finish */
+	get_file(luo_file->file);
+	*filep = luo_file->file;
+	luo_file->retrieve_status = 1;
+
+	return 0;
 }
 
 static int luo_file_can_finish_one(struct luo_file_set *file_set,
@@ -615,7 +625,7 @@ static int luo_file_can_finish_one(struc
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
-		args.retrieved = luo_file->retrieved;
+		args.retrieve_status = luo_file->retrieve_status;
 		can_finish = luo_file->fh->ops->can_finish(&args);
 	}
 
@@ -632,7 +642,7 @@ static void luo_file_finish_one(struct l
 	args.handler = luo_file->fh;
 	args.file = luo_file->file;
 	args.serialized_data = luo_file->serialized_data;
-	args.retrieved = luo_file->retrieved;
+	args.retrieve_status = luo_file->retrieve_status;
 
 	luo_file->fh->ops->finish(&args);
 	luo_flb_file_finish(luo_file->fh);
@@ -788,7 +798,6 @@ int luo_file_deserialize(struct luo_file
 		luo_file->file = NULL;
 		luo_file->serialized_data = file_ser[i].data;
 		luo_file->token = file_ser[i].token;
-		luo_file->retrieved = false;
 		mutex_init(&luo_file->mutex);
 		list_add_tail(&luo_file->list, &file_set->files_list);
 	}
--- a/mm/memfd_luo.c~liveupdate-luo_file-remember-retrieve-status
+++ a/mm/memfd_luo.c
@@ -326,7 +326,12 @@ static void memfd_luo_finish(struct live
 	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
 
-	if (args->retrieved)
+	/*
+	 * If retrieve was successful, nothing to do. If it failed, retrieve()
+	 * already cleaned up everything it could. So nothing to do there
+	 * either. Only need to clean up when retrieve was not called.
+	 */
+	if (args->retrieve_status)
 		return;
 
 	ser = phys_to_virt(args->serialized_data);
_

Patches currently in -mm which might be from pratyush@kernel.org are

mm-memfd_luo-always-make-all-folios-uptodate.patch
mm-memfd_luo-always-dirty-all-folios.patch
memfd-export-memfd_addget_seals.patch
mm-memfd_luo-preserve-file-seals.patch
kho-move-alloc-tag-init-to-kho_init_foliopages.patch


