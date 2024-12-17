Return-Path: <stable+bounces-105054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A89F56F4
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CFB16C431
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B53F1F76BF;
	Tue, 17 Dec 2024 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ETzIqN96"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DDA15E5D4
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464301; cv=none; b=Hpa8JotqbxIievSUrAa++siM0KnOvLeRweDgceL9yh+9pGsPL49O4IJ1umTQXHiMnqhO/9pBK5OmW3FT1Uztsd1MVOCmNMjdE27sRivNUWX2LW0Cy4CbwBuaXC1m3lEpufClPgsO/uGU7yvcGAxFF9B52egHYpcTF5DsbgFeRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464301; c=relaxed/simple;
	bh=BlX5PFVtVorWrjZZejf5sVJZU99ayY7KutQE4SAHvtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXIRX+7H1xgjmjY8poZPmsZGbCi2UDLfEamuDEMI1ZdOjLs69HFHQ1veyjCDZrGJ6loGPy0qmfbcrGhoj3EX3j7Z10jobpTeBvTKccnWfe0CI4t6MmqKrOKR0WlKJjL19H0+iJtRwqgwzeyWXyW1MvGQ4mzyPJ6CmARPtnBrv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ETzIqN96; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa6a3c42400so8084466b.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 11:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734464298; x=1735069098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GoM1B1YX2SDxMKP/fkuxJP48vkpnRndLUKOmCSwzkQ8=;
        b=ETzIqN96s1gLC1ysTJgvZg8WRBd2/5+DySlrtTUnbPEXn7kGZLo35MKpkqrjslT8F+
         PAvPx8Rs03AQRolhwU5/lfRXp1nntmcZbxK6qLnxCe+rDk8wRERx2y3NfFGIfrQx4yII
         +z+ghfZBjdmQ34sy7KI5w744ouTTtXCKbygVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734464298; x=1735069098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoM1B1YX2SDxMKP/fkuxJP48vkpnRndLUKOmCSwzkQ8=;
        b=DNSCr91Pf5KGFr92Zvb6Y6QWNTtH4/tXmxhUEknAB33LjvNP9WsgPSVQHyi35gOnDT
         k0V/xXrney5lt2JKGg48me99ilBej/GIZ39H5gsYtG7fKfNYGeE+1t4CZkdm0hj6mkW9
         rSQeEEYlrgmJ6sIX56cO+mRwiosFk0+u4J12L0CvqLWWEoO1ZxGusZX8l0mRje6ppDp8
         77Z1xJT/x5UYdTistidu2M1Z3SgK4gLbW0+oN0gzpberbTVmsw53WBaXmslAtk+EKKbD
         ++jp+W1xvy5Q2wKrbpywPCuGa4VvpAOAVEc/xUikiQtsVUENooCTET6LPyhM2RGyraoy
         cftA==
X-Forwarded-Encrypted: i=1; AJvYcCVQHVgPhuxk6imCYBmeArt8sz673vryTM7v0BYJ3N4tiiK9c8k0D0n1NIYE8AVIny5pYY2Ukl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIa7S1ApnHQag167NtuUdXcAhWpTdx1Q+lSwIVKXAO4hxUKKQr
	ZbNEGnzBWq3Avh0CjLZHnodWZTqfSeFXu9pZK+E2RJx7/W0IEUtB9UKRGC1JS6R+rNk0tMRH4m2
	TGzE=
X-Gm-Gg: ASbGncvN7P/uqlJHL0yRVooD7/7kyNewB8lXQWiYigaP/HGhk+l83REXB4PuGhZ0+nN
	zYTgmafBEWZF0QqFV1iRqntyjy1B8BTk2PD7DBeBQJT+R6I2fDYCWF6g9J7GEyk5xmJtg+JXTwi
	D1kPVNrjHNHG0WVVyTgbk5+cGtfSYAkwHRvt6UQRCQtnpYq+oLzKa46upmQYwHQCjLwqISwK8MV
	G5Umq6j3ByDBAEQrlkiqclngb8nUHt6aMEYMjS5woTjIIJqyAJDCb5V/Wy0/cWEGQGqnk4TbKee
	GrsrYX6laxE6KSmVjPGonWx862J3Ows=
X-Google-Smtp-Source: AGHT+IFWmPd4RaZWgl7CfPfoYFNE7E02xiyEYMbhqq+6UjhVdO6RKVoMsy0oy1MMddqrVzgci/r3bQ==
X-Received: by 2002:a17:906:308a:b0:aa6:912f:7eb4 with SMTP id a640c23a62f3a-aabf4358abemr2643666b.10.1734464297832;
        Tue, 17 Dec 2024 11:38:17 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96005f67sm472994866b.41.2024.12.17.11.38.16
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 11:38:16 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa679ad4265so8127866b.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 11:38:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXx4Q+GnaQ7ayEj2pGsqV6NKDHUGL7cFA3AmmbQsfBKUzOrOj+KD8d83z25jCkeK/qlD8VetNc=@vger.kernel.org
X-Received: by 2002:a17:907:608c:b0:a9a:6c41:50a8 with SMTP id
 a640c23a62f3a-aabdc8bd564mr467326366b.17.1734464296273; Tue, 17 Dec 2024
 11:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home> <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
 <20241217140153.22ac28b0@gandalf.local.home>
In-Reply-To: <20241217140153.22ac28b0@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 11:38:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
Message-ID: <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 11:01, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But instead, I'll replace the text/data_deltas with a kaslr offset (it will
> only be exported if the trace contains data from a previous kernel so not
> to export the current kaslr offset).

Right - never export the KASRL offset for the *current* kernel, but
the same interface that exports the "previous kernel trace data" can
certainly export the KASLR for that previous case.

> Then, on our production systems, we'll save the meta data of the events we
> enable (this can include module events as well as dynamic events) and after
> a crash, we'll extract the data along with the saved data stored on disk,
> and be able to recreate the entire trace.

Yes. And if you save the module names and load addresses, you can now
hopefully sort out things like %s (and %pS) from modules too.

Although maybe they don't happen that often?

            Linus

