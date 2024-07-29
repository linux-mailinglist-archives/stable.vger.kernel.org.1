Return-Path: <stable+bounces-62447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6AB93F236
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10F828464D
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DA71442E8;
	Mon, 29 Jul 2024 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xu652Ggy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570E014373E
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247688; cv=none; b=gLsCIcAcvFagtHk/ObmcbJjdf7IWEX3TmzfqFkRQQaDen+TrSsvBJtLKqhudwTKLL+1oWyWWV9r3+qQN/OF6EpP051kfP5xkCg/azufZQtFcfIhvFHFVWjmgt6uQoS4nJhhQmwpdY9Surr3EhMGvNs3tEiQ06ptAnVyW5TbSbFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247688; c=relaxed/simple;
	bh=wHO9aus5C3S7ao1GWevC2+ejTQDuw92w98vnsxmEaf0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aZlNjugOVmHvp17zxoGNK5ydjU0M62TLcvZv8kfkHz1H2Xo7b8xSqbLDNZvuB4XCrVcqZQ9CRdplCX6sAj9quG/M2eIo/ecQ/TolsUo3QrUVwAAX1ZOHNtfqOZ+AGQQwJHpVYBQVwTdMYlP09Nv2PJG+g00Kzx5cdWoxfhY4Ntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xu652Ggy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C2FC4AF0C;
	Mon, 29 Jul 2024 10:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722247688;
	bh=wHO9aus5C3S7ao1GWevC2+ejTQDuw92w98vnsxmEaf0=;
	h=Subject:To:Cc:From:Date:From;
	b=xu652GgyAHZh9yyUL+R+qNZbVI6ciAjPVohGTcMMJRViKM3HF3YqIJ4Z9PS5ene0e
	 rFvlz/rMoMg7KEDtfxmdvdwqSUE2gkuduvROHEfNM24pmNcR3Zw7DvFk1v51PUsZ6O
	 9atmXNlz/EhrTKEnNxz1Yd2P1VIijevYxnxUiM8A=
Subject: FAILED: patch "[PATCH] apparmor: use kvfree_sensitive to free data->data" failed to apply to 5.4-stable tree
To: pchelkin@ispras.ru,john.johansen@canonical.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:08:04 +0200
Message-ID: <2024072904-landmass-fragrant-ef08@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2bc73505a5cd2a18a7a542022722f136c19e3b87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072904-landmass-fragrant-ef08@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


