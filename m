Return-Path: <stable+bounces-167022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC7CB20510
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 12:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0FE77A6EE8
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7774622E402;
	Mon, 11 Aug 2025 10:17:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113371C1F05
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907434; cv=none; b=XiI3px3JF2XQJwTnsu3cTcbic8dMhw0zanV3405RxSm8jCQER5btRcboFPwc6t8MjdrHJB8TPBOaqZnBlxjHGdtDI2LCDQDzVzZXV6h4PcOn+e+7wzkg+rCrgmKjPdcsqNHLol9+g4NFH6Nh7mw/CQ0MNStVOsfTP9kBBEAQEfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907434; c=relaxed/simple;
	bh=HDwvPzdpHW98oeq7fUUOimJlla8qzlgUCzf5px3FZmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KTf/YI9QMbG37ZJ0JGnAYT1pb36tGSfbfhOGErBAMCxcKNHrHL8WfmlcnZDytHfcV191zrqiZyLDtFpMtuXrwHBeaIPcXiJUaMaZEFLN2x/11f7r/JRjA86W1Qt8vyobbAEPiVi/H3f07DnbVHLY8ZYL3VCaO+tA9attyAI2J28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
	by 156.147.23.52 with ESMTP; 11 Aug 2025 18:47:08 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
	by 156.147.1.121 with ESMTP; 11 Aug 2025 18:47:08 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From: Chanho Min <chanho.min@lge.com>
To: Steve French <sfrench@samba.org>,
	linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	gunho.lee@lge.com,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Paulo Alcantara <pc@manguebit.com>,
	stable@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Chanho Min <chanho.min@lge.com>
Subject: [PATCH 2/4] smb: client: fix potential UAF in is_valid_oplock_break()
Date: Mon, 11 Aug 2025 18:46:37 +0900
Message-Id: <20250811094639.37446-3-chanho.min@lge.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250811094639.37446-1-chanho.min@lge.com>
References: <20250811094639.37446-1-chanho.min@lge.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Paulo Alcantara <pc@manguebit.com>

commit 69ccf040acddf33a3a85ec0f6b45ef84b0f7ec29 upstream.

Skip sessions that are being teared down (status == SES_EXITING) to
avoid UAF.

Cc: stable@vger.kernel.org # 5.4
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ chanho: Backported to v5.4.y, misc.c was moved from fs/cifs to fs/smb/client ]
Signed-off-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/misc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index db1fcdedf289a..4d838d7db7b57 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -473,6 +473,8 @@ is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv)
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each(tmp, &srv->smb_ses_list) {
 		ses = list_entry(tmp, struct cifs_ses, smb_ses_list);
+		if (cifs_ses_exiting(ses))
+			continue;
 		list_for_each(tmp1, &ses->tcon_list) {
 			tcon = list_entry(tmp1, struct cifs_tcon, tcon_list);
 			if (tcon->tid != buf->Tid)

