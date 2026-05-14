Return-Path: <stable+bounces-247277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAvUFesZBmrGegIAu9opvQ
	(envelope-from <stable+bounces-247277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 20:52:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A161F546100
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 20:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 714F0302F39E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47C733DEE0;
	Thu, 14 May 2026 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="MnBPeOrm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CwIdWqvE"
X-Original-To: stable@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5461E7C2E;
	Thu, 14 May 2026 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784601; cv=none; b=mgGdFFUbjlKsF+YVczj0APZFIWAylzOz8rWzjvKD1yf8uvBp/NWMj5UNuNIQOUyteXW4AbifiT+s/JuGoxz7oVf+FrwlnZcv/fY+/Id8yS0jjmgL+4IDrEAXsKMJVASeLVeFMOo/5kkb4UphZznmXv9kl24szHc+8ysCRMaD9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784601; c=relaxed/simple;
	bh=wkSvyIjXKkHhir2aUOQz5yRmvCL8h6LzleHDKkvHgts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeTz5Q7gxx8CN/x58dkGXbqrZ8qwua6PeV5758/6QzYPnYAD/r/dTp0dhel8A2LW01h8/MFcewYOoJlOl2s/O5eSeVPnrnyYv7Jzuh31VIi+/oQ9PkzXbRvVbw5CRDEhqSxmRTV6OEhgXSkxgs4c2JWNjq53UPgBU0jGQAL713s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MnBPeOrm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CwIdWqvE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5EEB7EC0096;
	Thu, 14 May 2026 14:49:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 14 May 2026 14:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778784595; x=
	1778870995; bh=YeNmVh7M/iDdCpdHND8BuXH1OVD6QSi5GrmO9WwYUaw=; b=M
	nBPeOrm+cy27W26nDaE3SJPfJELWu9/1nBwk29SenJ4x06uN2flmE2b/F1zUmY2m
	JzNHO6VYpz+w6sVPTxIU/8ttE8K4eTwPzexRmGGn9hBpO4FYbhCJ4bClR+WdBFgp
	Hey4DImFg9bXc4zujSxDb1QJ6zB7vNm8U/UQoBUwZJmSqDxY6e8MVT545FGUcjAK
	X7Q39CXKQTD1TznGHplCBlUzqJYHaIqnXLuHJ+egeHvPWrD091wex8QxWEKNKcBl
	E7AYomDVLOFgWqnljkYfw9nd7O92WIJKsHH0B2MtYX5faV3tQVEBUqXpUCPpp1Or
	YImSJ1GN+8dJUG4KRny/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778784595; x=1778870995; bh=YeNmVh7M/iDdCpdHND8BuXH1OVD6QSi5Grm
	O9WwYUaw=; b=CwIdWqvET6x/O7ogXGgBe3O36F4F3M9qUzaXrjDIddFQMi59sst
	8Yfw88ivBjgM8fC/XuQCje1morFh7Yzuz+PSJgrClm00nVtaTCk7q59Z0Ecee6UN
	YqVX0ABpCmuKYdVAtZh5KQSu57hI3rC2Tg6FrZYfO3wnlM9j7EVfqpxCw1HH58Sh
	a1jkHQvBDZ8vJV05Q1zbMBCfJJ9gBrkt1hc4M5XFsKJtFQQW7Td+23M9ZJXglzd0
	YzFRzgzzCcSbfbyn2cb+BMhtXbcpfmydFfPaj8P50VkHWmp7XPDzOypFzPmM8MBg
	rAjXwUA/WJqpnq+PiGAMQ+7rj7oNmqaTtag==
X-ME-Sender: <xms:UBkGagMAAU89j6IBmmt-iSfnA_8EUO5XnfeQY8S2vOybZUoN_gVA1A>
    <xme:UBkGaoVKTohkIxmgXUQMh1wCoGkbiFYxy3lCZBQpdPHjYyCwHXDmFB-MKq3pV2B_I
    HKT7AdhOUqvUtyPjeI8tSMIDDdWV_KWsb8BZnZdmlC-YOlCPMD0-OeH>
X-ME-Received: <xmr:UBkGagj4mwTFLtE9T9YS4cbMLBBE7AoPw-mSUaZNPtoOSUszPbBXHh38EBW0o_yYM7UciSwr2isVZamHZ-hlTME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdekvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeghffftdevudfgkeffjedvie
    eilefhtefffeefgfehvdevhfejjedvkeefleeggfenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedukedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepihhmvhegsggvlhesghhmrghilhdrtghomh
    dprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohep
    vgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlh
    hjrghsohhngihinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhunhhihihusehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehmhhgrlhesrhgsohigrdgtoh
X-ME-Proxy: <xmx:UBkGag-ClrK3x4qApRlQge-DsYfwmfmPF7AZHOyHSgLXqClgpcf9dA>
    <xmx:UBkGavTjaED7nnJKd-rLNMqMwFylorfxP2AeEfzEbzImGEZsVv0eRw>
    <xmx:UBkGanukSXvpXBY3r5D99F4AsfOKYJeUK-yb7Pog236TDptjh6sqwQ>
    <xmx:UBkGap7cdKVgzeB5Df12kT4FK9QSjj1OiMIFlxFScapqXgBkqXqVzQ>
    <xmx:UxkGag4ByfQwOipgh1OTaK6aePRMfwt2iLRFZ1QwV_Jw22zNI5ArtfKA>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 14:49:51 -0400 (EDT)
Date: Thu, 14 May 2026 20:49:50 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, mhal@rbox.co, jiayuan.chen@linux.dev,
	steffen.klassert@secunet.com, vakzz@zellic.io, ben@decadent.org.uk,
	herbert@gondor.apana.org.au, dsahern@kernel.org,
	sultan@kerneltoast.com, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agYZTjQSunDj6rOD@krikkit>
References: <agW4vC0r8QOUKtRT@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agW4vC0r8QOUKtRT@v4bel>
X-Rspamd-Queue-Id: A161F546100
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-247277-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,linux.dev,secunet.com,zellic.io,decadent.org.uk,gondor.apana.org.au,kerneltoast.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,zellic.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:dkim]
X-Rspamd-Action: no action

