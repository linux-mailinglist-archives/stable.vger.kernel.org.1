Return-Path: <stable+bounces-187420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01665BEA449
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3990E509596
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B41330B37;
	Fri, 17 Oct 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Fv0g3RU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EA0330B1D;
	Fri, 17 Oct 2025 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716019; cv=none; b=hpWb9VXBVxlrCtG9vlaS7Kklksv1AQ+oFgIjo5SNWZTvKUQ9CSduW6ATQLfdNXkKKlJUqMWlirOjsLB8CE/ywWMuadiGr7mfGj3HAyA29F6DQcAZ/WuZ1N9ch8fiG0qwByltxrJ6o/RO/gzcd9R0KihB03v76535aSGBJCejbHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716019; c=relaxed/simple;
	bh=gVceDJd0LdQqySc2h+wG8zjAVq7mPJ4UCV7srASYUlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qStApr5Om3gd1vqrEC3b2mFcuLopGFmBAHmDnduKOIic/gsuilgXRfa1MMPHLaoX8+cgNg0r10rmbwa1lnRAU6kft1SRjLlFsIZVahf/RG/ksBoRNlMF9kwI2OxTI9b1ymKG4vCWleej/T31VkFaaC8c92fp6N7Gm52gNZXCfn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Fv0g3RU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63831C4CEE7;
	Fri, 17 Oct 2025 15:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716019;
	bh=gVceDJd0LdQqySc2h+wG8zjAVq7mPJ4UCV7srASYUlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2Fv0g3RUU5ERrZkg7IAgDFzhj7UZJQSMv5rABqfTJ7YarT6zBkLEPb08osK0i/O3X
	 KocqVjdDFly2qogFXoxccLzAvZaHBNhUV5gzMnI0wxUmG0kcoCAPdc2Uh3vFtGGBAx
	 C5gKPTt82ZWjO1+yLQDroUTk1U73g+3vb/386uoM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+136ca59d411f92e821b7@syzkaller.appspotmail.com,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 046/276] bpf: Explicitly check accesses to bpf_sock_addr
Date: Fri, 17 Oct 2025 16:52:19 +0200
Message-ID: <20251017145144.085159040@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Chaignon <paul.chaignon@gmail.com>

[ Upstream commit 6fabca2fc94d33cdf7ec102058983b086293395f ]

Syzkaller found a kernel warning on the following sock_addr program:

    0: r0 = 0
    1: r2 = *(u32 *)(r1 +60)
    2: exit

which triggers:

    verifier bug: error during ctx access conversion (0)

This is happening because offset 60 in bpf_sock_addr corresponds to an
implicit padding of 4 bytes, right after msg_src_ip4. Access to this
padding isn't rejected in sock_addr_is_valid_access and it thus later
fails to convert the access.

This patch fixes it by explicitly checking the various fields of
bpf_sock_addr in sock_addr_is_valid_access.

I checked the other ctx structures and is_valid_access functions and
didn't find any other similar cases. Other cases of (properly handled)
padding are covered in new tests in a subsequent patch.

Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
Reported-by: syzbot+136ca59d411f92e821b7@syzkaller.appspotmail.com
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Closes: https://syzkaller.appspot.com/bug?extid=136ca59d411f92e821b7
Link: https://lore.kernel.org/bpf/b58609d9490649e76e584b0361da0abd3c2c1779.1758094761.git.paul.chaignon@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index f346f19cf468c..b95af925b9c27 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8595,13 +8595,17 @@ static bool sock_addr_is_valid_access(int off, int size,
 			return false;
 		info->reg_type = PTR_TO_SOCKET;
 		break;
-	default:
-		if (type == BPF_READ) {
-			if (size != size_default)
-				return false;
-		} else {
+	case bpf_ctx_range(struct bpf_sock_addr, user_family):
+	case bpf_ctx_range(struct bpf_sock_addr, family):
+	case bpf_ctx_range(struct bpf_sock_addr, type):
+	case bpf_ctx_range(struct bpf_sock_addr, protocol):
+		if (type != BPF_READ)
 			return false;
-		}
+		if (size != size_default)
+			return false;
+		break;
+	default:
+		return false;
 	}
 
 	return true;
-- 
2.51.0




