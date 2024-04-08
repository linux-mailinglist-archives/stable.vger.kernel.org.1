Return-Path: <stable+bounces-37126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498C089C372
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D891E1F219FE
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80986126;
	Mon,  8 Apr 2024 13:35:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E547D413
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583325; cv=none; b=D0JcihpdNWCrA612f6HbWfBVG+W0p+j43uWhD/nhhRMKTY6NuD4VqF89D/N6VW2Y4lAHDPq9u7Tx0R1Llz6JmMVhWwbRPyUyz3+4J3ml/vXzwMTSfgUyET8oIyQtxFsG70mim4Q69KBxMV+ioOppHdBvBGJWsvb4KuFWn54ZbFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583325; c=relaxed/simple;
	bh=QzID8QBM4d0TPssMG/Zyt2dw7OJJF0xwNDkHYAmuFSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqpJgneWiwkQNOZiWqyaRb88CsOgfwX4LxElVpkBTEnOe01SuX6s3IHLsk9dlZ+QG0L1pQUwrFrMVbYmkb+BP6YXWnB+abhh1IM1l/mYSdLYSGsVKXfRliQqpLBkVG9MTBTaQRWABSfkL3L6A+AGrFfK66Yvmgb3IjGUGZzhseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Mon, 8 Apr 2024 15:35:20 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.8 046/273] netfilter: nf_tables: reject table flag and
 netdev basechain updates
Message-ID: <ZhPymMVOJRCLQaWc@calendula>
References: <20240408125309.280181634@linuxfoundation.org>
 <20240408125310.727931386@linuxfoundation.org>
 <ZhPxo5aJctUtO4Go@calendula>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhPxo5aJctUtO4Go@calendula>

On Mon, Apr 08, 2024 at 03:31:17PM +0200, Pablo Neira Ayuso wrote:
> On Mon, Apr 08, 2024 at 02:55:21PM +0200, Greg Kroah-Hartman wrote:
> > 6.8-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Pablo Neira Ayuso <pablo@netfilter.org>
> > 
> > [ Upstream commit 1e1fb6f00f52812277963365d9bd835b9b0ea4e0 ]
> > 
> > netdev basechain updates are stored in the transaction object hook list.
> > When setting on the table dormant flag, it iterates over the existing
> > hooks in the basechain. Thus, skipping the hooks that are being
> > added/deleted in this transaction, which leaves hook registration in
> > inconsistent state.
> > 
> > Reject table flag updates in combination with netdev basechain updates
> > in the same batch:
> > 
> > - Update table flags and add/delete basechain: Check from basechain update
> >   path if there are pending flag updates for this table.
> > - add/delete basechain and update table flags: Iterate over the transaction
> >   list to search for basechain updates from the table update path.
> > 
> > In both cases, the batch is rejected. Based on suggestion from Florian Westphal.
> > 
> > Fixes: b9703ed44ffb ("netfilter: nf_tables: support for adding new devices to an existing netdev chain")
> > Fixes: 7d937b107108f ("netfilter: nf_tables: support for deleting devices in an existing netdev chain")
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  net/netfilter/nf_tables_api.c | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> > index 00288b31f734c..db233965631bb 100644
> > --- a/net/netfilter/nf_tables_api.c
> > +++ b/net/netfilter/nf_tables_api.c
> > @@ -1198,6 +1198,25 @@ static void nf_tables_table_disable(struct net *net, struct nft_table *table)
> >  #define __NFT_TABLE_F_UPDATE		(__NFT_TABLE_F_WAS_DORMANT | \
> >  					 __NFT_TABLE_F_WAS_AWAKEN)
> >  
> > +static bool nft_table_pending_update(const struct nft_ctx *ctx)
> > +{
> > +	struct nftables_pernet *nft_net = nft_pernet(ctx->net);
> > +	struct nft_trans *trans;
> > +
> > +	if (ctx->table->flags & __NFT_TABLE_F_UPDATE)
> > +		return true;
> > +
> > +	list_for_each_entry(trans, &nft_net->commit_list, list) {
> > +		if ((trans->msg_type == NFT_MSG_NEWCHAIN ||
>                 ^.........................................^
> 
> Remove this, only update is narrowed down.

Apologies.

Patch is fine.

