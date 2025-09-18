Return-Path: <stable+bounces-180559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 187CDB85F1E
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 18:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43224A522A
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387FE30EF86;
	Thu, 18 Sep 2025 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUbAwwh6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869DA21B905
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212387; cv=none; b=UEh27FgpbgGOIV2Ka1AvknBjYeqvkQEqrLHMOfwVDY8DrSLhEAVPE+Ey21QCmnZmgsbXuj06OaJzB2je8TFd10R2yyQmfYSpBjP9Eo32lxUd5OeIXTiCtrS1eTrzCsBVVzWZnaAdOY94ih2gWcojl6rrZQfi/oyvmDEqQFAMMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212387; c=relaxed/simple;
	bh=EFWvOc5eU4ofeSkKNZEI5Kq6UjweP2qNOUO50xD8gVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfXMD9QbtXm1TzsBXvCWp6WDTdMe2Y74ql08QTHlU11b0pPZori+pFVtK0AHfW2V8ZpXeLRMfaO5a9bPSd+TPQMyRQWi1poTqtcbF2nyiBKBFKp7TXoNRqwXfJeD7SD9dbwgwEnssh0Q42ggORoDLBscCX1ueDusuSJHlx2YWjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUbAwwh6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758212384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kcQaTjAvvBmm7x2rEgbh3SMOE0LbLZC8F5+37ZuTXtw=;
	b=gUbAwwh6OohneQMIHIJp6pNk3GrPSKuuCRA7jBBKmG99RgEzhYRjbs4sIu8z2hFgL4AlXD
	okAjClWG0Gv61G5CE5m24930//4m6lHl3bmTZBZiITz4Wq+4ARybOBZ3lf1MmoG4bsliMO
	y/rF6LORQRRxDvuTjQZVtHTQ+d1aNL8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-Dh94rcwlO82KYbGoOV0YeA-1; Thu, 18 Sep 2025 12:19:42 -0400
X-MC-Unique: Dh94rcwlO82KYbGoOV0YeA-1
X-Mimecast-MFC-AGG-ID: Dh94rcwlO82KYbGoOV0YeA_1758212380
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3df19a545c2so682310f8f.3
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 09:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212380; x=1758817180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcQaTjAvvBmm7x2rEgbh3SMOE0LbLZC8F5+37ZuTXtw=;
        b=sTMsUFZoov+F3tZPmr5/nhiqOMfUQZ4m/8GQF1uAfCb4k9QtWVh89dlO8zLvexcWeT
         pFtGnzDBG1S4sPAVXUoczRQRJgUsjXn2eiDW64rfT9P0bLdcQyvJuNneQ5j4XewwJXnQ
         hxkS4IgCO96IVxR1Sk4/DD0zWgVKDKKKEcumPd0uU+q5SNPj8N90OY1+HiSECqgUyRYw
         2sKfqAmDEUrxErbioIQBNXEwfO8FcoNY+JeFcZ2nAqk7A0CGZTxQypHGHnBSTkDPhUdv
         VO3JyXfxmgXTXOoYAeDbTCtHT9PqnvGyw0kvwKeuYZB9dgvPURiwnFjilFafrDtXDMrU
         k6tQ==
X-Gm-Message-State: AOJu0YxgtixBfWuJW3+RlwdmWJr/kl6GitniAnZe9OAMndx5Cpn8DoR1
	jn4MnxYxBVeT0zr68CoTxZCcCYwJ1Qu2KbIHK+BH8yEorAEOsqDVhkTtZ7coDzgJD2qAV0u+p0U
	EyKpk8VlJRXp8JGJ33/f5UOIRUIRlLTWcHWrY7UQdCJHnsawwwcWkHjkq8tkHPalNZA==
X-Gm-Gg: ASbGnctzXh9wzLzOLwFg4aK2BcsYHYmM/Z2i+IQqWUSC5dLIWpgC6d/OXWa9v8Yz87B
	oNmtUaAX3TXa+N9ksja78Wyha7s2M5L+o46aZ+E2Z6Wp1hoKEn0vzVyk6eztyN7qXLsz9391u8K
	rHAOg+u0V8dUxesvDpucRQ4+NZPUkHzKToJoLDAEXMy45XmaRd0A5l4i8zNZD03LMSnWHCYsVhQ
	5X8fi58T9RbfSg7ksN6xC9v3hsroc0h6zU3sim40A4Hih8w3zCfBoVICc8MbfZOmn1Bh04wJMH3
	hilfoEtaudBPMvasXNoG5i1ZOpjRqJOQpHU=
X-Received: by 2002:a5d:5f45:0:b0:3ee:1461:165f with SMTP id ffacd0b85a97d-3ee146119demr1602977f8f.31.1758212379962;
        Thu, 18 Sep 2025 09:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3PnU0tA1p+umFkE5BXiLm4CDiDfRh2pQLB+Ug4+MdhzoDSNOstwjT9AY/VoIif+xcobxEvA==
X-Received: by 2002:a5d:5f45:0:b0:3ee:1461:165f with SMTP id ffacd0b85a97d-3ee146119demr1602954f8f.31.1758212379509;
        Thu, 18 Sep 2025 09:19:39 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e754140sm86493805e9.21.2025.09.18.09.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:19:39 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:19:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: stable@vger.kernel.org,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Daniel Verkamp <dverkamp@chromium.org>, Amit Shah <amit@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
Message-ID: <20250918121858-mutt-send-email-mst@kernel.org>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
 <5a9aa16aafbcd8235a70f25249b94de6a897fc14.camel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a9aa16aafbcd8235a70f25249b94de6a897fc14.camel@gmail.com>

On Thu, Sep 18, 2025 at 05:58:55PM +0200, Filip Hejsek wrote:
> On Thu, 2025-09-18 at 01:13 +0200, Filip Hejsek wrote:
> > Hi,
> > 
> > I would like to request backporting 5326ab737a47 ("virtio_console: fix
> > order of fields cols and rows") to all LTS kernels.
> > 
> > I'm working on QEMU patches that add virtio console size support.
> > Without the fix, rows and columns will be swapped.
> > 
> > As far as I know, there are no device implementations that use the
> > wrong order and would by broken by the fix.
> > 
> > Note: A previous version [1] of the patch contained "Cc: stable" and
> > "Fixes:" tags, but they seem to have been accidentally left out from
> > the final version.
> > 
> > [1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ibm.com/
> > 
> > Thanks,
> > Filip Hejsek
> 
> Sorry, that patch might actually end up being reverted, so please wait
> until this clears up. We are still debating whether the Linux
> implementation or the spec should be changed.
> 
> Best regards,
> Filip Hejsek


OK I sent a spec patch to make it match Linux. Let's see what is
happening.

-- 
MST


