Return-Path: <stable+bounces-231417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C1IKFa9y2kwKwYAu9opvQ
	(envelope-from <stable+bounces-231417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:25:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A18369727
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95B6730ACB04
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46B63E1D05;
	Tue, 31 Mar 2026 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="OTalYU3c"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CB73E1205
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 12:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959696; cv=none; b=KXcuAH7KkRGoJmtOHRW3QL5gexMvCUA2eNnNJZm1VTwRU8866GAUvdMACBwUuFOWeavp8H3p63N8HfTsGoyLzfLgGRej3QgziTl2NC52E2ziiAKPXvZjyIoUqV6BGiANZcwUzHLZeUC4uvn2fPGcNtCCtKA6mLl9SPEi5WmxZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959696; c=relaxed/simple;
	bh=tLKKlkBPHGBCLGEsREkfW9B6Lbeag78/9yaa4ykOKOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5h3T0COWDAMh/r2FR116U8041TrfuAA2yrCATMHynZajaDAKA5kN2cL0Rp+2USS0jqhi3ySD5uVt9Wrf3xWtPcOakh/dhR+LtphyVBLBdsZDYCi8PIMMUXD04/t0cFfPBagZyJ+8RlLIw+9mQfQZRlIAwVGHsExUwk9eq04Mew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=OTalYU3c; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-112-174.bstnma.fios.verizon.net [173.48.112.174])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 62VCKh5d020429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 08:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1774959647; bh=NgNcg+u1NBRoAeJ0X2EC7mko2ww9hZ9u4YDqZn07NJA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=OTalYU3cH/zbxpYh+VufB1Rr+bdCrgFKwM738zGplWvymBF6OUgZu9hWPAzjeHaDM
	 GeZHgEIvEybyWZGOtv+Aj2qOgDjEcpW4xk60ILOXsKPV6t6YOZRK2Ruyd+JkqnjKG1
	 SXqRJNxi99vuNRrTlgUSuvgv1l9iWZCPTiAVLx11jTT5RULo2j7D6OL13XUPICc3nC
	 sgfCVF3MVZY/aXuhKkqvrlneGO/4nOIuz5QboAJzrPh8Z6yH/qn4SVuRTaknr/1id+
	 n29o5SXu06wFfiEmG1v8oFk44lf+PNZw/X+Eh5H4zMYZW+CIB2KQ1ms2pTM5ngFLOi
	 bVHabiPWhVKfQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 5D6D560291BE; Tue, 31 Mar 2026 08:19:43 -0400 (EDT)
Date: Tue, 31 Mar 2026 08:19:43 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "# 5 . 19 . x" <stable@vger.kernel.org>,
        David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@kernel.org>, damon@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: (sashiko status) [PATCH 0/2] Docs/admin-guide/mm/damon: warn
 commit_inputs vs other params race
Message-ID: <20260331121943.GA74409@macsyma-wired.lan>
References: <2026032915-library-embolism-b48c@gregkh>
 <20260329193226.59025-1-sj@kernel.org>
 <20260330142205.e7c7d7b47ec15a634f6eebf4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330142205.e7c7d7b47ec15a634f6eebf4@linux-foundation.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231417-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[mit.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12A18369727
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 02:22:05PM -0700, Andrew Morton wrote:
> 
> I view Sashiko as primarily an author tool.  Sometimes I call it
> checkpatch++.  In a better world, author would be able to sort out
> Sashiko issues before ever sending out the patchset.  But in this
> world, a public send is needed to obtain that review.

Note that Sashiko is fully open source and the prompts are available
in third_party/prompts in the git repo:

	https://github.com/sashiko-dev/sashiko

So people can run it privately, although they will need to provide
their own LLM credits.  This also means that you can use some other
LLM besides Gemini 3.1 Pro.

Cheers,

						- Ted

