Return-Path: <stable+bounces-223108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCrMBJRuqGkkugAAu9opvQ
	(envelope-from <stable+bounces-223108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:40:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D86205497
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF82E301E3FF
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3B436D4FB;
	Wed,  4 Mar 2026 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="m83VMf8U"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591237D13E
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646028; cv=none; b=OQ58FAUvMllTOqFZKW3k+ebf4IksE530HO2+SnODihyR7fmgQft5mACufmWCdwD0504qmkZ8ZkIIhZorylk/3nHBV4IXJMfeEnEP67DAau3DglZdk+a76GhnEoubwRUIuN39UK6oG/d2JiSGwUUWjUWw0akN4iZZRG16NftQxsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646028; c=relaxed/simple;
	bh=6u/b5Hl4P4F7KcDCqfOGbAd0OkLTF9XpNnpPJHP/ooo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRDzNyVUG+LFEg1mtqzkuCkSp4HImA0DyKdHFJCouz69u1uY7WVpZ/yroxWnO+gWfW1dhzG9WPMRugcCdB7Y4tJwn9s7/VLJBQuJ25M2fPRXMYrejVaC+LxUEprv3FYK8zEpzMRIeZNJ1HN4JtpW4RSlWtgXK6RxualJ5yp9JPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=m83VMf8U; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb420f7500so677298685a.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 09:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772646025; x=1773250825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgpC2SAOeCJOj5g+sj2OoOXZXcoH9wp6KBcGzu497t0=;
        b=m83VMf8Ujf90rIzWBraxVZVWaQetcU/VHPEgswLk0hPwk6LmKgloeaRkV7Atmyj6vP
         8861uvwbqACAEZjmIJO6MkZ0Kf/cACl8m2MUIydVPgtNhKnH4M3/neBt4h/dj6wI5chl
         /yXFZHlyBbSPjdGAh5SuFgYVdmxfhIchVOJc8awifkVjCvZNPdOFolaOJ7eegYi5Y2nG
         DcUYbCJwTk9wFkvvC73G9ak+mEYl3JL3bQDSk8gG1JcDZgstPBep4MeBeKRdunQ1fTI/
         u6SwEcgE2WjprN393puHO2vE1b9l3r/PPN9vyWwbZPfAH1k+BoFahoQcne7p/dZQH0fg
         9RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772646025; x=1773250825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgpC2SAOeCJOj5g+sj2OoOXZXcoH9wp6KBcGzu497t0=;
        b=Tk/kkSAKCWMepdVQgAYTGmNTcBX/oB4126toSxxHfITdepyWbovWMJ0DxhwR6SV+m5
         tZgbuOrXJ05igoVw4RVl9rIHRdDHesUgl4pd6k6Pex0ttRhX+yJNrkKIwRz9NdnBlTTx
         rwZIcp2x01mEe7exxw5Kw/uQjBi9n41w9ujkE9vcFGCy0bmsCqpiEv4pGgM1gA01RMvr
         oaZasrSz79O+HD93iGtkAXqTbRSh7Qo856qABgsXcF/7p1aYpAmIYOkKvhm4WGe0/R+k
         lPkdCw62+ATEA/rOeGP+HT86eQdMq27/HO0uCsaFBPSESQgkaLLFcg0cBXRtkS+P7/js
         obMw==
X-Gm-Message-State: AOJu0Yw2dtrJpjWq+r1dyAzuV71Nk8N0hnp9EiOJw6kstp1QUm3Fk1Zm
	Trn9NsKZKqHvy0Gj8wmrZ4Oya3AfoNnsIauP5og+9TTnD0gnZ36h4vp3Ft1W7Kq0FfA=
X-Gm-Gg: ATEYQzx8Ch0/VbANyBLKaeuoj7VkSHLXPsvw8NspBoFKnlnO9jiEbf/HEOUvKNZj9xX
	EET+3dRzjbnmG5QbuTG92xL0MfeXL1yc6b6nHtK+Doh7fd8K6jLTNhCpnyaoxwjz0ZrBaEYPzuo
	2TvJ3Qmv0fn7wb0beweAyKTuvU5BFeutSg3J+f9KFfutdE2VDhmWMJhQ72krWEdCijg7nde7b3K
	q6S7j8Ke6XIQgKjNFh2HvJRurKnvikoS6hx0dbtDNzPS7VbC1RXqX/8g9uJpTscw9IHJ0/bhEdP
	m7nnpfvF62AlvpF9M28tqtx4DN6nMRssz8U2MFdph45J7eUzW7xYHfKL9BZYJsnoTWiQBdHNDrV
	2G+tOjcFhk1X7W/tNqghS2bEchw0QaN5h0Jy4/TykuVVrOcp6Qm5yBHTy9ExkqHTLM4bJ59UmJV
	aFu0OQHXVRq/jT4U601H848G0qfvBUMBwtmcBF23mKdREH6Izbutr2HB0+xK6xlwfr3UJFJw7lq
	mb1HKruvA==
X-Received: by 2002:a05:620a:19a1:b0:8cb:2830:175b with SMTP id af79cd13be357-8cd5afaa850mr354601985a.65.1772646025360;
        Wed, 04 Mar 2026 09:40:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f948dsm1668520385a.30.2026.03.04.09.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:40:25 -0800 (PST)
Date: Wed, 4 Mar 2026 12:40:23 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: stable@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	Li Ying <liying3@sungrowpower.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Lameter <cl@linux.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 6.6.y] mm/mempolicy: fix wrong mmap_read_unlock() in
 migrate_to_node()
Message-ID: <aahuh6N6zfll5EPB@gourry-fedora-PF4VCD3F>
References: <20260303101245.22290-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303101245.22290-1-david@kernel.org>
X-Rspamd-Queue-Id: 65D86205497
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-223108-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:dkim,gourry.net:email,oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linux.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:12:45AM +0100, David Hildenbrand (Arm) wrote:
> The backport of commit 091c1dd2d4df ("mm/mempolicy: fix migrate_to_node()
> assuming there is at least one VMA in a MM") contains an error:
> migrate_to_node() does not lock the mmap_lock itself, that is handled by
> the caller instead.
> 
> So let's drop the wrong mmap_read_unlock(). Fortunately, this path is
> very hard to hit in practice.
> 
> Fixes: a13b2b9b0b0b ("mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM")
> Reported-by: Li Ying <liying3@sungrowpower.com>
> Closes: https://lore.kernel.org/r/aaZgUNxAyKC2IwuG@casper.infradead.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

straight forward, thanks for the quick fix

Reviewed-by: Gregory Price <gourry@gourry.net>

