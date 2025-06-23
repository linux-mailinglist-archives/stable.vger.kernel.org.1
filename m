Return-Path: <stable+bounces-157679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54526AE5512
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DBB4C3046
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23579221FD6;
	Mon, 23 Jun 2025 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zMc2Nvyl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21123597E;
	Mon, 23 Jun 2025 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716458; cv=none; b=HOLw+j3DTnOfapB3j3EJfza0cj7/k7guHy+HV/YB5ID7QH/pTbBfB5wFFvhW5rmIlhOy5ANZiLDtKb9jrtjwu3JuZCsvvvn8Pj3DZc5xBbrBghTWo8/HT8jxIDDBO623haPMYqQZJhLUUYW+QAH6/fo7F0OTBTth5ja/cs51lQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716458; c=relaxed/simple;
	bh=P0UKYy1OvxLb8/zMsoUUjeJktRa/BGfgebAHpVAGLx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7Pvs5+DSSX4yUMH1vkzAf/jQcvh+v+mldNRv4a+tU75TRK9L+23GSSvPfyBl8MEq+Ls6wZkZNdD+QX7qlpnelvKtOY4tqWb3bYREpVurq6eif5vFhmgDrGg1BXvSnwKBna1EzDcsibOEhr0WxX9eHxBVDcela8+bl+Ef+0JhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zMc2Nvyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D5CC4CEEA;
	Mon, 23 Jun 2025 22:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716458;
	bh=P0UKYy1OvxLb8/zMsoUUjeJktRa/BGfgebAHpVAGLx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zMc2Nvyl1BwkL8D3vQ6TP8A1k2J6SInBKjQ9SqEIKF8hI5eyd0ybnnHKvnXq1B8Nf
	 Ia/CNlnJy/MAkm5LzXTh1l0hdfFzzx/4Ch4jMdyyJrCvuFpEzTDcttb/JALxRqQ04c
	 erHFs8Lzz7u8y3bXPqbeUbrAUGMnWD0HR1pnnEhM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 252/414] bpf: Use proper type to calculate bpf_raw_tp_null_args.mask index
Date: Mon, 23 Jun 2025 15:06:29 +0200
Message-ID: <20250623130648.345660390@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shung-Hsi Yu <shung-hsi.yu@suse.com>

[ Upstream commit 53ebef53a657d7957d35dc2b953db64f1bb28065 ]

The calculation of the index used to access the mask field in 'struct
bpf_raw_tp_null_args' is done with 'int' type, which could overflow when
the tracepoint being attached has more than 8 arguments.

While none of the tracepoints mentioned in raw_tp_null_args[] currently
have more than 8 arguments, there do exist tracepoints that had more
than 8 arguments (e.g. iocost_iocg_forgive_debt), so use the correct
type for calculation and avoid Smatch static checker warning.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/bpf/20250418074946.35569-1-shung-hsi.yu@suse.com

Closes: https://lore.kernel.org/r/843a3b94-d53d-42db-93d4-be10a4090146@stanley.mountain/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2c54c148a94f3..f83bd019db141 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6684,10 +6684,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			/* Is this a func with potential NULL args? */
 			if (strcmp(tname, raw_tp_null_args[i].func))
 				continue;
-			if (raw_tp_null_args[i].mask & (0x1 << (arg * 4)))
+			if (raw_tp_null_args[i].mask & (0x1ULL << (arg * 4)))
 				info->reg_type |= PTR_MAYBE_NULL;
 			/* Is the current arg IS_ERR? */
-			if (raw_tp_null_args[i].mask & (0x2 << (arg * 4)))
+			if (raw_tp_null_args[i].mask & (0x2ULL << (arg * 4)))
 				ptr_err_raw_tp = true;
 			break;
 		}
-- 
2.39.5




