Return-Path: <stable+bounces-249630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB63E0SMDGr0iwUAu9opvQ
	(envelope-from <stable+bounces-249630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:13:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9504582124
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FBDE3045DD3
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047993090E8;
	Tue, 19 May 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fzU10xQg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162F2765F5
	for <stable@vger.kernel.org>; Tue, 19 May 2026 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205333; cv=pass; b=bt6eaj1k3fjBm9xYLTMMCgI5WyiI4h+eL18+doeNFqycGOmxNwE/fIVsVBA1NujKyUOfX3iHZDlEab6ScvWe/p7ar4RT9lljzevCdq8pwqD0XVAevmrmikVWgjNEr2CBDv4ALfMl+eEkcTGsIM3Crv2EPyioPfuxPzzWXyo6ZHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205333; c=relaxed/simple;
	bh=IGhdNMGmhqiwDqIsGMKMjYg4siHGnTWYXEgLbA3AK5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvyWm9OGWy3GF1FqnkCZnjWsnBfYf+7Zw386bc8QoiR2ctl3A/ChzCaq2aT3CarEk3o85jZvhApUUCH6hH2C/JzEkO8DS1YUrcknxjhu7DuoAEnz+Ur3e1J5qYsSkr0mMqPEpmqrLrRl6ZufTAFtrwvMJhagnYKxbL7w6fmwmdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fzU10xQg; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e5c7eb565so43919441cf.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 08:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779205331; cv=none;
        d=google.com; s=arc-20240605;
        b=jq34+twIaXOxDP7wN0sJM9J69QhUE6u2TBE2R8aikS9h+0jsOREw8Zkl0oeAOM+3rW
         pP3Lobtnzs+qIY7PN24TcGfGW7qUrcz9rfrxD38F1NrXsz5y4/rFFTrgbuNBZarPapTq
         oqYYNuL0uNmkAY/05MPJPEDL+dC/BCn5Y8YqgzBnZGiMpq3Bh+1rkOjqBq22/uHr0clI
         kx3rnp3alzqixOhnmuHsJ9PI40YpuGcAdxI8wGl0hIoxJE6fjsp5PxKbThyQZVxIGdBS
         CbZgz2ZtNO7lODLxfCr3n7utvnNRH+zcc+MAA24JjCAZVNqKfbtSWMz+1zqUgXWdKo4e
         BW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0DthtS1U1pZ4Fbe0dWrF5fFOKxVek98WD7TwcKkU6hc=;
        fh=qugFPmDUbl3Rikvuj6e4s9sL6AxxHqRXhCyBeuz0AY8=;
        b=LJoSsJ1Qhb9PNDcu5lcdSj+FZ9mljn4F6hBHasZKABCbDsDgnHqjuC5Zb4MrV9SmWm
         K6iMpii3U++9hG3YWxFAHQLLvrZ2/ACp27iIBacKSJe1wBdM94NPvWzWxYKwPlYzOCCc
         KraOj4QRfKOHmvlm0cgRo7Kkf++tKgMl8VWC/Z5EbDNznDZSzdDv69YEbxol0CVoUgSC
         UVng9OYDvMyAZLdBo1YW+As+EHkCEvZLPK89hihDfhN+LwiQ0HTJ4bgxhET3LHpQsngT
         ICx5123Hcu8Lx0HmTLMU9yu6rdrzBt5LN3JG5ZWs7XJkvgsmP/sIOm6cvs90QjY+TEBa
         8b6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779205331; x=1779810131; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0DthtS1U1pZ4Fbe0dWrF5fFOKxVek98WD7TwcKkU6hc=;
        b=fzU10xQg5bzlmWQx8Q3C9G4eXRlo3UQV+1Aa+Y6CPaQr8YmNSYATd5UMS5EbnpC7mr
         aDHixamBc8Xs7lTZxUfdraBiNH6WdQ4PW0hKsoBJ1O28d/1BYbRPlgUZj+YgIUYlhYEl
         vPkNpvO0htxj0FeXSFDvMDYaecYTwaxXqzTpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205331; x=1779810131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DthtS1U1pZ4Fbe0dWrF5fFOKxVek98WD7TwcKkU6hc=;
        b=MvXWlvsKUBc0erAI3qdckmFi2Ct/Q3qMc47kzy2SaJHcw/zfgzTJ+UGOpQlw1drjhW
         6FXyPd915yGYYtuuWvg6ZKJxDNPijcWLa30qj7pE1u+F7pKqajnZQz0tNNqM0NLyd4WW
         DaAD/hbxj57tjNPJzaMmADMB4aWo5NdRswcayRyVUU30SPTY6qeJChiE8+DQzAm0uzIo
         0Ba0CItdaOCS5A6llhRSmno6kJ+s93iR5xQd4jVi29cVF6iVsx5dIm2Tixnd489NR8G9
         mYOP3YBSw7K2D3bHzc6xWAMPr4vHhxgN38l5ukxydV4zvILyxnjYTRFoujl3QnMoH4+J
         DgGg==
X-Forwarded-Encrypted: i=1; AFNElJ/kxRc6tu5TJXJ4jIqrK4ZqWleqvq04KyooZp98SoIi3ReI0z4ysesgAu5ykx3LVH8IfHDaNtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8NColihRDMRz3oO7tXiBWQX2to33H1JqA+MA6AkOQ7r+hajga
	bDAvuxw/tW5GrW96IAfZmmRqtwPkAzMgYLWkMR2us0btRaO2+27GVinMpe5D2q1YxehBGNIirQP
	RbrC95Au1rDg5gq+wpv6a3gZpTpmgsWCYSrl86E6DLQ==
X-Gm-Gg: Acq92OEk/5h6p9odiVBDTR6M5Ie8Kckn6AbJ8XtqFCWJLBID/Osk7/fsrQ68c+OIIiv
	0a7xFG4R4XKd+uFJ0RWlBFCy0Ie2gCIfo+7zA9XcYxY6Pu6zoD4n6UYhwac0X8CS9CVtVNv2Xpq
	GFZeABO46Oq/XeYEZ3o+dPo9v8uu7v/c4KyQCVv59ptPDn/CoFkT78TOWflxz6cT93VWHrMHbWg
	hEgAjsWVp3F6FIwJiA82jdg2b6upAxR/JsDej67J1hXiuOZwq0WR4a1naW/UwVl2ze0i4LKXUnX
	b7+QZO0DVfgJheMlVQ8VIIcXoAJw+LVqMWmcbc8=
X-Received: by 2002:a05:622a:2614:b0:50f:135d:9508 with SMTP id
 d75a77b69052e-5165a30cc40mr246584771cf.55.1779205331232; Tue, 19 May 2026
 08:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519004746.3203156-1-mochs@nvidia.com> <CAJfpegsTsKqq+QQKyBexQFP1=EGd8YiMT=rbaCOPeTBvLsY_JQ@mail.gmail.com>
 <F3BA075C-8E63-4077-B701-63269703155E@nvidia.com>
In-Reply-To: <F3BA075C-8E63-4077-B701-63269703155E@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 May 2026 17:41:59 +0200
X-Gm-Features: AVHnY4KcsTJrIRXcU7-IPyEiVnSNZcnyE9sN6B_1CphQIDbfkZs7nyMEQjPcuJw
Message-ID: <CAJfpegsJ+ZQW_WteMypErq31hggYsMMkBOPd0o+vifhAS6dPvQ@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: back uncached readdir buffers with pages
To: Matt Ochs <mochs@nvidia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249630-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,szeredi.hu:dkim,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A9504582124
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 at 17:34, Matt Ochs <mochs@nvidia.com> wrote:

> With out_pages but without the byte-size cap, fuse_simple_request()
> still returned -ENOMEM. Capping the request to 1048576 bytes / 16 pages
> made the same test pass.

Can you tell why is it failing now?

> I can rework the commit message to make that distinction clear.

Please remove the request size cap from this patch.   We need to
discuss fixing that properly: limiting by max_write, while might seem
to make the failure go away,  is conceptually wrong.

Thanks,
Miklos

