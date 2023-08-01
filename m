Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D532376AEA8
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjHAJkg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjHAJkI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A5D1990
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D36E1614FC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68FAC433C8;
        Tue,  1 Aug 2023 09:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882688;
        bh=8HXLGUrCNiavyQ6pVX0C+j0ohz4Q5cHmJEclUQg60fQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cLqX007oQXFRQ4JQHr81j9V8NIQjBVEgHdv8jqW6pKlTE5ULvoyApH+onnswE4L/W
         HfPFoJqNTuHOsPq5PmjoPBQ7rXtpQcunBIFx/3fwZ0IB8XN4pxYvsrRidNcStAmhUA
         gH7GF21xmu4C0okyOZPALQnrxZFY6dd7uwlG5/Jk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 6.1 195/228] xen: speed up grant-table reclaim
Date:   Tue,  1 Aug 2023 11:20:53 +0200
Message-ID: <20230801091929.912618240@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Demi Marie Obenour <demi@invisiblethingslab.com>

commit c04e9894846c663f3278a414f34416e6e45bbe68 upstream.

When a grant entry is still in use by the remote domain, Linux must put
it on a deferred list.  Normally, this list is very short, because
the PV network and block protocols expect the backend to unmap the grant
first.  However, Qubes OS's GUI protocol is subject to the constraints
of the X Window System, and as such winds up with the frontend unmapping
the window first.  As a result, the list can grow very large, resulting
in a massive memory leak and eventual VM freeze.

To partially solve this problem, make the number of entries that the VM
will attempt to free at each iteration tunable.  The default is still
10, but it can be overridden via a module parameter.

This is Cc: stable because (when combined with appropriate userspace
changes) it fixes a severe performance and stability problem for Qubes
OS users.

Cc: stable@vger.kernel.org
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20230726165354.1252-1-demi@invisiblethingslab.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-module |   11 +++++++++
 drivers/xen/grant-table.c              |   40 +++++++++++++++++++++++----------
 2 files changed, 40 insertions(+), 11 deletions(-)

--- a/Documentation/ABI/testing/sysfs-module
+++ b/Documentation/ABI/testing/sysfs-module
@@ -60,3 +60,14 @@ Description:	Module taint flags:
 			C   staging driver module
 			E   unsigned module
 			==  =====================
+
+What:		/sys/module/grant_table/parameters/free_per_iteration
+Date:		July 2023
+KernelVersion:	6.5 but backported to all supported stable branches
+Contact:	Xen developer discussion <xen-devel@lists.xenproject.org>
+Description:	Read and write number of grant entries to attempt to free per iteration.
+
+		Note: Future versions of Xen and Linux may provide a better
+		interface for controlling the rate of deferred grant reclaim
+		or may not need it at all.
+Users:		Qubes OS (https://www.qubes-os.org)
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -498,14 +498,21 @@ static LIST_HEAD(deferred_list);
 static void gnttab_handle_deferred(struct timer_list *);
 static DEFINE_TIMER(deferred_timer, gnttab_handle_deferred);
 
+static atomic64_t deferred_count;
+static atomic64_t leaked_count;
+static unsigned int free_per_iteration = 10;
+module_param(free_per_iteration, uint, 0600);
+
 static void gnttab_handle_deferred(struct timer_list *unused)
 {
-	unsigned int nr = 10;
+	unsigned int nr = READ_ONCE(free_per_iteration);
+	const bool ignore_limit = nr == 0;
 	struct deferred_entry *first = NULL;
 	unsigned long flags;
+	size_t freed = 0;
 
 	spin_lock_irqsave(&gnttab_list_lock, flags);
-	while (nr--) {
+	while ((ignore_limit || nr--) && !list_empty(&deferred_list)) {
 		struct deferred_entry *entry
 			= list_first_entry(&deferred_list,
 					   struct deferred_entry, list);
@@ -515,10 +522,14 @@ static void gnttab_handle_deferred(struc
 		list_del(&entry->list);
 		spin_unlock_irqrestore(&gnttab_list_lock, flags);
 		if (_gnttab_end_foreign_access_ref(entry->ref)) {
+			uint64_t ret = atomic64_dec_return(&deferred_count);
+
 			put_free_entry(entry->ref);
-			pr_debug("freeing g.e. %#x (pfn %#lx)\n",
-				 entry->ref, page_to_pfn(entry->page));
+			pr_debug("freeing g.e. %#x (pfn %#lx), %llu remaining\n",
+				 entry->ref, page_to_pfn(entry->page),
+				 (unsigned long long)ret);
 			put_page(entry->page);
+			freed++;
 			kfree(entry);
 			entry = NULL;
 		} else {
@@ -530,21 +541,22 @@ static void gnttab_handle_deferred(struc
 		spin_lock_irqsave(&gnttab_list_lock, flags);
 		if (entry)
 			list_add_tail(&entry->list, &deferred_list);
-		else if (list_empty(&deferred_list))
-			break;
 	}
-	if (!list_empty(&deferred_list) && !timer_pending(&deferred_timer)) {
+	if (list_empty(&deferred_list))
+		WARN_ON(atomic64_read(&deferred_count));
+	else if (!timer_pending(&deferred_timer)) {
 		deferred_timer.expires = jiffies + HZ;
 		add_timer(&deferred_timer);
 	}
 	spin_unlock_irqrestore(&gnttab_list_lock, flags);
+	pr_debug("Freed %zu references", freed);
 }
 
 static void gnttab_add_deferred(grant_ref_t ref, struct page *page)
 {
 	struct deferred_entry *entry;
 	gfp_t gfp = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC : GFP_KERNEL;
-	const char *what = KERN_WARNING "leaking";
+	uint64_t leaked, deferred;
 
 	entry = kmalloc(sizeof(*entry), gfp);
 	if (!page) {
@@ -567,10 +579,16 @@ static void gnttab_add_deferred(grant_re
 			add_timer(&deferred_timer);
 		}
 		spin_unlock_irqrestore(&gnttab_list_lock, flags);
-		what = KERN_DEBUG "deferring";
+		deferred = atomic64_inc_return(&deferred_count);
+		leaked = atomic64_read(&leaked_count);
+		pr_debug("deferring g.e. %#x (pfn %#lx) (total deferred %llu, total leaked %llu)\n",
+			 ref, page ? page_to_pfn(page) : -1, deferred, leaked);
+	} else {
+		deferred = atomic64_read(&deferred_count);
+		leaked = atomic64_inc_return(&leaked_count);
+		pr_warn("leaking g.e. %#x (pfn %#lx) (total deferred %llu, total leaked %llu)\n",
+			ref, page ? page_to_pfn(page) : -1, deferred, leaked);
 	}
-	printk("%s g.e. %#x (pfn %#lx)\n",
-	       what, ref, page ? page_to_pfn(page) : -1);
 }
 
 int gnttab_try_end_foreign_access(grant_ref_t ref)


