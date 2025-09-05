Return-Path: <stable+bounces-177849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC4B45E15
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 18:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3414F5C7904
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 16:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6543263F2D;
	Fri,  5 Sep 2025 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oc+RQ8U/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACFE31D72D
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089609; cv=none; b=ExFowTi/tHTRfwkeYqRC1rV0VbSROwgccIUI2JWRoRsdqBlNYrl3AqpzvNwzT/l+qBw96ppuZSfQnEslF1V7eBVP90HiYoxqeTO7cZsWZWURDiXqhEdyfkedo0kJsLQ9CkjoKwY8c81Pm9qXMdsbsgk6wZsC1dbwYhqfaVod4sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089609; c=relaxed/simple;
	bh=2PS5JRt8rYq8ZdgH2QfqyI1JjO6i3QNO1FmCz8ytBWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX2wFLqBWmo8C3Ofdpryy8w6GAcJPLBi7lxXidpV1CAYASRj7GV9HWhbTQcV+4vtajyefW9BiBj7dvfFbQMxKacEkY+RADdDQfwXirBDFuUcBtyeVFBMJx27ZAwtihdursLEys41SdtHoOmXnd7zeRswxzigWjxoNVHmVHqv7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oc+RQ8U/; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-726dec342bbso22634966d6.1
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757089607; x=1757694407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PS5JRt8rYq8ZdgH2QfqyI1JjO6i3QNO1FmCz8ytBWQ=;
        b=oc+RQ8U/IdmF+raFPFWc4kfmsKJNExqLun3iNBIUl0A4ii6A8l6Q7wvjRUAguQMX3j
         GlPZ1rUO8tqor4vjIPtnnXDDY4kj24DmYtD12p/Mbw22zko17G71NdYGW1B8zKTdvwne
         +U7h168qIibNrc0uLLlc2VhC/utpDCEvoDQroiWwdsBl3kyyXVCkFgASOsxR7IMgbYAr
         5SUD0pFVQWQzzq+dMEW9dJOfjaGMN6YC55TduXwWB0eoc/emupmTQq1xSCTQ9GHLAlWY
         Ct/4O1pOeclbTXVvpSVhZ3yXM7n3WWlRAmvRi/RZt3SooPt4yBx1szAhz/P7g530y2io
         ZGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757089607; x=1757694407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PS5JRt8rYq8ZdgH2QfqyI1JjO6i3QNO1FmCz8ytBWQ=;
        b=fEhzzRcn8cUB9K04bx9wGD9FKlZ43vFL/HTSqfRneiPSGOk54c3WV1c3gtDeCWHOxq
         2EfjPCTQ2ox9fZFOerw5y6HhAOTvbNd5T6Fb/iFTQ6AJjeCXfJJMIwbG+c5WObat7+Cg
         dJIFRzbOYfa+APY54uv/ZXk/MFPXEE/tI5XuFDNepZwZOO37n8rLA4p21wkQNwC3izYU
         nRwjmbUSZMSH+g1c+hhKnhfx40ohn+Qdv6+a//ZLqzGCg3C1YkARFixyv74Z6p+VBDIZ
         uU2Jf9vHiX16Myd4RPt2RleYAar6dY+1EStGAKDY5JhvRIYGba/RhH+0jzEQjUnPM7RL
         0iTw==
X-Forwarded-Encrypted: i=1; AJvYcCWo8Tdnc+SQGYR+x3I9yGItNXkzkyxU3C6rqb+24LpoSnyIJmQgkov+v2S2d6eLV/j89R6MXWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeTv8zuU21AuJ5utuNO8n9b47SrcQQw1OitYeHgUllGkuggjnn
	bVGi0Dp3APXYKrsD+fTundDeoDGxC/e052Lvvcd9qUPvS5x0xqJMJD/Hn1ZaYtr/gng=
X-Gm-Gg: ASbGncv+OXfVxe/rDuXy0DdA7cTENyNeCqTTMKnoJfTQxEskuqIBjphfCpL2FOk3UxK
	aBxNdyADcY94zTr4rvam5oECgNWok72ZnopVw/7tGoC+HM9IxPd+bDiC5tLQH1Velm5X/cjVKaY
	9/QNMzxxl+b8YA2/hhjVMiWlbVy59VfXmgQrikj0v1VEJaQl0rmJv+UqlqbIh3CDIvPU3NV++t/
	FfHIkFmMFCvQY3rvXXz1X4tuXDV5lhwCSWDHf7G2f5U/odtJeItRcvQT0cDSp9/Gd1Nl1rfWhJp
	jMVSkOAL5oua246PMpuQJz3ZYa/+o6ohCj+t9nnw3bjzhJXldB8LgGuvgfKWCs8KAlzz3h/Q+ZB
	j95kE8wEoFvXkUa+BIXnXBBJSLYrsnkW7XJYDuY1HQSdWqE7gePhESyEW7ixcss/gJFNd
X-Google-Smtp-Source: AGHT+IFSn5HY+WeJUt1wAviTMKOBWm+lvLAThCgWpXgEcnXeGVtNLDN/lb9+gdaDyGFY+W25tA/JJg==
X-Received: by 2002:a05:6214:301e:b0:70d:6df4:1b21 with SMTP id 6a1803df08f44-70fac920713mr231386786d6.62.1757089606848;
        Fri, 05 Sep 2025 09:26:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16e723sm68417896d6.9.2025.09.05.09.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:26:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uuZGv-00000002sYM-3KbU;
	Fri, 05 Sep 2025 13:26:45 -0300
Date: Fri, 5 Sep 2025 13:26:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: leon@kernel.org, stable@vger.kernel.org,
	Nick Child <nchild@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] IB/rdmavt: Fix lock dependency in rvt_send/recv_cq
Message-ID: <20250905162645.GB483339@ziepe.ca>
References: <175708273545.611781.8035611015794018890.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175708273545.611781.8035611015794018890.stgit@awdrv-04.cornelisnetworks.com>

On Fri, Sep 05, 2025 at 10:32:15AM -0400, Dennis Dalessandro wrote:

> Note there are cases when callers only held the s lock. In order to
> prevent further ABBA spinlocks we must not attempt to grab the r lock
> while someone else holds it. If someone holds it we must drop the s lock
> and grab r then s.

That's horrible, please don't do this.

If the caller holds a lock across a function then the function
shouldn't randomly unlock it, it destroys any data consistency the
caller may have had or relied on.

If the caller doesn't actually need the lock after calling this new
callchain then have the function return with the lock unlocked. This
is ugly too, but at least it does not expose the caller to a subtle
bug class.

Also, this seems too big and complicated for -rc at this point :\

Jason

