Return-Path: <stable+bounces-36058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EF689999F
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23AC81F22BAA
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8781015FA9F;
	Fri,  5 Apr 2024 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CpVFDr79"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0E15FA9C
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309880; cv=none; b=kD85MXqhwb4ul+Dk08Z+58KyUU1xK2p2wQCKR9PWGp6o+7YNa4GnOb8TS8v4S8S3YxuceRJSw9AfkfFTBNMPbT5QgcBbBnUBdvafUOe0ea5U7L98fCcJH1b2AjFOm9ls1/uVpxv9kQsxropUpDTJrcIdSxzMZcocJIMZNQG1ETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309880; c=relaxed/simple;
	bh=oJjrQu60tjng2sEGaDk/BR24cbVr+jn+bbiEUj5vvGU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uXcZu6ezGbacCvdpPyycMvU264Pdmkf1P76fk/IHM0skdrfx8eSyFgN28MO5FdJQT5f/5pa6362FKUIpqm3K6S88SFz0IgfBCIlPrqdDF9c6khaLO67aML+EIzvCSQ6rmCNJPt2HBQQbowJcY4PG/9rXLjPmlPjhwytCyyqZ6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CpVFDr79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70560C433F1;
	Fri,  5 Apr 2024 09:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712309879;
	bh=oJjrQu60tjng2sEGaDk/BR24cbVr+jn+bbiEUj5vvGU=;
	h=Subject:To:Cc:From:Date:From;
	b=CpVFDr79ESvvoZfHpFxxkFxEhpDGBmglfFKoqkHBEOk+YZPANsLrCVvdLKjcRLxzQ
	 bocZ99Geogg7iuQ3xFDOd4jKwMREFbOU+PwBa92wfkciMuTo1AjVztg0V3YwDsvdKC
	 qSATGjuQo/odpqW7Y5LUpEHjD9no1WHxwsJb8L0w=
Subject: FAILED: patch "[PATCH] netfilter: nf_tables: reject new basechain after table flag" failed to apply to 5.4-stable tree
To: pablo@netfilter.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 11:37:56 +0200
Message-ID: <2024040556-dexterity-handwrite-98fd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 994209ddf4f430946f6247616b2e33d179243769
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040556-dexterity-handwrite-98fd@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 994209ddf4f430946f6247616b2e33d179243769 Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Mon, 1 Apr 2024 00:33:02 +0200
Subject: [PATCH] netfilter: nf_tables: reject new basechain after table flag
 update

When dormant flag is toggled, hooks are disabled in the commit phase by
iterating over current chains in table (existing and new).

The following configuration allows for an inconsistent state:

  add table x
  add chain x y { type filter hook input priority 0; }
  add table x { flags dormant; }
  add chain x w { type filter hook input priority 1; }

which triggers the following warning when trying to unregister chain w
which is already unregistered.

[  127.322252] WARNING: CPU: 7 PID: 1211 at net/netfilter/core.c:50                                                                     1 __nf_unregister_net_hook+0x21a/0x260
[...]
[  127.322519] Call Trace:
[  127.322521]  <TASK>
[  127.322524]  ? __warn+0x9f/0x1a0
[  127.322531]  ? __nf_unregister_net_hook+0x21a/0x260
[  127.322537]  ? report_bug+0x1b1/0x1e0
[  127.322545]  ? handle_bug+0x3c/0x70
[  127.322552]  ? exc_invalid_op+0x17/0x40
[  127.322556]  ? asm_exc_invalid_op+0x1a/0x20
[  127.322563]  ? kasan_save_free_info+0x3b/0x60
[  127.322570]  ? __nf_unregister_net_hook+0x6a/0x260
[  127.322577]  ? __nf_unregister_net_hook+0x21a/0x260
[  127.322583]  ? __nf_unregister_net_hook+0x6a/0x260
[  127.322590]  ? __nf_tables_unregister_hook+0x8a/0xe0 [nf_tables]
[  127.322655]  nft_table_disable+0x75/0xf0 [nf_tables]
[  127.322717]  nf_tables_commit+0x2571/0x2620 [nf_tables]

Fixes: 179d9ba5559a ("netfilter: nf_tables: fix table flag updates")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 17bf53cd0e84..1eb51bf24fc2 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2449,6 +2449,9 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 		struct nft_stats __percpu *stats = NULL;
 		struct nft_chain_hook hook = {};
 
+		if (table->flags & __NFT_TABLE_F_UPDATE)
+			return -EINVAL;
+
 		if (flags & NFT_CHAIN_BINDING)
 			return -EOPNOTSUPP;
 


