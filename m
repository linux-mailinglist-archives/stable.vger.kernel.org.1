Return-Path: <stable+bounces-19079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1403884CDC2
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 16:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD2A1F24EFD
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B257F7D0;
	Wed,  7 Feb 2024 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9EvbbFh"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51A250F3
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318690; cv=none; b=rUsSVJFkD1ji+g8yFJejVnlc1Q1pWeA6c7k5giU6pZXahBXKOtiR14IOTaC+4/qNJYKoN3XBe3qXQLNNHoPnyf51P2lCLOdR7MMIogjEdRfcxjq1JFwR6Z4R4DLLO3rkgoFm41LUkjPCRtuNPtQGKkH8JozQaQxJqT8dVQ3454E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318690; c=relaxed/simple;
	bh=YQOFWbgDdWyBqBS23K8FHRgqULUi8WS15+BS3fze760=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0KIQ6nCqwIDxgzWXEzx6+8/8YlzkAz0DhZz0iJwrrC9xuWldVFuL7FjJ8ScYcsGTWVirAiyF7ap5oDOTX39Qi7l65z3o9KahYGEq2ubYnhatxjYwzRWJmYuQv6SThymt3FMP1OYZAyzjm9cFB5MlwqFjX/yWEsr3Z696PFucLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9EvbbFh; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51165efb684so1358329e87.3
        for <stable@vger.kernel.org>; Wed, 07 Feb 2024 07:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707318686; x=1707923486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzJ81C4HL/u23pMrIXE4d3WYHx/TRJ6odshS9CAIiMY=;
        b=N9EvbbFhSANF3sPm2cpqHL1MF1wqLzHNNFHcZ7UB7Tpb1dHA+cxywwp1xlC3OlCg+5
         kPxw0bq+vCGVMnfxjQWg6ADb7k6rEMStZQowPtvXPxLTlLxBHwJd0jVhjWniGWabucAH
         annW3kt2XOBwlEyuoK1//Xl8LpA9D3RtqPDSwnsyVqPJHMmU0e+o7J6WMkr+y+xkAmX2
         ztR+FnINwwujL3gyZ2LZkjDywW2Y5fUlkF/NJpgeOdH7DOVldXEHmGFzPAJpBpWOImAe
         0KJ4O2O6ol4ZM3+ka6e9nMirZ2qRz1ps8khINetbYgVNuw0gCBNuge6VXdiEeoq7JPDm
         ICYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318686; x=1707923486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzJ81C4HL/u23pMrIXE4d3WYHx/TRJ6odshS9CAIiMY=;
        b=ceKofHpfweHjFdx0yXjU3lbHLIAazw6w4/fA8/fw+pT61JJVK98NYxDz3X/Y5q2o7M
         A5pNMzuZCTW3FLd5Z35IceC87Utfuqak/8aZsaOoxiOrLaBJaRmOHBs5CgF2mqfiofgR
         7A6LIW4hUvSyWxjP1rvrpjDAcBEQJZy2qw8U8/04gug6uj02/snmw3HNEc3Ipn78oaWg
         gPrB0S/de8y8GYcKJf0/quB6bqH75pOpqBwQPkCP0WOqSOOQ5eZZ7i1h/oMiP3TBEk2E
         QSWsu9rFQeqUEMmSzpRWjr/njHxb+8k7d6FXsPDkjaTjmA93Siuzdpe/n+rmOprwojg7
         mzIA==
X-Gm-Message-State: AOJu0Ywfzu9hq2wyueng3nVYRMvvn77mqkywEViIHHM/TQHBdm654AdN
	5EmEWh3Y2R+0gMpH/wf88CkYOdVuN5j+9WPss7qWULbIjyX5aYNQLnsYYk4k5ns=
X-Google-Smtp-Source: AGHT+IGvp0FazOi1zqX6wCGKvEoA98IIKrUsregww+ttoggrFGweMcWVseBOcvsLHo9UwyLpPo+BFQ==
X-Received: by 2002:ac2:5dee:0:b0:511:49a0:200e with SMTP id z14-20020ac25dee000000b0051149a0200emr4216150lfq.37.1707318686256;
        Wed, 07 Feb 2024 07:11:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+q2iGBXeP6YQqHTt7gVxY1955vZWqAxVYg34Wgi/epLYlHSuWsaiP10+tDUrzyfqpmJf9sHp4FJhe2+d94hdBRN+ZzA9vO8vBeFfHRAMZnyrJWZyS/C76tcWCdTZescXWexguZavCkjIw5jnLHmKD3X8kZGQLigFm1w1+Jidla5xTHdfbEHTYEAarYF+n27Uu0CuqeATiIGau4hEQ/oCUYBKaB7+/OZnPHTtmffBUHw6ja4LjaJs8wty7r9BE+cCfzyw=
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id lv6-20020a170906bc8600b00a354d25da36sm854349ejb.83.2024.02.07.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:11:25 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 007CDBE2EE8; Wed,  7 Feb 2024 16:11:24 +0100 (CET)
Date: Wed, 7 Feb 2024 16:11:24 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: ZhaoLong Wang <wangzhaolong1@huawei.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, sfrench@samba.org,
	kovalev@altlinux.org,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 5.10 0/1] cifs: Fix stack-out-of-bounds in
 smb2_set_next_command()
Message-ID: <ZcOdnBHA0OIB956t@eldamar.lan>
References: <20240207115251.2209871-1-wangzhaolong1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207115251.2209871-1-wangzhaolong1@huawei.com>

Hi,

On Wed, Feb 07, 2024 at 07:52:50PM +0800, ZhaoLong Wang wrote:
> Hello,
> 
> I am sending this patch for inclusion in the stable tree, as it fixes
> a critical stack-out-of-bounds bug in the cifs module related to the
> `smb2_set_next_command()` function.
> 
> Problem Summary:
> A problem was observed in the `statfs` system call for cifs, where it
> failed with a "Resource temporarily unavailable" message. Further
> investigation with KASAN revealed a stack-out-of-bounds error. The
> root cause was a miscalculation of the size of the `smb2_query_info_req`
> structure in the `SMB2_query_info_init()` function.
> 
> This situation arose due to a dependency on a prior commit
> (`eb3e28c1e89b`) that replaced a 1-element array with a flexible
> array member in the `smb2_query_info_req` structure. This commit was
> not backported to the 5.10.y and 5.15.y stable branch, leading to an
> incorrect size calculation after the backport of commit `33eae65c6f49`.
> 
> Fix Details:
> The patch corrects the size calculation to ensure the correct length
> is used when initializing the `smb2_query_info_req` structure. It has
> been tested and confirmed to resolve the issue without introducing
> any regressions.
> 
> Maybe the prior commit eb3e28c1e89b ("smb3: Replace smb2pdu 1-element
> arrays with flex-arrays") should be backported to solve this problem
> directly. The patch does not seem to conflict.

It looks there are several people working on the very same problem
addint patches right now on top.

See as well https://lore.kernel.org/stable/c4c2f990-20cf-4126-95bd-d14c58e85042@oracle.com/

But this is already worked on and the proper solution is to only the
eb3e28c1e89b backport included?

See as well
https://lore.kernel.org/regressions/Zb5eL-AKcZpmvYSl@eldamar.lan/ and
following.

And this needs to be done consistently for the 5.10.y and 5.15.y
series.

Regards,
Salvatore

