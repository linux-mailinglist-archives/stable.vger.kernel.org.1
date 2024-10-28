Return-Path: <stable+bounces-88259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461BF9B231B
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 03:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060A52818A4
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 02:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7415B54C;
	Mon, 28 Oct 2024 02:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeSMS0UA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8B02C697
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730083681; cv=none; b=bcU+Fzf8ERBabcmSf/6JMgV0DAOTmboZG5jvXQiDRgMIXZZ+YGiQzIEuH0dV1dqQtzIwJeOhtW34EC7tNnzKLw2oQLnqgGxP3Znne1FhC0wLqGYnuNB8K9KWy80HZFHWDEkkqO5wOH2GRd/0jy0rKdiA5Gu1mSAaye1BgWSjp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730083681; c=relaxed/simple;
	bh=qTIoHv5eUAvFOvAv9kQlKA1yfTJ92EPInupbVJRFQxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/xeT8yj+z42w2iqYiKZ2LJGX/UisxeQRuj+RY8CX/nuP115CkSd5d8VE+r5tNAM3ITQdpR4GpDNCkLGjG3kR2fwBl/AkgTQ4I6ftpdCEFMkXnDPR//KziY0iveuHaJuIn0bDDNuObz+Fnj7PUYGTlrPbecTm3Gz0ERZib+9oKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeSMS0UA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aa086b077so471014266b.0
        for <stable@vger.kernel.org>; Sun, 27 Oct 2024 19:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730083677; x=1730688477; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IHc5w1UyhVRJnRjGZPqOL75Dby7lM4tAlHnRtwB4D4=;
        b=QeSMS0UAX1ZXBTHwtVsxh+++qZbajaME42jv4cwB2Y7qZVhX4SCpuQSXLu19EJkXKJ
         Eb5wn16dedW6oSKCxWiLEVJC8XfggUmFhZp3cssiW8iR2jzkF1KWXAhAJxbRZbyTfYiJ
         mxQEokcMlC9s/Tv/6eTiwNyboNSmiJLZG7b3dZ8cYNxNBO4CZ5aRkF/zax/uPJOZQSfr
         EfiOBPd69dwGzjY3IK8DPCe9wcYv8cBm1rkPij9BxRa1lS5slLNgkGf7TtWcjyMB57Mf
         yDnC0WgixZ1BPds9L4ZXYn0IqU6/QvrDUc0X6hSvy1dF4kN1JZfR1z0SJ10OfkxFvtm4
         GemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730083677; x=1730688477;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/IHc5w1UyhVRJnRjGZPqOL75Dby7lM4tAlHnRtwB4D4=;
        b=XY2RhAqSo2qPX7mn/ZUenfaZ+0wxGr/Iu4nzeiuspXuvZOd+0qyPb+PYaQ+w0aP0pj
         DjM4cNaKQnO1Djl+QScB8Zz3cV10rGA8Y/gZoZT7r9KNBZK6eEofCzpq5R/Fh1bbr3oc
         WvQxR6KXWunYiHkzyLtWWB/nxM0uId4y/X6DN3/Z7WOUtGMjm3DVHblY5DRJROsO+mpl
         lEk9VYqDCiiWMThKVoGG8xnOpGNGbAl8Mo4AAVe1650RsJqmJ68k6lvtWQnqvBouXh9W
         lNoO9vQIYqFdiMMjTNHf5tKrQoFj6gSxkbnzHd5Bjd1ty2DgSqBWCI1cxfZS58FbHj5I
         C5eg==
X-Forwarded-Encrypted: i=1; AJvYcCUQUpogLdHVv029xHVtdcnlpgyaisXANkRc1oITxt37X/xp7jjDXah7yNFr5sNvzHS1SpX5Sjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzg0OfjYY9VL9Kx9PFvPOXXecMKtLYBtnXZiJsZYIEijPSDXT8
	ZeC4mwBBStleA/gY+bA1t1JTQ9676AA2XiZK2bJoH4N8uNetm8t8
X-Google-Smtp-Source: AGHT+IGOEvzSI1JPj11nwnADDIynGv3TJKAgVsP3a+SvqU1QnwUGUy4Oi2gld9G0oLks46PxWlMvKw==
X-Received: by 2002:a17:907:72d1:b0:a99:65c6:7f34 with SMTP id a640c23a62f3a-a9de5c91b63mr593435566b.7.1730083676928;
        Sun, 27 Oct 2024 19:47:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f58991sm328091966b.159.2024.10.27.19.47.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Oct 2024 19:47:55 -0700 (PDT)
Date: Mon, 28 Oct 2024 02:47:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	Jann Horn <jannh@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH hotfix 6.12 v2] mm/mlock: set the correct prev on failure
Message-ID: <20241028024753.yqteimzthoj2rmmi@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20241027123321.19511-1-richard.weiyang@gmail.com>
 <20241027175347.af0faeac9fdfc2fc8ae051e9@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027175347.af0faeac9fdfc2fc8ae051e9@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sun, Oct 27, 2024 at 05:53:47PM -0700, Andrew Morton wrote:
>On Sun, 27 Oct 2024 12:33:21 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> After commit 94d7d9233951 ("mm: abstract the vma_merge()/split_vma()
>> pattern for mprotect() et al."), if vma_modify_flags() return error, the
>> vma is set to an error code. This will lead to an invalid prev be
>> returned.
>> 
>> Generally this shouldn't matter as the caller should treat an error as
>> indicating state is now invalidated, however unfortunately
>> apply_mlockall_flags() does not check for errors and assumes that
>> mlock_fixup() correctly maintains prev even if an error were to occur.
>
>And what is the userspace-visible effect when this occurs?
>

When error occurs, prev would be set to (-ENOMEM). And accessing this address
would lead to a kernel crash.

So looks no userspace-visible effect for this.

-- 
Wei Yang
Help you, Help me

