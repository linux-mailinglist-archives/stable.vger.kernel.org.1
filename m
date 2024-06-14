Return-Path: <stable+bounces-52222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2AF90903D
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 18:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A163F1C23838
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 16:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60BA171E71;
	Fri, 14 Jun 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V4Cv8gkK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6EE637
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382513; cv=none; b=LuCuhkCmEeFYCuFj97VMZqUJroyZfAmpmg/BGrpHJ/DMZkvC3Byd5z4c1XNafAMUOgADNy3rfnoF7fq7FSXv/BwcWdKZ+X26KW08zsS3M1mm7gZqcfEXcquxDmHlRDyvCmuAtXqP6FpT0qmgZcv89GGDzeuLuwiQ2kOzt1U5rJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382513; c=relaxed/simple;
	bh=8esRhZr5t++HylGupLX6lyRpqHu8zZM1p1WN0/F8Ko0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTUJG2v7NOZ3wk4GaewZ4QpvUDHOcICfl4h9E3EBCMFQcWx/QHcJWwzkWtQd3FQoSLxiTf2ZU4+2jake7FSxCwK3GR7IscREACYdawyJ43GsiG3eOTCvygk/ndJe/onaGwTW4tt4POz4s9vjfiCA6w0yIKeuT+L6GTUm9aVx7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V4Cv8gkK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6efae34c83so315870366b.0
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718382509; x=1718987309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjciShuEmN4FOttkz3Fru1iIAynJFsivm4utVaX4RDQ=;
        b=V4Cv8gkK56l5oxvYJmamzusDkfTD9NKIE2ExJ8mmzsfLMSKroCdM81ez60zXOX6Z/l
         W9RUQvJgzWgpspSnrBbvuLelHj4iZDi/boFiV4q4y+UFpNx/TjoWqjWt00xN1CPzmFBU
         lEuOT2v2ZDDBb10QVDf5o1BupcO0ZVKsLZeLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382509; x=1718987309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjciShuEmN4FOttkz3Fru1iIAynJFsivm4utVaX4RDQ=;
        b=jVGRVJ2+hWbmOYuifVVH4cjXjoqcLaXuTgYT4B+5hxPWPhPdJsu1wst46OHYeytdKn
         w5RBaDfcBSK+3xOQQ+HD7OxH8r4gNF5aD+9PekJlgMbuaxut9IocudCCauJX+bPirfAn
         f88PMY9HFkFQYgQMllWGXiwmJzX5nZ9/H/3lbeEGoR7LeoeMxPr6RgfqoGTyA+i25tn/
         e1/hXh35QeqtqtPRnpfy2tLYRVhUOs1Hj6uDkvdxDe98XMxgPamXibuH3PoMWEFMHnfW
         3iWrcG3/nQuqxUKsVh1pv4ZMQ+2wyjWnJBqxc5XLoOobK40JSz3lLch4uiEskD+YvSCN
         3HWw==
X-Forwarded-Encrypted: i=1; AJvYcCX25kc4Lt1geTpVOHaLS3qxDsteyre90fDiVvo7+Fd1q+AYivWckF94kNGkklItziUxerkBBP9sLzA9uDiafiM5AhHa2LTy
X-Gm-Message-State: AOJu0Ywu+u02iETZw4G1U5wuCRCL+tJOx2nSoNptBIsJ8BkAjoqqrIG/
	YV81r8CZXAGvZbikmDJAvAPF6eegIxVMa0brnNHYqsbJohYmzyqFqNzYhbp4lGhuxkZVcN563kK
	a3ZxNpw==
X-Google-Smtp-Source: AGHT+IHK+yo87swT9DkJj3foTZVP1KhGixfH1Y/sjhcMSSzKiInH0BHIEMx+5jBKkmkbXR9VZbd4LQ==
X-Received: by 2002:a17:906:1919:b0:a6f:1f40:600a with SMTP id a640c23a62f3a-a6f60d2caa3mr213814366b.30.1718382509503;
        Fri, 14 Jun 2024 09:28:29 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da32c3sm203789966b.13.2024.06.14.09.28.28
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 09:28:28 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c68682d1aso2549074a12.3
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 09:28:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXF4T8Gac736KBF8pdCaxss30wwBHTuiDraQkVVlCHxoRR2tq1fz6LO27uyWHwQI+CykDJHgKIwNIC5oNxZtlz3gGhRz0sZ
X-Received: by 2002:a50:c357:0:b0:57c:7594:4436 with SMTP id
 4fb4d7f45d1cf-57cbd6642ebmr2048528a12.12.1718382507928; Fri, 14 Jun 2024
 09:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zmr9oBecxdufMTeP@kernel.org> <CAHk-=wickw1bAqWiMASA2zRiEA_nC3etrndnUqn_6C1tbUjAcQ@mail.gmail.com>
 <CAHk-=wgOMcScTviziAbL9Z2RDduaEFdZbHsESxqUS2eFfUmUVg@mail.gmail.com> <Zmv8sMMGS8uosLQD@kernel.org>
In-Reply-To: <Zmv8sMMGS8uosLQD@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Jun 2024 09:28:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOwJD6sp6mdFg+6Ab8shcB0+qD8=m6MFBA-ExxBnYG5A@mail.gmail.com>
Message-ID: <CAHk-=wiOwJD6sp6mdFg+6Ab8shcB0+qD8=m6MFBA-ExxBnYG5A@mail.gmail.com>
Subject: Re: [GIT PULL] memblock:fix validation of NUMA coverage
To: Mike Rapoport <rppt@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Jan Beulich <jbeulich@suse.com>, Narasimhan V <Narasimhan.V@amd.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, stable@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Jun 2024 at 01:20, Mike Rapoport <rppt@kernel.org> wrote:
>
> A single constant is likely to backfire because I remember seeing checks
> like 'if (nid < 0)' so redefining NUMA_NO_NODE will require auditing all
> those.

Yeah, fair enough.

> But a helper function works great.

Thanks, that patch looks like a nice improvement to me.

                Linus

