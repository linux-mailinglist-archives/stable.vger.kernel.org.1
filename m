Return-Path: <stable+bounces-52653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A34790C7CD
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1C81F23EA4
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 10:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E326156C5B;
	Tue, 18 Jun 2024 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZJlPwQu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137AB15688E
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702387; cv=none; b=dFnoBS4VUhOwGpdfSh17eMAvaMONuXMJfJ9oXQzQKfB5qO8ne6PrQqyetsRzYwZwnvZDjx5UnDLt6elnwWjMuVSxksccI324ZVLBLnYrJALBp0I/u5DLSk4w4p2cClz9Oawyavy7fAkfeYeUr8/RNXnsR7DGSliVhsn7Cmcqf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702387; c=relaxed/simple;
	bh=SERh8K0/Gl6yV36ck7deaCxzVPKLagmqhq6I44vtk0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7qNyAoAfAz42F1Ia9zYAensE7xkPiV1WUUS3sIOBBLEhMWwIeEMdFQCrExuf9iu6moOUkxCDINL0FwLPssYWnn/K+0dvimdobEwIGjMBnKboOhLNlI1da+uhVcQTqu97Z2nW8hLIsNyAx9rNOvulwl25CoIt51o1Y7b05+DSRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZJlPwQu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6b0a40721so38285585ad.2
        for <stable@vger.kernel.org>; Tue, 18 Jun 2024 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718702385; x=1719307185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ctg3WvF4umv0ZsFiiMRmkdW/mGcIQZ/imljvFgRM8MU=;
        b=TZJlPwQu9mO6uACNgmhQTWWmRCsPebO8rFEw8jlPhyhTbDVE8S6iY9zHj2ZUNbzJXh
         oTKSqTL3g/Akos9G1c9bfLxB143gu/9xUa3OyZxveB8I5ySsF+MnjpbIIxm/y8SlT03B
         HVDIfuSR7zNrn/5yx0gj3+HjIE1/y8cz1FpXJmu1WsnZ+Rdi6zzS9Dz7T30/lvSNcE8t
         KaOnIzIcusF/1GhAQ0DHJElQ+sy3VNZD1Q59PvGYtshD/nq5K3Gkv/xYWT8aLE2cBy5K
         i3pkQ0C113K/VcXypdx2k0lgS9d5UZl6JCDtylUgXCavwg+Lv4G9QN31EwDYwKNhj1Gd
         Poxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718702385; x=1719307185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctg3WvF4umv0ZsFiiMRmkdW/mGcIQZ/imljvFgRM8MU=;
        b=qJscW36RHwEWcbDhZex2ni4Wy7KwJJw/mCjv3mdD81WFwkDhDb1HGMJFHONYN6uij5
         GOYykHGXqKfONamwZQezPRkh7bS2tJ0I3jppEuLzfIQbrhyrq1RsNrVYq92+nhXT5aWL
         JPEkAHfwLYTVOm+TUgMTA3GJ6NdaYd8I8TwMi730Fw4qBzr9sDfNVLqujdARPBJSY0G5
         ZvXbplEkYn+pfu3+0zswPPdbrS7hsHV4TP6hx3l3K3PaYlYZHrcCu3/F3vmpZl7qiEDy
         mvcIO+J60wmF/raJHxnaU+IPkUlvl3LEUHZzZP7XD0kDA9cSY6oEyX2HBYneZ9bXAi8T
         rFAg==
X-Gm-Message-State: AOJu0YwPp1WuR6x38k9FFAFo81lCzZVI+b61hYR3C1SxTdA4XYjKsWvn
	a6Tc1h1iiDF3QU0ilXv3aiHBjPeipm8Gv8crwCr5VylisPb+CavxFZkWNT/Z
X-Google-Smtp-Source: AGHT+IFHYqrcvl6aDd9UmZEfxnX+Nya5utP1Mct9vF4OerYuzM12Y4tRR+l8Qf5uYFzyZ8893eJ5Tw==
X-Received: by 2002:a17:903:18a:b0:1f6:4ba6:74ad with SMTP id d9443c01a7336-1f862b260ebmr137117345ad.58.1718702385206;
        Tue, 18 Jun 2024 02:19:45 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782c:cfa0:b84b:f384:190:dd84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e72beesm92898945ad.100.2024.06.18.02.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 02:19:44 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:19:40 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, petrm@nvidia.com,
	pabeni@redhat.com, kuba@kernel.org, bpoirier@nvidia.com,
	idosch@nvidia.com
Subject: Re: [PATCHv2 6.6.y 0/3] Fix missing lib.sh for
 net/unicast_extensions.sh and net/pmtu.sh tests
Message-ID: <ZnFRLEhSnMZalWN5@Laptop-X1>
References: <20240618075306.1073405-1-po-hsu.lin@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618075306.1073405-1-po-hsu.lin@canonical.com>

On Tue, Jun 18, 2024 at 03:53:03PM +0800, Po-Hsu Lin wrote:
> Since upstream commit:
>   * 0f4765d0 "selftests/net: convert unicast_extensions.sh to run it in
>     unique namespace"
>   * 378f082e "selftests/net: convert pmtu.sh to run it in unique namespace"
> 
> The lib.sh from commit 25ae948b "selftests/net: add lib.sh" will be needed.
> Otherwise these test will complain about missing files and fail:
> $ sudo ./unicast_extensions.sh
> ./unicast_extensions.sh: line 31: lib.sh: No such file or directory
> ...
> 
> $ sudo ./pmtu.sh
> ./pmtu.sh: line 201: lib.sh: No such file or directory
> ./pmtu.sh: line 941: cleanup_all_ns: command not found
> ...
> 
> Another commit b6925b4e "selftests/net: add variable NS_LIST for lib.sh" is
> needed to add support for the cleanup_all_ns above.
> 
> And 2114e833 "selftests: forwarding: Avoid failures to source net/lib.sh" is
> a follow-up fix for tests inside the net/forwarding directory.
> 
> V2: Add 2114e833 "selftests: forwarding: Avoid failures to source net/lib.sh"
>     as suggested by Hangbin Liu.
> 
> Benjamin Poirier (1):
>   selftests: forwarding: Avoid failures to source net/lib.sh
> 
> Hangbin Liu (2):
>   selftests/net: add lib.sh
>   selftests/net: add variable NS_LIST for lib.sh
> 
>  tools/testing/selftests/net/Makefile          |  2 +-
>  tools/testing/selftests/net/forwarding/lib.sh | 52 +++++++--------
>  tools/testing/selftests/net/lib.sh            | 93 +++++++++++++++++++++++++++
>  3 files changed, 120 insertions(+), 27 deletions(-)
>  create mode 100644 tools/testing/selftests/net/lib.sh
> 
> -- 
> 2.7.4
> 

For the series

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

