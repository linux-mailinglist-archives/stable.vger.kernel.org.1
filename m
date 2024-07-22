Return-Path: <stable+bounces-60718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F9693955C
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 23:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB11C1F21B7E
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 21:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178E928684;
	Mon, 22 Jul 2024 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="K18hSOpP"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E31CAB5
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721683302; cv=none; b=llGtd7zKvgUnhHG9Qi+0dPrmyUf83aDgd5kbC/JLQMTh532wpFC3paeTJiv+0xuwfu+npyk0tCyPP99eGASWoNEnaX4KoB3CTIO+pFeGIQKb3WesnP4knWuyXfTznBl8nQYlnUd6gV2Y9uwfWr5IppHT8/+F2NdrE8MySHL01+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721683302; c=relaxed/simple;
	bh=0lpQd8qI5204hNQEXIF/V5SDukSCRny4FbkhxxRFDVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwXHuWRgUrtd5PDqrGTGTKbVSB568cU9uCx9dPC6BJetW3LhOBBqMKm8KHY106sx2Wr4/kxlmOV4AobsdQYGGcshpOCWxbhHSEZdZ/VzTiXiy48ReybZtONPJGYXdbqEbKdhFbvkKirxNm7ZHniEIVgQTEj1CjSCn5X3ULR5mHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=K18hSOpP; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-66a048806e6so30814927b3.3
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1721683300; x=1722288100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zqSoKvFiBiJxHeJhy5s7HFegZkcCFesRNlWHvZMNH1I=;
        b=K18hSOpPpilKps67RNy/YQSmjDRLNt/kidfgh8aKZMKCo2+eEsY0/GamQjvE1ludr6
         0VItPjOkZDTaZT2rSz5+zRca+hxVlZ4Yn3HKZErLHJThnwZlzzCGyKkMxOsxcY1VJ11K
         /arr656jSNum90DKferAWu0J3RCUbuVHNz9dqCq+CLTlSq55MuL161neohOvH5d9SEJD
         lQMV8GhEMSXUC+bvSVT2kXbgnaayyByTR3h+MuVU0SEe0o4LIrYB/TvX/zUrRUMuqfMn
         mMW2x6MAUJTbCux3h7K4L+pqE/iXlVYUAOVck7HPVvhAuY96vUJIC6YaLSrGZ6px03en
         Zuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721683300; x=1722288100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqSoKvFiBiJxHeJhy5s7HFegZkcCFesRNlWHvZMNH1I=;
        b=avzmIhmwkUjnSxjJHagGZ58pfrkEYPV2CACEIIxldoeb8PwgLncdL3rfzQ3KPvjU87
         F7RBmQWq47xS8gZzHZLRJxKubF8jYlw8kWVJX4pzymx7jK7aiQ2AQd1BGsSasr7ZsS+/
         GTSK8clkblbO1RAeKvA9skdGcoa8Zqay9TmK4B/4Tr+hjLcCt1WIrxLr4r3Y5lobcUdX
         sk8qwFmTf+YhYd3b9iNoJurO70D/hmDE+Epa4gAF2EeeQNxovUjKkM2VoNhmUkan40Av
         y0WlFwf9PdAeHo2e7aUGsMLqJeKH7KnyW33u+rwLkqrQ58VDfbnxRLMk1NCFKJPeNZX5
         99Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXzRM3WTy6AzREBj3Bnv/jIX3PuWrbJeOEnY7p83q7M6QJi89YAeJ2AR9QoYYQl0HC8vQ/rs4tM1/kNaud/1ihImq6TdO4Y
X-Gm-Message-State: AOJu0YxZNS2rnXQESkA+t4e1hk08IoUKlkNbi+TrTJrrUSTScG/qDx0u
	tUNqgo5fefIxC06HKeidnbbuVeay1lFxXIR4pdT2DK+iAmoxA2Vh4dtV1zpeySY=
X-Google-Smtp-Source: AGHT+IGUW01TO929BIzL3yzqV8bnWCQFvaquNG1dCHNmvJwdldWO0GlecujW79LoSol4O0vtRMmUzw==
X-Received: by 2002:a05:690c:660f:b0:644:ffb2:5b19 with SMTP id 00721157ae682-66e4b7ecf18mr14047497b3.9.1721683300197;
        Mon, 22 Jul 2024 14:21:40 -0700 (PDT)
Received: from devbig133.nha1.facebook.com (fwdproxy-nha-008.fbsv.net. [2a03:2880:25ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66953ae08adsm17874337b3.98.2024.07.22.14.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:21:39 -0700 (PDT)
Date: Mon, 22 Jul 2024 14:21:38 -0700
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jerome Glisse <jglisse@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix maxnode for mbind(), set_mempolicy() and
 migrate_pages()
Message-ID: <Zp7NYoBGrwTnJtrc@devbig133.nha1.facebook.com>
References: <20240720173543.897972-1-jglisse@google.com>
 <Zpv6KNYjZcBuQfEk@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zpv6KNYjZcBuQfEk@casper.infradead.org>

On Sat, Jul 20, 2024 at 06:55:52PM +0100, Matthew Wilcox wrote:
> On Sat, Jul 20, 2024 at 10:35:43AM -0700, Jerome Glisse wrote:
> > You can tested with any of the three program below:
> 
> Do we really need three programs in the commit message, for a total of
> 287 lines for a one-line change?

Better yet - why not a ktest / LTP contribution?

~Gregory

