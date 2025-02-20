Return-Path: <stable+bounces-118528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9F0A3E88B
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 00:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 550067A6274
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 23:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915C92638BC;
	Thu, 20 Feb 2025 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpG9No5o"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF4F2B9AA
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094354; cv=none; b=TDZajQpSwe/GuZBwTBBA3Qt14v61G2lBymr0zoN82GN10BncLafgjSrlM+nJXx/JJ2CRFGjceZrudy8ZpHVFPA0fxBv+7LFy8vtLWEt4gngXQrrnObZMjOBpdeb3E8UiAPp4Fk0PuAeoEJ48f5z3aVl09w1XIjB6rM77vPtQnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094354; c=relaxed/simple;
	bh=WyCQCkZgWtLPS2+4mp3qa+r9YKNbKr4P4U6wtDXmDbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kymh0aG4nldE33LyWHcyOZY6UnVBrgHQtXNSNX1oEnS1nryakp8yo0WSrFqKRfl7n48qypz8+BbyE8vJeTW2pdQnKAYyiUvqcCYO3UeU/inGJEYOdWFoefiAaHC+K79kyH6mjPAzt/4KngTOQyuwM4Wr4NODmtxV74B3lIxL/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpG9No5o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740094351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpXtuTJBxLIXGcIlZvfZ/VOXa5GYRIQZ7uAJoU84fS8=;
	b=UpG9No5oiqLP1vY+tpIA3FfU763HEQkjYyqgvw34YstHEd87XAs73S/rA39wAPTcL+2YSR
	z4u8jkAdbc+sgEbmSvRnIUx3Q0jumQaauUyyABZSeFu/GAAhuuN7p/G//H4DeP+E901KPj
	K1nJDpINWDNFc2kZ6SdzLRwza8cy+q4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-BQLHlUzKPiGJUld7M9oa3Q-1; Thu, 20 Feb 2025 18:32:30 -0500
X-MC-Unique: BQLHlUzKPiGJUld7M9oa3Q-1
X-Mimecast-MFC-AGG-ID: BQLHlUzKPiGJUld7M9oa3Q_1740094350
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c09be677e7so504438785a.0
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 15:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740094350; x=1740699150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpXtuTJBxLIXGcIlZvfZ/VOXa5GYRIQZ7uAJoU84fS8=;
        b=tz4xRa0YwFvDDtjeNQEEfwSytyRPzW3wnnSePqUYfiJJUY8WETj/ospgr776JnYjSt
         3IUJj/UmE/6W2jnv6tAC9H9ej7+q+H0JldXVRW6xigkbnMOtq7HkKZm06iklA/b3Ezv+
         /FovsZE4R4ytCAtrtNBbY6aZBQY4gg7ixSX3elD4RapgS7NkomE+ooOtG45N+zNrxhIy
         tTreVmyLYHI1NXIdkWQmkEyiOVG2pa2XR0LRrp66uNgtJd7n4twCSnefOGBHOaJIdfFa
         Zs+dQmc4yDPgi+Rrz0CzjkmM9b2kmDtY4xdhmndrEMHHt61vIoesMJGh2fQV6RrPH5Oq
         78kg==
X-Forwarded-Encrypted: i=1; AJvYcCV3mSuN6O3epErJPgIn2+v3fp4jaDP88wRsCxLDW57T/woEQcx3mHTYDw1MCB2NnC793A380qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26Rcaz6egu9iAYEp23dkCzI693wC98UznOQb7FkRh6Gg/0A11
	iLVkqY/d+PbEEVr3bBCb70u3sXrliQfTutB3fLDmoBy789yJA1OkJCvcG20GQv6OlRNGKCPKxYY
	5ymfYlYs4l3gkQfGuWGsZM2o/+esvCt30f01ZPI0t8i45UjK+HwZG4A==
X-Gm-Gg: ASbGncsqQx5yMh+H22E2Sgbg4ZvLXGlvnXaK/d/bEXudo40PL3j7XPi23tYO8GM4RfR
	OKL/s83U9+foGPpfmN52k8CZS95o2TmQuH9MKbGsJNqWq+EzLBXp7JnZ32AJDK9qtdAWssoSaUz
	33v0Pt3o750QsBJmuyWCOVeQLPYA+XWLQNYGARpzWG4W0gHdgOxzle03WVjgGprAyFiJOeq9SQi
	zYTiu5RSzET5If9+EuOL5j1Gb1lIJ0j8dHN1eSyJQUbq7yDjTIC2AM9y+E=
X-Received: by 2002:a05:620a:4512:b0:7c0:a272:65a7 with SMTP id af79cd13be357-7c0cf0e2eaamr178562985a.2.1740094349719;
        Thu, 20 Feb 2025 15:32:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFRu2Dnc+2Q7aLVvcud0WLNtdkmcDWf2h64KzsKzPXi5Ef2jfC4H9CsgJUUAwL7iouzkB4kA==
X-Received: by 2002:a05:620a:4512:b0:7c0:a272:65a7 with SMTP id af79cd13be357-7c0cf0e2eaamr178560085a.2.1740094349435;
        Thu, 20 Feb 2025 15:32:29 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09d8d4fb4sm542978785a.55.2025.02.20.15.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 15:32:28 -0800 (PST)
Date: Thu, 20 Feb 2025 18:32:25 -0500
From: Peter Xu <peterx@redhat.com>
To: Barry Song <21cnbao@gmail.com>
Cc: david@redhat.com, Liam.Howlett@oracle.com, aarcange@redhat.com,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	bgeffon@google.com, brauner@kernel.org, hughd@google.com,
	jannh@google.com, kaleshsingh@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lokeshgidra@google.com, mhocko@suse.com, ngeoffray@google.com,
	rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org,
	surenb@google.com, v-songbaohua@oppo.com, viro@zeniv.linux.org.uk,
	willy@infradead.org, zhangpeng362@huawei.com,
	zhengtangquan@oppo.com, yuzhao@google.com, stable@vger.kernel.org
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters
 swapcache
Message-ID: <Z7e7iYNvGweeGsRU@x1.local>
References: <69dbca2b-cf67-4fd8-ba22-7e6211b3e7c4@redhat.com>
 <20250220092101.71966-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220092101.71966-1-21cnbao@gmail.com>

On Thu, Feb 20, 2025 at 10:21:01PM +1300, Barry Song wrote:
> 2. src_anon_vma and its lock – swapcache doesn’t require it（folio is not mapped）

Could you help explain what guarantees the rmap walk not happen on a
swapcache page?

I'm not familiar with this path, though at least I see damon can start a
rmap walk on PageAnon almost with no locking..  some explanations would be
appreciated.

-- 
Peter Xu


