Return-Path: <stable+bounces-76601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F0897B3E1
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 20:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD26285702
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 18:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BA21779AB;
	Tue, 17 Sep 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ICZknHN2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA44B5AE;
	Tue, 17 Sep 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726596311; cv=none; b=j0s00TfUBPsDj0iXGuwQmmf/rOaMZEje/0Z6Iaj0WiLrLhWTNpbozY3tOQVgggQxOZH+6Azeo2k3LfPsfjXlbd4mqovmu7ahj4EbGM9NVtvDznCPadRp5QsSeHnAYFoHX0P0XQd3bEKXDhYCoe82gKf0gBTPV5kFj3HrV1k3aCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726596311; c=relaxed/simple;
	bh=HNiU/xFkXuBMHW7Zd5LsIV4jMcr1zTjEJbiCwnEDbRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRacSMwLYVg3G8skeeB5s+04q/w/6VC+mvwiUirFct6eJ91NB9O2Vs2mm+ui2Ekz1VMFVUV5w1UJR//HBYx3YfENdi2Jk93lmlW7XUJpX5uSBUio0rCilBOs+r1PLR5+Tnkgxq+5kMi8Eho6RbotwbRBI72fzQT/+1Hcvgz2dns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ICZknHN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2E3C4CED0;
	Tue, 17 Sep 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ICZknHN2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1726596306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNiU/xFkXuBMHW7Zd5LsIV4jMcr1zTjEJbiCwnEDbRM=;
	b=ICZknHN2wr6dqCtKUdedr1JBjPSQKgbtFXOE/Diejh05c40JiOMKq6QcWpZoJKgkrECahl
	2SFL/0/Z5eS5rS1ZI/hz7GCZ93Q32WDv+YbnFtbrFwsVQPy2OIOtPXKGko5NB17jBRYrmX
	HQ4Ccy7uCO81e72BYfd4Pn+HIJikevo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ef27daea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 18:05:06 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-27cebc3e91eso260701fac.2;
        Tue, 17 Sep 2024 11:05:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUobvUI67+VqRGFvUHB84YPE17UQbf80LDALi9LzvXyT1v23uIwPgRxytmQ3hSbNg15/czi4Ytk@vger.kernel.org, AJvYcCX2A1mzV1D3XQ/ylA5kfUKlypp1Eud/bKWeACUoOxNUpaaxyGgYgWb7PnEKzUSlekPjOg9Eu0lhAra3bbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4FmiF3r9VRnCDuonXNA+wizdRHIxI5XKXlY0OrMFCcUM0SwLn
	op2XOSPmjDSJVcZcfowrol1StPcj3PyJqWmXKVe7p6QdAPplecqmmdDtX26r7mdnJjKeyHcGDDR
	f0wfgFJTrQ9C9TBnSFdd/G6i1GAU=
X-Google-Smtp-Source: AGHT+IEQZRhAA4Jq8raTdkSStrXgki8rCOXGQ5BoH3HW1S+7ShUR0mu1p+XIZxVwkJ+vt4xnl2M4yPpvrx+YnlExQ5I=
X-Received: by 2002:a05:6870:d107:b0:260:fb11:3e49 with SMTP id
 586e51a60fabf-27c68c344d6mr8469322fac.45.1726596304061; Tue, 17 Sep 2024
 11:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418114814.24601-1-Jason@zx2c4.com> <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
 <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
 <ZieoRxn-On0gD-H2@gardel-login> <b819717c-74ea-4556-8577-ccd90e9199e9@amazon.com>
 <Ziujox51oPzZmwzA@zx2c4.com> <Zi9ilaX3254KL3Pp@gardel-login> <01d2b24c-a9d2-4be0-8fa0-35d9937eceb4@amazon.com>
In-Reply-To: <01d2b24c-a9d2-4be0-8fa0-35d9937eceb4@amazon.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 17 Sep 2024 20:04:51 +0200
X-Gmail-Original-Message-ID: <CAHmME9rxn5KJJBOC3TqTEgotnsFO5r6F-DJn3ekc5ZgW8OaCFw@mail.gmail.com>
Message-ID: <CAHmME9rxn5KJJBOC3TqTEgotnsFO5r6F-DJn3ekc5ZgW8OaCFw@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH] Revert "vmgenid: emit uevent when
 VMGENID updates"
To: Alexander Graf <graf@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Babis Chalios <bchalios@amazon.es>, 
	"Theodore Ts'o" <tytso@mit.edu>, "Cali, Marco" <xmarcalx@amazon.co.uk>, Arnd Bergmann <arnd@arndb.de>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, Christian Brauner <brauner@kernel.org>, linux@leemhuis.info, 
	regressions@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael Kelley (LINUX)" <mikelley@microsoft.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 6:37=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:
> Friendly ping again. We would really like to have a constructive
> technical conversation and collaboration on how to make forward progress
> with VM clone notifications for user space applications that hold unique
> data and hence need to learn about VM clone events, outside of any
> randomness semantics.

With the other work now mostly done, sure, let's pick this up again. I
think next on the list was getting the virtio rng device delivering VM
clone events and unique UUIDs. There was a spec change posted a while
back and a patch for the kernel. Do you want to refresh those? I
thought that was a promising direction -- and the one we all decided
together in person as the most viable, race-free way, etc --
especially because it would make ways of exposing those IDs low cost.
And, importantly for you, I think that might *also* cover the need
that you have here, so we'll kill several birds with one stone.

Jason

