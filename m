Return-Path: <stable+bounces-144594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97484AB9B9F
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 14:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DF79E4AC6
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 12:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9F1238142;
	Fri, 16 May 2025 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt08rREA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA721D00A;
	Fri, 16 May 2025 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747397294; cv=none; b=rGXlSFMr8UT6krRDavXc4CNIljej1OXDngU3yfLir6DmNSLmqCaj7oJzUqxdfrf4ekDbp2x0MP+56Hsg97w/Py2ysk706G2POpCWTWzBEu1NIbCLi2HW9n3lGsK0er/XqeoK40fau2wDrhtPot3/ehKSA6A3lghgbTiw9UwgQrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747397294; c=relaxed/simple;
	bh=vvInzG+WhOwuClFT+hBEQCpv3Ilc02wgtTPwylfKFcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6cgTNXU8Wh4cE8W5a23ZCDG7z2r+7LgeCdOK3UTKr4HMI/yoGRC+3kGlrw4mrc8x+QA0yczuuxb9BxSHlknZgKN5zZB3edcCg4G7Nxo2eTsihb9MtMXXlND21jSXAe7lGJe0Z/oS/PTK1KKw1ggA3jqNbcAlrflhmab15x8YWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt08rREA; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-879d2e419b9so1816790a12.2;
        Fri, 16 May 2025 05:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747397292; x=1748002092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vvInzG+WhOwuClFT+hBEQCpv3Ilc02wgtTPwylfKFcs=;
        b=Zt08rREA6SiuLLxrm4DRz1ooQ7lP2n9VI1h9ss/QeIWNVDE/sPfC2HBVBvVraM4mqu
         n7jf1BQEHIa2PxHpoBZNPBAg2DRs7hvbKqNx0Wd7j/bGTpA7BLvFry77RSTSZenTC9If
         6hwfeFrQKy2R1UT+jRMMncTtBrR5e4qC8hrt3DFfr8YsKhzPKP1Wf357qu+xDd+l1oNw
         0KGzvcS6HhPJu2QDg/pSt49HQqj33eMjx656r+UW0kpo9m/V3DsL9qvLAfXWns17fb2C
         ebnh/56obAKu/wdVeCxnfzAHzbmq18xH/0JdL8uMuQKtvrdi3dhBDD2imjYEqR3Ki3j7
         Bz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747397292; x=1748002092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvInzG+WhOwuClFT+hBEQCpv3Ilc02wgtTPwylfKFcs=;
        b=jLce9OFYVpo89NaKI6DX8OmVANDJ4zyvEIS7PUTdc+rxvUxjMYe4W1wgKJBdyeA/ae
         q7ZHjxHB8c2zBiGH+U4Xxn+3JDA7kBP5/7kOHV7n3ITFNEQpPp2t4gfa8UdZTgk4//RA
         T2o6odSpWY+AJFb16ug8bzVM9rSCPuFp8TGrA5RhtTCcc84jiqAgR4moWHONBgPBidfe
         wJAPebWMVUe+uwHxFzgfrnhOfDVqSZqt5k/ULvxs4hN85ZN/XPmwheXCZz70c0451ZUy
         8HyMwn7ISKLye1Sy8MAi32pvKMv1pqeS79fBXKZmCGFJ9L0beLR/+morH1xmpCLQ1+j8
         RGbw==
X-Forwarded-Encrypted: i=1; AJvYcCVPfz8fFo3vLUq8Odn933ZJcbhjqRdVwknwWk81yMLG76XqvkTI0CHqitY13k9/clxghx+UyHch@vger.kernel.org, AJvYcCWGOyzH/fFaE3NoqLgrrp7RWeXoN4vSbRh7/yPynrzpbb9INJPIfVyJPGktp7o8ToGdfWmGsXuxEdPcp5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzauKbu5nClB57/mCdcvwtsBdDY6RhPz+Alx0oEf8C0yzQ/9fPC
	292oBOUYaAQnlI4cmQFWqNv2vlmk1DBB8Ix56AuE6L9gdrNDn4AGwYz2Pl800piNw3n+c1oQZbu
	mkWApyQUgj6K+53pD2JDSEv8W0ufjEq4=
X-Gm-Gg: ASbGnct7xSokVEexJ6G5KfRTXWox6VRW20hcAkTTzl98N5dTC5yPp3Jlt4WvOfVHV6z
	DLMxyYwwSiqJiiEe1qGaX9gK7LEFilqs1SgUWMYnEeY6NZUe30BKSjtEj9+w6cG4vU1QcviC9ry
	gLTWkCF+d3RF4UyZu2WsFchteAHS1vj6s=
X-Google-Smtp-Source: AGHT+IHOrDmbHxv5DER6XUzHCdNLptqi6Yl/kppUI/qzVCXsv5Y5EK81JcGT+mIeDr/DOLOoxGm31qXAeLeUTcgBjTE=
X-Received: by 2002:a17:902:cecf:b0:22d:e57a:279b with SMTP id
 d9443c01a7336-231d4519b0bmr49246575ad.24.1747397292421; Fri, 16 May 2025
 05:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515175500.12128-1-kitotavrik.s@gmail.com> <enhxf3daymfubn226ha4ywvh74k3zhacdya2mgfln7g2kzsq6x@llwzvp3vejsk>
In-Reply-To: <enhxf3daymfubn226ha4ywvh74k3zhacdya2mgfln7g2kzsq6x@llwzvp3vejsk>
From: Kitotavrik <kitotavrik.s@gmail.com>
Date: Fri, 16 May 2025 15:08:01 +0300
X-Gm-Features: AX0GCFtAc7jQ5C9dsDEktognTcJ9Mvl7g7BjNAjuCOqFs1-0YBxSmiPN41nxW4o
Message-ID: <CAJFzNq5Qwb3o5WHSq2c_k3-Nj1KTbcLQL-L6e03o+nZvRxpoVA@mail.gmail.com>
Subject: Re: [PATCH v3] fs: minix: Fix handling of corrupted directories
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Josef Bacik <josef@toxicpanda.com>, NeilBrown <neilb@suse.de>, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

No, because the live directory has nlinks = 2 when deleted. But if I
understand correctly, it's worth adding a check for parent
directory(dir->i_nlinks <= 2)