2026-05-14, 20:57:48 +0900, Hyunwoo Kim wrote:
> Three frag-transfer helpers (__pskb_copy_fclone(), skb_try_coalesce(),
> and skb_shift()) fail to propagate the SKBFL_SHARED_FRAG bit in
> skb_shinfo()->flags when moving frags from source to destination.
> __pskb_copy_fclone() defers the rest of the shinfo metadata to
> skb_copy_header() after copying frag descriptors, but that helper
> only carries over gso_{size,segs,type} and never touches
> skb_shinfo()->flags; skb_try_coalesce() and skb_shift() move frag
> descriptors directly and leave flags untouched.  As a result, the
> destination skb keeps a reference to the same externally-owned or
> page-cache-backed pages while reporting skb_has_shared_frag() as
> false.
> 
> The mismatch is harmful in any in-place writer that uses
> skb_has_shared_frag() to decide whether shared pages must be detoured
> through skb_cow_data().  ESP input is one such writer (esp4.c,
> esp6.c), and a single nft 'dup to <local>' rule -- or any other
> nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
> skb in esp_input() with the marker stripped, letting an unprivileged
> user write into the page cache of a root-owned read-only file via
> authencesn-ESN stray writes.
> 
> Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
> were actually moved from the source.  skb_copy() and skb_copy_expand()
> share skb_copy_header() too but linearize all paged data into freshly
> allocated head storage and emerge with nr_frags == 0, so
> skb_has_shared_frag() returns false on its own; they need no change.
> 
> The same omission exists in skb_gro_receive() and skb_gro_receive_list().
> The former moves the incoming skb's frag descriptors into the
> accumulator's last sub-skb via two paths (a direct frag-move loop and
> the head_frag + memcpy path); the latter chains the incoming skb whole
> onto p's frag_list.  Downstream skb_segment() reads only
> skb_shinfo(p)->flags, and skb_segment_list() reuses each sub-skb's
> shinfo as the nskb -- both p and lp must carry the marker.
> 
> Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> Reported-by: William Bowling <vakzz@zellic.io>
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
> Changes in v3:
> - Include the skb_gro_receive() audit patch suggested by Sultan
> - v2: https://lore.kernel.org/all/agToIEDI4TaTNLRb@v4bel/
> Changes in v2:
> - Also propagate SHARED_FRAG in skb_try_coalesce() and skb_shift()
> - v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
> ---
>  net/core/gro.c    | 4 ++++
>  net/core/skbuff.c | 5 +++++
>  2 files changed, 9 insertions(+)

I think we should also be propagating SKBFL_SHARED_FRAG in
tcp_clone_payload(). It's copying frags from skbs in sk_write_queue to
a new skb in the same way as those functions you're fixing here.

-------- 8< --------
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f9d8755705f7..6e4bb411dc04 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2626,6 +2626,7 @@ static int tcp_clone_payload(struct sock *sk, struct sk_buff *to,
 			todo = min_t(int, skb_frag_size(fragfrom),
 				     probe_size - len);
 			len += todo;
+			skb_shinfo(to)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 			if (lastfrag &&
 			    skb_frag_page(fragfrom) == skb_frag_page(lastfrag) &&
 			    skb_frag_off(fragfrom) == skb_frag_off(lastfrag) +

-- 
Sabrina

