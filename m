Return-Path: <stable+bounces-195450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA547C77175
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 04:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 19BAE31840
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 03:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06D2DECD3;
	Fri, 21 Nov 2025 03:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PCkYEqnz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C5155322
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763694013; cv=none; b=O2eqkxQMo+YjwNWTAYPuTGpGhj3yYHXr5fz2wM10CbjiVhzmV/gSeSbrE1h+/swZ9aMbFyxyj26ajczKwURKvaULPcIYOvA9gffuileS1XoFXInpCreeFbsux4lQ+CuS81Wd6YL71+5eHeuzGz1Q2qAJh4Dtb14qNUFGOzOeuIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763694013; c=relaxed/simple;
	bh=6UnKMS9m0WzkUknJ2P9VGxsS5gNcxDJtdGWfBbGjn1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YME2TPx7/iup0TghgoM1v9STnOzjx/gaDyIQNjbje/66h8uAMPPGgjPfnys7eBTo+NTZpdEAP24fkaTLARL8kz4oR6P9ER3nwvIXBXiDrQ4UpyKRbsOnSTYtDuS6M+AvCoefadnMiiuun3uiappEhEjvYzj8FJf0Qt+coJI0fAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PCkYEqnz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so1439843b3a.2
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763694011; x=1764298811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TwXQx/qh+8r1jODh/v1DnkHGAbvpfSuxgYbOTg93Q/g=;
        b=PCkYEqnzlfx+xPV/Cqay/WRE2XkIHLn0aPt+yHp9Eet2RPkchzc4kwdn5LveOY2GhC
         AGswL3+58ZmlX8Pb4b7q/qi/L+taj/gtQWnG0Mkc6i3snbnHBbBDCA5sJGhv6x3WZ3Po
         Vy/eiLw3bD+egVfH8fM8Y3mmgsbC2DNjan1Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763694011; x=1764298811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwXQx/qh+8r1jODh/v1DnkHGAbvpfSuxgYbOTg93Q/g=;
        b=El87oQAJdCdxtYbeQJT6piCWxDAInVGoYmcwmmgZicWtdUhuEZ0+ITxI5L2yxOo2dY
         odH/hbXBOZaPfjhpku6Dd6HT8zxjq6A8xcfzPnBVf/+3wcV3ExZpsH827JWzqE/4K/le
         ZVXj748BW9RxPDg6wG9Zq+mTVyeyrW3n0IydzjIDmS8QCHo77JV0k4/PzqA29L6iNDq4
         qw6OqeNydx5J1m9Vc/ncs9R3jdgifWZZ1QORAvaRAU8aHpkp5qI4VZU6FT9FJkqAQhwC
         2ShuSI5URTgnDubjUi3Mz6lczjEK8aMtTYEfcnGbm5W3JnKb620avpE7nhyIpv8YIvC4
         CucQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwP8LU+Lrp/ooIAfPTXw+q+qY3fMHegpsuV4wjQpwGJhtfj99JMIJeUEN0CJbgy9DFbDZY75I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8KvdWr3tJ1tsDi23shKNH7Q4K6rReG3douxt+R1D6kdjVLULI
	j+VQLXDWHPbp1o1/y+OSLglAsEkqrBMZq0Q3lA9tmaLiywXzcyZ9i75oYzZ+Y+zQAg==
X-Gm-Gg: ASbGncutjatebWe5eqlm8viT3Mz2MGknXUDTWQQlxle40Wf8F2lDLLsZpPyhsk51b0P
	FadvYrJNzBGRjOGrUfH3KXheH6rMW7SwxX0loPGazEB/dU2i5qX5BWLFjkZdOoMlXVzV1xuIYJ4
	k294b4aLMjyoR1Ue0lCstVuGdWuBC4HcdZVtKhxUfiR/pIIVvH9L7l4h4P6syjPr+euo8pS2umP
	+5ldvCweM3KfpCzdFVLCXwRdBTH9cHVQEKrCH2qcDb1NFF4G1704vn3N/U7ANr9y3CBRHJGFGd8
	NmIXKpvACRT4uxtiVDYDGs1a95+RZ9hOdSg083Tyn2g0NLjBjxL7MKOdOj/l/9N5ZQk+U5aW6nE
	7EjLapkRFLKPxPZaTQ6dHVYAbiGjn4CY9DTDue31X7EKO9BBVvAXEIZkF2cp3PsD4Gqqpz7kdWj
	fPl01SukSLH3EbPQ==
X-Google-Smtp-Source: AGHT+IG951CqwfOawPLG6jVVC1czgIM+nx3fCQxsmCgvHKHhNOQ+U/RwEh2phaqkDepdH4cN/K2ebQ==
X-Received: by 2002:a05:6a00:1895:b0:7b9:a3c8:8c3a with SMTP id d2e1a72fcca58-7c58beb75bfmr652832b3a.7.1763694011521;
        Thu, 20 Nov 2025 19:00:11 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b321:53f:aff8:76e2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7d849sm4210618b3a.14.2025.11.20.19.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 19:00:11 -0800 (PST)
Date: Fri, 21 Nov 2025 12:00:06 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yu-Che Cheng <giver@google.com>, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
Message-ID: <xhv2eshihzyt3j2tc7oz2gn2gkhucmlnxhoxyrdkxdnxtfwkmb@ebknoqcery5u>
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <CAKfTPtAkYfCYc3giCzbDFLBDNTM-nXjkE8FXMZhvJj_im+Qz0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAkYfCYc3giCzbDFLBDNTM-nXjkE8FXMZhvJj_im+Qz0Q@mail.gmail.com>

On (25/11/20 11:55), Vincent Guittot wrote:
> > Hi,
> >
> > We are observing a performance regression on one of our arm64 boards.
> > We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpufreq:
> > Rework schedutil governor performance estimation").
> 
> Do you have the fix ?
> https://lore.kernel.org/all/170539970061.398.16662091173685476681.tip-bot2@tip-bot2/

Doesn't seem to be helping.

> And do you have more details to share?

Sure, I'm going to be offline for some days, so I'm trying to
find someone on the team who can take this over while I'm away.
I'll try to help as much as I can before that.

