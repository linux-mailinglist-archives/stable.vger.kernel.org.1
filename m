Return-Path: <stable+bounces-197618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0EFC9294D
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FBC84E2855
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E3B26E718;
	Fri, 28 Nov 2025 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBUzgcrw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8649EEACE
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764347443; cv=none; b=UpkXXMvIu63boDmLQzucd4RuiqabxSt5w9E7TE5A/xAl88qHUO7f1ESkhg6y29XOcEXWWx1I4wWrytGNmDOfVevHWwtstECMVPTYjmjzKOychkl1p2bD9quKxXNZeQBEUFkoG8ErqoYtlMkU2/16hRgHfXzYusXLN6rUIL6fzyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764347443; c=relaxed/simple;
	bh=XnsAGt/K8t48mxSClqWIxlzwe7yWwxHAIh7zgQNrVdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR+QDa6tTKWbyNsWETGVyRWW/LalNbLzqrsq/UZpDKP7KHowO4J/pzokUAS6bs9k8iLB+QbzjqxSXLqq//FJLT/dQVhJXJ7T/NGfUZXiZAUTqW/mPEiad2VLrsRIgC/LnFgLo+kEzLnTxFfFoGt9rtUkoeyHrLAJBjoih7+EE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBUzgcrw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aad4823079so1817846b3a.0
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764347440; x=1764952240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnJSFmXIzcu6m8f2k6bb5zTTnIroco3rAnnd5ePbVg8=;
        b=mBUzgcrw10whZBouZFSWgtcY77tzDKtd1gbNWRBGG4XCOSd5rr/HSM9xBdPLDie9mS
         FexyYQOcMHIPro7wVrvyCjwHWzCdtQBj/5oqCjq66uz8H51W9mFVRh6iwfVf/3+bcnbw
         JRlbRqfOy/u9PY2aLyRIr3YDkfecxDiTKCpvz9lciBIfFfBLD39OWoOlxm1RiN5tKkEn
         ysjBjtOmQRhXaUC4j/hucWKzvrFnlGdM34eeJJ1hrM2xtv2dIQMdU4LXK/qchUZzbS/c
         IWMcJhOwvGucAx9U8F7cF0kRsB82bargKn81VvgxSa2b2VxV4QvqqVYR23W7iE/3b5b1
         4Iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764347440; x=1764952240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bnJSFmXIzcu6m8f2k6bb5zTTnIroco3rAnnd5ePbVg8=;
        b=BRl9xkCK4W/k8A4hiYXiemvj9NYt3AWKnEEw+jCmu+TvjikfBP3tvB09mBlHSyody2
         TGhLLVrW5oPYhDnu+fUa8ZwPbBAYQl+ZA4pKP3Z0v4xI+0+FRpoePFsxg5JWNTrbWemr
         Cs2D+AjG89ephp/+DhRmayze3bX3mWvWK7x5X957+Yyl6kIy3/fVRJXMRZU8vaiyRK40
         fD9nOhyo3eZcfc3E9JbIjveI1+45h66nm/oC7FKRt9+TZUVF6y2KvrlJzXM6/V3oJOr5
         to9BTDm9QUIE4P4p1jF2u0dasCIrICTwUuKEAanaJSbVq9DI0OK4RNGgehQD3D3TzxbP
         SNjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT8nqIU7G2l59Sq1AJ/qKAF+kN4wIZWOMo6pMRQwyRnGO/yAluJ7YyWDLJ3qZH28g/6jgAmBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOrBZn44JL9ld7Vf4GwFhgLWTz8D72VcdJSaW0yu0F7dOrMOMs
	61dMeXkaTMJi6/foFYe7oq5lX895kjqmSkgOmVXY5O2sVCjOwWXnqY95
X-Gm-Gg: ASbGncuEiYc2EbwuJAn7bRRb9u49mEZMh4FRCDS0+1mGFti0k9EqkRpF/pHxomlY+P5
	ZIrMlE7Xe9kzrL0c3ZFCNt5xKn8eA6q2BmorXCe2qWaZgEaJpvawT9Kxgf2kcpsUUfrpZqj+ToS
	6waUoQlMaZkjyAGYhVgLxFaEkHxPkTb1kxsv84b7ON0ahNv/jHiMkdhW8bZGSRUM53JkFK1AC5J
	fTlZCmTsWRTmYDH24p0b4RzFQq6OGJj7ShdMY5qMjmZTncdSlimECvBSETFHrw+8ZIhCtIJFqYG
	Gyy61yk3ShqGLFqfrB2C2XTQcRPiz3fcpD1Hn7j6ZIbkJQ2kk6kR6n2ISvdw2qkt+MRwhCcH/Rj
	04XXWd2IG5xn12y/6Vxe6D7k9rfZU5Io4BV90wszxDbMLo0sVngWkrEQ50Xk5ZmJsoWur2baGqh
	TV4TMSKHwTm5MfW+sAaU93ZiM=
X-Google-Smtp-Source: AGHT+IFOQUFqcyf8Z/GfA3QnB9AfAAqcIZA/UlGBc772GKHTlSMoVyFyjFr6O20exxh0wIxbOSubzg==
X-Received: by 2002:a05:7022:f509:b0:11b:a36d:a7e8 with SMTP id a92af1059eb24-11c9d812b80mr11166033c88.13.1764347439320;
        Fri, 28 Nov 2025 08:30:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb04a07bsm19837274c88.7.2025.11.28.08.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:30:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 28 Nov 2025 08:30:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (w83l786ng) Convert macros to functions to avoid
 TOCTOU
Message-ID: <554af5b8-4a52-40ce-aeb4-59285977cfe2@roeck-us.net>
References: <20251128123816.3670-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128123816.3670-1-hanguidong02@gmail.com>

On Fri, Nov 28, 2025 at 08:38:16PM +0800, Gui-Dong Han wrote:
> The macros FAN_FROM_REG and TEMP_FROM_REG evaluate their arguments
> multiple times. When used in lockless contexts involving shared driver
> data, this causes Time-of-Check to Time-of-Use (TOCTOU) race
> conditions.
> 
> Convert the macros to static functions. This guarantees that arguments
> are evaluated only once (pass-by-value), preventing the race
> conditions.
> 
> Adhere to the principle of minimal changes by only converting macros
> that evaluate arguments multiple times and are used in lockless
> contexts.
> 
> Link: https://lore.kernel.org/all/CALbr=LYJ_ehtp53HXEVkSpYoub+XYSTU8Rg=o1xxMJ8=5z8B-g@mail.gmail.com/
> Fixes: 85f03bccd6e0 ("hwmon: Add support for Winbond W83L786NG/NR")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> ---

Applied.

Thanks,
Guenter

