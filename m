Return-Path: <stable+bounces-38593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1907B8A0F71
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A921B2317D
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FA5146A82;
	Thu, 11 Apr 2024 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UU5YGDtt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD14145B26
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831031; cv=none; b=kGeEpqspUv8RfNftGkSu2fCB3jQC0viw3S/WPWN0FNdPz+5Ge7NEuQSzHrBlGuJryNL1/ncfpSZkyq9Psrr/I/DJ+IGyqrcXDb16pn3hIc8idJVbz2YLFFm4wgoJOkZhzJE30QEixtUVtbrvOkMPcqaDFzvrQ3UtT71HfS22s/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831031; c=relaxed/simple;
	bh=MTcx/3gMB/VETB37QkC86nIrNO5Ed3Znd6ib7+AVlQQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=imL7jc9WWOCNEXwIgWPIT0EetMuKjUODBXTcg78Am5YZ/LZTsz6QkQTaTAuv1N8YLZjtJgLwveDVD6IoPOCO508sVb9pvk5riIzsxPmcfftxMhgC57seN0ZuiC0eHWRjG09+wpkyemMnpSAx7dpVZvSuzKdJKy393X+ThQ/XELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UU5YGDtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0081C433C7
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712831031;
	bh=MTcx/3gMB/VETB37QkC86nIrNO5Ed3Znd6ib7+AVlQQ=;
	h=From:Date:Subject:To:From;
	b=UU5YGDtt15ia2QUq7t7igV6M2pKZjbY/MMfFmaNWhMPVscdbG26VHVgB1jSw9ALVC
	 SgENzEk74MsXEwwNYNSCI/n/6dW8S+k5vQhN+lCppnbl36yXSEPGbjk3xi3ySU8KfB
	 tMKb2XVqBe/AQCO+4WDStnclxfqmoGe1Z+UFnsdq2Syq97ipwru64C8kGDBtUe7VDC
	 Ul/x2FsQ+ISdXIP+gMANl0i+VDnudssfBPqjZruMuc7oOH25fkYEjByiRXFh5Q//Vy
	 nQNWJcddAn14Qk5ps4AVihQFkBj//ExB+4PgQEvsulrjfXwR7jEyU3Q/aeKHxQ5aD2
	 KI3vDur0Up9TQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d87660d5dbso57140561fa.3
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 03:23:50 -0700 (PDT)
X-Gm-Message-State: AOJu0YyPalFHF5/3UtayNgmE0/A4kPJ+GYhP3nT0ExV0/FKhOPv+10eL
	cuMdtQTM/o/ipfZODT/jgQi5zES+XxV4FOhQOikWY75DDD76uL9icnoUwRipOnl58m9ktvRDMxF
	yvNwiwUsKXT7M5de2tOOtQYExgKc=
X-Google-Smtp-Source: AGHT+IE8/9LMup2SdcPAUy6HyZ6t3NvbKAPy3GYrFYDjZ3c3thyWEmu7lJdswZ6CxS1k1lljttHMoyQhkxaEEeE4e9c=
X-Received: by 2002:a2e:9dd7:0:b0:2d8:1267:3202 with SMTP id
 x23-20020a2e9dd7000000b002d812673202mr3366797ljj.10.1712831028937; Thu, 11
 Apr 2024 03:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Apr 2024 12:23:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEGNNZm9RrDxT6RzmE8WGFG-3kZePaZZNKJrT4fj3iveg@mail.gmail.com>
Message-ID: <CAMj1kXEGNNZm9RrDxT6RzmE8WGFG-3kZePaZZNKJrT4fj3iveg@mail.gmail.com>
Subject: v5.15 backport request
To: "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please consider the commits below for backporting to v5.15. These
patches are prerequisites for the backport of the x86 EFI stub
refactor that is needed for distros to sign v5.15 images for secure
boot in a way that complies with new MS requirements for memory
protections while running in the EFI firmware.

All patches either predate v6.1 or have been backported to it already.
The remaining ~50 changes will be posted as a patch series in due
time, as they will not apply cleanly to v5.15.

Please apply in the order that they appear below.

Thanks,
Ard.


44f155b4b07b8293472c9797d5b39839b91041ca
4da87c51705815fe1fbd41cc61640bb80da5bc54
7c4146e8885512719a50b641e9277a1712e052ff
176db622573f028f85221873ea4577e096785315
950d00558a920227b5703d1fcc4751cfe03853cd
ec1c66af3a30d45c2420da0974c01d3515dba26e
a9ee679b1f8c3803490ed2eeffb688aaee56583f
3ba75c1316390b2bc39c19cb8f0f85922ab3f9ed
82e0d6d76a2a74bd6a31141d555d53b4cc22c2a3
31f1a0edff78c43e8a3bd3692af0db1b25c21b17
9cf42bca30e98a1c6c9e8abf876940a551eaa3d1
cb8bda8ad4438b4bcfcf89697fc84803fb210017
e2ab9eab324cdf240de89741e4a1aa79919f0196
5c3a85f35b583259cf5ca0344cd79c8899ba1bb7
91592b5c0c2f076ff9d8cc0c14aa563448ac9fc4
73a6dec80e2acedaef3ca603d4b5799049f6e9f8
7f22ca396778fea9332d83ec2359dbe8396e9a06
4b52016247aeaa55ca3e3bc2e03cd91114c145c2
630f337f0c4fd80390e8600adcab31550aea33df
db14655ad7854b69a2efda348e30d02dbc19e8a1
bad267f9e18f8e9e628abd1811d2899b1735a4e1
62b71cd73d41ddac6b1760402bbe8c4932e23531
cc3fdda2876e58a7e83e558ab51853cf106afb6a
d2d7a54f69b67cd0a30e0ebb5307cb2de625baac

