Return-Path: <stable+bounces-112275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AB6A282F6
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 04:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACABD7A2600
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 03:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878DB213E65;
	Wed,  5 Feb 2025 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMbVHHZK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E181EB3E;
	Wed,  5 Feb 2025 03:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738727132; cv=none; b=bPqe0aoqoUhvrnx59mwIyuZOGApxuZ3GZSL7ntp/nbjJAadMj8H4BieaqIcVbr3BUJy2dA2+9B4tfsLcaTaqbKVFW7vQAlSTdN++kE3WSy7OVfC1k6ck3/soVogJ/GT0DR9qHrZtuZhH4Has/C2qz50hKwBAXJJVv2I6k8+jn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738727132; c=relaxed/simple;
	bh=qT3uB6BFnXnuoNmO5ZICAMNYpk2rYRyb7Df6Uuc3yM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t91UzA2tKS16LeksCoSwrCjdXdqJ8y8pLRniA03xcMX3GVMnFI2bwClyfZZj2ApMAe2iM0Icr4Xlq+FquPkegP9HZqkF0lqoL4PFBoFm31RvN0tQoJUwDX8z0tw1xhU3o91W6FZCO8bFLktGJBh6Xw5MOTOtp7TGqZC6g6NNFco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMbVHHZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC15C4CEE4;
	Wed,  5 Feb 2025 03:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738727131;
	bh=qT3uB6BFnXnuoNmO5ZICAMNYpk2rYRyb7Df6Uuc3yM4=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=pMbVHHZKs7P25UVROkPy0e8TaaRQkao/kjQBlVYOjxMxdnZKVKpnfPw73WfAYObhK
	 TmYJoKrLJgF4y0gm/qS/tYKJk8rVr9TdlqWWlmLRjN16I9XT+om1a4rP2N5agr/iEf
	 rPJrwrhrlNpiGX98R6ZwiVySLAZpgqhX7XnuR2SBzKGth6LJZzfYtzMffblRL34nAe
	 kBQgrJgOg77v74XUFvNp3smUos2M++mJKHZ9utXGhAFqbCqrg7VCXse4GR1gFKiZmw
	 Cya2bwsqJ6gegFg4MU1615gvJtSSw+d/oyAQ1SHOzdM3SfNr4IPMWNBn7zm7+h9MSl
	 NGtinAJqKkzcw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30227c56b11so62440781fa.3;
        Tue, 04 Feb 2025 19:45:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwOESc3wAml16HvmRuoiyH4EJg0/rWGMysowPWHVstjJv0phUO/iBhugb3Z110EbC5wKCWp9NK@vger.kernel.org, AJvYcCWo5q4nFsAOLZezVH983UVCsLzE6GLNMomlD4OkVwt7taHFO4VSDqlGVq+GgREBMlUZRXiY4alb+27/Hwo=@vger.kernel.org, AJvYcCXis4gX6+JemXXn34KUnVTh+Ga3ldpxx1sjCh6wKkpOoUVDNdpMkqy7HreJDydu/V3Co54ECPxi@vger.kernel.org
X-Gm-Message-State: AOJu0YwVT7Mwehj/iJZ3kI7TMysuHMSDcshiuE5SjlJFHmlemtC4UHgy
	9/oYya2Ls3TUuRX54khn3yyeLVtaDOmJtthYpinp+ZwywnsshKlhlqmbK+obE76uK1aC3LtVtEB
	VgHWtNzcoczHD1DvOKzSUbveg+f8=
X-Google-Smtp-Source: AGHT+IF/j4mjEmNMJlaOseMTc31MNVXclZ/WljET6VoPTchVI9nwi6yNBFx9ce6hMcBEMWkiJTzpYrsil92u3LJXWWw=
X-Received: by 2002:a2e:bc8c:0:b0:300:33b1:f0bf with SMTP id
 38308e7fff4ca-307cf23bdb9mr4600901fa.0.1738727129916; Tue, 04 Feb 2025
 19:45:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204161359.3335241-1-wens@kernel.org> <20250204134331.270d5c4e@kernel.org>
In-Reply-To: <20250204134331.270d5c4e@kernel.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 5 Feb 2025 11:45:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v641vvtVKv8QbiEfHnMWngcKYTJZAgfH5k+G_nOvZcbC9g@mail.gmail.com>
X-Gm-Features: AWEUYZlfZKNFERbjqveUEQnkoJAkV94srAWQ5Bo9GwhmHD8TgbxWwy-L79DYJGg
Message-ID: <CAGb2v641vvtVKv8QbiEfHnMWngcKYTJZAgfH5k+G_nOvZcbC9g@mail.gmail.com>
Subject: Re: [PATCH netdev] net: stmmac: dwmac-rk: Provide FIFO sizes for
 DWMAC 1000
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Heiko Stuebner <heiko@sntech.de>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Steven Price <steven.price@arm.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 5:43=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  5 Feb 2025 00:13:59 +0800 Chen-Yu Tsai wrote:
> > Since a fix for stmmac in general has already been sent [1] and a rever=
t
> > was also proposed [2], I'll refrain from sending mine.
>
> No, no, please do. You need to _submit_ the revert like a normal patch.
> With all the usual details in the commit message.

Mine isn't a revert, but simply downgrading the error to a warning.
So... yet another workaround approach.

