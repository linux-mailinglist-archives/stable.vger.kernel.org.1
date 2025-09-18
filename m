Return-Path: <stable+bounces-168219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA1DB233F5
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC10167B6F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429682FAC02;
	Tue, 12 Aug 2025 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JlDRrbgq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005DF191F98;
	Tue, 12 Aug 2025 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023447; cv=none; b=r2JtI5aeWbtC0Bsc1ktMLN2eZjanQ+4q+IOaHKjaaBeho1+uubPfCPvTqv4Ior+4KvUYsyhYcWKlETzLYfA8cVbCWfeb0PpgGjNp0OTHPBpn4jE419doUEwW9f1M0ZAIoccRUw718oVw1z/vpQVyOtFsUd8Leb7Q0M3rvdSYE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023447; c=relaxed/simple;
	bh=rOMWmXaaAamSudSDvDxibfkfvlzIc87cbQAwW3PoAFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9zAYCsl87sC7mTqt4Ac0ztNm6PqLscKIS+2Fzs3OT2v0KA4AZjbBPQIPMqMEMXNXe8bBAXAo/khBrXbnaXVXZEuaA5tGTVs4ZLbn2xs3QQxk8z0tuGZ+4BhQw8SlwzX1SaHJEm3eMvKVKh3Nihz2+MrTneUI8h4CgDcKYgBUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JlDRrbgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BA6C4CEF0;
	Tue, 12 Aug 2025 18:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023446;
	bh=rOMWmXaaAamSudSDvDxibfkfvlzIc87cbQAwW3PoAFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JlDRrbgqbWNdkJo3jEX0w6q1ki5VT9YtXAwD9WcfcimsV8EEHc2B3rUgzrnqImWtt
	 Niiq+NH07eVK8ubo47OBjoDGlXvm5Z6IPZxIDxH7urSVLIoVgBMlQD9vEaHsa6ojBE
	 /lF5I+EUX2Ly6oElrQveLSoNvkPgQUWQTgHUaYmM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+9b9124ae9b12d5af5d95@syzkaller.appspotmail.com,
	Lizhi Xu <lizhi.xu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 082/627] vmci: Prevent the dispatching of uninitialized payloads
Date: Tue, 12 Aug 2025 19:26:17 +0200
Message-ID: <20250812173422.424686817@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lizhi Xu <lizhi.xu@windriver.com>

[ Upstream commit bfb4cf9fb97e4063f0aa62e9e398025fb6625031 ]

The reproducer executes the host's unlocked_ioctl call in two different
tasks. When init_context fails, the struct vmci_event_ctx is not fully
initialized when executing vmci_datagram_dispatch() to send events to all
vm contexts. This affects the datagram taken from the datagram queue of
its context by another task, because the datagram payload is not initialized
according to the size payload_size, which causes the kernel data to leak
to the user space.

Before dispatching the datagram, and before setting the payload content,
explicitly set the payload content to 0 to avoid data leakage caused by
incomplete payload initialization.

Fixes: 28d6692cd8fb ("VMCI: context implementation.")
Reported-by: syzbot+9b9124ae9b12d5af5d95@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9b9124ae9b12d5af5d95
Tested-by: syzbot+9b9124ae9b12d5af5d95@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Link: https://lore.kernel.org/r/20250627055214.2967129-1-lizhi.xu@windriver.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/vmw_vmci/vmci_context.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
index f22b44827e92..d566103caa27 100644
--- a/drivers/misc/vmw_vmci/vmci_context.c
+++ b/drivers/misc/vmw_vmci/vmci_context.c
@@ -251,6 +251,8 @@ static int ctx_fire_notification(u32 context_id, u32 priv_flags)
 		ev.msg.hdr.src = vmci_make_handle(VMCI_HYPERVISOR_CONTEXT_ID,
 						  VMCI_CONTEXT_RESOURCE_ID);
 		ev.msg.hdr.payload_size = sizeof(ev) - sizeof(ev.msg.hdr);
+		memset((char*)&ev.msg.hdr + sizeof(ev.msg.hdr), 0,
+			ev.msg.hdr.payload_size);
 		ev.msg.event_data.event = VMCI_EVENT_CTX_REMOVED;
 		ev.payload.context_id = context_id;
 
-- 
2.39.5




