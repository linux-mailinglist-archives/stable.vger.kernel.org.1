Return-Path: <stable+bounces-69943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B45E95C56D
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 08:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D24281D35
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 06:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1369762D0;
	Fri, 23 Aug 2024 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THfzAoP8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006B4A08;
	Fri, 23 Aug 2024 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394339; cv=none; b=QAzbYDuT7SwdHJ8JfPjPyMjYPc0fh87NUDc5+oIi+7lM8+bebSh+H2Z+nC13GMA1JUAJvCqIffM8rJKaESyz62f8rdKHdMqxho5VnfLlG2ZpTh06Ewqks3QT941hIYZnT3aEVza9Kb+Z+MbH9I/cwajUFGrhJ506SX+kar3pGRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394339; c=relaxed/simple;
	bh=EJerxnPxRB0KW1TVZXRDHwhScilR90S9r+lwAZVL1rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvHb48cZPV8r9+NKUblZVlE4/UQdptHKbdhr+847lqECBDMF62gb4+pT0q6/oIcee66W6nMVb4Uk45PKUQmVXEiNLR03XL+jSGdfwn5KvcBEfjBgeT31o97BAD5FdZvrcykiwT476C3YrVZMfsauFXmteJ4sylKADaMtVsSSlVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THfzAoP8; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd9e634ea9so909684a12.0;
        Thu, 22 Aug 2024 23:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724394337; x=1724999137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1lnOT/8D3piyd5h7N4Z3HdqGdyLvt9g914K4psbQ7x4=;
        b=THfzAoP8Rz2t1/Yv3yVz9qPnPm7uNv5xNxxIRC/j92ryd9qyijmi5YgC3/UQv0nDdK
         5BgzaLZfDzG4iE8XPFJDBpYBrlv+xR7Up6Z3WgIpfsLu3F4SdxPUEMcpZoHZ59fBq3WR
         25VOtRshP9sUCjM+Y14RIhIi7y/31da1Uv2056yV9hIN5yEMQrvNsAAtVlU5y882bpXo
         UIlgrR+rF/lI0Z7q5N5SQmiQNW9cI46LHAfV1CwWEk+RSKLSFAdsKidt8dUFpDnjYqqs
         ZSltlWYs+FzAsl4xbWtY8hFCmSRtRq0zqz4t9nR+7NzyLTzwJu++D0cyEu9s7xHLzq+w
         tHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724394337; x=1724999137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lnOT/8D3piyd5h7N4Z3HdqGdyLvt9g914K4psbQ7x4=;
        b=I3slc9E8iT6/NN8/GosBG65jFzu/9+b9QsyfU+pL8E93tiZrCnrqOg1s2cyV4KfEOx
         bWQjmkiZGlT0FvbRg+RtuZsD3jCKI0zMAHOymjg9xFLIldMJS80jXp5yqenLVnOPCqs5
         GvROLbhMHxL7qkrgKHjRLb96fN6dIuCzplHivBHTt8TEiU/jpwrYSgXtLkbqnk+Esx7O
         MQwxWYeONBRf6YUq4jyWcHnNGeqIRuPDCbAUtSJZPuQpB9f8m8SYSgDMu12lM/mFKsvG
         rok4roGQi3U25uqPTiTA21w9ufFG9DIEN7a6pttMpzDCBknoMjF72KNO+GxgdNEjOsZs
         kAyg==
X-Forwarded-Encrypted: i=1; AJvYcCVkqJM6+wWc14NJ0V+hWN7Fe8dPIVxeYZs/BgSLB4cSF2Cj4jdrs2iFmEu1FehtgH04/x94KD+3@vger.kernel.org, AJvYcCW17uFFe3JaVa944BNDGm1lsyFqne9QAw02OW2P9jaobflo6yHNvBXNyTHhThad4AnT7/J0SW147VOVFUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1xuCBR77cz7y0dd39gJPFpqeAkegtHfW+Bq2gXU48fi1m4Zy
	aW4iiQSabkg7X2lawH+4U7w+i08z/uJBvTfBgLdTIHXAe/X1fZlfOZCiUQ==
