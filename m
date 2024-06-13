Return-Path: <stable+bounces-52083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB5E907A05
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 19:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E18CCB24431
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 17:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0F114A0A8;
	Thu, 13 Jun 2024 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vz/mvTf+"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A214A096
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300330; cv=none; b=avRyAKFDQTUzY8GOTI8ZqIaZqt0fChqzWdaWOuwEyRJJAywUhf/0oz798d8rqZoOfWd4Bk1ViWIdpP1/0eqgN6z5YXOB7znHWVahxDYhjP4bnBTp+5hBVF22+z/dcEXEOOVW1XmnSzFzFTAjPyOF7eLCfKkyVhaUgIFGcDnVRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300330; c=relaxed/simple;
	bh=xS//hxlHlulQtpNFdFV93N5i3djVdh0tUjRe9XeoGIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqPuUunY7JV1PgMlPT3a3LZp1SSgC7f9G4r9qwz+BJ0icTQZEE8+20qYnaG9r/XCtXcdF6rhAEgnizdEyRf0WW7w6gPSyVeJV6/6IeAbDfSjsWGYDOwsfs2bU+n7rOcKYN7ZwNhdBGhKJWawWTr/BNs8DzJSXeblojtTmwvnf9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vz/mvTf+; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebdfe26217so11785831fa.2
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718300327; x=1718905127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=duvBWZAfOAJXQBLKoqD/ee3JGbLIv42ynDQwfWnNWn8=;
        b=Vz/mvTf+hln5CDD6zgSmqfprN4l4PscvPCZKedoBw6fv5PUwbq1VxV0aK623UmWJ+j
         3iVI8dvh3b0vHlq5+W3FWMDI4RriDQC8yLMkSg059CPu6fgh1h6X89sMh06DeuGeY7ak
         taRnUxc0ZE5jgVb0t4elju8AwJtXAEP2Bd7Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718300327; x=1718905127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duvBWZAfOAJXQBLKoqD/ee3JGbLIv42ynDQwfWnNWn8=;
        b=D2WyZ1n8LeIo+e7/c3oktfzhZx5cpp0gAh7IV6zn+7yljARmW9gFueCYlgcOnBJ/l/
         7d41LOXhFl9czzjeokqX8PSyYz7bKPe9tYAznUeh3/V82mKMxtxRmCSWqH6NYBjTZHSq
         7SAqaEP0Zko8HGKZlYbuihfIffxc2xODJydFtRyw6nIUl6UupTYb9c8WqBhgkRBZajdC
         q7VgzbmDVuMa+lmrU+k6B/P099avgC+w4JyPFJx56VxtNC7WM8ScoMo1dE00Y2i/SoOh
         rwLS0fxSRlKMcYVjvxyFzMVI88vYrnLCv3LCMG0/ZYkyqocF7OjOmO/2E3r+tVqgoCJ6
         28hA==
X-Forwarded-Encrypted: i=1; AJvYcCU6U9fFj9H6I2YsyHYK5cXbca+j1xoFzHHaB7yST17a0h2AL+BOEmtocBzqYfQaufJ/Aq2egJyQqtXZRgqpjKRCA9olGf8d
X-Gm-Message-State: AOJu0YxuQU6JtvdQkEf6Xh81CESt9EV7AUCEKmNp4iywHN5ODwT/rcQq
	sJO31DFbWkdbIAKQnET0Mrz52JhqGvAFBb8tmKdyW1oaohEGE1J4h29ovmWbLL0fUYmNdfbdPDN
	67x2bdw==
X-Google-Smtp-Source: AGHT+IGX65sasKAgPqpqFiGxeSbDB8UI+Obb1mhx56RmwbPymQ+sLLtitk0oAzhtL0FjhJ1kSSx9Lw==
X-Received: by 2002:a2e:8886:0:b0:2ec:492:3fee with SMTP id 38308e7fff4ca-2ec0e47c209mr3558331fa.30.1718300326726;
        Thu, 13 Jun 2024 10:38:46 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c16c91sm3252691fa.63.2024.06.13.10.38.45
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 10:38:45 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso15183801fa.3
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:38:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWbUwWk4Y5mpdAy5koZY3i6aMB6bkCkb35uDsUJBXsL/b041n/5c57hN6KFVa1blqm2fC6G+lG1pefP2iY8g5ox2Y40Tlz
X-Received: by 2002:a2e:9658:0:b0:2eb:68d0:88be with SMTP id
 38308e7fff4ca-2ec0e46df16mr3471851fa.12.1718300325016; Thu, 13 Jun 2024
 10:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zmr9oBecxdufMTeP@kernel.org> <CAHk-=wickw1bAqWiMASA2zRiEA_nC3etrndnUqn_6C1tbUjAcQ@mail.gmail.com>
In-Reply-To: <CAHk-=wickw1bAqWiMASA2zRiEA_nC3etrndnUqn_6C1tbUjAcQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 10:38:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOMcScTviziAbL9Z2RDduaEFdZbHsESxqUS2eFfUmUVg@mail.gmail.com>
Message-ID: <CAHk-=wgOMcScTviziAbL9Z2RDduaEFdZbHsESxqUS2eFfUmUVg@mail.gmail.com>
Subject: Re: [GIT PULL] memblock:fix validation of NUMA coverage
To: Mike Rapoport <rppt@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Jan Beulich <jbeulich@suse.com>, Narasimhan V <Narasimhan.V@amd.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, stable@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 10:09, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Is there some broken scripting that people have started using (or have
> been using for a while and was recently broken)?

... and then when I actually pull the code, I note that the problem
where it checked _one_ bogus value has just been replaced with
checking _another_ bogus value.

Christ.

What if people use a node ID that is simply outside the range
entirely, instead of one of those special node IDs?

And now for memblock_set_node() you should apparently use NUMA_NO_NODE
to not get a warning, but for memblock_set_region_node() apparently
the right random constant to use is MAX_NUMNODES.

Does *any* of this make sense? No.

How about instead of having two random constants - and not having any
range checking that I see - just have *one* random constant for "I
have no range", call that NUMA_NO_NODE, and then have a simple helper
for "do I have a valid range", and make that be

   static inline bool numa_valid_node(int nid)
   { return (unsigned int)nid < MAX_NUMNODES; }

or something like that? Notice that now *all* of

 - NUMA_NO_NODE (explicitly no node)

 - MAX_NUMNODES (randomly used no node)

 - out of range node (who knows wth firmware tables do?)

will get the same result from that "numa_valid_node()" function.

And at that point you don't need to care, you don't need to warn, and
you don't need to have these insane rules where "sometimes you *HAVE*
to use NUMA_NO_NODE, or we warn, in other cases MAX_NUMNODES is the
thing".

Please? IOW, instead of adding a warning for fragile code, then change
some caller to follow the new rules, JUST FIX THE STUPID FRAGILITY!

Or hey, just do

    #define NUMA_NO_NODE MAX_NUMNODES

and have two names for the *same* constant, instead fo having two
different constants with strange semantic differences that seem to
make no sense and where the memblock code itself seems to go
back-and-forth on it in different contexts.

              Linus

