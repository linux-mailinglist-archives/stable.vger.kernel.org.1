Return-Path: <stable+bounces-77794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A34E9875F9
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 16:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DC428B2C6
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F19B14D703;
	Thu, 26 Sep 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="gRjbrUWG"
X-Original-To: stable@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAF11553AA;
	Thu, 26 Sep 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362239; cv=none; b=SBNewBSzTV90LXHHHYoaThhBQGp9H8rIJP810PHqKZE8gqon+dZWe4Et0t33e9uIpzLcLKxSvu2Y5G8wv9C7j/esPoiGWaHgpQuVsWu1knVwjjhJYgUpwyDae6b9n07tN0gClI8KzR+vcnFWiUSbwM0MJaH6XZSszibpVAbCWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362239; c=relaxed/simple;
	bh=qhpM/0HcfOuJCelTNvv7GMVa0xIJX8RdHPtxmvGJJ7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsG3PEX0KkJj+yd36UKEL9aDM17V0RHWilJRfL2ETrjf91rJnNSh/k0bbBFjavPTsswstsvoxQRAhyV0VrStINbcmxzEDmLVlJ4A0QQNqgVNxoNLS3HxgWVFZ9U9OKWoyhAI8Nna7VLxXO8TkpkE0LKzIUEFlKz2++rDjHJbI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=gRjbrUWG; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 30F6FEDABFC10;
	Thu, 26 Sep 2024 17:50:26 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id bxDXcRfi0DwX; Thu, 26 Sep 2024 17:50:26 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 03F85EE677C6F;
	Thu, 26 Sep 2024 17:50:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 03F85EE677C6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1727362226;
	bh=FzNUZhWdCS1OUORwDMta3qKIHBA0BUIs+eqtK3/W8Xs=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=gRjbrUWGzY9Q6tpu2NfosOPMKj2+ALxbmQbCB4TXhE2H017iRopIuyNl7FaiNSxK+
	 GapLnSdzkx/rcIMN33SveA6EWa69ug1WtL5xvVFLaMcsurC5irFb+gzy/YuRx7pyLF
	 Mk1swH7Q2ShvQXATL0hW5je6d43Dst6KCQCkC1mF0NI4c0qekiqTwn9AQMaKX6heg8
	 8IsArnAkiT8EoNolL6xIrFbaQ7eBeeVc2UwaeniIglo3HRhoIznIHqMTx0dcwL7Rop
	 GhuRDnoSb6y0YNevWE4+gWDdqeOnertayVFMBz/doCRVQwLI2sBjlPKvOxpcKyfBxd
	 JHe14P8oO66aQ==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id G6lWgT3BvZNz; Thu, 26 Sep 2024 17:50:25 +0300 (MSK)
Received: from localhost.localdomain (unknown [89.169.48.235])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 8D5CDEDABFC10;
	Thu, 26 Sep 2024 17:50:25 +0300 (MSK)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Anastasia Belova <abelova@astralinux.ru>
Subject: [PATCH 6.1] mm/memory_hotplug: prevent accessing by index=-1
Date: Thu, 26 Sep 2024 10:49:21 -0400
Message-ID: <20240926144924.53444-1-m.lobanov@rosalinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Anastasia Belova <abelova@astralinux.ru>

commit 5958d35917e1296f46dfc8b8c959732efd6d8d5d upstream.

nid may be equal to NUMA_NO_NODE=3D-1.  Prevent accessing node_data array=
 by
invalid index with check for nid.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e83a437faa62 ("mm/memory_hotplug: introduce "auto-movable" online =
policy")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
 mm/memory_hotplug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index dc17618bad8b..90f0cc9a298a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -783,7 +783,6 @@ static bool auto_movable_can_online_movable(int nid, =
struct memory_group *group,
 	unsigned long kernel_early_pages, movable_pages;
 	struct auto_movable_group_stats group_stats =3D {};
 	struct auto_movable_stats stats =3D {};
-	pg_data_t *pgdat =3D NODE_DATA(nid);
 	struct zone *zone;
 	int i;
=20
@@ -794,6 +793,8 @@ static bool auto_movable_can_online_movable(int nid, =
struct memory_group *group,
 			auto_movable_stats_account_zone(&stats, zone);
 	} else {
 		for (i =3D 0; i < MAX_NR_ZONES; i++) {
+			pg_data_t *pgdat =3D NODE_DATA(nid);
+
 			zone =3D pgdat->node_zones + i;
 			if (populated_zone(zone))
 				auto_movable_stats_account_zone(&stats, zone);
--=20
2.43.0


