Return-Path: <stable+bounces-69295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D594B95444E
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 10:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7CF282191
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 08:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E871384B9;
	Fri, 16 Aug 2024 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="cbaEAE8L"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A06A8405D;
	Fri, 16 Aug 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796713; cv=none; b=aOCkUABhaz8xjBt+p6VMyWres3+dPlBB6Pd0G5Pk8fiUJhcYDNWEiY7RjDlgO1nNRHWS3mQfqfJAGgctl92RioS7qv4Ss/YH/rsB9htno46yY6QpleC3F7tY0zgDtELkVUs42l78pk7XMFDgL1E5ZiGhw3xKjgVMrOvA9ygIM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796713; c=relaxed/simple;
	bh=QcOFQgHkGxfByn5sxPygi7GLac0v6oLJGGGQJeE24jU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oGWRO6OovWBHpxrMZG0j0X4sWvTLf1IeWIpJ7iOhlnpfP/iQ4Uqqz3Lw3YHbjAHno8xQG9zuSfT6TdxflNCnN3tCatD6KLRXC5L6WHfJbaVlRgvtroeDQF7OlxTP04TIHj8HqsUSfjb6feZoQRyhra89gbsLDu3wI11b6AUYO4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=cbaEAE8L; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1c0f:0:640:cad:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id AD923608DB;
	Fri, 16 Aug 2024 11:23:16 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:8907::1:38])
	by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id ANEodI0gviE0-QXKYLn4O;
	Fri, 16 Aug 2024 11:23:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1723796595;
	bh=+gTuOQWW7OgvnEVkFJ0NET1PkguB+sAW0J4GCxO15PM=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=cbaEAE8L9fv61infRYf4rHN1CzyjiHeAueGQUVVssVUejiQEEzu7sQ1cCaIFAotC2
	 ZW6BczbCN3WhYkwz0wz5KOBm8wOsi5ZzEdQEJGv4epiEHu7+ed+rxoR7FhwbaOcpB7
	 0jxliAZCvQBRrshOQYIUlkUf/J9BCvjH6CnVTQ20=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Kumar Sanghvi <kumaras@chelsio.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
	Ganesh Goudar <ganeshgr@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH] cxgb4: add forgotten u64 ivlan cast before shift
Date: Fri, 16 Aug 2024 11:22:39 +0300
Message-Id: <20240816082239.4188902-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is done everywhere in cxgb4 code, e.g. in is_filter_exact_match()
There is no reason it should not be done here

Found by Linux Verification Center (linuxtesting.org) with SVACE

Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: stable@vger.kernel.org
Fixes: 12b276fbf6e0 ("cxgb4: add support to create hash filters")
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
index 786ceae34488..e417ff0ea06c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -1244,7 +1244,7 @@ static u64 hash_filter_ntuple(struct ch_filter_specification *fs,
 	 * in the Compressed Filter Tuple.
 	 */
 	if (tp->vlan_shift >= 0 && fs->mask.ivlan)
-		ntuple |= (FT_VLAN_VLD_F | fs->val.ivlan) << tp->vlan_shift;
+		ntuple |= (u64)(FT_VLAN_VLD_F | fs->val.ivlan) << tp->vlan_shift;
 
 	if (tp->port_shift >= 0 && fs->mask.iport)
 		ntuple |= (u64)fs->val.iport << tp->port_shift;
-- 
2.34.1


