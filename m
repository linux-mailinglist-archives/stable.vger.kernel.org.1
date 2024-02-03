Return-Path: <stable+bounces-18423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AC58482AA
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9A0283074
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FF61BDD3;
	Sat,  3 Feb 2024 04:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F/93x2qK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADF11739;
	Sat,  3 Feb 2024 04:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933788; cv=none; b=J0PjEh990bsKZ2rqVx+gO+2PFAiQdZBuRnDw1FtTwhU/74ql8Qgv76NG03baXhSUEY+bYg5tlLBp8sAbDh6DDv/cfgsLKv60SDSHWjj3GA8gtgsR+KH8iQixxkx33rlaD8tZzrxjDutpcsEds08BQvuUaxueOiv5N1TGafh+amc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933788; c=relaxed/simple;
	bh=/QGYdGwd5eXHJvJp6RdME+w+9sELtvaznN3YiI39tuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTmAgzoDvFuoSbAAA5FM5Db92YQqQylM8WsMtlVBkZyLDG7QFJYLSvM8bEZtST8/SsppAYiqtDVdL2iuCFIUegZKNyU4pTRwm8adKR2p55hqmBVodVXgnNTedHKeaAsQAX/WJ/VUTWPLixy5TtSGp+xGJhkb1HdcUM+Uxx6L/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F/93x2qK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B7FC433C7;
	Sat,  3 Feb 2024 04:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933788;
	bh=/QGYdGwd5eXHJvJp6RdME+w+9sELtvaznN3YiI39tuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/93x2qKmgURdPkKpiUtE5BdbK/fMxNqB1rPpJr/hvHi/Hh1FmRNzSVPjeMdB8+gb
	 xSDZoYPQVjcmdxpWCx45HDm6EdHf0N+AjF8284zeoW41s0cgaeKd6pa1pKMocuKwpZ
	 8XoVA34U915xHlxZFLyVxvBu38pDUYDd3uo3eL9M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 096/353] bpf: Set need_defer as false when clearing fd array during map free
Date: Fri,  2 Feb 2024 20:03:34 -0800
Message-ID: <20240203035406.833801540@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 79d93b3c6ffd79abcd8e43345980aa1e904879c4 ]

Both map deletion operation, map release and map free operation use
fd_array_map_delete_elem() to remove the element from fd array and
need_defer is always true in fd_array_map_delete_elem(). For the map
deletion operation and map release operation, need_defer=true is
necessary, because the bpf program, which accesses the element in fd
array, may still alive. However for map free operation, it is certain
that the bpf program which owns the fd array has already been exited, so
setting need_defer as false is appropriate for map free operation.

So fix it by adding need_defer parameter to bpf_fd_array_map_clear() and
adding a new helper __fd_array_map_delete_elem() to handle the map
deletion, map release and map free operations correspondingly.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20231204140425.1480317-4-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/arraymap.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 9bfad7e96913..c9843dde6908 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -871,7 +871,7 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 	return 0;
 }
 
-static long fd_array_map_delete_elem(struct bpf_map *map, void *key)
+static long __fd_array_map_delete_elem(struct bpf_map *map, void *key, bool need_defer)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	void *old_ptr;
@@ -890,13 +890,18 @@ static long fd_array_map_delete_elem(struct bpf_map *map, void *key)
 	}
 
 	if (old_ptr) {
-		map->ops->map_fd_put_ptr(map, old_ptr, true);
+		map->ops->map_fd_put_ptr(map, old_ptr, need_defer);
 		return 0;
 	} else {
 		return -ENOENT;
 	}
 }
 
+static long fd_array_map_delete_elem(struct bpf_map *map, void *key)
+{
+	return __fd_array_map_delete_elem(map, key, true);
+}
+
 static void *prog_fd_array_get_ptr(struct bpf_map *map,
 				   struct file *map_file, int fd)
 {
@@ -925,13 +930,13 @@ static u32 prog_fd_array_sys_lookup_elem(void *ptr)
 }
 
 /* decrement refcnt of all bpf_progs that are stored in this map */
-static void bpf_fd_array_map_clear(struct bpf_map *map)
+static void bpf_fd_array_map_clear(struct bpf_map *map, bool need_defer)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
 
 	for (i = 0; i < array->map.max_entries; i++)
-		fd_array_map_delete_elem(map, &i);
+		__fd_array_map_delete_elem(map, &i, need_defer);
 }
 
 static void prog_array_map_seq_show_elem(struct bpf_map *map, void *key,
@@ -1072,7 +1077,7 @@ static void prog_array_map_clear_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_array_aux,
 					   work)->map;
-	bpf_fd_array_map_clear(map);
+	bpf_fd_array_map_clear(map, true);
 	bpf_map_put(map);
 }
 
@@ -1222,7 +1227,7 @@ static void perf_event_fd_array_release(struct bpf_map *map,
 	for (i = 0; i < array->map.max_entries; i++) {
 		ee = READ_ONCE(array->ptrs[i]);
 		if (ee && ee->map_file == map_file)
-			fd_array_map_delete_elem(map, &i);
+			__fd_array_map_delete_elem(map, &i, true);
 	}
 	rcu_read_unlock();
 }
@@ -1230,7 +1235,7 @@ static void perf_event_fd_array_release(struct bpf_map *map,
 static void perf_event_fd_array_map_free(struct bpf_map *map)
 {
 	if (map->map_flags & BPF_F_PRESERVE_ELEMS)
-		bpf_fd_array_map_clear(map);
+		bpf_fd_array_map_clear(map, false);
 	fd_array_map_free(map);
 }
 
@@ -1266,7 +1271,7 @@ static void cgroup_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_de
 
 static void cgroup_fd_array_free(struct bpf_map *map)
 {
-	bpf_fd_array_map_clear(map);
+	bpf_fd_array_map_clear(map, false);
 	fd_array_map_free(map);
 }
 
@@ -1311,7 +1316,7 @@ static void array_of_map_free(struct bpf_map *map)
 	 * is protected by fdget/fdput.
 	 */
 	bpf_map_meta_free(map->inner_map_meta);
-	bpf_fd_array_map_clear(map);
+	bpf_fd_array_map_clear(map, false);
 	fd_array_map_free(map);
 }
 
-- 
2.43.0




