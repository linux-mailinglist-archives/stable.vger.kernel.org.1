Return-Path: <stable+bounces-126834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE7A72B79
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 09:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9EA1892CD8
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 08:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6DE2054FB;
	Thu, 27 Mar 2025 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwog2qQj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5D17F7;
	Thu, 27 Mar 2025 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743064144; cv=none; b=T45zwuTDO6/mvq2jApyrPBICo6bVxVDKxAnCT5lweGIHKsvQE2tAInJDbavBRDVrZlXMYUdSSMOHbTqkBpQF6AbXv5sIbHRFDtcapgX6+LvUhHp2bxH4RbPvvKnGYdPtkQJR/zqzDm60KrtNMy7mmLYyTYdwQHvutY6wZicthLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743064144; c=relaxed/simple;
	bh=/KjbeBkX0TUviFp654wJl78xlNao9GXDXJZEcc3NUTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofp6U7uY2H5jLLvmRLE2uC6drJAPdX4FeAUCVS2Fm4j69L2PCQzMWBXLMXd0pcV5rCQSmBdOXqtcTOJCdGncQO3QbYwY0x8DSGgYvSjjbw69TA8ZjNhOrV/aOVM4ivuRihKkZFvKJ0nDU4Qaii3WaqqHFGrS9/BGXPV2LZUc2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwog2qQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9B6C4CEEA;
	Thu, 27 Mar 2025 08:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743064144;
	bh=/KjbeBkX0TUviFp654wJl78xlNao9GXDXJZEcc3NUTk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rwog2qQjARFqB191XG5XnEPAhbZjGosUXmz76mUkNJYsCN8qTXy4M+slR2Z7Gn9sF
	 S04skBrh1C3X/+v0Xei69RUHKZOPXYguZRYzf9ibV9RVF1F35wjuBEmVSnd8xAvg1T
	 bs1z3hUKg12hJAjcTjfOnkCkEtvgPvgHz7548qgga4mGNHUvjT1LzALqPr4V6/8443
	 UIp21EQblZ5yUuIQDRA7tgzW4HJfs7TB99flTPeG/dNSwfTo8I9BHvNrE/0/7Zg4Ij
	 YynuIcEnwiHdTh+JTAOi2vGxpmfXmoGLoBJLhlEs9NqysdSZknDWPVYl2AlSPBB+ZV
	 /fwg9/PqhQFgw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499659e669so687416e87.3;
        Thu, 27 Mar 2025 01:29:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgxuD8jF3zm3Zj7sH9pGK2CW0XwiV5I5tgt5jm/jBTLTswA52npVqMPAbnUC77YGqzzKOHk5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmkYWgVa5QLOPA7jIgdzqfpzVFFzUosLFIDtlAotdw6jGWGzjG
	bvi1K5zeCoEaoaekv0v8/l4Z48nOztkecxxu7HgoOz+pbgbAOKYmIMbOV71T9IxhdahoOvGHkbn
	mCO2veSGLHPgue7DBf1fokH9wr4o=
X-Google-Smtp-Source: AGHT+IEEGieGBG8VFA8rb+y0tpCAmH/6HNPAEzzY/KEP4vlPOJPWtbUXUOj6CLdTYNNWvePwtsUVJkNrLekrEIj/18k=
X-Received: by 2002:a05:6512:2354:b0:549:91ab:54cd with SMTP id
 2adb3069b0e04-54b011ce529mr996187e87.4.1743064142537; Thu, 27 Mar 2025
 01:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326200918.125743-1-ebiggers@kernel.org> <CAMj1kXHCJQ4-KAPpWFA-rqjogbebUP8Y=NKrdEB1ZmSbKG3bdg@mail.gmail.com>
In-Reply-To: <CAMj1kXHCJQ4-KAPpWFA-rqjogbebUP8Y=NKrdEB1ZmSbKG3bdg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 27 Mar 2025 09:28:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHzonmwoji49sCSJ__0ZwhfqBDVxBPJsgywbTTZ2Q=hBw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq-0MlPxa7VBpHCtJoChVZeqv4ZnDpsM8XlJmsmdinC5Ej7iKCpZ3JGon8
Message-ID: <CAMj1kXHzonmwoji49sCSJ__0ZwhfqBDVxBPJsgywbTTZ2Q=hBw@mail.gmail.com>
Subject: Re: [PATCH] arm64/crc-t10dif: fix use of out-of-scope array in crc_t10dif_arch()
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org, David Binderman <dcb314@hotmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Mar 2025 at 09:15, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 26 Mar 2025 at 21:09, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > From: Eric Biggers <ebiggers@google.com>
> >
> > Fix a silly bug where an array was used outside of its scope.
> >
>
> Yeah - mea culpa.
>

Ehmm - tua culpa, actually :-)

