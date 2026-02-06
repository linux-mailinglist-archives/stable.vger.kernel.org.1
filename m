Return-Path: <stable+bounces-214698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kICSG0cxhmmtKQQAu9opvQ
	(envelope-from <stable+bounces-214698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 19:21:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DAA101BA8
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 19:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A7D9300BDB3
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 18:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF893358B9;
	Fri,  6 Feb 2026 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltciiJGJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B902D7DF2
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770402108; cv=pass; b=KnkNg5DYWy5wTpbkvSnvUcR1YsvOPDE0LbjqZYcMdmQQldj3susUekkjpRGsq4xrcj+f/CLVtXtSEdTPg5kyQE/sVNvfDwx4sLe8lZomn54sCAfqdysBE1DZaq88JhWZLlp8x0r4UAenPDyWY8pcX9DHgRQqeeq3G5v142EUq7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770402108; c=relaxed/simple;
	bh=P1xMJV1RX8usJkOhUgCSFWhXH1p1NkF7tpRo8hVA3gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqL6cI6q36OxfQ6HV9ZnaLIGVShc57zLmbiVBQI0W0O4oqiOdjLr6VwEprFzBvn92lWTnoCxqNzxqtpakH+yz7elBSaeBi7L+R3EBGaTstGWNNvjUMHez4DtWxm0Qlpgm2Ktg7N2z7o0ZjLxuU8cwdjVgcaZqUIlAhcFoQNHNlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltciiJGJ; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d1866473b0so1283091a34.1
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 10:21:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770402107; cv=none;
        d=google.com; s=arc-20240605;
        b=h+6hDL8IwqABXoyn+YyYhsFqAnP0QYB8Jwk0vc+ridDVg2ryVNIkzPHrdslFhVv7qC
         68rgWWypmnpK2YJvpKQvMavkCxlfvfar+nkswUQm61P0Gzlk8QRc38DbGA1mZqAFQ7mA
         xqB3zk3Z0WFahXGoVtGO2tEuQ429QswwPXaTquvBlLg0q2lwwTcuIXskWWgsSsQs7kho
         /9qqXo4eIuy/2EkSJKAk/AHXb3LR/EFzRY2mBYkTnngyMmX2XXh2T9x1fCB1iQckIm3y
         VkXlk3LM0xbB5f5yQF1GwfK7nNQZz8awfF96xCV1jy5H7ErkOLu6TCKi0St7sQ4TF1Ob
         DNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P1xMJV1RX8usJkOhUgCSFWhXH1p1NkF7tpRo8hVA3gw=;
        fh=px0ChSl/oWFL6bKdDoB4sro7y9g8Un7CWv18acc4Tb4=;
        b=KVl+gB2klo+oqG+2zPo0/XT84HGjOrhVvBC/4pLL2Xr4rtqeLo3TqLtlkk5bnM9CVt
         /cbnAc3HRht2IUebDzW13iI35Vyy82tmQd5c1AbBSA+25MhtwqQWMfhw7pWfDV2uAjzb
         d1cluZOEG2M5LDSfESGWga1BqUm0jReI1yhIAgG0y1Y0wwYsAH157Yjm77mc+43s/M3w
         q6Rd4kd3BhmuHvQFR4R10GnPTwTwxNQ9dOxpjq1kjUepuJxQcEFGT+hpfIAVEkyLER+p
         U9EC1n9Qkt4Tk85DglyKHTPgyyDMAzUY0HTj6gIKewtN5+MArwaxdw3AzFRKN6rIUK+a
         Dkxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770402107; x=1771006907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1xMJV1RX8usJkOhUgCSFWhXH1p1NkF7tpRo8hVA3gw=;
        b=ltciiJGJs270wH9NUqwVmI6C84+p3u7aD6qXdCxnpb4cfxqwVicdPuMmfd6S97arDT
         Wrgt48jrCT+nr+c0eklSmokXdSheYYIZFqCqeSKTK60IZv8vCiP/UI0LXS9BVupcZHkZ
         eTtG7GHKlj5Z1Acaw7vmcW0DKmQYNcZ/EHtDYRpxQx3x0j4nF99Ro0CLea9Hhdh9tnu0
         3yTJkFp9CIRA25tPnYsM2D5wrgkmyWYima753ruzAn7TSEwdKAHdO0L/Nvr1ar72+lwq
         qfB6cR1EQkJFOtKXn0D1BA+gFh2dSoAskkP2g3gCSMIXhswoY2w4DFz2prfzn72/Ybwn
         4r/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770402107; x=1771006907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P1xMJV1RX8usJkOhUgCSFWhXH1p1NkF7tpRo8hVA3gw=;
        b=nMLtcwDAOvw2BFlRB74mibRZ7CtbDRUU7swxN55jCXShNWC81TGdQP6QRB2MtWEr2B
         uYPZMqsGpyeFg7TnXJ7J5i1LJX6EstPoXdh4tqhvr+apkvJZHBaG4kDAgXmAFfIDSrAd
         p7FYzaAHZA5y/MmTlhYpDbvGIW9Qr/gpkcwtzvlfsZdgXwg5Yq22leqZk2+coteS6KUB
         maLc5WhUdG5cUhYwRY8WM2qyaG35Jo8GmxhaypuR/xGha/h2WxbxeRw9X+1wmGXw1K5m
         VsyZC/mZ+aS2LXyISXY9GjD8gND6tcridaF0v/+WQ7wg0wOT1KVC37CFQf/f8WwkVmqc
         0sjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOa1Hhx6ZzgpTzt3IeRucHAT1sTbzEfvMJdWgXXShOCZk6ecXqEcd3484xCtqamg17fdh7vlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw539fBWHlB2toyhcDTaqme+6a9vRo+bGAq5ThucmKec7UijG7g
	OwMh+5Ir8USLinMbFIlDhyWuv5iEux+8KlN9cYQTncWOrkBlRsYJTwuSsqIrCwsMCLrNETMtiBH
	Aej93c6mqL8VouiDxn3wa3cNdvItC+PY=
X-Gm-Gg: AZuq6aJqaubKrtLfPBhqDUTCorXAO7FXYTjSowtqZo5IziufLDxKgOSHVKt/GDYnHZV
	FbunfY4xsyh6YM1p5o914dADgF9/rbpMCs+xgq6Q59NU9INJnqBaM0U2vh2gdufREY2ON6EYWuV
	5wnOnyvaocjGZN7ym7kaPNDjgjVZJXfnXk6t5s6LvTcZXI35Ujn1xQfL7efxbv7r1fsFP79CV5v
	7v0xeHdPXSbR4CL/5G6Ip5ju4w2l5GKW5noAJndd/O3zzbdXIYaZ3GqhQ0Q2UQHWs2860fCxQ==
X-Received: by 2002:a05:6830:3c88:b0:7cf:ddb7:8823 with SMTP id
 46e09a7af769-7d4643f2cacmr2508175a34.11.1770402106721; Fri, 06 Feb 2026
 10:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCs03XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ3PwP0mGXA@mail.gmail.com>
 <20260206174017.128673-1-mikhail.v.gavrilov@gmail.com> <3BB6BA1D-3756-4FC6-B00D-79DF49D75C51@nvidia.com>
In-Reply-To: <3BB6BA1D-3756-4FC6-B00D-79DF49D75C51@nvidia.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 6 Feb 2026 23:21:34 +0500
X-Gm-Features: AZwV_Qgne92Nuw9ugbsrMJv72AiexOG9tkvmf158F-E6lOhbaFGhB4UAL2p1RZM
Message-ID: <CABXGCsOMzrQTsByYraNby_MXnTuYBNt2vbWu65KCGX6bmi11iQ@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: clear page->private in split_page() for
 tail pages
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz, 
	chrisl@kernel.org, kasong@tencent.com, hughd@google.com, ryncsn@gmail.com, 
	stable@vger.kernel.org, David Hildenbrand <david@kernel.org>, surenb@google.com, 
	Matthew Wilcox <willy@infradead.org>, mhocko@suse.com, hannes@cmpxchg.org, 
	jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214698-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,suse.cz,kernel.org,tencent.com,google.com,gmail.com,vger.kernel.org,infradead.org,suse.com,cmpxchg.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C5DAA101BA8
X-Rspamd-Action: no action

Hi, Yan

On Fri, Feb 6, 2026 at 11:08=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> Do you have a reproducer for this issue?

Yes, I have a stress test that reliably reproduces the crash.
It cycles swapon/swapoff on 8GB zram under memory pressure:
https://gist.github.com/NTMan/4ed363793ebd36bd702a39283f06cee1

> Last time I checked page->private usage, I find users clears ->private be=
fore free a page.
> I wonder which one I was missing.

The issue is not about freeing - it's about allocation.
When buddy allocator merges/splits pages, it uses page->private to store or=
der.
When a high-order page is later allocated and split via split_page(),
tail pages still have their old page->private values.
The path is:
1. Page freed =E2=86=92 free_pages_prepare() does NOT clear page->private
2. Page goes to buddy allocator =E2=86=92 buddy uses page->private for orde=
r
3. Page allocated as high-order =E2=86=92 post_alloc_hook() only clears hea=
d
page's private
4. split_page() called =E2=86=92 tail pages keep stale page->private

> Clearing ->private in split_page() looks like a hack instead of a fix.

I discussed this with Kairui Song earlier in the thread. We considered:

1. Fix in post_alloc_hook() - would need to clear all pages, not just head
2. Fix in swapfile.c - doesn't work because stale value could
accidentally equal SWP_CONTINUED
3. Fix in split_page() - ensures pages are properly initialized for
independent use

The comment in vmalloc.c says split pages should be usable
independently ("some use page->mapping, page->lru, etc."), so
split_page() initializing the pages seems appropriate.

But I agree post_alloc_hook() might be a cleaner place. Would you
prefer a patch there instead?

--=20
Best Regards,
Mike Gavrilov.

