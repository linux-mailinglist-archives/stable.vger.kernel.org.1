Return-Path: <stable+bounces-51221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4E0906EE0
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D241F23057
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BC4146D6B;
	Thu, 13 Jun 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yENkU5Zb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105A2145A02;
	Thu, 13 Jun 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280662; cv=none; b=YEhhfyRMQNy7G5CMZl2iyTRfnd1DzP/UL9q7futcb96mv/D3xjOqaaSJxlkCcMXso00SxUKvjOc6fC1Nf7XDwG0NKsKbzN2C1OpyYxhoCXWbcbVgGsPrKsaGN58NUwYRYtmnYwqq33LAjwEcLo13kltEjJaFMC3yY/wDL7zBOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280662; c=relaxed/simple;
	bh=zm5n1jLxSEqflkepeZouz7EV6lre6TESAkf6Lt+uGyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clhPlYYJdHxfJuKpxm2kY9gzDigvHUZXc18sOgiAFQnnphc5KVUZUFDPCOFXERPLLBkCuy6z7+wTDCoumaIoHzF2NZmjEziZWjez5Wu86syDfOeU/DybzS+iQWiLy6B8N1y3wz/G43IB+Hldit9Xy362ilj0OUy2Uhe0zCbas0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yENkU5Zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD75C2BBFC;
	Thu, 13 Jun 2024 12:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280661;
	bh=zm5n1jLxSEqflkepeZouz7EV6lre6TESAkf6Lt+uGyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yENkU5ZbO6tFmlrQWC2UrW3Eqda9AnHIQzW0keJDdbabw0byqy3Pz+kNiaW1voz2x
	 2D/TY848qlKFr/BEokRGoJ4O+y6vkitMmC4W0ikzYFmY5KErnzAr6LA16rTRMrS9uI
	 GV/Bl0afi1kATVQRrnaWXpVLHloTqRcjucJHq2wM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6 129/137] eventfs: Keep the directories from having the same inode number as files
Date: Thu, 13 Jun 2024 13:35:09 +0200
Message-ID: <20240613113228.304192422@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit 8898e7f288c47d450a3cf1511c791a03550c0789 upstream.

The directories require unique inode numbers but all the eventfs files
have the same inode number. Prevent the directories from having the same
inode numbers as the files as that can confuse some tooling.

Link: https://lore.kernel.org/linux-trace-kernel/20240523051539.428826685@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Fixes: 834bf76add3e6 ("eventfs: Save directory inodes in the eventfs_inode structure")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/tracefs/event_inode.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -50,8 +50,12 @@ static struct eventfs_root_inode *get_ro
 /* Just try to make something consistent and unique */
 static int eventfs_dir_ino(struct eventfs_inode *ei)
 {
-	if (!ei->ino)
+	if (!ei->ino) {
 		ei->ino = get_next_ino();
+		/* Must not have the file inode number */
+		if (ei->ino == EVENTFS_FILE_INODE_INO)
+			ei->ino = get_next_ino();
+	}
 
 	return ei->ino;
 }