X-Google-Smtp-Source: AGHT+IEmbZYP1rA5gPbO2k30cZOYoJ1peNpiBFndLlP2Fc+eYx6CAZ1QycIFCu6Frapn7LzbEX8U8A==
X-Received: by 2002:a05:6a20:d818:b0:1c4:d4b2:ffe6 with SMTP id adf61e73a8af0-1cc89d68929mr1783006637.19.1724394337165;
        Thu, 22 Aug 2024 23:25:37 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:ccdb:6951:7a5:be1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9037a2sm5392608a91.13.2024.08.22.23.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 23:25:36 -0700 (PDT)
Date: Thu, 22 Aug 2024 23:25:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: Fix an uninitialized variable is used by
 __device_attach()
Message-ID: <ZsgrXg3JR-Z1z-sr@google.com>
References: <20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com>
 <ZsfRqT9d6Qp_Pva5@google.com>
 <04c58410-13c8-4e50-a009-5715af0cded3@icloud.com>
 <2024082318-labored-blunderer-a897@gregkh>
 <Zsfk-9lf1sRMgBqE@google.com>
 <2024082349-democrat-cough-bf77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024082349-democrat-cough-bf77@gregkh>

On Fri, Aug 23, 2024 at 02:11:45PM +0800, Greg Kroah-Hartman wrote:
> On Thu, Aug 22, 2024 at 06:25:15PM -0700, Dmitry Torokhov wrote:
> > On Fri, Aug 23, 2024 at 09:14:12AM +0800, Greg Kroah-Hartman wrote:
> > > On Fri, Aug 23, 2024 at 08:46:12AM +0800, Zijun Hu wrote:
> > > > On 2024/8/23 08:02, Dmitry Torokhov wrote:
> > > > > Hi,
> > > > > 
> > > > > On Fri, Aug 23, 2024 at 07:46:09AM +0800, Zijun Hu wrote:
> > > > >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> > > > >>
> > > > >> An uninitialized variable @data.have_async may be used as analyzed
> > > > >> by the following inline comments:
> > > > >>
> > > > >> static int __device_attach(struct device *dev, bool allow_async)
> > > > >> {
> > > > >> 	// if @allow_async is true.
> > > > >>
> > > > >> 	...
> > > > >> 	struct device_attach_data data = {
> > > > >> 		.dev = dev,
> > > > >> 		.check_async = allow_async,
> > > > >> 		.want_async = false,
> > > > >> 	};
> > > > >> 	// @data.have_async is not initialized.
> > > > > 
> > > > > No, in the presence of a structure initializer fields not explicitly
> > > > > initialized will be set to 0 by the compiler.
> > > > > 
> > > > really?
> > > > do all C compilers have such behavior ?
> > > 
> > > Oh wait, if this were static, then yes, it would all be set to 0, sorry,
> > > I misread this.
> > > 
> > > This is on the stack so it needs to be zeroed out explicitly.  We should
> > > set the whole thing to 0 and then set only the fields we want to
> > > override to ensure it's all correct.
> > 
> > No we do not. ISO/IEC 9899:201x 6.7.9 Initialization:
> > 
> > "21 If there are fewer initializers in a brace-enclosed list than there
> > are elements or members of an aggregate, or fewer characters in a string
> > literal used to initialize an array of known size than there are
> > elements in the array, the remainder of the aggregate shall be
> > initialized implicitly the same as objects that have static storage
> > duration."
> > 
> > That is why you can 0-initialize a structure by doing:
> > 
> > 	struct s s1 = { 0 };
> > 
> > or even
> > 
> > 	struct s s1 = { };
> 
> {sigh}  I always get this wrong, also there's the question "are holes
> in the structure also set to 0" which as you can see from the above
> spec, should also be true.  But numerous places in the kernel explicitly
> use memset() to "make sure" of that.

I think it has more to do with our preference for having declarations
before code, so if there is complex or conditional initialization then
it is more natural to declare uninitialized variable, and then later
explicitly memset() it and assign required values to members.

Thanks.

-- 
Dmitry

