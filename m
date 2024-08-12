Return-Path: <stable+bounces-67051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8A094F3AD
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D7C1F20F9D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E55186E20;
	Mon, 12 Aug 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2C4RYFQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257EC183CA6;
	Mon, 12 Aug 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479641; cv=none; b=NI+qai8oG/UFMtLVD5AqkNZrjg2FhrrvyKrjIeDLOCxHZ1BcPRkEtif3jsW06N7xvn/O9DlqVbyAQaADrBQ4NlrgRNBUlV+EQ0iAXoIJ9/Sjp/vd+zHuhFOhz8dgk0/Q7fqtazga8R8snaOKp7ZsPfeTRA4z8F6y/aB70pXQGH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479641; c=relaxed/simple;
	bh=2GEwOOA5u7LphoxHGhtOsNcB7ZvtfRfNgd0zvrkiYyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqyL6LM2caZu4+MzZDNVke4hqHGdh8KKib1kOpvHGo63aNdHEjFb29pz9lHcV7JMzRetoMREBkMwo9NuqSn3lEHh2ZbyEZQf4a3+g5eLRb5fIucD9b1NZyHHnvPUllRiPoBPWBXgehNYTA+JTSP7t3iGxVjfWfL0y+1SibdL/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2C4RYFQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827AAC32782;
	Mon, 12 Aug 2024 16:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479641;
	bh=2GEwOOA5u7LphoxHGhtOsNcB7ZvtfRfNgd0zvrkiYyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2C4RYFQLjrsZQ9DtVLLcFr6Rgklk/1wfLyAdOHeZ7vu5idNGBm9H3VCjYxqUpu4sE
	 oPpspNyHujwlfqb9ZaXAwrsBVV55UFobsMO96I+hGc+4mvj8F0jR7z9H/TQgCQlOcV
	 iTxNvntptY97k/uol2p1MEZ+x2i5YDKhF/IOMM/U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Cheng-Jui Wang <cheng-jui.wang@mediatek.com>,
	Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6 148/189] tracing: Fix overflow in get_free_elt()
Date: Mon, 12 Aug 2024 18:03:24 +0200
Message-ID: <20240812160137.839734351@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
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

From: Tze-nan Wu <Tze-nan.Wu@mediatek.com>

commit bcf86c01ca4676316557dd482c8416ece8c2e143 upstream.

"tracing_map->next_elt" in get_free_elt() is at risk of overflowing.

Once it overflows, new elements can still be inserted into the tracing_map
even though the maximum number of elements (`max_elts`) has been reached.
Continuing to insert elements after the overflow could result in the
tracing_map containing "tracing_map->max_size" elements, leaving no empty
entries.
If any attempt is made to insert an element into a full tracing_map using
`__tracing_map_insert()`, it will cause an infinite loop with preemption
disabled, leading to a CPU hang problem.

Fix this by preventing any further increments to "tracing_map->next_elt"
once it reaches "tracing_map->max_elt".

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 08d43a5fa063e ("tracing: Add lock-free tracing_map")
Co-developed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
Link: https://lore.kernel.org/20240805055922.6277-1-Tze-nan.Wu@mediatek.com
Signed-off-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/tracing_map.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -454,7 +454,7 @@ static struct tracing_map_elt *get_free_
 	struct tracing_map_elt *elt = NULL;
 	int idx;
 
-	idx = atomic_inc_return(&map->next_elt);
+	idx = atomic_fetch_add_unless(&map->next_elt, 1, map->max_elts);
 	if (idx < map->max_elts) {
 		elt = *(TRACING_MAP_ELT(map->elts, idx));
 		if (map->ops && map->ops->elt_init)
@@ -699,7 +699,7 @@ void tracing_map_clear(struct tracing_ma
 {
 	unsigned int i;
 
-	atomic_set(&map->next_elt, -1);
+	atomic_set(&map->next_elt, 0);
 	atomic64_set(&map->hits, 0);
 	atomic64_set(&map->drops, 0);
 
@@ -783,7 +783,7 @@ struct tracing_map *tracing_map_create(u
 
 	map->map_bits = map_bits;
 	map->max_elts = (1 << map_bits);
-	atomic_set(&map->next_elt, -1);
+	atomic_set(&map->next_elt, 0);
 
 	map->map_size = (1 << (map_bits + 1));
 	map->ops = ops;



