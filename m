Return-Path: <stable+bounces-26796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFE68721DD
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 15:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4BCB21293
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2055186AE4;
	Tue,  5 Mar 2024 14:47:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail2.pod.cz (mail2.pod.cz [213.155.227.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F086AE2;
	Tue,  5 Mar 2024 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.155.227.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650036; cv=none; b=aAroEzCeJSD7IpyHJ3L81LFpwENkkPN3k69NEHFHF60ZW+Hi6INsYwxSENLa4T97AQHAgnq6R26ZEXJQu2v+Cynho1M2xGttAi/5zORLV4iyvZ69LPDXaldClYKyGsSNWGtYFCXmyG+FbfppQojuPf8rQKNrR5+p1rY30vQ7CUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650036; c=relaxed/simple;
	bh=8GwYVLsy0/2Nb2oX+Em0rpqEvoPnVtOu78eq/+GfMAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gke+a/s64O+Eue/zY7+AVnV3aAQFzIneJSA6WGjTp2EAl1dWdxPNSGFgEGUHDTVWaNMRtkaB2VLhE0CFM/04fcASLkU1sFUsLLuzHgwQpoKctLh6A9wAxgxu5dM/nW1tjxs2WJgfOObKmRJ0ftUzQmRYXsVaj/ZBzwtEsYfUhoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samel.cz; spf=pass smtp.mailfrom=samel.cz; arc=none smtp.client-ip=213.155.227.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samel.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samel.cz
X-Envelope-From: vitezslav@samel.cz
X-Envelope-To: dsahern@gmail.com
X-Envelope-From: vitezslav@samel.cz
X-Envelope-To: kuba@kernel.org
X-Envelope-From: vitezslav@samel.cz
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-From: vitezslav@samel.cz
X-Envelope-To: stable@vger.kernel.org
X-Envelope-From: vitezslav@samel.cz
X-Envelope-To: heng.guo@windriver.com
Received: from pc11.op.pod.cz (pc11.op.pod.cz [IPv6:2001:718:1008:3::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384
	 client-signature ECDSA (P-384) client-digest SHA384)
	(Client CN "pc11.op.pod.cz", Issuer "Povodi Odry - mail CA" (verified OK))
	by mail.ov.pod.cz (Postfix) with ESMTPS id 4Tpypp0NzKzHnV9;
	Tue,  5 Mar 2024 15:38:10 +0100 (CET)
Received: by pc11.op.pod.cz (Postfix, from userid 475)
	id 4Tpypn65bJz6yYZ; Tue,  5 Mar 2024 15:38:09 +0100 (CET)
Date: Tue, 5 Mar 2024 15:38:09 +0100
From: Vitezslav Samel <vitezslav@samel.cz>
To: stable@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	heng guo <heng.guo@windriver.com>, netdev@vger.kernel.org
Subject: fix IPSTATS_MIB_OUTOCTETS for IPv6 in stable-6.6.x
Message-ID: <ZecuUV4xwXxQ8Ach@pc11.op.pod.cz>
Mail-Followup-To: stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, heng guo <heng.guo@windriver.com>,
	netdev@vger.kernel.org
References: <ZauRBl7zXWQRVZnl@pc11.op.pod.cz>
 <20240124123006.26bad16c@kernel.org>
 <61d1b53f-2879-4f9f-bd68-01333a892c02@gmail.com>
 <493d90b0-53f8-487e-8e0f-49f1dce65d58@windriver.com>
 <20240124174652.670af8d9@kernel.org>
 <ZbIEDFETblTqqCWm@pc11.op.pod.cz>
 <ZbJ5Wfx7jNfXBpAP@pc11.op.pod.cz>
 <08d60060-ee2b-436f-9dcc-8aad1c8c35a1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08d60060-ee2b-436f-9dcc-8aad1c8c35a1@gmail.com>

	Hi,

  could you, please, include commit b4a11b2033b7 ("net: fix
IPSTATS_MIB_OUTPKGS increment in OutForwDatagrams") from Linus' tree
into the 6.6 stable tree (only)?

Reported-by: Vitezslav Samel <vitezslav@samel.cz>
Fixes: e4da8c78973c ("net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated")
Link: https://lore.kernel.org/netdev/ZauRBl7zXWQRVZnl@pc11.op.pod.cz/
Tested-by: Vitezslav Samel <vitezslav@samel.cz>

	Thanks,

		Vita

On Thu, Jan 25, 2024 at 11:20:58 -0700, David Ahern wrote:
> On 1/25/24 8:08 AM, Vitezslav Samel wrote:
> > On Thu, Jan 25, 2024 at 07:47:40 +0100, Vitezslav Samel wrote:
> >> On Wed, Jan 24, 2024 at 17:46:52 -0800, Jakub Kicinski wrote:
> >>> On Thu, 25 Jan 2024 08:37:11 +0800 heng guo wrote:
> >>>>>> Heng Guo, David, any thoughts on this? Revert?  
> >>>>> Revert is best; Heng Guo can revisit the math and try again.
> >>>>>
> >>>>> The patch in question basically negated IPSTATS_MIB_OUTOCTETS; I see it
> >>>>> shown in proc but never bumped in the datapath.  
> >>>> [HG]: Yes please revert it. I verified the patch on ipv4, seems I should 
> >>>> not touch the codes to ipv6. Sorry for it.
> >>>
> >>> Would you mind sending a patch with a revert, explaining the situation,
> >>> the right Fixes tag and a link to Vitezslav's report?
> >>
> >>   I took a look at current master and found that there is yet another
> >> commit since 6.6.x which touches this area: commit b4a11b2033b7 by Heng Guo
> >> ("net: fix IPSTATS_MIB_OUTPKGS increment in OutForwDatagrams"). It went
> >> in v6.7-rc1.
> >>
> >>   I will test current master this afternoon and report back.
> > 
> >   Test 1: Linus' current master: IPv6 octets accounting is OK
> >   Test 2: 6.6.13 with b4a11b2033b7 ("net: fix IPSTATS_MIB_OUTPKGS
> >           increment in OutForwDatagrams") on top is also OK.
> > 
> >   Seems like my problem was solved in master already, but
> > it still exists in 6.6.y. IMHO commit b4a11b2033b7 should be
> > marked as for-stable-6.6.y and forwarded to GregKH. AFAIK only 6.6.y
> > stable tree is affected.
> > 
> >   But beware: I only tested my specific problem and I don't know if the
> > commit with fix doesn't break anything else.
> 
> Only reported problem, so with b4a11b2033b7 backported to stable we
> should be good. Thanks for the testing of various releases to isolate
> the problem.

