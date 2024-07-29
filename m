Return-Path: <stable+bounces-62448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B629F93F237
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1E5284701
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E769D1422A8;
	Mon, 29 Jul 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A01eNUnF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77741420D5
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247697; cv=none; b=DeAbVXV+LRWDWCGmIPuJAaAMvXm9Pj+51s93hfUOrvjMZVjkYjYrIQseYsbwNQKOFUElk2QGiNh25GUczFouUKu7vlrxsUOxm3j3w+vkFwRUhoXSXqqutE69ZL0ddeVYzWTaIFG8i+1FhnUVEAabIlZbGeIT9nu+jhGaprDsM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247697; c=relaxed/simple;
	bh=HcBEt6WoB5UBrMYYsEVlXZHc7UcGeW5vWQDX14xoTxo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nV944DvhRqmkds5EUtnU7H8zaro1Ugz4QWBrdqpea6NpDWMARB2JXqT6+t9DWLOB7ujw1VTSEXPCbnrT6hkmjPyDQilUmNMxC1Nfzz3pZCwaPRx7Jx/19HgMlxMe+6wglMKOFaY9VJIAgqGRqDf2XwdDXlvhsb64ePsPG5Y1zrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A01eNUnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C51C32786;
	Mon, 29 Jul 2024 10:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722247697;
	bh=HcBEt6WoB5UBrMYYsEVlXZHc7UcGeW5vWQDX14xoTxo=;
	h=Subject:To:Cc:From:Date:From;
	b=A01eNUnFUPNzVOiBFlkFfxkyvJb9x1UWrRUFplGUKi2t8LKHrwKpvU9Nm0lhHpXwF
	 cIp+JX6xFmPQax1rkU2V0GqTgpOwBquih6qcMkPLVbpLZHWRIrgc3sbFb/tUq+zogJ
	 7vZ0qDj4894edUnACQfiKZrpAyf1cOB5OqJMeqNo=
Subject: FAILED: patch "[PATCH] apparmor: use kvfree_sensitive to free data->data" failed to apply to 4.19-stable tree
To: pchelkin@ispras.ru,john.johansen@canonical.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:08:05 +0200
Message-ID: <2024072905-twirl-endless-6a91@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 2bc73505a5cd2a18a7a542022722f136c19e3b87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072905-twirl-endless-6a91@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

2bc73505a5cd ("apparmor: use kvfree_sensitive to free data->data")
000518bc5aef ("apparmor: fix missing error check for rhashtable_insert_fast")
453431a54934 ("mm, treewide: rename kzfree() to kfree_sensitive()")
45365a06aa30 ("Merge tag 's390-5.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2bc73505a5cd2a18a7a542022722f136c19e3b87 Mon Sep 17 00:00:00 2001
From: Fedor Pchelkin <pchelkin@ispras.ru>
Date: Thu, 1 Feb 2024 17:24:48 +0300
Subject: [PATCH] apparmor: use kvfree_sensitive to free data->data

Inside unpack_profile() data->data is allocated using kvmemdup() so it
should be freed with the corresponding kvfree_sensitive().

Also add missing data->data release for rhashtable insertion failure path
in unpack_profile().

Found by Linux Verification Center (linuxtesting.org).

Fixes: e025be0f26d5 ("apparmor: support querying extended trusted helper extra data")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: John Johansen <john.johansen@canonical.com>

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 957654d253dd..14df15e35695 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -225,7 +225,7 @@ static void aa_free_data(void *ptr, void *arg)
 {
 	struct aa_data *data = ptr;
 
-	kfree_sensitive(data->data);
+	kvfree_sensitive(data->data, data->size);
 	kfree_sensitive(data->key);
 	kfree_sensitive(data);
 }
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 5e578ef0ddff..75452acd0e35 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1071,6 +1071,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 
 			if (rhashtable_insert_fast(profile->data, &data->head,
 						   profile->data->p)) {
+				kvfree_sensitive(data->data, data->size);
 				kfree_sensitive(data->key);
 				kfree_sensitive(data);
 				info = "failed to insert data to table";


