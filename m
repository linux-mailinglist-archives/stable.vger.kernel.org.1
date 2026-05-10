Return-Path: <stable+bounces-245049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KcFIlW6AGruLwEAu9opvQ
	(envelope-from <stable+bounces-245049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:03:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E204950543C
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26C86300B62C
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3A8388E72;
	Sun, 10 May 2026 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNFkwMYF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAFE19D8AC;
	Sun, 10 May 2026 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778432592; cv=none; b=BpgdfaV96QhjH0lEaT5pzalqY79x0iwc6Z16M3rYCmmrf5V63PDmmivSyj+HN3bm0/PCOLO17lvWCkrEVbi7lZ0AmWhpKDmUQWF13xBPqIh0sO/cN/+WL/lOzndsKxSZJw5YeVRbiSqYqJXVPCFsBhw0ubJoiKGMhaY4yvsDAP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778432592; c=relaxed/simple;
	bh=Xb96f+U/EMxP95g4iEmwFtMr8KSCJAosakS/ah/rrec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKKCfMNiON5IinI4uOVVesz79IAez5pEIHytNZkPsprfiE7+aDBtV2FShZGslB5FmUwdie9Sc9dvoveF8UMHVAIwA8jNrMY4PtYisXNkPtmwcyfZ2N5gGPr8by4D5a36mQGleqERREeE29nArSEl66yRCIPjDT++BVRZrfLPGGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNFkwMYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182E9C2BCB8;
	Sun, 10 May 2026 17:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778432591;
	bh=Xb96f+U/EMxP95g4iEmwFtMr8KSCJAosakS/ah/rrec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZNFkwMYFi1tyCHZLLrtnOU98mYDy3nliE+gfXxZDpL40IlZCL++kkYu9ek08kVJI6
	 QupW2MaWggslQLV7YH6XL984RVBgbxwGwdvlQ53VFf+eBDZwlVW7+w6C2YbXveC4k8
	 CgKEY0fXMegX63vWrNLk85CRxJXlnDbgue52qqaYd93YfW2Fb6ZiuOirWP/r1+qHRS
	 d4Th4uBHQyhLmd2wzEYUED3ol/J7sP0t76T8cYTxREyIfXz1TqqulXg2y/LNhbmEaL
	 uDh4SNwqG65Hp40M4oUKjpKX/9+y+prgPYq1z9I1qVc04FRX5eMOf6SYmGy+6ycsRv
	 KX/VT/7W6nfBA==
Date: Sun, 10 May 2026 10:03:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 qingfang.deng@linux.dev, jiayuan.chen@linux.dev,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
Message-ID: <20260510100310.230b15ed@kernel.org>
In-Reply-To: <agC256wVYa4Gnvy1@v4bel>
References: <af2kdW2F1gJ9U-Gg@v4bel>
	<20260510084520.476745b5@kernel.org>
	<agC256wVYa4Gnvy1@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E204950543C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245049-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 01:48:39 +0900 Hyunwoo Kim wrote:
> On Sun, May 10, 2026 at 08:45:20AM -0700, Jakub Kicinski wrote:
> > On Fri, 8 May 2026 17:53:09 +0900 Hyunwoo Kim wrote:  
> > >  			    sp->hdr.securityIndex != 0 &&
> > > -			    skb_cloned(skb)) {
> > > +			    (skb_cloned(skb) ||
> > > +			     skb_has_frag_list(skb) ||
> > > +			     skb_has_shared_frag(skb))) {  
> > 
> > We seem to be getting a lot of fixes for this issue, and this one is
> > incorrect :| Writing to _any_ frags is incorrect. You have to copy
> > if skb is not linear. skb_ensure_writable()  
> 
> I was testing a patch based on skb_ensure_writable() but it seems v3
> has just been merged to mainline...
> 
> What would be the best way to proceed?

Depends on the tree. Where was it merged?

