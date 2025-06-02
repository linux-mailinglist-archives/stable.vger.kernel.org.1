Return-Path: <stable+bounces-150001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED59FACB506
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 270457B458A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD832222DA;
	Mon,  2 Jun 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iiPPI5X/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E91EA65;
	Mon,  2 Jun 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875719; cv=none; b=VEm/mhV46NQzURiWGhhgnOY64qWFN5sCojhzREDMe8/GBWyBaHAu8wOqfWps2wHaS6zTufr+9MHNP99I4dUUe6ZqI+pNhdkNyOTyVKAwEiHXVDjuLgvsnBmTAqcaDRQWzluO47IIY20gbkuLqP6lu5O+2BKxh58wW5W0VyBOalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875719; c=relaxed/simple;
	bh=v+wxQsAE08UjMMlFuKFPqTvMg5VcINGuqD1VsDO202g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkiY3JvaMRULE7eq+L+i2gRVKom7IXdnBA6k+GznDoXkgED0G8hEongss23LYhGeoBo1ukk2rN4Xy3PMCPTGP6jI1dp4HbUvFu5SUaGG5IOED9YtKfv9yqYOIyDGl8HzU7EJ2Wi/efTNkEzL5FUs193bk0slMZtBauW7yHZZ4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iiPPI5X/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74335C4CEEB;
	Mon,  2 Jun 2025 14:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875719;
	bh=v+wxQsAE08UjMMlFuKFPqTvMg5VcINGuqD1VsDO202g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iiPPI5X/zBD+PspFTKzY5qNxTlc5Bh68d6V1djgxi+HSgyEgNTf6bAbvOyCiuYJQ7
	 YbrfT/kcdELacLzPsUef7N696nP3ON/SVTH2aJGsGLkO6fYrFxB+3+3yYoJnWgR5WY
	 dtlgYbtf7qwzvjEJWwb4x5zxMi0KPxzDSElefARo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viktor Malik <vmalik@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 221/270] bpftool: Fix readlink usage in get_fd_type
Date: Mon,  2 Jun 2025 15:48:26 +0200
Message-ID: <20250602134316.215123156@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viktor Malik <vmalik@redhat.com>

[ Upstream commit 0053f7d39d491b6138d7c526876d13885cbb65f1 ]

The `readlink(path, buf, sizeof(buf))` call reads at most sizeof(buf)
bytes and *does not* append null-terminator to buf. With respect to
that, fix two pieces in get_fd_type:

1. Change the truncation check to contain sizeof(buf) rather than
   sizeof(path).
2. Append null-terminator to buf.

Reported by Coverity.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/bpf/20250129071857.75182-1-vmalik@redhat.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index eefa2b34e641a..33065b17900fa 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -311,10 +311,11 @@ int get_fd_type(int fd)
 		p_err("can't read link type: %s", strerror(errno));
 		return -1;
 	}
-	if (n == sizeof(path)) {
+	if (n == sizeof(buf)) {
 		p_err("can't read link type: path too long!");
 		return -1;
 	}
+	buf[n] = '\0';
 
 	if (strstr(buf, "bpf-map"))
 		return BPF_OBJ_MAP;
-- 
2.39.5




