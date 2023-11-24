Return-Path: <stable+bounces-1800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ABB7F8169
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5200A282648
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EA3364A5;
	Fri, 24 Nov 2023 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cv1sKG1Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC482D787;
	Fri, 24 Nov 2023 18:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C96DC433C8;
	Fri, 24 Nov 2023 18:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852305;
	bh=Ub+g1KgMGmZ3NvGf7F2T2kCscKdgc3V3qFQZSR79d5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cv1sKG1YmoX4/nF/nX1104uk7ya6mPRjPDIzfNYBUcFQz6u6gRuRR1MIXgBmf87BU
	 Ov+3QiR5i8GhQ8X475CMtTjcJziQlQEqjBatF9BHOn82mlEAFNjFo3rMsjM86iWeNn
	 pDi5tyz9wa0QbUlOpJPkaskl/cFENd1kJDHYYD0k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shinhyung Kang <s47.kang@samsung.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 278/372] ALSA: info: Fix potential deadlock at disconnection
Date: Fri, 24 Nov 2023 17:51:05 +0000
Message-ID: <20231124172019.723628933@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit c7a60651953359f98dbf24b43e1bf561e1573ed4 upstream.

As reported recently, ALSA core info helper may cause a deadlock at
the forced device disconnection during the procfs operation.

The proc_remove() (that is called from the snd_card_disconnect()
helper) has a synchronization of the pending procfs accesses via
wait_for_completion().  Meanwhile, ALSA procfs helper takes the global
mutex_lock(&info_mutex) at both the proc_open callback and
snd_card_info_disconnect() helper.  Since the proc_open can't finish
due to the mutex lock, wait_for_completion() never returns, either,
hence it deadlocks.

	TASK#1				TASK#2
	proc_reg_open()
	  takes use_pde()
	snd_info_text_entry_open()
					snd_card_disconnect()
					snd_info_card_disconnect()
					  takes mutex_lock(&info_mutex)
					proc_remove()
					wait_for_completion(unused_pde)
					  ... waiting task#1 closes
	mutex_lock(&info_mutex)
		=> DEADLOCK

This patch is a workaround for avoiding the deadlock scenario above.

The basic strategy is to move proc_remove() call outside the mutex
lock.  proc_remove() can work gracefully without extra locking, and it
can delete the tree recursively alone.  So, we call proc_remove() at
snd_info_card_disconnection() at first, then delete the rest resources
recursively within the info_mutex lock.

After the change, the function snd_info_disconnect() doesn't do
disconnection by itself any longer, but it merely clears the procfs
pointer.  So rename the function to snd_info_clear_entries() for
avoiding confusion.

The similar change is applied to snd_info_free_entry(), too.  Since
the proc_remove() is called only conditionally with the non-NULL
entry->p, it's skipped after the snd_info_clear_entries() call.

Reported-by: Shinhyung Kang <s47.kang@samsung.com>
Closes: https://lore.kernel.org/r/664457955.21699345385931.JavaMail.epsvc@epcpadp4
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20231109141954.4283-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/info.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -56,7 +56,7 @@ struct snd_info_private_data {
 };
 
 static int snd_info_version_init(void);
-static void snd_info_disconnect(struct snd_info_entry *entry);
+static void snd_info_clear_entries(struct snd_info_entry *entry);
 
 /*
 
@@ -569,11 +569,16 @@ void snd_info_card_disconnect(struct snd
 {
 	if (!card)
 		return;
-	mutex_lock(&info_mutex);
+
 	proc_remove(card->proc_root_link);
-	card->proc_root_link = NULL;
 	if (card->proc_root)
-		snd_info_disconnect(card->proc_root);
+		proc_remove(card->proc_root->p);
+
+	mutex_lock(&info_mutex);
+	if (card->proc_root)
+		snd_info_clear_entries(card->proc_root);
+	card->proc_root_link = NULL;
+	card->proc_root = NULL;
 	mutex_unlock(&info_mutex);
 }
 
@@ -745,15 +750,14 @@ struct snd_info_entry *snd_info_create_c
 }
 EXPORT_SYMBOL(snd_info_create_card_entry);
 
-static void snd_info_disconnect(struct snd_info_entry *entry)
+static void snd_info_clear_entries(struct snd_info_entry *entry)
 {
 	struct snd_info_entry *p;
 
 	if (!entry->p)
 		return;
 	list_for_each_entry(p, &entry->children, list)
-		snd_info_disconnect(p);
-	proc_remove(entry->p);
+		snd_info_clear_entries(p);
 	entry->p = NULL;
 }
 
@@ -770,8 +774,9 @@ void snd_info_free_entry(struct snd_info
 	if (!entry)
 		return;
 	if (entry->p) {
+		proc_remove(entry->p);
 		mutex_lock(&info_mutex);
-		snd_info_disconnect(entry);
+		snd_info_clear_entries(entry);
 		mutex_unlock(&info_mutex);
 	}
 



