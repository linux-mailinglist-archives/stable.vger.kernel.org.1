Return-Path: <stable+bounces-222825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJqGO9WcpmlqRwAAu9opvQ
	(envelope-from <stable+bounces-222825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:33:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 573EA1EAD57
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2202C3112131
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D1E375ADF;
	Tue,  3 Mar 2026 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auuNx0TI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5045E33EAF8
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526512; cv=none; b=VRZwy2xeD22BzAe+XMTvZM2Dy1Qcpv+gpkj8zjVTRSIsDQabqpnkbu5sIosNTEaZxap4SPsxouOZI0cF1gHPOjeALT7K4/S8S1ZwC6MgGVjGeVFNSpGupkzzCLRic/P42rLbJLAbrH4mCvmaBP5Jf5B4RkmOvDzSqMsjukOo12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526512; c=relaxed/simple;
	bh=Aj5EdWjVF2jxAv9z+0TobEuciQMJWsagsW0+QMnh1Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU83CwAXusB5/UHrEXTTY1HXzPvq0/mrloQ/Q5mDBP+oUZdaXQYU41k7i7BL+cYE/tCna4oJs6EVO1NUc7pUrQUjuydRC+xs90bxHOgXf3ooMyDv5iIvrCLL5qs1cCrdUQeBft9EvARj90+EfUe/A19zhabXFTrk85QsPNKxozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auuNx0TI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8fa449e618so772549766b.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 00:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772526510; x=1773131310; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvQ9ogjqY7GpWZR0jhfLALG/vdl5wh/KcgbqbjmLgoM=;
        b=auuNx0TITUBFiDejhfcWAgaKfZGi66w9epcPluFifmQQVMHeAbWmAbxxpkd00+voNs
         VaLtWNSYtcrnH1IfNzIocbnswtPjEnfpYwfmd1gqQ9s8eMB7uuISwzOjt9fotju89BYB
         /h0GTQR6udvguK8EEgTsIZtJPn35KqpS+Vfm0Hhh7gsKpTcggxfebbDMl/EnL9M+m+xA
         4G0eAdK05eb0D/9BZdnub7EdoCnrSVgfuVVe7xGi9/z2mxcjz+2stb0un8I4hcUoVGxw
         bLf/Br2IUi7heuQHX3Pfk3TBLK3EsG5LzoS4pki/7ia0j0qT52QWIdTYGgaJ1bqX/+0+
         HETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772526510; x=1773131310;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvQ9ogjqY7GpWZR0jhfLALG/vdl5wh/KcgbqbjmLgoM=;
        b=ajQcD1hGz3l7PVs5jSDWXKwNjyxTdJuM4auHqbuUJ7GjFVSUfBZDtIRFaMj5B2tq1h
         ZoKbGcYnolHaLfJiHXDzu3uX7Od9NbdyMOFCJwsSeaoG7FN5TAbzMEFeny4uGW535GH1
         lOTn2/ZCdMgmFH+xFF22DCiDU6DTbUXLbSKbMHs2CoB5GdbtWS6GVS37QNOO7KXva2fM
         5MXalVRuF7l0VIbCSXT0oHsVhBbSNMk34wR/PNsO9aK7CCsDOZCyTMmm4aMpt6CXUFf5
         6yy2j0IDqRJvuiREQUvlSYjrBrHxTLlIzPyPsPbsxQu39u3BV43EBfFJnFPJpYld19uG
         A10w==
X-Forwarded-Encrypted: i=1; AJvYcCWZouZHJK2yTP9HsNPEk4lACa42DMXK5G7fUiC8sZm+7xeX7uqfY0f/UFAi/LhGVeoXgniFiOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEnXRtLc3uQpFycBrVp9usRD/aEr9YwdseYoWleJhk1fCIv3o
	WJOSFkhFAUF3hKHsr6m0/Y9oqUoVLNq5VT6YsaoJuuvYyKVeaeaxfeY2
X-Gm-Gg: ATEYQzzUTkLYem8V6jXKNQOUC4V0t2sAyI8/+AjbB3UX0bT7xU+On+Mucv4GgfhtU8F
	kIttg2JqXzan5YATod4qi0oI7DicdIYUZiNw1st+FTOTF5XPtAke1QKSTYWaFCKRQ0a3hzJdv94
	KDoxrgWfw9ZQK7lOSiPwzqgmlNrDSr8cNgWPN/ZLVRA0VL3J+/gS/0YGZGMv7VRfXhwX7NrYjRj
	OocRouSPG42c7w1Fpiy3hriLCHifkWRZUCsz3zaCrQ3T5LagVWU0XNtvYciYLB/ctpufbfXjdr7
	FRYpsDw7rndtWvz7Nzalz8GwRLzJ9XNwSc1bVr4L8+AEJ8IB3ayHja/LlYuDV3Irq3wtpeokkm/
	TpbzyDr9W9zjWIq06tTXEsl3ITh/cVh5ZO4BOEpJaiMyxEQ0CJG7dIXupahDX4KERm/cb5jFcdZ
	SMf7u4lBYeSHB0aei7Cdlj7w==
X-Received: by 2002:a17:907:9492:b0:b93:94b9:26fe with SMTP id a640c23a62f3a-b9394b98ceamr771288166b.52.1772526509327;
        Tue, 03 Mar 2026 00:28:29 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac70b01sm559271466b.23.2026.03.03.00.28.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2026 00:28:28 -0800 (PST)
Date: Tue, 3 Mar 2026 08:28:28 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Bas van Dijk <bas@dfinity.org>, Eero Kelly <eero.kelly@dfinity.org>,
	Andrew Battat <andrew.battat@dfinity.org>,
	Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/huge_memory: fix a folio_split() race condition
 with folio_try_get()
Message-ID: <20260303082828.x2gypytceqn6pb6x@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260302203159.3208341-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302203159.3208341-1-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Queue-Id: 573EA1EAD57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,dfinity.org:email,linux.dev:email];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-222825-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 03:31:59PM -0500, Zi Yan wrote:
>During a pagecache folio split, the values in the related xarray should not
>be changed from the original folio at xarray split time until all
>after-split folios are well formed and stored in the xarray. Current use
>of xas_try_split() in __split_unmapped_folio() lets some after-split folios
>show up at wrong indices in the xarray. When these misplaced after-split
>folios are unfrozen, before correct folios are stored via __xa_store(), and
>grabbed by folio_try_get(), they are returned to userspace at wrong file
>indices, causing data corruption. More detailed explanation is at the
>bottom.
>
>The reproducer is at: https://github.com/dfinity/thp-madv-remove-test
>It
>1. creates a memfd,
>2. forks,
>3. in the child process, maps the file with large folios (via shmem code
>   path) and reads the mapped file continuously with 16 threads,
>4. in the parent process, uses madvise(MADV_REMOVE) to punch poles in the
>   large folio.
>
>Data corruption can be observed without the fix. Basically, data from a
>wrong page->index is returned.
>
>Fix it by using the original folio in xas_try_split() calls, so that
>folio_try_get() can get the right after-split folios after the original
>folio is unfrozen.
>
>Uniform split, split_huge_page*(), is not affected, since it uses
>xas_split_alloc() and xas_split() only once and stores the original folio
>in the xarray. Change xas_split() used in uniform split branch to use
>the original folio to avoid confusion.
>
>Fixes below points to the commit introduces the code, but folio_split() is
>used in a later commit 7460b470a131f ("mm/truncate: use folio_split() in
>truncate operation").
>
>More details:
>
>For example, a folio f is split non-uniformly into f, f2, f3, f4 like
>below:
>+----------------+---------+----+----+
>|       f        |    f2   | f3 | f4 |
>+----------------+---------+----+----+
>but the xarray would look like below after __split_unmapped_folio() is
>done:
>+----------------+---------+----+----+
>|       f        |    f2   | f3 | f3 |
>+----------------+---------+----+----+
>

Thanks for the detailed explanation, I finally realized it behaves like this.

>After __split_unmapped_folio(), the code changes the xarray and unfreezes
>after-split folios:
>
>1. unfreezes f2, __xa_store(f2)
>2. unfreezes f3, __xa_store(f3)
>3. unfreezes f4, __xa_store(f4), which overwrites the second f3 to f4.
>4. unfreezes f.
>
>Meanwhile, a parallel filemap_get_entry() can read the second f3 from the
>xarray and use folio_try_get() on it at step 2 when f3 is unfrozen. Then,
>f3 is wrongly returned to user.
>
>After the fix, the xarray looks like below after __split_unmapped_folio():
>+----------------+---------+----+----+
>|       f        |    f    | f  | f  |
>+----------------+---------+----+----+
>so that the race window no longer exists.

Since we unfreeze f at last.

>
>Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used) functions for folio_split()")
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>Reported-by: Bas van Dijk <bas@dfinity.org>
>Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
>Tested-by: Lance Yang <lance.yang@linux.dev>
>Cc: <stable@vger.kernel.org>

So thanks for the fix.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

