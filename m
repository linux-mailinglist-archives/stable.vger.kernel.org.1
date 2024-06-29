Return-Path: <stable+bounces-56121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ABD91CDA6
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04A01C20EAE
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1BA548E1;
	Sat, 29 Jun 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/QVuFOW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A120821364
	for <stable@vger.kernel.org>; Sat, 29 Jun 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719672663; cv=none; b=XAPOhL0n/qP9WAZEvJj5MGEnREOeCwiJCPRs/r85yeKrEKtyGpsdqZJKNLtWQZcSr+o3GpTdHxSYBsH7vkJu+2CdqAGdI73hfG7iaub3HuvCF+M/n604DezLUybmizk0RoO8iTAFT2bOxTGJ1kSynLrwW+c840lmSyS6MBlh1wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719672663; c=relaxed/simple;
	bh=7l8H4AiU3JIZBfwrfFOEuA0QFAe9YMBbtTUl0Xos0Lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIXwYcXWHY8IQN+7B0HFrj8TAT/yvEuULneIlBecwZolUWBm6jZld4DTGjg9jTQ7muHL0RGMOsBu37kS8eKkhlTjWNqt71Td9D5fuYP18+933WnHMYHOWTLEVZuenBbHMycWR+FEWnPpR+ZRldY+IHKNavF7r4FTBvxDettgHjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/QVuFOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174B0C2BD10
	for <stable@vger.kernel.org>; Sat, 29 Jun 2024 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719672663;
	bh=7l8H4AiU3JIZBfwrfFOEuA0QFAe9YMBbtTUl0Xos0Lo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J/QVuFOW5SZlQgIhevRh/NEGEpVgc7Jizu31iQ0VReMQ/Fm7F9nXVkhAUWtcR2dlC
	 2+jOncy9TDf5jJ3jpjWTcCPAmPKzbeWK2xVz2XG1eHij93Q3Vm4yDZpulAvsv6gTK+
	 gv4uJUpa+ch5BUMFuIJ6/JT9xgGY7J1gs3N7IzFypdQ4slduw0N5g/81pXgx4XOpA2
	 S6NI6ow5RzDa9gfFu4RwXiio5/WvYRqERuP5M3sgHZki9TxvRcZPssuIEegOzQdiO5
	 E1Xi7BL6HCln94RGZYgwSNX/kRE/f5sPnzuQeJi7fOrsbz6q1Eu2bGLdRXS8P0T1Pp
	 ATEu+5A5Nu5KA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cdea1387eso1698610e87.0
        for <stable@vger.kernel.org>; Sat, 29 Jun 2024 07:51:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZ15COxHa1kgz4f6w68jMYtegOuoC29BySYyiHcpymJc48MSRIVqHURMPv4PdZXsAdaKEFEoEbKonkGUY/ijvsKTu8pyjV
X-Gm-Message-State: AOJu0Yw0qyN8Dmu01WQsZEWbaJCTieaohliA+rCRblDZvN0jpDe2bKO3
	CF+g/LDk+NQNxbkBJVn2k4LAV94g68Dct3aHZh6Hs0M4f0pEhovqVFat2QY9FHsoeY1qwzT7WJV
	uwEVTpw939okaFa3mvAmQ7nT/8Wc=
X-Google-Smtp-Source: AGHT+IEAod5QWLhlbab+1KhGSyEAmTTxCdM/MKi57U0uYfcrMNcMdlB/OvTxffGjRiGzJLUGbwHDhemLIp3X7F9bTLw=
X-Received: by 2002:a05:6512:3e1e:b0:52b:de5b:1b30 with SMTP id
 2adb3069b0e04-52e826fbb96mr1091060e87.44.1719672661380; Sat, 29 Jun 2024
 07:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024062442-bonfire-detonator-1b17@gregkh>
In-Reply-To: <2024062442-bonfire-detonator-1b17@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 29 Jun 2024 16:50:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF5dosTmitMvCiYCb8Xo=+a23zrUd1F7cyWfpMFba0SXg@mail.gmail.com>
Message-ID: <CAMj1kXF5dosTmitMvCiYCb8Xo=+a23zrUd1F7cyWfpMFba0SXg@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] efi/x86: Free EFI memory map only when
 installing a new one." failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org
Cc: Ashish.Kalra@amd.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 18:41, <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 75dde792d6f6c2d0af50278bd374bf0c512fe196
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062442-bonfire-detonator-1b17@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>
> Possible dependencies:
>
> 75dde792d6f6 ("efi/x86: Free EFI memory map only when installing a new one.")
> d85e3e349407 ("efi: xen: Set EFI_PARAVIRT for Xen dom0 boot on all architectures")
> fdc6d38d64a2 ("efi: memmap: Move manipulation routines into x86 arch tree")
>

Please apply these dependencies (in reverse order) as stable
prerequisites. I build and boot tested the result, and it works as
expected.

Thanks,
Ard.

