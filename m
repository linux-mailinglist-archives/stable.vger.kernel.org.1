Return-Path: <stable+bounces-126875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1668DA73537
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 16:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BDF188F7B9
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 15:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947CE146A72;
	Thu, 27 Mar 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mas/slcB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0533035957
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087731; cv=none; b=lO0Kj6JH0SM9PdAORR6LMc4bCxQtOyKTZNds1By0ttBtY6oMkTfkf82iBaXdMNaPQLUlE2YSBQvFxKdX5p6a/aSfNAHSKPlGklDZoE5it66aNQTUqBJM8f7rZrQXohr+GdOky8OdCYhhIDlKiZwwIsxdSLvd7lJrfs7DGWTQJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087731; c=relaxed/simple;
	bh=oKZeyOlcmWhv+Tjy/QuaTCsTxF/1DkLzixlEK/75rmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrtTRWWyJa1Tqgx45MDjrQSC6OD4KuQI2KyR/mEg3IT39m+RMX0+UsmoFc8rSy7tcZqbx4chOHMc+T+Dvm16+pXQU0PMjiEmvNmgZlSOCQSHgLmbOWtXscVlZ0pDl93kH2R9PnX9UfJiU+nUN4oufMZtOfdhC7k1MrwV6xZivGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mas/slcB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240b4de12bso31982225ad.2
        for <stable@vger.kernel.org>; Thu, 27 Mar 2025 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743087729; x=1743692529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qSWt3uvMh71gDWYUGX7+fPc1Nv/aAAnMr090z0vRF4=;
        b=mas/slcB7LMJEJT59vrOmkPiPex6wsg+AqXWtTr+7ESbVtzwq8sQCKV1yMuQUo3+0a
         TCsP71PMh9bpbgtijjY+JTQ7Dnq+zvmOfiyldFpF2n/v0mghhsrRumgXQ03gBgqEvLmp
         smxPPYYHrJbu6x1UtOlURoKw5T2On6rddhd0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743087729; x=1743692529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qSWt3uvMh71gDWYUGX7+fPc1Nv/aAAnMr090z0vRF4=;
        b=ATOmeoX6X+JSW3Cv8ki6m3FQ/cZCk4CZ59haHWWsk8nFb3XvDyZZ5gRHUUzxpzBJCs
         P6BnrPGnyZQ1/zCIE3hbNLCRjzYTcKX+PqA/iICLdC7M6vsePps7V3CH9nVh01DDR/Qe
         MYgEV12BrLipjsVrFp3ZwIXYrlSCR/ZFM69RuAKcTB0lq9C6oOzsutoGr7999cAslVzZ
         8fBaaF1s535UpDof+TMRNSL7JQkwAuuVTLs72hwmuG9x792nRxtmbq4oEV3oKdVqXZX1
         XDwKzq2SSPyyW47G81LCwfU28Ilv8Wo8WwMBOYHo7n3py76zTVCczCUHKbxxM1wTIeYF
         DIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdOhUJi6Tqusu5m9wUgz/DwArAxgJ9/i2wPXJSUUK+YQ+MfOnmUL/LgQlAC0r0NE0LPDv8nxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2birdaDxWc/0Wg5DYDNi/s2auKSIG6DzSsV/7WuVYJFBo4IaM
	FR1zPuQtKou2A9BAgiaXuNSgxS3rK60WzFW3ibD4GZM4+fiB9TKelOluYDlXyQ==
X-Gm-Gg: ASbGncuUIJuhXO8hJW8DAGfU3OTTgxTsogkbRbwGFYIOwLWnsycpDxcxfdL7TiSiMrB
	R/YAr3Vsvv/oqGRIl9bbRoENXkOaidtdmHEnAQ7EkuNrTrLNReSSOBLkHy/qzFpGigEdT327Pwz
	8LCkvGApr7UH4WYraBSlYVtGpAOTCyPWsE70xDg8G5cmdtG1vWmM/0ca6cuJvoYFtW/N1JzECi9
	rXy65TChsYu9jT7AyBDw+hUXEAYLZU0sZJC8Mcn2Sef71MjX2DYceHQMxsKmFU9xvz7CGjpwydh
	omU3gG+/1wBdzV9AJQ6nvV5hbOmt5Zatk0zqAkdY4fCPz2E=
X-Google-Smtp-Source: AGHT+IG/IJqrqoT0m0m7gmMVPQjaTlvKtiXxSxIivb95+Nb+Y8jAJm8non/NDiXNCuNHB+d50FJhAA==
X-Received: by 2002:a17:902:cece:b0:224:255b:c92e with SMTP id d9443c01a7336-2280481d10cmr50732785ad.3.1743087729081;
        Thu, 27 Mar 2025 08:02:09 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:cd9c:961:27c5:9ceb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf93esm316675ad.154.2025.03.27.08.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 08:02:08 -0700 (PDT)
Date: Fri, 28 Mar 2025 00:02:03 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, 
	Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2] thunderbolt: do not double dequeue a request
Message-ID: <qdbqm52rasvncb7db5ok5qfep7bfkxq34veihhrd2xdodozdbl@wltsov2h5fcz>
References: <20250327114222.100293-1-senozhatsky@chromium.org>
 <20250327133756.GA3152277@black.fi.intel.com>
 <vxocwwtfwg3tmjm62kcz33ypsg22afccd2ua5jqymbxaxwcigf@nnydc53vu3gv>
 <20250327142038.GB3152277@black.fi.intel.com>
 <jdupmjvntywimlzlhvq3rfsiwmlox6ssdtdncfe3mmo3wonzta@qwlb3wuosv66>
 <20250327145543.GC3152277@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327145543.GC3152277@black.fi.intel.com>

On (25/03/27 16:55), Mika Westerberg wrote:
[..]
> > Yes, if it's scheduled.  If it's already executed then we can schedule
> > again.
> > 
> > 	tb_cfg_request_sync() {
> > 	 tb_cfg_request()
> > 	   schedule_work()
> 
> This point it runs tb_cfg_request_work() which then calls the callback
> (tb_cfg_request_complete()) before it dequeues so "done" is completed.
> 
> > 	                        executes tb_cfg_request_dequeue
> 
> > 	 wait_for_completion_timeout()
> 
> so this will return > 0 as "done" completed..
> 
> > 	   schedule_work()
> > 	                        executes tb_cfg_request_dequeue again
> 
> ..and we don't call this one.

Ah, okay, I see.  Thanks for the explanations.  I'll drop
that one from the commit message then (let me re-spin v3,
just for the history).

[..]
> > Let me see what I can do (we don't normally apply patches that
> > were not in the corresponding subsystem tree).
> > 
> > In the meantime, do you have a subsystem/driver tree that is exposed
> > to linux-next?  If so, would be cool if you can pick up the patch so
> > that it can get some extra testing via linux-next.
> 
> Yes I do, see [1] but it does not work like that. First you should make
> sure you patch works by testing it yourself and then we can pick it up for
> others to test.

Sure, if I had the H/W testing would have done by now.  OK, let me try
to work this out.

