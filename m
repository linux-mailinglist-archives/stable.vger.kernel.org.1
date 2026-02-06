Return-Path: <stable+bounces-214699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHdeL+A2hmmHLAQAu9opvQ
	(envelope-from <stable+bounces-214699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 19:45:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCB410232B
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 19:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCF743036127
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 18:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A0444B698;
	Fri,  6 Feb 2026 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krte11WO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA944B695
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770402323; cv=pass; b=d5D/l0AA3TbXlZ9XYPZxqDLpq8DbVOaum+FQXSN/cqMlHh/RdMkqhkVojJoCGbIpwjWywi7SfAf4viyuVaKc46E+sFhiCRvt7GbxilP2tYbFzqgYnb1vaCrTcqQu7F6POUhdm9826UBm85FkKNTc1+1tHxI6z+58Vq2/mTdtKKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770402323; c=relaxed/simple;
	bh=BdnMiZ5cC/+cpP7NJPnxAZV1j/p6+4QF4w+4P2BOE04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPQ/fvFC6jRTz7KUM6pyCzONH6QvoNKyP0DfaKf1MvheRKOQymQ17mQrUZGy/CwitEdG8KzJslcHZkqS5+l5aZ1GHbGwEXyEwSQKQKmK4PUi4vun50Bz+MEINdWRZ05itw+GGfOIacRAmx5rGhPOfWL0UnW8AKpOGISi5dpb6N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krte11WO; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8842e5a2a1so369850066b.2
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 10:25:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770402322; cv=none;
        d=google.com; s=arc-20240605;
        b=iHPe3d3kYSvIAC5j4ZY2Q/3tgfVbEGwoGXQLWuWEvGp2Nx245r4gqHqc11BIy94Eo2
         3Bb40c+s35Hi+vat6cu1jbt29ihklBadYVItLaMTysZIuN0K412qLfP5u/KfC4fYWUg0
         inBy8Z3nPhhPTtf/Qn8ZPqiilce8360A6440KjfiLCzTFzCPO85CT18l9cpJ0a8cLMqS
         TEd70X8AfPreSSysGc/ipJuF0YA8cDEfvRb+mcWZrTb/1qdaKzFxGY3HYJnX7XsZzNeJ
         +vVDMKLG9ZT9xaSVAu9QUPfVht0663fVW256urBvgXBl9d2g/hNVe11k5JGMWhdfWqZm
         DyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BdnMiZ5cC/+cpP7NJPnxAZV1j/p6+4QF4w+4P2BOE04=;
        fh=LsoD4DU4Hddla32es257bAhYfEhmapCCigIHjDB8fMw=;
        b=RPUXZ+l4cPewJleMi8+ZwsGDnIbN3nKpDf/j7X02yMquHJllXLw68cbL3ySkfMgMzo
         ufASLop7cyx5xDc3P/PwOPQYrV9MZo6p1oVxrxq+GwD2Z/tbqoRCg/OKkE7mdAGBi3ci
         jGp6Zh0LOtxAcpEuLGdK7tmTym0iY6P7svsK9QDOMROHx0VLTzbJpxTsRFeCMj4ho96+
         tsap4tc7+AbDF174A3TSEthnX0D8FP6URJ3TK4qea0hVHU+3xKK/IwFjIssaxnfn+246
         czATqMRsd/KPP3x+j6r78VRHKAOTY2L80AjORKK3Y9CsPum2gyCfTANMvFk+LY0TmN78
         Wc5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770402322; x=1771007122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdnMiZ5cC/+cpP7NJPnxAZV1j/p6+4QF4w+4P2BOE04=;
        b=krte11WO7wp9GYXhT6sc751i+tAYHW0hR4lzx+b26l0S0Abon3dxQqI6su+IagVvXz
         31INLoNIZvuqJH0GoQNMDWywcN3cXuT7GJiYqyZL+dRBOFrllByDHwC7d/sTzH9S3yFw
         mY/7DqGhVVf9W7hTPB4MbFPbVe0OZJ3u/hxdaKfeLan/MkU2wDw8RgFSKaqeOl3bbFK4
         0lDkgFZJZ62Btajfz90aNnnUSVWPT1Gd8V4a3Hn8QZ1+Mp4Fvaa5a23PVU9Mgtg3clk4
         ZW1KR1BctRNDuJBxs+z/PAo95jxh0UFkQ66G5Oi+CKknVxcD7iQPTVxsDSbg4Wjjnlsj
         KLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770402322; x=1771007122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BdnMiZ5cC/+cpP7NJPnxAZV1j/p6+4QF4w+4P2BOE04=;
        b=wPUul261kBGDZixuctLAfFxGrRcDv7FmesObQ4VZVUtpK18e6Mz4aQFpXuEFp7aZ2L
         zAPMtVNhYAecpxelEBdgllDxUU5ZgzG56S6aOOHOTrzYISoyMkBuh6ZN2b14eOciX3cd
         U5bICIB2C3rxS0GNnp/Y39j5wtpeYOwKSaZ4DEu8ctRuM0X87iFQZHrbgSgmy/M6Qvr6
         iRikTIcOTUx+dCza7cLtpylWTCjiDTbh4HwP9kmsPq1fmuuDi6vCcxv4WZZqE1QqMUhF
         Eq4u5smLp4jc3NFCXUcN4bFvPc+1JZAJkCBTlzWJKf8IHdhQDxA2XIeqSzQmcZjkq+38
         rVPg==
X-Forwarded-Encrypted: i=1; AJvYcCWJv6lsAp4EauiAUWMPopsFCM0PPJ+6SJrUNBh3mYOX9zg10nZxK+MTuOQhBO14qdoqd256+gI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy78v8uYb2NYWsD9MC87/t655RQ+spIbOjhTLUIBNNDTMx72U/4
	aH80c7CQBGRRfuHhRQaTGnc8gFdevK2P4FShW2Ehy/PMvT6EjkfKntuNDZ9Nr8HN8rjST5DCMfe
	iJiWrP98pHqnpF4rbWBxl1TAMH5JFMQ03LGw60BqQaA==
X-Gm-Gg: AZuq6aJaTIOXd2k8O+cTbg2pFMAUXR3dsNk1cRbrOnAYDSDe0t8ihBqexHj3dP1dtFk
	a7ty5E/jAtvq2NYpWbg650eb6mKXqDwu5L5xExBPNoK3AjAFAgjK2wZzXJKicL8ArLXyZ4YpA9m
	wUnPz7oHXCimdrN9KIy+YgmBYj4oC5KTy8Jb+26AShsKq68B5ppMGV4iB1el+fZyvbNubxw4qoi
	lVPF6AUWpr7sJIxQIQADIShsMTD83cEJMB3qwAdqNZyFo6YsmwrI97+jFEhLhwFOImU4v5aAD7V
	AKEsGbK8/3VCLesVuX7PN5vF3RqT
X-Received: by 2002:a17:906:4785:b0:b8e:9d66:f5fb with SMTP id
 a640c23a62f3a-b8eded5bf07mr212607366b.0.1770402321350; Fri, 06 Feb 2026
 10:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCs03XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ3PwP0mGXA@mail.gmail.com>
 <20260206174017.128673-1-mikhail.v.gavrilov@gmail.com> <3BB6BA1D-3756-4FC6-B00D-79DF49D75C51@nvidia.com>
In-Reply-To: <3BB6BA1D-3756-4FC6-B00D-79DF49D75C51@nvidia.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 7 Feb 2026 02:24:45 +0800
X-Gm-Features: AZwV_Qj9ArkpXSETCK1paJ36vy4F_CRQBBxAfzS6Lq5DExmenMFaALVelzse_U8
Message-ID: <CAMgjq7CMBXrPKHC0Ni-76C=Cep1emQ71mMjhoAZ1BrkahWzLwA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: clear page->private in split_page() for
 tail pages
To: Zi Yan <ziy@nvidia.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, vbabka@suse.cz, chrisl@kernel.org, 
	hughd@google.com, stable@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, surenb@google.com, Matthew Wilcox <willy@infradead.org>, 
	mhocko@suse.com, hannes@cmpxchg.org, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214699-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,linux-foundation.org,suse.cz,kernel.org,google.com,vger.kernel.org,infradead.org,suse.com,cmpxchg.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: EDCB410232B
X-Rspamd-Action: no action

On Sat, Feb 7, 2026 at 2:08=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> +willy, david, and others included in Andrew=E2=80=99s mm-commit email.
>
> On 6 Feb 2026, at 12:40, Mikhail Gavrilov wrote:
>
> > When vmalloc allocates high-order pages and splits them via split_page(=
),
> > tail pages may retain stale page->private values from previous use by t=
he
> > buddy allocator.
>
> Do you have a reproducer for this issue? Last time I checked page->privat=
e

This patch is from previous discussion:
https://lore.kernel.org/linux-mm/CABXGCsO3XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ=
3PwP0mGXA@mail.gmail.com/

> usage, I find users clears ->private before free a page. I wonder which o=
ne
> I was missing. The comment above page_private() does say ->private can
> be used on tail pages. If pages are freed with non-zero private in
> tail pages, we need to either correct the violating user or clear
> all pages ->private in post_alloc_hook() in addition to the head one.
> Clearing ->private in split_page() looks like a hack instead of a fix.

It looks odd to me too. That bug starts with vmalloc dropping
__GFP_COMP in commit 3b8000ae185c, because with __GFP_COMP, the
allocator does clean the ->private of tail pages on allocation with
prep_compound_page. Without __GFP_COMP, these ->private fields are
left as it is.

