Return-Path: <stable+bounces-3600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7C780042D
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 07:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092A12815BE
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 06:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D1111700;
	Fri,  1 Dec 2023 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3emrjF8t"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC18810FD
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 22:52:16 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c210e34088so170136a12.2
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 22:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701413536; x=1702018336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRkIzUVL8moRADOVLqm0jiXF7LpIsgbB7K5Hlu0moR0=;
        b=3emrjF8tq9YkovhG6MamCwPIG2D3nJ3WyiLVhWXophCXF1ftTYGkB8L/HK27oXqF3h
         Tuxg+02yLCiLNiJ70Ats7xdMaP566lcqGv+LNP2nAuaurXthDJm7+FzR4SnZHbqdL+uQ
         NKhOV9b3LxZb+pLxKfPZ6PTMTuZcV5HeNFGCyBrW0VW4GOk8dX29efOWOh7ckNE0KbSk
         svUah+yWjX89dfvwVCzx3rWI/JbviDrcq/hq5QOJmYhl80gpSQqwfQoWwWPm9i5I/MhR
         3NE1FNHZlKllbQ3vExn+Z6qV9Ij4cx8kFlFUlC8IqEHXvIgI0QGdMkX4W+mS1RKK8tTv
         bRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701413536; x=1702018336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRkIzUVL8moRADOVLqm0jiXF7LpIsgbB7K5Hlu0moR0=;
        b=Iio7bAcgai962Hc+Z3zbm8rgR6dGvPvIxEXSSb+jHKXix0lPYfuEui7AO2Rfwx6JPo
         nr1k/T653qgfEEieddWvw+w7/qWucwuq6wpB4K4yc+rWDsiGTm5oKFvHVvpDFwbYfQj1
         ba4qVevuuSqyqrlpHJn6xxi1qdIkK73TREXvIq4w4Snh8HLhxHQP6UVtTP/zQpVd3COu
         XZNpgVaZdHjOKf15F4iCmZny2JDWobKrYaQE0Zs5nc/XrzTQ150wKsYGzsB1Q82tOAeu
         d6PJi+1rmTbq89HJon82rOsKgdzYUdlymqbSeArYRH4+n9W3pna0NfqIreqQt9fcWAhK
         2lJw==
X-Gm-Message-State: AOJu0YzYoM1E+UAoBuXXlaqLFlDjxUyOZtg37aSZoAo7ERCK1QJ+THOH
	Uy9SFDZUmH1WuPqxdnTtO0SJgQ==
X-Google-Smtp-Source: AGHT+IGWPGI675H9YKswKjhhnrgi5wfg1KyVPlIuzV/jrOYnGNKTcqiL4Toa+T/GI3sDDyN+6jrgig==
X-Received: by 2002:a05:6a21:99a7:b0:18b:208b:7043 with SMTP id ve39-20020a056a2199a700b0018b208b7043mr33191190pzb.49.1701413536061;
        Thu, 30 Nov 2023 22:52:16 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id y31-20020a056a00181f00b006cd82bddd9dsm2272486pfa.157.2023.11.30.22.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 22:52:15 -0800 (PST)
Date: Fri, 1 Dec 2023 06:52:11 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Martijn Coenen <maco@android.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Todd Kjos <tkjos@android.com>, Todd Kjos <tkjos@google.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 05/21] binder: fix trivial typo of
 binder_free_buf_locked()
Message-ID: <ZWmCm8zzqJkaop1Z@google.com>
References: <20231102185934.773885-6-cmllamas@google.com>
 <20231107090805.257105-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107090805.257105-1-aliceryhl@google.com>

On Tue, Nov 07, 2023 at 09:08:05AM +0000, Alice Ryhl wrote:
> It's a bit confusing that the pair of methods binder_alloc_free_buf and
> binder_free_buf_locked are inconsistent in whether they user the alloc_
> prefix. It might be worth it to change them to be consistent?

Right, the prefix is concistent across the APIs but not really for the
local function names. I wouldn't mind adding the "alloc" part, it just
seemed easier to fix the comment and backport that.

--
Carlos Llamas

