Return-Path: <stable+bounces-47741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00788D53AD
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 22:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226D6B21776
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 20:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B90158878;
	Thu, 30 May 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLwyM/9Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2811B770E1
	for <stable@vger.kernel.org>; Thu, 30 May 2024 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100429; cv=none; b=lZ6hwhMolKhUunXv6RCZeESN6eHPNJRFptsd0WmH8QshHKdUM3m4RVW/sIQAciIE4B63yPZovJoXOqikqeBJ6fN9K7Q9Kj/3C5izakRuEIXBJQ+RzMznxLDuUyG5YwZNL3TUwAjNtT5Z/idybFIgTZHETp4Wgfq5atnM8f4Mdgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100429; c=relaxed/simple;
	bh=V4Iu2BqKHIcitHkE+HEYEi7U7gAsrnLi9fOAR9nBPfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RzDBuTImOxy9EIErOctUR91RIP1R877kMIrlsRfaUrqoRrLQ7MpJBeOWy66858xKs7smux1tW6Xko7HkWu0kEo8dVF7/6R7cpTh2+R4FtePu4cZBNZ7FMUEy4PgCQt3h1UZhRpqQJugiIk+HTT4oKfVNTuQ60OX9b9xHwzrxWqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLwyM/9Q; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b840a001dso772081e87.3
        for <stable@vger.kernel.org>; Thu, 30 May 2024 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717100426; x=1717705226; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V4Iu2BqKHIcitHkE+HEYEi7U7gAsrnLi9fOAR9nBPfg=;
        b=gLwyM/9QeFJ2C7QFmTUFx/eeyzh9QDOGzgX19G7IhLwPQgrsr0sxJHKg3Qv8KbcLIf
         y7BWlpabpNyskq13L+GmIU7xmr2lUw4Tn+Y2s/g0e6lcCWE1Wj+fOulTLgenoOszW9/f
         tyHJnPPYlqKEmMjtQ3tqROIGXqYlgTFSsGReOMT3srpQSgIB1IkLP4i9gSuRRkJseLZn
         jdgjYV5RUzekVt1azhXe5EevaKMugMh+cS1xCbQwMXqyapesNAEN6dlAKB//HV4n+336
         85nLrS66Uh0xMNZc47U2vvvl7EUNIn+/Liby4WL8xNnxto/1mWGM+mlT8KaTp5U2erEu
         nAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717100426; x=1717705226;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4Iu2BqKHIcitHkE+HEYEi7U7gAsrnLi9fOAR9nBPfg=;
        b=fz/hjYM++E/wAZ3FIznIh9goii5yMxWJpl81uhKgq4AMEIhXb6y+WR4BjJmxskmQys
         YHdyFvmBj7fVdNXSlM5WSq4X8snF965Zoum9PXzGsDass+aUD8tyLxNUiaMy+6Ck+cmf
         YJDo3Hb3cOTTNtfd7Tdq9rhAves5pOu3UGWuX8ZezBR+lh3WZz1aArUhB0Lx2FPSQHxs
         9TQh7U4j8J+bg0SqGXwnoHJggID3qL2gsfvDVCKzuTChxTcgrKM1NmGA/+kNfuF36BiF
         1Q/Fg3y6lpVsbhR12qvq5648uUZBvJvk9sOl9+p0rCHs/t/vdgMHh4rTNdfHHznY5Klz
         v3Dg==
X-Gm-Message-State: AOJu0YzKtfOrwauRGDyQfG1EJ7mLAjr6tGhCrkNO8EQl9zFM5/bXF98M
	UxiYL+GVM43Zo4qTFhvPkIqf+y0E7ZOogT3XnMK9zppPt6kNvoTDNOAlLlW9tPnLLvqAv/BDxjn
	MobLQ2jlpw5BvNFpjeD4lT2jlQ2NtAw==
X-Google-Smtp-Source: AGHT+IFfnSipC8rqnIaW25wSennEDZ764cbu1cpx7HMkImu4olbRVNnpD1bQ7ZjmAa6mvyakjuwA2ac0kFLp+lQFMr4=
X-Received: by 2002:a19:ca4d:0:b0:522:297f:cb06 with SMTP id
 2adb3069b0e04-52b7d434d92mr1727891e87.32.1717100426156; Thu, 30 May 2024
 13:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEQj+Ebm09gBePmOYZ3NiH2sMBLqDz=5RS5oODpTTfR1FWspzA@mail.gmail.com>
In-Reply-To: <CAEQj+Ebm09gBePmOYZ3NiH2sMBLqDz=5RS5oODpTTfR1FWspzA@mail.gmail.com>
From: phil995511 - <phil995511@gmail.com>
Date: Thu, 30 May 2024 22:20:14 +0200
Message-ID: <CAEQj+Eb8PByrAxZ9udhQaXXQi19QLg04isuHKL_EG62LsstrKQ@mail.gmail.com>
Subject: Fwd: Kernel 6.8.12
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Kernel 6.8 which is the default kernel of Ubundu 24.04 and other
distributions derived from it is at the end of its life for you !?!

As it provides better support for the Raspberry Pi 5 graphics card, I
hoped to be able to benefit from it under Raspberry Pi OS which still
uses the latest LTS kernel available.

But if you don't make kernel 6.8 an LTS kernel, for Ubuntu and its
derivatives, I will never be able to benefit from it on my RPi5 ;-(
In addition, I am afraid that OS derived from Ubuntu 24.04 LTS will
end up in difficulties due to this situation.

Best regards.

