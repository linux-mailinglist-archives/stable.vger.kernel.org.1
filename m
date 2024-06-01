Return-Path: <stable+bounces-47826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDB58D7119
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 18:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2431F21E18
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3831534EB;
	Sat,  1 Jun 2024 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpiVfu3b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A2152E1A;
	Sat,  1 Jun 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717259252; cv=none; b=F+WZLHHnBUiFRRPiUFN8dsu4bcBTpfkl1yyea4ccFbqCtRtH7IxRnog5WWnIT6uWOnDePeq2XuxZ4A7XhIvLzN3+Uro749F4PZf3PoyzVJJDZum+hHqUTMuMvrJAVMFUfnaNzg8q4LQ2m3ZINjl5SLoCpweZWRaqYJ/7x0rHcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717259252; c=relaxed/simple;
	bh=YjT/HqB+OVAmXmgDN4wwFDLygJNHKkJJ5MJwsyQjvfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMzXVAWUdDAZlVT05iiGiZvf9gJbuROWTi+lUMpoawezU+dhX2xlREzZVEdjpwvfHcFy+JahMAoiqCksWDFwgx7IqjVuPuIOhQwfWlcE9CKzzl/oG2WXN2a/neqb/A8qacpZxs2l1MRLa8t4xnHe9P6R2ZPUPs3GqE3AS2eVILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpiVfu3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457C2C3277B;
	Sat,  1 Jun 2024 16:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717259252;
	bh=YjT/HqB+OVAmXmgDN4wwFDLygJNHKkJJ5MJwsyQjvfs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FpiVfu3bSO7ocbUGjyxi84+d1DLoVXtnXpXaZii6sg+bxSCXOAR/Dlx4y6O4KbPdD
	 jC3Xh5vM5wlh9BMD7BU+Ux8USNbToO7uqVdWpaR0ruQy/w+4dw4WGvv5Zr4EfJrp/7
	 uD25HEmwyArNYKtyM/si8cPqWOT8tLiZ/eq9fNo6CUoQAvwgznLZtDppOwaiXhrsoA
	 s7CdtgM8IQpWjIXHyohFoTLCuDpZHzSw9aL5iZEs/gNLXb668n9xHazSur0HE+u/j4
	 0HXGzDUbR6ZFMq3ikHYou3bmNNwB4rXLdJ1PS+iR3RFKPyE808J12yyy/9DGEbiPw7
	 fF66DxekZ8WZQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52b950aa47bso203357e87.1;
        Sat, 01 Jun 2024 09:27:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YzQso/i+nsxK/q4+Pvf8pVb4SuwfuggmJezIvUnn03KeHvFci7I
	AUBpv1+M4Ilj7t5x57oxphZLcg1eEtuJ2kgM/+3GbE4C6izR+em5V7wn2dfHLdrA6K1aRZX6opd
	EcS+RP2yV6VquwTHVtpS4m2yKRFY=
X-Google-Smtp-Source: AGHT+IFY7oJgYLLcZigN136labmjIjfxWe12UE/nF9sGSj5FGWH/UgeM6KAe2QbidwRYDeDeLZ5LTQbLShPQrNRv/Ls=
X-Received: by 2002:a05:6512:239f:b0:52b:9037:996a with SMTP id
 2adb3069b0e04-52b90379a95mr1650808e87.28.1717259250898; Sat, 01 Jun 2024
 09:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530191558.29017-1-sashal@kernel.org>
In-Reply-To: <20240530191558.29017-1-sashal@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 2 Jun 2024 01:26:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNATcMm5Ypz+U5LmRpf57QA9xthTY0jUiNVirWwSvWX+4ww@mail.gmail.com>
Message-ID: <CAK7LNATcMm5Ypz+U5LmRpf57QA9xthTY0jUiNVirWwSvWX+4ww@mail.gmail.com>
Subject: Re: Patch "s390/vdso: Create .build-id links for unstripped vdso
 files" has been added to the 6.1-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, jremus@linux.ibm.com, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 4:16=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     s390/vdso: Create .build-id links for unstripped vdso files
>
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      s390-vdso-create-.build-id-links-for-unstripped-vdso.patch
> and it can be found in the queue-6.1 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit e5fcc928a0c3c2fe5e6e2c66a16b7d67334fac02
> Author: Jens Remus <jremus@linux.ibm.com>
> Date:   Mon Apr 29 17:02:53 2024 +0200
>
>     s390/vdso: Create .build-id links for unstripped vdso files
>
>     [ Upstream commit fc2f5f10f9bc5e58d38e9fda7dae107ac04a799f ]
>
>     Citing Andy Lutomirski from commit dda1e95cee38 ("x86/vdso: Create
>     .build-id links for unstripped vdso files"):
>
>     "With this change, doing 'make vdso_install' and telling gdb:
>
>     set debug-file-directory /lib/modules/KVER/vdso
>
>     will enable vdso debugging with symbols.  This is useful for
>     testing, but kernel RPM builds will probably want to manually delete
>     these symlinks or otherwise do something sensible when they strip
>     the vdso/*.so files."
>
>     Fixes: 4bff8cb54502 ("s390: convert to GENERIC_VDSO")


I doubt this Fixes tag.

I do not think this is a bug fix.
Its prerequisites are not suitable for stable either.











>     Signed-off-by: Jens Remus <jremus@linux.ibm.com>
>     Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/scripts/Makefile.vdsoinst b/scripts/Makefile.vdsoinst
> index c477d17b0aa5b..a81ca735003e4 100644
> --- a/scripts/Makefile.vdsoinst
> +++ b/scripts/Makefile.vdsoinst
> @@ -21,7 +21,7 @@ $$(dest): $$(src) FORCE
>         $$(call cmd,install)
>
>  # Some architectures create .build-id symlinks
> -ifneq ($(filter arm sparc x86, $(SRCARCH)),)
> +ifneq ($(filter arm s390 sparc x86, $(SRCARCH)),)
>  link :=3D $(install-dir)/.build-id/$$(shell $(READELF) -n $$(src) | sed =
-n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p').debug
>
>  __default: $$(link)



--
Best Regards
Masahiro Yamada

