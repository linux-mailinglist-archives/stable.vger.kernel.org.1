Return-Path: <stable+bounces-39114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D758A11F9
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CED1F273F7
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1715C146A72;
	Thu, 11 Apr 2024 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FZg2Zh4S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9D679FD;
	Thu, 11 Apr 2024 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832557; cv=none; b=Xb1vwcZTMuFt7kbzlB36Woiemsl/Aivg/gsbldRicB8PvvZ3m6jp+xZxDDl1cAgavYp3Ly4uXYteiygJKhvF2GjtI1+wHebzT/qQ8kNPO/fz/kNT9ERB4o/+DwIM2MOiioG6ltgAGOM08fcWEcMnCkaNh1FgLtK82HtQ3malze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832557; c=relaxed/simple;
	bh=agQ/0UKxwjXoXJAWi5BOE1n7UFJrCBp+k+UvZLEmLRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4Y/NgvyGDEJjtnZoEvnH6N0OZP/3k9p+D6cDjvRDMnv+EzzyqpGN/ujbKgvcvb/64DmY5IeLM0X2021sxcmJeuKkjyGlTqKNmrZ7frO6wMcTuOahfNWWhJRbbo2yPOC53LEFPsVaiB7Ye/rE7kEvZ9yio/06OCviKCOmS7Ynto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FZg2Zh4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5232EC433C7;
	Thu, 11 Apr 2024 10:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712832557;
	bh=agQ/0UKxwjXoXJAWi5BOE1n7UFJrCBp+k+UvZLEmLRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZg2Zh4SYE6sRfQxxVLVFj3xxY2sRwJ1PbceIpu/qsbrCUeO2/9GgODgGXqg5ffsf
	 Zo6vrvUS/wK/oKB5VxAFIHR39s2tH65hUFaFLnJUD6fcaWuF7ddtac8+ZFHk0eEIov
	 sM82vW0fuYI0O7XDLGJkF8xXCryjbly1e+Rkix+w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.1 82/83] VMCI: Fix possible memcpy() run-time warning in vmci_datagram_invoke_guest_handler()
Date: Thu, 11 Apr 2024 11:57:54 +0200
Message-ID: <20240411095415.157348111@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>
References: <20240411095412.671665933@linuxfoundation.org>
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

From: Vasiliy Kovalev <kovalev@altlinux.org>

commit e606e4b71798cc1df20e987dde2468e9527bd376 upstream.

The changes are similar to those given in the commit 19b070fefd0d
("VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()").

Fix filling of the msg and msg_payload in dg_info struct, which prevents a
possible "detected field-spanning write" of memcpy warning that is issued
by the tracking mechanism __fortify_memcpy_chk.

Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Link: https://lore.kernel.org/r/20240219105315.76955-1-kovalev@altlinux.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/vmw_vmci/vmci_datagram.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/misc/vmw_vmci/vmci_datagram.c
+++ b/drivers/misc/vmw_vmci/vmci_datagram.c
@@ -378,7 +378,8 @@ int vmci_datagram_invoke_guest_handler(s
 
 		dg_info->in_dg_host_queue = false;
 		dg_info->entry = dst_entry;
-		memcpy(&dg_info->msg, dg, VMCI_DG_SIZE(dg));
+		dg_info->msg = *dg;
+		memcpy(&dg_info->msg_payload, dg + 1, dg->payload_size);
 
 		INIT_WORK(&dg_info->work, dg_delayed_dispatch);
 		schedule_work(&dg_info->work);



