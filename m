Return-Path: <stable+bounces-100459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C84D9EB666
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 17:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672C4281A77
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 16:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1727C1C1F15;
	Tue, 10 Dec 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hf66nXEd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7808D1BD9D3
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848130; cv=none; b=d09VDNy1IPoNf33gR8FO2DVHAi0z/p24RsG9Mb8DNY6lILhYeURYaqmNDin+dUn3wg+6CqiZzNHpQ4vjtx0NzQUr0Gx086E4/YtEQYOiyq+fqFgfHYEjm2ga4YMeLUSvh30E0/I5xqD/FjLlcxyEpaoIgwlUWk18qytPzIRzeEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848130; c=relaxed/simple;
	bh=L8zZS+5vpYxW5QotLbpQWWWL3HA8cKGK24qRz6jBPBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDUjs6aXVNIer1QHSfXCbm2Qdop/GrVrq6c9gVGXpkRLyLndsrPZZ/yd2hPWcC5T5k96IoOyKGDrbtk/71SRXKE3GjrXJTEN8+9a1TKbBe3qgW3MONVNYLWUP6v3JZ3EOUVuf6M3q1oqA1LKhv+sw5iliCHJWKVu2SQva1Hhwu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hf66nXEd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166651f752so18420835ad.3
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733848129; x=1734452929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mj4MHdnpYsp681nq+qrKAbIFA8R/Y7sxbnd8+ouUZPs=;
        b=hf66nXEd/Jcz+r6C+YJWjGWiPoooFgvLyS2fuXgbyllAdotF828LhTavSiacbv+4Hn
         yCYwdwJ1I2YcAETkD6GxcXBlMtAW2Zlw7fbOps+DfeqD8Aqb9zyO023/O0cqPjnmu2Dr
         H0gidyX5yFL3g0GD1eJqBPrNFeTZEHF3h0g7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848129; x=1734452929;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mj4MHdnpYsp681nq+qrKAbIFA8R/Y7sxbnd8+ouUZPs=;
        b=tmSPZ4iU5ibiM3g/HfmzeJUj9POTRFLcFIs5jx7hpY4WjkslnLMjFj2iiOpW7VNJdv
         lQb28lXAdW0eubmZ2atKhGAzVqZuJCQEaBPOHgHLfDOp64vUu9dKz4VPrbGHoYOdfaWd
         4LA4jkNwpp8K2W3iv5G+yqqSXzOGpgXYQHOqeXNPjhULe1/+fo3kb9Uldpm97LBiOQIe
         kEn83dw2+GCiHHauD+lO1Qp3tYPTGGoJqvnccVz1gzmXKzcpqUDrdm6qtJqbnTnxN5/N
         zR83L/SrJt49qakopyPFXL+3IfIQNU4QtFz54UoD7rJi+zFoNnvZdCSgqZhmF6jEtGxi
         ocGA==
X-Forwarded-Encrypted: i=1; AJvYcCWN+sdNsgdvoQeVGk19PlkVcJiGY/BSQx5g2CiJQ47WR6dihLFGoa+za5BaKyRIRh2s5lvupts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFG6JX2EQOmHV4++QGXswmJqoluAMr/DbFL2pAvaaRFphwQPrT
	Gu0XuijWwtQ5T0RqTs2PVtKJthzCfAvSEuOuKUqitmGYl4uAkw9W3W7HZoLftbo=
X-Gm-Gg: ASbGncvFH+SKYJqPrCFT6AL3HQJAtT15caNY9U+OnG1zf9M2f6LftOHhb2N/MLsNZpj
	pDUdueVfTt/Qkh1wEWoUoSkrDKUka2sDKHwnUgikTyiJmg/iCmxp/ASMdqh9ff51Ok0y45nVSSe
	laIUCIhvexg0x9t9YQbh7qfO0u2TmmJFAZKM8s6dzUZvJGk5pUgPY3PBqlCI8pS3Ol9YiVox/R7
	i7TrwrTWhXGc24ecv00/X+910tk6lGkeP5UA5hfe7eqXl5Rz2itdGAbR2hcn7ysIDdNG+73RQKp
	HhaQn0Wjtr29cYihwE/v
X-Google-Smtp-Source: AGHT+IEtgwyNJx3QaHHEzPTwoCjXsg8GMUEN+CgmtihyPC+PN4MzAUpVMRw/PLiYKbMt3qlJgKKa+w==
X-Received: by 2002:a17:902:c412:b0:216:725c:a12c with SMTP id d9443c01a7336-216725ca3bfmr41703775ad.9.1733848128663;
        Tue, 10 Dec 2024 08:28:48 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21632b2b26csm55443055ad.98.2024.12.10.08.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:28:48 -0800 (PST)
Date: Tue, 10 Dec 2024 08:28:45 -0800
From: Joe Damato <jdamato@fastly.com>
To: Frederik Deweerdt <deweerdt.lkml@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Michal Luczaj <mhal@rbox.co>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	xiyou.wangcong@gmail.com, David.Laight@aculab.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net] splice: do not checksum AF_UNIX sockets
Message-ID: <Z1hsPdG3ITuDlWnT@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Frederik Deweerdt <deweerdt.lkml@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Michal Luczaj <mhal@rbox.co>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	xiyou.wangcong@gmail.com, David.Laight@aculab.com,
	stable@vger.kernel.org
References: <Z1fMaHkRf8cfubuE@xiberoa>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1fMaHkRf8cfubuE@xiberoa>

On Mon, Dec 09, 2024 at 09:06:48PM -0800, Frederik Deweerdt wrote:
> When `skb_splice_from_iter` was introduced, it inadvertently added
> checksumming for AF_UNIX sockets. This resulted in significant
> slowdowns, for example when using sendfile over unix sockets.
> 
> Using the test code in [1] in my test setup (2G single core qemu),
> the client receives a 1000M file in:
> - without the patch: 1482ms (+/- 36ms)
> - with the patch: 652.5ms (+/- 22.9ms)
> 
> This commit addresses the issue by marking checksumming as unnecessary in
> `unix_stream_sendmsg`
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Frederik Deweerdt <deweerdt.lkml@gmail.com>
> Fixes: 2e910b95329c ("net: Add a function to splice pages into an skbuff for MSG_SPLICE_PAGES")
> ---
>  net/unix/af_unix.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Joe Damato <jdamato@fastly.com>

