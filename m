Return-Path: <stable+bounces-73928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54346970927
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 20:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462361C210E3
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62CE16EB53;
	Sun,  8 Sep 2024 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="abkiG8fB"
X-Original-To: stable@vger.kernel.org
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67D535D8
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725818641; cv=none; b=D6pbMaZbegQy8QQncOeU0JnnqxsH4cu0P6OrZowkkuTowuZCFM6zvILFYIBFT9YgOWBCqzq31pmyDp5PbUr593i14YjFzjOXyxhstd/rAiG34yr5q4a9iZoph1TkwrdWMqEJfs21UsYo2haSjHHzMbw775znR4Sun0UWBLPbEiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725818641; c=relaxed/simple;
	bh=nZN8scjb8KyukYtoO9Az1meJv0lebPBpAsN+5P83mRc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyjwD+rNB2aLbs/uwYkUO/S9jRod8itYOjZicpGT0S2O20panvwmtLe3LLiHBWxqS5Gx1mCMPrUZAY4j3Ck+zqJmAwHmVtgCYCr/QWd+Su3hNHiOxi6uVHPI+juUj0G60ptCLKcCbmHU2lmewUOOTisRs3Mg88i5P2YwQmjV5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=abkiG8fB; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail2; t=1725818630; x=1726077830;
	bh=6pQjEJgxcCXQnfSSKttWuknSYhxuYvInnzchhzPrTcs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=abkiG8fBW1aYyY3rHc+N4PqNteJjac8jA+Jvz6yzGfxJubpQ9Nvj4N5wRu+59ep2R
	 J/+1bZPi79CbCOh+lNdH+CcGGtsEiahZHlyJID43KW3R62Rv/rC+E1LE3q9oLIleG0
	 5ZQ7HXwQOaFr/BL9DHFZnbDuTL0Rzn+9+5lisVfw87/fqDaG+AmcVDTzCEbgaCWj17
	 LqY4DUT3zIGamXv5BEca+mqOWzhDtLp/pyLanW10C9+ww51PQQ+K0vYe3DSVRVY1gO
	 sxUilox9Wo3NQqxuYBUhLo+I6/E8v/7q/yQU3Dj/wpsuTeg8jcO06rGsKKuguMsgmd
	 rlgLqk5NkO/ZQ==
Date: Sun, 08 Sep 2024 18:03:47 +0000
To: stable@vger.kernel.org
From: Mike Yuan <me@yhndnzj.com>
Cc: Mike Yuan <me@yhndnzj.com>, Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH 6.10.y] mm/memcontrol: respect zswap.writeback setting from parent cg too
Message-ID: <20240908180219.31396-1-me@yhndnzj.com>
In-Reply-To: <2024090839-crimp-posted-6a31@gregkh>
References: <2024090839-crimp-posted-6a31@gregkh>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 9f561bb16a5e24d1080628faf22f09713aa04769
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

commit e399257349098bf7c84343f99efb2bc9c22eb9fd upstream

Currently, the behavior of zswap.writeback wrt. the cgroup hierarchy
seems a bit odd. Unlike zswap.max, it doesn't honor the value from
parent cgroups. This surfaced when people tried to globally disable zswap
writeback, i.e. reserve physical swap space only for hibernation [1] -
disabling zswap.writeback only for the root cgroup results in subcgroups
with zswap.writeback=3D1 still performing writeback.

The inconsistency became more noticeable after I introduced
the MemoryZSwapWriteback=3D systemd unit setting [2] for controlling
the knob. The patch assumed that the kernel would enforce the value of
parent cgroups. It could probably be workarounded from systemd's side,
by going up the slice unit tree and inheriting the value. Yet I think it's
more sensible to make it behave consistently with zswap.max and friends.

[1] https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate=
#Disable_zswap_writeback_to_use_the_swap_space_only_for_hibernation
[2] https://github.com/systemd/systemd/pull/31734

Link: https://lkml.kernel.org/r/20240823162506.12117-1-me@yhndnzj.com
Fixes: 501a06fe8e4c ("zswap: memcontrol: implement zswap writeback disablin=
g")
Signed-off-by: Mike Yuan <me@yhndnzj.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  7 ++++---
 mm/memcontrol.c                         | 12 +++++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 8fbb0519d556..bf288421e7d9 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1706,9 +1706,10 @@ PAGE_SIZE multiple when read back.
 =09entries fault back in or are written out to disk.
=20
   memory.zswap.writeback
-=09A read-write single value file. The default value is "1". The
-=09initial value of the root cgroup is 1, and when a new cgroup is
-=09created, it inherits the current value of its parent.
+=09A read-write single value file. The default value is "1".
+=09Note that this setting is hierarchical, i.e. the writeback would be
+=09implicitly disabled for child cgroups if the upper hierarchy
+=09does so.
=20
 =09When this is set to 0, all swapping attempts to swapping devices
 =09are disabled. This included both zswap writebacks, and swapping due
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 332f190bf3d6..82d60449e823 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5804,8 +5804,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *pare=
nt_css)
 =09WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 =09memcg->zswap_max =3D PAGE_COUNTER_MAX;
-=09WRITE_ONCE(memcg->zswap_writeback,
-=09=09!parent || READ_ONCE(parent->zswap_writeback));
+=09WRITE_ONCE(memcg->zswap_writeback, true);
 #endif
 =09page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 =09if (parent) {
@@ -8444,7 +8443,14 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *ob=
jcg, size_t size)
 bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 {
 =09/* if zswap is disabled, do not block pages going to the swapping devic=
e */
-=09return !is_zswap_enabled() || !memcg || READ_ONCE(memcg->zswap_writebac=
k);
+=09if (!is_zswap_enabled())
+=09=09return true;
+
+=09for (; memcg; memcg =3D parent_mem_cgroup(memcg))
+=09=09if (!READ_ONCE(memcg->zswap_writeback))
+=09=09=09return false;
+
+=09return true;
 }
=20
 static u64 zswap_current_read(struct cgroup_subsys_state *css,

base-commit: 5945e30dd429c9d63cbb646a06b99c2003d17941
--=20
2.46.0



