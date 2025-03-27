Return-Path: <stable+bounces-126833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5C9A72B32
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 09:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33DD77A3440
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 08:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD81FFC5D;
	Thu, 27 Mar 2025 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kN80WkkY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47E1FFC48;
	Thu, 27 Mar 2025 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063323; cv=none; b=COVbxFSm4Vqy8Ltixax35pwHD0LMRQmdMhM1bo6kkKPRksTI7K+UwKpJv5rf1aK49YMglfxPB4+IF88zYJ4YipmNgdYo4vTqpU8ZIHYLWy0zAdBMeR2b++6eJv7IZbZX2LPpKjCAepXlNmGYaYXyknsY/pRVTW22urcyA0HXXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063323; c=relaxed/simple;
	bh=9PgcpZ/esO8INWaHTNIYzHKUcxhITaDwP+ZHht7YxcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l54V0LNM3pOmAkjOxQTkPeXdN62DvSFCHq7VmZkXguTj/FacDw2fV/ymYHxUp5d+vku4sXm/4e0Tdp/fwgZWdwy66Ip7LgOlupTFi/Ja7Q0NbeLm1ewmo3q1m7uGxI67IwLsedB6rna4mM2Ai7XPDxlmCkD2jNyC2pG04noRqsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kN80WkkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217D4C4AF09;
	Thu, 27 Mar 2025 08:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743063322;
	bh=9PgcpZ/esO8INWaHTNIYzHKUcxhITaDwP+ZHht7YxcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kN80WkkYt4/TjO/Zu1shRNEzCG0QNS7grNgvpXUv+HxUXqD6UK97w9H6EWT2DCgTG
	 cs9XKSW20hQGZydiUIsxe844jcUKkAPBfvKnVt+HAjlzUgsdvaLF8/KiYeypC9dBjJ
	 hrs3VWO4pejTqeZweR1qBlzT3qG7B14b38rFngUwdmvFTLhNjfY+179AA2vsZ2CRXw
	 L036VSY0TMHyWUs0A96rpXhdMrW3GzGdSKk7Hjkm2sa2Rrj+zwZi+1Guyy9RpsyShX
	 jXuHnNm/w6wFLZTr+yxOwKs6C+Y7m4okQwsb2TVTIiKccIeZBuS5iktMf6dRR5YTPA
	 u3M9LRVCdhqRw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bee1cb370so6949591fa.1;
        Thu, 27 Mar 2025 01:15:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbmuOJbuN8bOe48mP9RDZ5lKh6IMg6ESaL/fj8CB9cqBMXd9j6CuuuFuH9McKc0ZR8dl+cZo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPKqOOuOmUkEvc6N4TjAftwxCZKvBb4g4rpf5jvfdTyEaNokEl
	MHW543BcG+QNVxLUa8MGj5M/czxZED7bDDOcqzpMs/9VFieL3mlRy5Tg6TNTA7L3WebIYnD6O98
	/jUTWMzwhQ/Auy58g7t2FDRpLMbk=
X-Google-Smtp-Source: AGHT+IGkw8DaYd4Eu5NEbusC5ONevkWWyvGlPYa9uF267c64a1SDfB9oFxUUIQo+/5FzHdRWEcPrx38Io9KtoibvkTU=
X-Received: by 2002:a05:651c:388:b0:30b:f15f:1c02 with SMTP id
 38308e7fff4ca-30dc5decb2fmr9982021fa.18.1743063320450; Thu, 27 Mar 2025
 01:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326200918.125743-1-ebiggers@kernel.org>
In-Reply-To: <20250326200918.125743-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 27 Mar 2025 09:15:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHCJQ4-KAPpWFA-rqjogbebUP8Y=NKrdEB1ZmSbKG3bdg@mail.gmail.com>
X-Gm-Features: AQ5f1JrIWn7OOFzH7s-batV_zW2_biAisG1z_ayEXTgeejni4X1t4_knp6dOK9A
Message-ID: <CAMj1kXHCJQ4-KAPpWFA-rqjogbebUP8Y=NKrdEB1ZmSbKG3bdg@mail.gmail.com>
Subject: Re: [PATCH] arm64/crc-t10dif: fix use of out-of-scope array in crc_t10dif_arch()
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org, David Binderman <dcb314@hotmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 21:09, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Fix a silly bug where an array was used outside of its scope.
>

Yeah - mea culpa.

And the fact that we exit with a tail call means buf[] may be
deallocated by the time crc_t10dif_generic() refers to it - I'm
surprised this didn't already break in testing, but I suppose no tail
call is issued for other reasons.

