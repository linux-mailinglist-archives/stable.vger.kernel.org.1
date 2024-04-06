Return-Path: <stable+bounces-36173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 014C989AB98
	for <lists+stable@lfdr.de>; Sat,  6 Apr 2024 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E7E2823D1
	for <lists+stable@lfdr.de>; Sat,  6 Apr 2024 15:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1E83A1B9;
	Sat,  6 Apr 2024 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="jz+BEpKI"
X-Original-To: stable@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F0381A4
	for <stable@vger.kernel.org>; Sat,  6 Apr 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712416576; cv=none; b=CThAAOZhoDjx//5lNCVz77jPdGc80Q/NTnGj99dUpRlxrl7Fy7dx6TmKhiSXn99x48Yh5bKSQSF6kfSU/HfAxFbpnVEfCrpPW9U/cM2CfMIlW6uhOW9dS1Od8NMyCqvexAVZbYExX4rzxP30ikDPxn76wYQUToNJxZj98ZMfkjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712416576; c=relaxed/simple;
	bh=+28usJkCIUzq4Uj+20wQsZBunr+57TTu478pi6Y0p7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RUCc6XxOxbghHxswXPj7jQ10aSwymSAvD5YSpCPTognTiyYXRrqfDLCFg69V8WK8NpO3Oo+kGNBSCrzMsx+p11JJDRge0xLJ+BJ3ajrd3iuQ50JLown/GX1GY1ukm8xRZYPVwM3qaknl1szcB9z3xK7/Lwtu3qiqhHHCE0APESE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=jz+BEpKI; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 55811D96875B3;
	Sat,  6 Apr 2024 18:07:36 +0300 (MSK)
Authentication-Results: mail.rosalinux.ru (amavisd-new);
	dkim=pass (2048-bit key) header.d=rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id puLWL5YOGtIF; Sat,  6 Apr 2024 18:07:36 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 22FC3EAA667F4;
	Sat,  6 Apr 2024 18:07:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 22FC3EAA667F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1712416056;
	bh=q4C2UQcxSwDuAVBPbzCdwka1wKufvqLvW0TUC2hLCm4=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=jz+BEpKIw92UUIXbfnQyuc4Vx85tolEAJXO+jT97bSJwiSYRI/MBwebirpPA1ep7j
	 n5F8bRmblwYk7UW7gKv0TB8is4OA9SJH2pA4IcdlEjL7AuYxuOn/l/1wKamTfoe2oT
	 5p9ykuB/TWnUsB/WzKkEy+ozmrGUl0FwCekaoc6d8WI1QPOQg4s4YWv7Upw8s1FLs6
	 c95KJq+m2yHoUJmGSXNvkshTQSqdb0Y2zxVKL+ihi4m8wAYYDTt2qqGvUHQBXnsmO4
	 8zSuOcy/9dvdyBOO5k4RXHJyKuGYN9fvnmewNxFV9O665DEv9bEgtoDOQAzIsbHKYo
	 577QZL3pwIM8A==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QmWiOWfEAEPw; Sat,  6 Apr 2024 18:07:36 +0300 (MSK)
Received: from localhost.localdomain (unknown [213.87.161.43])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id C29EBD96875B3;
	Sat,  6 Apr 2024 18:07:35 +0300 (MSK)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: 
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	stable@vger.kernel.org
Subject: 
Date: Sat,  6 Apr 2024 11:06:18 -0400
Message-ID: <20240406150622.39055-1-m.lobanov@rosalinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Date: Sat, 6 Apr 2024 10:29:09 -0400
Subject: [PATCH] bpf: dereference of null in __cgroup_bpf_query() functio=
n

In the __cgroup_bpf_query() function, it is possible to dereference
the null pointer in the line id =3D prog->aux->id; since there is no
check for a non-zero value of the variable prog.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: af6eea57437a ("bpf: Implement bpf_link-based cgroup BPF program at=
tachment")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
 kernel/bpf/cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 491d20038cbe..7f2db96f0c6a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1092,6 +1092,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
 			i =3D 0;
 			hlist_for_each_entry(pl, progs, node) {
 				prog =3D prog_list_prog(pl);
+               	       	if (!prog_list_prog(pl))
+				continue;
 				id =3D prog->aux->id;
 				if (copy_to_user(prog_ids + i, &id, sizeof(id)))
 					return -EFAULT;
--=20
2.43.0


