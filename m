Return-Path: <stable+bounces-180943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5E1B905CE
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 13:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF81F189D834
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 11:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53091305967;
	Mon, 22 Sep 2025 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="katISNTj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6464305E29
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540532; cv=none; b=GfPJYvyNT0NiWL18ZiJJivslrLe2uKIGbD+AqRFjPEjOPXshetHn9x2j8Sp98RyxpCxNS8/kgyZ6bjm+aryOGUELKK0z6b9V8DlCINmQlKLLUyJ8TpS157rXGOcWTVVr2gAaZJaaaKUwimFG46fmDDACFZZtFyIJtlVav09IqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540532; c=relaxed/simple;
	bh=3FWccC0wBYnZhQF9LERuXtOSWdEQxrAed3E09vmEwMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwEBejPsT34FJyfVH/YXhEDIHMngMfnnx9to9XcGNRuL+nncMjtE3IJmJKQH/3AckgCClTPp4U68/mxTUY5bAPvYdqnWRuqR3ETbncwkmQ3IoNaV2qMOJKBsVQ/UgF391EtPPb0q7RwdzUzS4Unmu+ifzgal9pf8TSqjgW3hYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=katISNTj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso2657274f8f.1
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 04:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758540528; x=1759145328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjU7ecr6qYWC8I2dcd/G+p4fmR13pHtJbJz7aga8+1A=;
        b=katISNTjkTkyYPV3MxJRrAe1oX4IX0uilaDShcMIZsExff9INZ81eZO1x+APrwsoH8
         yScSt2GXQwCYn2tdQ+qq1MdXlVmkvqpjxfXih7mmxysXydeYEvL8/+U5oObUS91GnZMd
         /s0WumZq98+ViXsmWFPTwStjxjlgA7cf+lyBZpNQkW07YcWiLeoCrF2WLbXeLKLEZRnX
         0F8rw5QodROn/mwKxMn1XTnNOnAe1R9vXNbK1hqVfPFvrMlLW2vvlaevkS+hMe2t+WKT
         4bKuM5w9iN6NFJt3JOwrxxa+wm/ODkaAAaLQyQSZB0tw3D9tdApu3SnEi+GrORfkQZVc
         +z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758540528; x=1759145328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjU7ecr6qYWC8I2dcd/G+p4fmR13pHtJbJz7aga8+1A=;
        b=PLZBgOzwdMz7nMQHKhx/e08c3vPVx1mc6MVNhgKHkZ2e6UwVCtYxacW/ru244lOF4N
         Vn0/PFHWBVohKKAb2H6Idd8q2NzeZlmxgQfvBT25JN5ZWfg/EdV0pWWS+eJcjDFQfwzH
         huktKK+EVOsgvfIA8iHiDTr1AWLU4VTZDb6jc30IohlUmTV71n5a9PWvAdoSwgUzhLj7
         O3ivETi16vmmwyTtKf6TgnjXxTsE3yt3Q6nBBGY2HhXrbPxSTbRj/V8y4kKO06Qqs6Rf
         gZ/BWmRxtaR4uocFp/JfAsfCe50iCouHn44m/j+y2S47V9DpsUBL5sFEKun/58aOkeOn
         P65w==
X-Forwarded-Encrypted: i=1; AJvYcCXv07lP0anGoObeMYp0ux6XlrVYSH16LJVCBV1h5WNY4gjkNwojIFcWPAUWcvR50uUXv1sKFoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+vuFGMRysyH3APMDPDgHafvGLs19LjwX8DSrP7hNSiLx1L8t
	lcmicNXNeQvMUvQlPXTUVHMNX8fcXyg6+97KI0MN9yYK9KtyTZAv22i7yWh50GB9sKk=
X-Gm-Gg: ASbGncvl1b8ZPTVzAVwoUE/XwASMrV2SRpVfQ4RboatVL2jd2fSn1OXcfwppS3xQRhK
	Jv/kUts73cIg9dqJByQN2OGf0c4IrsRFaJfZ7a3DTjzEjIfOKq/2zoKR5+Fg9QdAC8jWcCGKgvJ
	8Hm0Rs7RMxQPHAyfb7llT7RqbA9rpBqHBSpf+BlyiGSw20Vm3qeXBzOdHwLKnqCQ/+oUMiTXpjH
	typgAqQVv7wxGZBZdZhe58Ytx8D8vocNgrccl0nv+szn3JytIybjLI+4o1LVo/QrBjF7QuCPHwu
	bThX8GZIDeQatAqbfbZ2sc1lqT7T8iohEd0Hsdbq1wvfDMvpqEtZq+EqRLRbMYb5ZVe3TDqEB0H
	8Jh8u46ya5PxMH6z05zhnUrHUhYIc
X-Google-Smtp-Source: AGHT+IH4MVTTvJNffVVHP3rQfdQ1+Yz3bv5wsjwPbeG+w6rdZ8vSfpmXOdmU+Yfl/Cq/S4gBo7/gWA==
X-Received: by 2002:a05:6000:400f:b0:3fd:7388:28a with SMTP id ffacd0b85a97d-3fd73880634mr2585927f8f.8.1758540527943;
        Mon, 22 Sep 2025 04:28:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e15d1610fsm15388905e9.7.2025.09.22.04.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 04:28:47 -0700 (PDT)
Date: Mon, 22 Sep 2025 14:28:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org,
	matchstick@neverthere.org, dominik.karol.piatkowski@protonmail.com,
	arnd@arndb.de, nichen@iscas.ac.cn, paul.retourne@orange.fr,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] staging: gpib: Fix device reference leak in fmh_gpib
 driver
Message-ID: <aNEy7LsnKa50Pq3c@stanley.mountain>
References: <20250922084512.9174-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922084512.9174-1-make24@iscas.ac.cn>

On Mon, Sep 22, 2025 at 04:45:12PM +0800, Ma Ke wrote:
> The fmh_gpib driver contains a device reference count leak in
> fmh_gpib_attach_impl() where driver_find_device() increases the
> reference count of the device by get_device() when matching but this
> reference is not properly decreased. Add put_device() in
> fmh_gpib_attach_impl() and add put_device() in fmh_gpib_detach(),
> which ensures that the reference count of the device is correctly
> managed.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8e4841a0888c ("staging: gpib: Add Frank Mori Hess FPGA PCI GPIB driver")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - modified the free operations as suggestions. Thanks for dan carpenter's instructions.
> ---

Actually, it turns out that this isn't the right approach.  Sorry.
This will introduce double frees.

The caller looks like this:

drivers/staging/gpib/common/iblib.c
   204  int ibonline(struct gpib_board *board)
   205  {
   206          int retval;
   207  
   208          if (board->online)
   209                  return -EBUSY;
   210          if (!board->interface)
   211                  return -ENODEV;
   212          retval = gpib_allocate_board(board);
   213          if (retval < 0)
   214                  return retval;
   215  
   216          board->dev = NULL;
   217          board->local_ppoll_mode = 0;
   218          retval = board->interface->attach(board, &board->config);
   219          if (retval < 0) {
   220                  board->interface->detach(board);

   So if the attach() fails, we call ->detach() which works.

   221                  return retval;
   222          }

It's weird because the fmh_gpib_pci_detach() function does have a
put_device() in it:

	if (board->dev)
		pci_dev_put(to_pci_dev(board->dev));
                ^^^^^^^^^^^

The detach functions are really similar...

regards,
dan carpenter


