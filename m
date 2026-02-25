Return-Path: <stable+bounces-219693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PJaDB5On2nNZwQAu9opvQ
	(envelope-from <stable+bounces-219693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 20:31:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B59D19CBA4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 20:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88CD13018AC3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227573ED136;
	Wed, 25 Feb 2026 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="gvMKoedl"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8AC23EA89
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772047892; cv=none; b=q5rJIxisEF7JeP3z9NfmzZQAIMxL6pIJwbaWrM6+dnsAgJdTDHh904OL5bX0zwFGPVPVEIVbUNO5JxkQfM7S23L5ia3jGC0Nqmmi0yExuQUPO42x8vCjg0LGEYM84uh0Bi0CmQfKJve+cwnk6qFzqtio2NNYIake45+GAt/KC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772047892; c=relaxed/simple;
	bh=nBqF4w+CUs5G0Dk674hPgFrbQ9Ruua2n7FSfL7WEBlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOv64cBOgyFpNF55rFajF+o87o865IDJfhLXjz3gNWr19HsOXsiRjcRRjmkktMYvQBr4D3jTAl8wDIN9afego7tOM1S7Nx/AicYtrebXhdIQQ2C5OXGZgB33w/Nw3AgLz9LzUPH/J9o2plDU3yVrCEYJN6dDjmg0PvAtsuuaw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=gvMKoedl; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-897023602b1so1236386d6.0
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 11:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772047890; x=1772652690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3Jxm9A3azjabtMJunPGxErvPjmUnEkcbOHkg5GFLOM=;
        b=gvMKoedldtlpnr+OKjNj67GSHzGtIsdMyAHeQDxnO8ge5VpROoJjslHgL1NuYC/Ejp
         genntVRbM3YYlyo9RVIuJstNp88lZLJlrl0WAcBrFpceDv4vy3JIZbFaDbanM0ljknTK
         j81bCI3wrTb2zxFplksD3kUyKYKDA0Kk4qALwf8sgktQWuv4IcSNASJ7KGcGmiG2RJMX
         MOlwotvv2nSINwl8G3nU0pIk3AkYCPl8IJPdMDaJDjf6/VBxALv5C2HcH9yobt1Ed0r6
         fVSOOAggzkD2RdM9YPtSBc+agX77nzQBgX5nSVHFptN2ezjqODuScNnPoHNj5h/+61af
         NycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772047890; x=1772652690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3Jxm9A3azjabtMJunPGxErvPjmUnEkcbOHkg5GFLOM=;
        b=qjZ0ABEDIRvogKzWrE0ajPWFGI2f9GPOPiFfnevaG3PHVDOwjRaUeLMickMtdhAj4g
         wnUcV0J3vQFehOaAiFxk/NHcVZDamL12fVyfsym96JA4Y5aDjpk6PyHci/HnPnXigLOs
         wqWsmacu6TAZTA/5HmVpWbhzXI6NHJ/ARgx+kBpVe+lL0apG4WXnjhhWpYQIBpCIFOxC
         7Z/idTPwA2leEl6rN+BmlDE/5qGnxJsZ0Gyw+HxF3O+LPKVpcNbtjzHKHSuRfcX0MBc9
         LfBroBK60hNl+PwjeNAFi7+1G/wbY0LRgBYTWLUfxfCKQWRIH6SLAtN4wKz9o81e+/ie
         JoRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsX/Ld3c5SSBWOtO4rCsJENOst7G7JGaJ1DkScLh37pIyK21EMn8N1WOEt9UfYJFDOzFqTuzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhLA5qb1NRHxKvgOPWScAfiiQJKTK/J0znM8yap0fh5e9SIf6u
	vTjloCglQLhrq7W4EPAsbV1+cTRXk0+hR3AuSBHYr+uuxtpl79e7E3tCpT561pzC+p8=
X-Gm-Gg: ATEYQzxQPlRr39/F1wpnlU8Iya5hYwIhMxmTxQp5AXDq4fyIYmHa+dzGlWElaadd8rV
	6UDWPvTaBZgIFcU5F4hI3uuryC38k09pLz+eQuzudkCK67joej1/6A512owMe3pkmy1CIEnC/aB
	GUGpleS9WHmpg4lBLG7siMl8SNty/kCOiGdrVtQANhtX0BjdcRJFnOZd3pD+VWMkK3H0djEWEHy
	VMGb1Z6TLGt0u7KwMS0M6v84SxxyCqDyO7ijqHavXeI66duUU6qcYdldx+j9xWd8XiDZhTkYpXl
	nnHoJyjO6sueXy7UYZqpa84q2O+qsDvewuz8I7eRjd5f04IVwXDCetqgZBnCD+9m4iftTQtXzNh
	ZG08mi8Lji+GfCPXELEMsSVoON5J4dNoMSDPfqt79/MXLOs4/lMMr+3jc2X3dsq55TnzKrtjOVN
	alushVA2BXxqWw2GC+kbHPmcMDlIyIwwN1
X-Received: by 2002:a05:6214:768:b0:896:fb96:e13c with SMTP id 6a1803df08f44-89979d91197mr276698026d6.57.1772047889659;
        Wed, 25 Feb 2026 11:31:29 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf659210sm6749685a.8.2026.02.25.11.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 11:31:29 -0800 (PST)
Date: Wed, 25 Feb 2026 14:31:28 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "ptdesc: remove references to folios from
 __pagetable_ctor() and pagetable_dtor()"
Message-ID: <aZ9OEAzENzeFYDB2@cmpxchg.org>
References: <20260225002434.2953895-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225002434.2953895-1-axelrasmussen@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-219693-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cmpxchg.org:mid,cmpxchg.org:dkim,cmpxchg.org:email]
X-Rspamd-Queue-Id: 8B59D19CBA4
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 04:24:34PM -0800, Axel Rasmussen wrote:
> This change swapped out mod_node_page_state for lruvec_stat_add_folio.
> But, these two APIs are not interchangeable: the lruvec version also
> increments memcg stats, in addition to "global" pgdat stats.
> 
> So after this change, the "pagetables" memcg stat in memory.stat always
> yields "0", which is a userspace visible regression.
> 
> I tried to look for a refactor where we add a variant of
> lruvec_stat_mod_folio which takes a pgdat and a memcg instead of a
> folio, to try to adhere to the spirit of the original patch. But at the
> end of the day this just means we have to call
> folio_memcg(ptdesc_folio(ptdesc)) anyway, which doesn't really
> accomplish much.
> 
> This regression is visible in master as well as 6.18 stable, so CC
> stable too.
> 
> Fixes: f0c92726e89f ("ptdesc: remove references to folios from __pagetable_ctor() and pagetable_dtor()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Willy's cleanup proposal looks good to me too, but this is more
straight forward to backport to stable.

