Return-Path: <stable+bounces-111954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5713FA24D0A
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 08:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A10C7A48E1
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 07:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A87C1E3DCC;
	Sun,  2 Feb 2025 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="lnW4E4jz"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12A01DDC1B
	for <stable@vger.kernel.org>; Sun,  2 Feb 2025 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482659; cv=none; b=cyTXyQ0hkLHrGHVl26IIZ9VnqE4bm7A4MAX4gcz+1DSywlNWknaCVP6Q3tt4r2rCb1Gx/hRTbpGGF3qjTkdHqcCxsJaI8PRimzUbFE+MSAwAfMmtEHQxgbxpvVtqMOneEXY0T1v0ot3BPXj9y9xr2zMNeVjhTCIZsnNHe2JqeQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482659; c=relaxed/simple;
	bh=kyQ9akgwVX8wxCsx2V+xoWQH+koRQPP7eyCpSK9HL0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsSGa3LPIXJJrymrFmhqm1ROTVcymh3ob+F3BHwR5deeZe7xX4gWIAfbbTypbkWn1Zbsyo1hQGdZ07ivnIK/Cj3vfOmXtjgy9MjLWv6z0jy8Z7V476O5GXT+eeNpFtRk0t+K0vwUs2IWw3j71cjm2PtteH08vR4KBzFzna7y0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=lnW4E4jz; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 717A11C2439
	for <stable@vger.kernel.org>; Sun,  2 Feb 2025 10:50:56 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:to:from:from; s=dkim; t=1738482656; x=1739346657; bh=ky
	Q9akgwVX8wxCsx2V+xoWQH+koRQPP7eyCpSK9HL0k=; b=lnW4E4jz0X7Q/iwaou
	t3J/3CMf7jOj5Gw48Loxfe9i6Uo/ZzL1l+wuvHYZ5l1Ww2gWDP6nbyA9uQi6yLOl
	T2fBW5fwkzSCuETOwiTmt1xyG4w87ZnTVVr4tBjA/JWGu2YBtBirlOYoEKkS0a/F
	pQ7XTPUp5NpqUUQH9IrzbIcIA=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hlt4yjTJ_iIQ for <stable@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:56 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 8D0761C19B7;
	Sun,  2 Feb 2025 10:50:25 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH 6.1 15/16] bpf: Remove unnecessary check when updating LPM trie
Date: Sun,  2 Feb 2025 07:46:52 +0000
Message-ID: <20250202074709.932174-16-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250202074709.932174-1-sdl@nppct.ru>
References: <20250202074709.932174-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

commit 156c977c539e87e173f505b23989d7b0ec0bc7d8 upstream.

When "node->prefixlen == matchlen" is true, it means that the node is
fully matched. If "node->prefixlen == key->prefixlen" is false, it means
the prefix length of key is greater than the prefix length of node,
otherwise, matchlen will not be equal with node->prefixlen. However, it
also implies that the prefix length of node must be less than
max_prefixlen.

Therefore, "node->prefixlen == trie->max_prefixlen" will always be false
when the check of "node->prefixlen == key->prefixlen" returns false.
Remove this unnecessary comparison.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20241206110622.1161752-2-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 kernel/bpf/lpm_trie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index fd6e31e72290..6c96241f49a4 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -358,8 +358,7 @@ static int trie_update_elem(struct bpf_map *map,
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
-		    node->prefixlen == key->prefixlen ||
-		    node->prefixlen == trie->max_prefixlen)
+		    node->prefixlen == key->prefixlen)
 			break;
 
 		next_bit = extract_bit(key->data, node->prefixlen);
-- 
2.43.0


