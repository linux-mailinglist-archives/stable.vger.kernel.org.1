Return-Path: <stable+bounces-108288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849C0A0A4C1
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 17:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881673A5FA8
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3741D14EC7E;
	Sat, 11 Jan 2025 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QzpxJ5Q3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820C1474DA
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736612571; cv=none; b=pa4RB9QOm6Yw4GGd/It4pLZwlSZW+YvVPcWnD5jc5bLr6R1/QzzrUFYM7ufvDVcfULjmDXwepmnz3Rvur90TGdsd58XgxELZVjycdufU4CTxSw2bT0ph2oBrXOsGNJr8EK5kXbzq6WjEcC9k637QTyMqdOF5undbOmeUiekWpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736612571; c=relaxed/simple;
	bh=so5DNPZHDGexhBhT6Mg9hXXkrhaNx9oiCpfDTOQVQKg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X4YuR8uqaBN6q0LkTznTXuCuSw2h7TNfMM5Q9s9R74aFpJc3Uut7i5nSbUsaIkl8UbJPWe0LhnI956YuDag7UeU5SHozetlguuhv/0f+dy1NsIKPdOb7GvMYPhkyh9uOFpyKZ5ClqJPNcrFY4+0Z6cEGzEriA7MpW/kSgZ+HLeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QzpxJ5Q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503BCC4CED2;
	Sat, 11 Jan 2025 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736612570;
	bh=so5DNPZHDGexhBhT6Mg9hXXkrhaNx9oiCpfDTOQVQKg=;
	h=Subject:To:Cc:From:Date:From;
	b=QzpxJ5Q3mbFptmftvLT5T6d9QtnRynXnXk3wjhkNna2KzcWTJsRb7IW8HnoyMGr8P
	 mhfpD5lfeaIOgFwBcZ4FNzSjoQkuv0jsBhffEFDESK6Vyr+uIhMzVDq/MSaJIoM4z5
	 91F6gC204nuyOkcs+5UKvDt+GHxVaFNkVBnyr4MY=
Subject: FAILED: patch "[PATCH] sctp: sysctl: rto_min/max: avoid using current->nsproxy" failed to apply to 5.4-stable tree
To: matttbe@kernel.org,kuba@kernel.org,viro@zeniv.linux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 11 Jan 2025 17:22:39 +0100
Message-ID: <2025011139-spoilage-camping-62c6@gregkh>
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
git cherry-pick -x 9fc17b76fc70763780aa78b38fcf4742384044a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011139-spoilage-camping-62c6@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9fc17b76fc70763780aa78b38fcf4742384044a5 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 8 Jan 2025 16:34:33 +0100
Subject: [PATCH] sctp: sysctl: rto_min/max: avoid using current->nsproxy

As mentioned in a previous commit of this series, using the 'net'
structure via 'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The 'net' structure can be obtained from the table->data using
container_of().

Note that table->data could also be used directly, as this is the only
member needed from the 'net' structure, but that would increase the size
of this fix, to use '*data' everywhere 'net->sctp.rto_min/max' is used.

Fixes: 4f3fdf3bc59c ("sctp: add check rto_min and rto_max in sysctl")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250108-net-sysctl-current-nsproxy-v1-5-5df34b2083e8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 9848d19630a4..a5285815264d 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -433,7 +433,7 @@ static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
 static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.rto_min);
 	unsigned int min = *(unsigned int *) ctl->extra1;
 	unsigned int max = *(unsigned int *) ctl->extra2;
 	struct ctl_table tbl;
@@ -461,7 +461,7 @@ static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.rto_max);
 	unsigned int min = *(unsigned int *) ctl->extra1;
 	unsigned int max = *(unsigned int *) ctl->extra2;
 	struct ctl_table tbl;


