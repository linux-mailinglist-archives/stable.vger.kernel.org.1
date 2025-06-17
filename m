Return-Path: <stable+bounces-153899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386C7ADD728
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CCF3B51B3
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76292E8E0B;
	Tue, 17 Jun 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lrX00LLE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C7204F73;
	Tue, 17 Jun 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177457; cv=none; b=EOIOmNGh76fQ2+Zaqu2+EGZKLCrDIi/vkxTZIsuRuLgpH7deCNsGnNSS0YNONBw2a2qddhczfX30ipWyY0PvRhXgoi0qDZCKah6i5mJw0U9pqeZIp4IvfkvXeDI6nLaVuVggiHO/gMStEBG5pviv2Hv+/N2v1irjAM3jaNtnW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177457; c=relaxed/simple;
	bh=o0OhMUDSwa2YCiicJBtLofGdMrPLVWv9z1maglfK4PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2Uf3z0aZwemrWi/oKoSV+k9kvQpnZU8faGY2iz0FnF/rYtg19/TMLHOmWtPfxY5cgUymu70b/rWPMYJF4XvnpIm1lFfFVS5T8A4Nw4xnx0oZhXswaJkEnK9WfN46CWRbamSfAP1/ZxLHYi2739rRpOSsjiTAjzx7KeIGs6TmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lrX00LLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DAFC4CEE3;
	Tue, 17 Jun 2025 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750177457;
	bh=o0OhMUDSwa2YCiicJBtLofGdMrPLVWv9z1maglfK4PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrX00LLE0GSVmRKq7DJQ0zH1QLiKP1utvUljmOKsNtL9fK4SOIHwYFFHhPEVs2g0I
	 MK94KsyjoSbnKbb4pXD+XwXXhluZqYQ8P8d47icnhPZQ3mR0ArHXK/spBCQ62+KFvK
	 +yAml8j39SPPmDP/0D5LYiZPa+h5Qfi+GpaXaVv0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com,
	Charalampos Mitrodimas <charmitro@posteo.net>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 349/512] net: tipc: fix refcount warning in tipc_aead_encrypt
Date: Tue, 17 Jun 2025 17:25:15 +0200
Message-ID: <20250617152433.726327604@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

From: Charalampos Mitrodimas <charmitro@posteo.net>

[ Upstream commit f29ccaa07cf3d35990f4d25028cc55470d29372b ]

syzbot reported a refcount warning [1] caused by calling get_net() on
a network namespace that is being destroyed (refcount=0). This happens
when a TIPC discovery timer fires during network namespace cleanup.

The recently added get_net() call in commit e279024617134 ("net/tipc:
fix slab-use-after-free Read in tipc_aead_encrypt_done") attempts to
hold a reference to the network namespace. However, if the namespace
is already being destroyed, its refcount might be zero, leading to the
use-after-free warning.

Replace get_net() with maybe_get_net(), which safely checks if the
refcount is non-zero before incrementing it. If the namespace is being
destroyed, return -ENODEV early, after releasing the bearer reference.

[1]: https://lore.kernel.org/all/68342b55.a70a0220.253bc2.0091.GAE@google.com/T/#m12019cf9ae77e1954f666914640efa36d52704a2

Reported-by: syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68342b55.a70a0220.253bc2.0091.GAE@google.com/T/#m12019cf9ae77e1954f666914640efa36d52704a2
Fixes: e27902461713 ("net/tipc: fix slab-use-after-free Read in tipc_aead_encrypt_done")
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Link: https://patch.msgid.link/20250527-net-tipc-warning-v2-1-df3dc398a047@posteo.net
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/crypto.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 8584893b47851..79f91b6ca8c84 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -818,7 +818,11 @@ static int tipc_aead_encrypt(struct tipc_aead *aead, struct sk_buff *skb,
 	}
 
 	/* Get net to avoid freed tipc_crypto when delete namespace */
-	get_net(aead->crypto->net);
+	if (!maybe_get_net(aead->crypto->net)) {
+		tipc_bearer_put(b);
+		rc = -ENODEV;
+		goto exit;
+	}
 
 	/* Now, do encrypt */
 	rc = crypto_aead_encrypt(req);
-- 
2.39.5




