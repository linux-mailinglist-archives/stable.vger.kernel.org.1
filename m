Return-Path: <stable+bounces-54846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE8912F9F
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 23:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8280428479F
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 21:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4337817C215;
	Fri, 21 Jun 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skyn2N5R"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31D1770FB
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005788; cv=none; b=kdu88GTOcxuKUzlmEdngwSOZc2Rcg4cMz4bjESCeFxV2rduNgKOJVfiilKaj0iC4Ricd+vWLA/K5/oVdZ2Rt3vJayPPH4BB7qYPmYinSBPoDiGv8j6lqzfO19JUfcge2F2WVUc90nY5rI/DkpAR82/1JLxZDH3C762rc3MybV8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005788; c=relaxed/simple;
	bh=J6T7Na7W07rHi07yZxQZLcoT8svWNPjAiL3PLyX1v1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S47cQ+GnMKs6EQXJMP5Lpv3tStUvipTuG4titIRSFNzB9UewuzrDA4Eb0U4a4xp4FxHJXkXCJVXUKDjuogUNJuVyexmZLf68ep2fg3HNAsrZeGe1h48Sfq5naHr7AiK+lJzvuvj1ezMJwrpM5rJhZY+3SjkCKkLnszhlPD5jVUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skyn2N5R; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f991bb9fb8so216805ad.0
        for <stable@vger.kernel.org>; Fri, 21 Jun 2024 14:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719005786; x=1719610586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qlrUdHgGXihL/s+EgvCZEvEZrMZokYDaqZqpEHg6XbA=;
        b=skyn2N5R3yKupzC1a3FWnICDYSn9+S+7JEQkcpcthxCLYdV/AdriB2nI0VIp199mny
         HzxOYTh6ff1tlxkw+kt/cBq0XlZFDm+BFRL8B9x2vxSYkw9zp/E0kxTbtm8y+lYdhbPF
         fZlNtHZOht9iXdxjajut4q1vUNBayIpoPYRfzThmw8ES8bqoFF/ZH3kVEhD6gyLluaOy
         7EIIUy0qvLzvKtTiOjPbFgeXit5yXiAeOlDBesEcN2zXdZnuYovnOTUrqs3rxYZK/WiU
         guaaZ+KRfaSsH2SrVnia/W86an4VJwjPyxLVUJVy1j9KX3ul3keGY89Qm3pvPSmEwv11
         yWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719005786; x=1719610586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlrUdHgGXihL/s+EgvCZEvEZrMZokYDaqZqpEHg6XbA=;
        b=ZVTtUbu3Q4RiIJls2wWEaU4DOkwEuuZRxf7SwPRmhXCuYqZ5AFuBP4s9oOrTFinKi0
         gpo41OrVxs1eDF6skKlWbpASdDJMtYysiT0KxZVlmJgGqLQ6jTroApPZCu61lp7nfYiC
         dQpWDDZNmPskvfQlCcqBSnlpFnvrOyMJtJiHsb1EHI2Idf8rFBrmdUz4CSB9SFQfSujb
         RXLzYBTRwufXlvdjdvsaPUO0oKK7R2PzMdhimF7rRq3NTTmwcAapEx90Dv/8pL2Kddu8
         bLvKqq1G5+g2MDQ9R1W1WKpYRNMJ21THGzpDGDW8W7rlDfJdh4/NHS0V+q1WCfWug8Ts
         JZMA==
X-Forwarded-Encrypted: i=1; AJvYcCUsDjbnyf6b8v/Lg7WbypvuJZ8cLAc+wuBUKD2w1X4StLKsaRhvCA0jEanAIB2/vPgJEm6jRDJQ0gw7ebIuUsova2Kc3viU
X-Gm-Message-State: AOJu0Yx+bJxfX6ZbyKEN9pzRWIHijBPf/ol4eWL4ygo5S6lwy8NM9pHh
	+f0Rqm1csufAs2UKyeI9l3wgxWPER/L/xWMutpdrTczEkBNXwWq9gMsSOD5j8Q==
X-Google-Smtp-Source: AGHT+IEx++ezoVub5SOEh9xhLwbBZL8BdR18TTcUskjdhukEtqq4FP0yVpR6/gM15x7oUCPPTDXFJQ==
X-Received: by 2002:a17:903:294c:b0:1f6:7fce:5684 with SMTP id d9443c01a7336-1fa09edcad2mr522365ad.3.1719005785564;
        Fri, 21 Jun 2024 14:36:25 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651305157sm1862472b3a.208.2024.06.21.14.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:36:25 -0700 (PDT)
Date: Fri, 21 Jun 2024 14:36:21 -0700
From: William McVicker <willmcvicker@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr
 is valid
Message-ID: <ZnXyVWsUpY4GywNY@google.com>
References: <20240618022334.1576056-1-jaegeuk@kernel.org>
 <2cb67503-d974-4db2-942d-b68b69de9447@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cb67503-d974-4db2-942d-b68b69de9447@kernel.org>

On 06/19/2024, Chao Yu wrote:
> On 2024/6/18 10:23, Jaegeuk Kim wrote:
> > mkdir /mnt/test/comp
> > f2fs_io setflags compression /mnt/test/comp
> > dd if=/dev/zero of=/mnt/test/comp/testfile bs=16k count=1
> > truncate --size 13 /mnt/test/comp/testfile
> > 
> > In the above scenario, we can get a BUG_ON.
> >   kernel BUG at fs/f2fs/segment.c:3589!
> >   Call Trace:
> >    do_write_page+0x78/0x390 [f2fs]
> >    f2fs_outplace_write_data+0x62/0xb0 [f2fs]
> >    f2fs_do_write_data_page+0x275/0x740 [f2fs]
> >    f2fs_write_single_data_page+0x1dc/0x8f0 [f2fs]
> >    f2fs_write_multi_pages+0x1e5/0xae0 [f2fs]
> >    f2fs_write_cache_pages+0xab1/0xc60 [f2fs]
> >    f2fs_write_data_pages+0x2d8/0x330 [f2fs]
> >    do_writepages+0xcf/0x270
> >    __writeback_single_inode+0x44/0x350
> >    writeback_sb_inodes+0x242/0x530
> >    __writeback_inodes_wb+0x54/0xf0
> >    wb_writeback+0x192/0x310
> >    wb_workfn+0x30d/0x400
> > 
> > The reason is we gave CURSEG_ALL_DATA_ATGC to COMPR_ADDR where the
> > page was set the gcing flag by set_cluster_dirty().
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 4961acdd65c9 ("f2fs: fix to tag gcing flag on page during block migration")
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Hi Jaegeuk,

I've been running my personal Pixel 8a device with this change for the past
3 days and haven't hit any kernal panics since applying it. Feel free to
include:

Tested-by: Will McVicker <willmcvicker@google.com>

Thanks,
Will

