Return-Path: <stable+bounces-111062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01322A21403
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 23:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E1E3A815D
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 22:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ECD19ADA2;
	Tue, 28 Jan 2025 22:15:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4A192D76;
	Tue, 28 Jan 2025 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102550; cv=none; b=L+atMqGf0gXrYzPZ7MjePjHUipoPdDRoKaD3/E8or0GjZT8oZz5TnrmrXygk5qbswc72Z13cAeRpIPfBK01gHtl1goAaD26mcl/FtVeKHByiBU1V6DNqIAMLiaIIcGVybdSMzaW3WqrWs4i9PbbjjC8BLy3Lh+ALIGIwxTdx2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102550; c=relaxed/simple;
	bh=QZtstUTeu3/QKVPQw5YJYEj+nE65D4XGIfJBf1mcaQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aoIF82H8CzmwzhgrgedUedCifVXSBLn8EWwTQRYuOhbcXOesybvUPtgx4AffyqrZQ5Sb0M9sEdNwxR++Xy5IQH3NLvzLZy9q/cnpeQPYDlvKXoIoyQgfTYXpTW9jLyrcqIVsfZO1pORWNI9gzVurQzge93LoytEzpwT6c/EPNgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 32AF923339;
	Wed, 29 Jan 2025 01:15:37 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH v3 5.10 0/2] net: Backport to fix CVE-2024-56658
Date: Wed, 29 Jan 2025 01:15:20 +0300
Message-Id: <20250128221522.21706-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link: https://www.cve.org/CVERecord/?id=CVE-2024-56658

5.15: https://lore.kernel.org/all/20250115091642.335047-1-kovalev@altlinux.org/

---
v1: https://lore.kernel.org/all/20250115091913.335173-1-kovalev@altlinux.org/

v2: https://lore.kernel.org/all/20250121192730.155559-1-kovalev@altlinux.org/

v3:  (Suggested-by [1]: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>)
Added a backport of commit
41467d2ff4df ("net: net_namespace: Optimize the code")
as a prerequisite for
0f6ede9fbc74 ("net: defer final 'struct net' free in netns dismantle").

[1] https://lore.kernel.org/all/20250127134248.25731-1-abuehaze@amazon.com/

[PATCH v3 5.10 1/2] net: net_namespace: Optimize the code
[PATCH v3 5.10 2/2] net: defer final 'struct net' free in netns dismantle


