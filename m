Return-Path: <stable+bounces-55001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A3A914912
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 13:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE9BB2347D
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 11:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79A913B2B2;
	Mon, 24 Jun 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aTbeZvdZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B70D13AA45
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229510; cv=none; b=DY+PiDqtZQhp49VooAVDjQhg1mbzj2+5YynLS6rSkaK2IvkvcFXjmog2qv0EskM0Ur8UiErnDoulWPOvWdnW3+tLkFOGNmwlsF3YrokdTXDUFF8cZMCMQxKRpcgOOVtRf8RDEl3NDlIXyYAXWDrn2JjbkT7xDvp8f/uF3rrodtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229510; c=relaxed/simple;
	bh=ZTb6ItNVRUVXB0JKvtftUqyzvS/9Wc86rHio5MZRE5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uw3NgWA988qL4wqM67Y4eYwLoaSgdoYrJ36J+2EHHSHERiwbrvFjoGBduh+KntFSsA1srDJSvwB0r3P4lC/Ox1s9TlksZVxAuJmeP12KW9bn1Fr4A0VSarilCaX+cIA73U1pwUVAyT82WxCrP8M2t7dQAEpARxe3mXxVXTKKjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aTbeZvdZ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso46237431fa.1
        for <stable@vger.kernel.org>; Mon, 24 Jun 2024 04:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719229507; x=1719834307; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Olwpy3S2NO7dozWXBkNeO0Wjc6p2uaDnBhKTeSGxqpk=;
        b=aTbeZvdZuiF8zAh50H0zbLHSOv6jQUWvGX1TzVAVstHG5jLLV1rNW0S1+I+Lni/edx
         oFS9Xwsq9JqiUglu0vrG5b4Xlh7q+dOAt6JodyymlDMzuHmkLjxr8brFY+xEf1WZ9nmq
         BqQ6Lv5HK10LIZaqpKyxYnHmOFTdjh0EYq12Lei05NCTvRVrf0y3JMKo7BsoS2o0laAw
         UJLdawVp6OtXFZznpBrm4LP6fxsxwcK91zgtLn2DmXXl5WIzd5PezVHBkVQJw2MmCM5R
         PqbBGfuvrsx8uBPFFqjBPfT81JKZacoCp+k2PrJ7t7MT24OiYActbD1uxTrkiIWDFxZD
         d62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719229507; x=1719834307;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Olwpy3S2NO7dozWXBkNeO0Wjc6p2uaDnBhKTeSGxqpk=;
        b=U2JxfZKjMwQIK/w8VkKrrW5+ew7BUCh1CWa1UJ8P84XuVuusc6J967h6w92P8/0uPh
         tTbvnGK8A+SF1TjRauKaZGMBmiKSxOOX8BMO/Bd0mDhedrKuTj/k4kDut8Fvd++bKfvZ
         4uFrGBAeWu93SWP+TyEKDUaEIYUYRjGI7ItIpxJnuoT/VV8WeEXph5KEQu4RFsHqcFVg
         lO1hgJ5FFD3rvzI2DMg6xx0M8slY/wpjZ+O+syjuDV/cZL+szHs+QHGzYHAD/k77RCr4
         e0wLmGxLWzr4utGrev9JE4El/PgGH9+t6TCrvkjeFtCm68eoJcXTtXvIPW225lPuwC/a
         IGug==
X-Forwarded-Encrypted: i=1; AJvYcCXdnkhyws19m9sb9brTX+EuF6VE3dmHAXvuEDv9bFcSvup4tF3YvNFC879ufo70mOpYQUnGhndsnu6hMmy8Tfu7ImKo+E7V
X-Gm-Message-State: AOJu0YyxsCVauF6V6OdQ+7rZgeMs3jG2xR+OgjjP5VUGJVunO0BeVTqm
	S9T398vl5IIXLFRhdgHDBID4FgVf2D02rLzXebOgGPQQ6FGHY+Ye+kyu9yxDLoo=
X-Google-Smtp-Source: AGHT+IFsOq7RvpS4DTLa5t33aUT4eiJQaXEezbXtvZjKsdrtYyXNMldiri2DeYMRY7GZoSW4pmitGg==
X-Received: by 2002:a2e:9dd8:0:b0:2ec:4fc3:a8c8 with SMTP id 38308e7fff4ca-2ec59312e0fmr32546011fa.0.1719229506433;
        Mon, 24 Jun 2024 04:45:06 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5c97sm60893015ad.125.2024.06.24.04.45.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2024 04:45:06 -0700 (PDT)
Date: Mon, 24 Jun 2024 19:45:01 +0800
From: joeyli <jlee@suse.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-block@vger.kernel.org, Chun-Yi Lee <joeyli.kernel@gmail.com>,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
	Kirill Korotaev <dev@openvz.org>, Nicolai Stange <nstange@suse.com>,
	Pavel Emelianov <xemul@openvz.org>
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20240624114501.GK7611@linux-l9pv.suse>
References: <20240624064418.27043-1-jlee@suse.com>
 <e44297c0-f45a-4753-8316-c6b74190a440@web.de>
 <20240624110449.GJ7611@linux-l9pv.suse>
 <8d076c38-f5d0-477b-9b9b-bceee3e2fec4@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d076c38-f5d0-477b-9b9b-bceee3e2fec4@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)

On Mon, Jun 24, 2024 at 01:28:54PM +0200, Markus Elfring wrote:
> >> Please reconsider the version identification in this patch subject once more.
> >>
> >>
> >> …
> >>> ---
> >>>
> >>> v2:
> >>> - Improve patch description
> >> …
> >>
> >> How many patch variations were discussed and reviewed in the meantime?
> >>
> >
> > Only v2. I sent v2 patch again because nobody response my code in patch.
> > But I still want to grap comments for my code.
> 
> How does such a feedback fit to my previous patch review?
> https://lore.kernel.org/r/e8331545-d261-44af-b500-93b90d77d8b7@web.de/
> https://lkml.org/lkml/2024/5/14/551
>

I want to collect comment of my code in patch then send next version.

Joey Lee 

