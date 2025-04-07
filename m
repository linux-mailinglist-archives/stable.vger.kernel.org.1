Return-Path: <stable+bounces-128564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932D9A7E275
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81DB3BE054
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA461EF373;
	Mon,  7 Apr 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yaj9Zp78";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mXNjXQl1"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D291EF367;
	Mon,  7 Apr 2025 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036190; cv=none; b=f0CHBFn1R+Dg4Kvd3PMy80DRJLKfMvYSXTGodB/haEhrYUtiPe7Cev/T2vadZ0a6YvWDXK1P1P3yCj9xynw5k0O2eYyUHtnliNL/0oJmkAKJRTXoLSGqg8ymtiVCae2QzK4aG3QJgoAM+2nzhGdTx3doNhq+kbNSkeqhC4acqnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036190; c=relaxed/simple;
	bh=T+XSKUg+3cl1YZa5bHCT+bIC91GkJLiUJMRqn5YOT0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pXswWL0bNNK1rG2KdSsnz4np2QXZcOm6Ey5Jy6u0xk+YKIgz2C8+tnBtvvZIHJglYHTAgxhuhYSKghSLAJ/60Okiyyr0lce/3iXHQTivv+3ogE1af0n3Lb7gHz8YdHwR0YmhHO47+y/13EwnIwZ7pqLzqCHf2H+zIXlYEsn7NFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yaj9Zp78; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mXNjXQl1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vw6kxFJ/B4hFmzSYacFWEppeyubkdiRcAzeuJ6ECk2Q=;
	b=Yaj9Zp78zxPgKkgaLBSVXSAIgEOST+m5rLC6kJSfLZ9nhM2HqEfbwijl13On5GYnGXBQMN
	N3m6UQSumzudT1R7sK6hIy8SyPKCHys+y+kPvhUw9hy+prsl6yWrBjbeDbmHSZmqaPTub5
	S9N/hu/qhHZ9XXs9Vv7Vgz5FIXnLZMIITEviNTSz/BCoF715BNM3WJhJlxTPOGEXdm/ivY
	FrHd0eoTRwmybxFOqQVolnT0GO1Y1oz0LUSAYICvtZJMfi+Kq2aJbnkhQBcsBh0SoG5uQI
	sLMXJesT8hbLKDWAbNULicantT7K3yJ1oQXcMWvhYzQXq1YRNySgimoUAXsMfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vw6kxFJ/B4hFmzSYacFWEppeyubkdiRcAzeuJ6ECk2Q=;
	b=mXNjXQl18o4/fMUD8bZwMocoR165eOUErwqCTaBbiVxFjKsDC/fq4HDw5oauigHkw/khRU
	0Jwzc6zpuVvYaKAA==
To: stable@vger.kernel.org, stable-commits@vger.kernel.org, jstultz@google.com
Cc: Stephen Boyd <sboyd@kernel.org>
Subject: Re: Patch "timekeeping: Fix possible inconsistencies in _COARSE
 clockids" has been added to the 6.14-stable tree
In-Reply-To: <20250407140759.3092465-1-sashal@kernel.org>
References: <20250407140759.3092465-1-sashal@kernel.org>
Date: Mon, 07 Apr 2025 16:29:46 +0200
Message-ID: <87zfgsujs5.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 07 2025 at 10:07, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>     timekeeping: Fix possible inconsistencies in _COARSE clockids
>
> to the 6.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      timekeeping-fix-possible-inconsistencies-in-_coarse-.patch
> and it can be found in the queue-6.14 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

As I asked on the stable list already, please do not add that to any
stable tree. It has been reverted in Linus tree and the problem will be
fixed differently.

Thanks,

        tglx

