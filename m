Return-Path: <stable+bounces-254552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKxTHo7RFmowsgcAu9opvQ
	(envelope-from <stable+bounces-254552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:12:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA7A5E32A2
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD893009525
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574823F0A95;
	Wed, 27 May 2026 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ARrf1Y2Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q37CK1Lv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y3XK6YZ2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8C3OTFdM"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7703EE1D6
	for <stable@vger.kernel.org>; Wed, 27 May 2026 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779880323; cv=none; b=YtQ5JIXY2psQ9C0wNE+TWQMHKQdaXATtFVYat8wLiLA58SUmU5fIh162QQUnVMbiWvL5/D3Q/PmF+NVMThalPdHM8FC1TRK8Fs/pWJq46u5swuCN2TpoyF7n60O0q+Z/hYT9xWljFuTi4Zi3qEfkKhur1zzo1c1Oy6E63NuP1bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779880323; c=relaxed/simple;
	bh=hmzv3evJWKDG1ijGXshnxk8ZWXXgQAuckoIhRWmecK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4ACcMDDESByB2ysltRVHJMY3ZWOSHINo1LderIK8sEg3klFPYk5T9VoxGXplI2LkBKauY3ANBePod2hARvxpLyR82QQDtky7lIBo3LMzQKDM+sov7aRxXiIceZjdpIOBdoyduZ4IAuMOCmlgcRKKbU7ljQNcDk7K/bB6/wIlO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ARrf1Y2Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q37CK1Lv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y3XK6YZ2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8C3OTFdM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9461F67080;
	Wed, 27 May 2026 11:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779880319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKrQoRgjTDNoQNekm5OnXBHl8URyX2aoygUus9E39fQ=;
	b=ARrf1Y2ZScI4IgB+flGzixDsexBm78r2tcmGUYq7M2ETGKMicMga+xO3gR20uqdHagRAHR
	uRqQRT/gE01v7XX2MGLbeY/ptG21xpfTU2MTyau51+8Ss+5igq+s6hvrQV4jtsKqO/j8LX
	WhCK8iat+seBsWRIWoChUWtJcKpOyyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779880319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKrQoRgjTDNoQNekm5OnXBHl8URyX2aoygUus9E39fQ=;
	b=q37CK1LvkmedEp0N2V0sdPbLWfD3q0jlvEoJoi2OFl8sVGGQZd5UpHiE1qcQPFOdhr0UCN
	tlaF/Z3JXWAGF9Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y3XK6YZ2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8C3OTFdM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779880318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKrQoRgjTDNoQNekm5OnXBHl8URyX2aoygUus9E39fQ=;
	b=y3XK6YZ2m519HbtJDw5CZYk/hX+qedlGDlH4Mr/uEyL4TZJtMuokkn+2ujv0QwdSehuNfZ
	z960UPity/1v++8k6YTfoJWoqivzx287lCU/DyVorUcImMoG8DttRp/yaX2intNznSc/cx
	n/iQy4WTQqrHO949NEbMmTNKjIluxwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779880318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKrQoRgjTDNoQNekm5OnXBHl8URyX2aoygUus9E39fQ=;
	b=8C3OTFdM9Hr58mnI4NnYlXkRoZ1UWJFERiPoqjkceSJmMnvzi/qNL7z1JBOxgah9jUrnxY
	K/PgYFWrk9Uu9vCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0D695A7D3;
	Wed, 27 May 2026 11:11:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WDDdM33RFmqgGQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 27 May 2026 11:11:57 +0000
Message-ID: <21df0b14-f530-4e9a-931a-21154ec18c78@suse.de>
Date: Wed, 27 May 2026 13:11:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] hsr: broadcast netlink notifications in the device's
 net namespace
To: Maoyi Xie <maoyixie.tju@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Jan Vaclav <jvaclav@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <CAHPEe=GO=2qqWZPwBB4rrXc3mkD0dznp2K78nCsKwF=c-QwxEw@mail.gmail.com>
 <20260527075924.2707856-1-maoyixie.tju@gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260527075924.2707856-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254552-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CAA7A5E32A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 9:59 AM, Maoyi Xie wrote:
> The HSR generic netlink family sets .netnsok = true. HSR devices can
> live in network namespaces other than init_net.
> 
> Two async notifiers broadcast events with genlmsg_multicast(). They
> are hsr_nl_ringerror() and hsr_nl_nodedown(). That helper delivers
> only on the default genl socket in init_net. So the events always land
> in init_net. The network namespace of the device does not matter.
> 
> This has two effects. A listener in the device's own namespace never
> sees its own ring error and node down events. A privileged listener in
> init_net receives events from HSR devices in other namespaces. The
> payload carries the peer node MAC (HSR_A_NODE_ADDR) and the slave port
> ifindex (HSR_A_IFINDEX). It leaks information across network
> namespaces.
> 
> Switch both callers to genlmsg_multicast_netns(). Other families with
> .netnsok = true already do this. Examples are gtp, ovpn, team,
> batman-adv, netdev-genl, ethtool and handshake.
> 
> hsr_nl_ringerror() already has the slave port. It uses
> dev_net(port->dev). hsr_nl_nodedown() takes the namespace from the
> master port via hsr_port_get_hsr().
> 
> Fixes: 09e91dbea0aa ("hsr: set .netnsok flag")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
> This is the fix for the problem I reported on netdev on 2026-05-18 [1].
> That thread had no reply, so I am sending the patch and adding the HSR
> maintainers to Cc. The proof of concept and the test numbers are in
> that message.
> 
> [1] https://lore.kernel.org/netdev/CAHPEe=GO=2qqWZPwBB4rrXc3mkD0dznp2K78nCsKwF=c-QwxEw@mail.gmail.com/
> 
>   net/hsr/hsr_netlink.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
> index db0b0af7a692..067ceaf7304b 100644
> --- a/net/hsr/hsr_netlink.c
> +++ b/net/hsr/hsr_netlink.c
> @@ -247,7 +247,8 @@ void hsr_nl_ringerror(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN],
>   		goto nla_put_failure;
>   
>   	genlmsg_end(skb, msg_head);
> -	genlmsg_multicast(&hsr_genl_family, skb, 0, 0, GFP_ATOMIC);
> +	genlmsg_multicast_netns(&hsr_genl_family, dev_net(port->dev),
> +				skb, 0, 0, GFP_ATOMIC);
>   
>   	return;
>   
> @@ -283,8 +284,17 @@ void hsr_nl_nodedown(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN])
>   	if (res < 0)
>   		goto nla_put_failure;
>   
> +	rcu_read_lock();
> +	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> +	if (!master) {
> +		rcu_read_unlock();
> +		goto nla_put_failure;
> +	}
> +
>   	genlmsg_end(skb, msg_head);
> -	genlmsg_multicast(&hsr_genl_family, skb, 0, 0, GFP_ATOMIC);
> +	genlmsg_multicast_netns(&hsr_genl_family, dev_net(master->dev),
> +				skb, 0, 0, GFP_ATOMIC);
> +	rcu_read_unlock();
>   

The patch makes sense to me. Anyway, I think we can reduce the RCU 
critical section here.

What about moving rcu_read_unlock() after the if and extract the net 
before unlocking? The benefit is minimal but I think it is worth it.

Thanks,
Fernando.

