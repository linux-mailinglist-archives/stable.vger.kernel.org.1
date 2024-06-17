Return-Path: <stable+bounces-52562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8E890B551
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 17:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F47E284690
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1075139D17;
	Mon, 17 Jun 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDds+aaQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E28060E
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638676; cv=none; b=QDJc5OEK6VMMjbDZljE0uw5CWItKDFIWcK2+ZpKZ//fldqJdVn/wi//vu6GAsmeoqdr3IDjntYZN8PeOHBpVQGzC+coUqdACGZ1tVmizncHIT0ju3dozYyoKg8yQZVGTC09yMhSYRt760jRnnzUH/3Wn+kBlPHHV2h6719LQG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638676; c=relaxed/simple;
	bh=M4oqWQrrCHjEeRM/M07yKZApsUbXLvS82ZaDRHtRzz8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Jgurp+QsemvDd+EBUnvUtvU/hYc1hD+gnJ3IBJ3gitpinufIenI0ciJqJNSmDvRUOMhjc9TwOZOKwQcEMRhmWj3q2pIK+lPKnhp/I/HH2KhUeCWnStDM4kJ8RceUreKAJ4uCRFNQi4y9hMxplQH80f/RJRy9TG//Sk2oSqu+43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDds+aaQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c2dee9d9cfso3847775a91.3
        for <stable@vger.kernel.org>; Mon, 17 Jun 2024 08:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718638674; x=1719243474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uex1uGHA1tHl76WKsbQeDe9MuGysGr+t11M0WOROa2s=;
        b=ZDds+aaQ5naTr+z527HOqWagMaQV0EZ6tH9XFVFRhrnUKN4B7DE4DGstqHIcEKkIbk
         87uds+3I8zfKNISnzaz1PF3x0s6Y0ULWsxHP+c8I0aome74XxFtzXT8UNx2y9vZ1tOhd
         svEJQlI3T0Y44M/OU8A4XoBja1sguVOFuNuzw3kBa9Qe+me4TJ9l2XAlqvMnE1DZ8sya
         EtAu+DrZDOW5wvpymCStkTagv3iXYuJm5qYkwNHqp0v65RCqXt9i6nksOOlCbsiDFmbp
         mnIn8tVbcLmBqrLu0rEQNwTpwg+J/qMuqxAo6p5TIbMXkL5YQ//Cwffc5wukZ8QEcP1L
         /9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718638674; x=1719243474;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uex1uGHA1tHl76WKsbQeDe9MuGysGr+t11M0WOROa2s=;
        b=iWg1mAU5nXBle4kQv9KoIPnJz3pOYDcSFcF8zP8LDHG7acx+CariF0BRsga0Wpu4G2
         0qVjSaxae9veBpmFhZcCJOrqm+hJ9XC8EhyNmDvfDcGI2wGD08CpsZfquW/v5fFIdjnO
         oxVs+WLO+5OnWdgJ8Bgl69tVoU7ut46DJuD+apPhS6zRpm+aItMD440xi/Ghkw+81C6X
         0PlDmBMNwQMZSRti8mYcEDZlKeWb1j4/MRTpqOvM3tNW7AlDVyOmugGfa2Wgqfe8Bbqv
         Cn6vnreSA5sbfRuMH3gjQhSud1RvEvrYn0zSr0BKe5+qCOUmPoieFrpUyPR/ptrCods9
         WH4w==
X-Gm-Message-State: AOJu0Yz/Sm93T7IGCa7/exDVPrc4TEoWOyx140GwAHfKMH/fIY2SISr1
	TGwvutuGMSmkJO4Q4MY+eP3HFGH+pCX//kttXb68HY50/wQAfd8cAE18XVCAwYNpCKZiZhNxWsy
	AAmJBWjN/NIbzzvxdNcV0Zbhf3SjQl45o1k4=
X-Google-Smtp-Source: AGHT+IFQdJoVYqdwuIC3CyZwuGJEgujxfCY9EtdOFDLqASOiZfJqQJfd4c1W9W+CVJgYPRKxpoUvSEFzgUyLmsAEDNA=
X-Received: by 2002:a17:90b:1d01:b0:2c1:b88a:3a22 with SMTP id
 98e67ed59e1d1-2c4dbd44110mr8726462a91.45.1718638673813; Mon, 17 Jun 2024
 08:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Edward Wawrzynski <ewawrzynski16@gmail.com>
Date: Mon, 17 Jun 2024 11:37:43 -0400
Message-ID: <CABRw72orHLEqpAS=cW1ThGkVUW0juqc7Y_-N2=o-k0rSqgpLxA@mail.gmail.com>
Subject: Xinput Controllers No Longer Working
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Good Morning,

I was reaching out to report that there's been a regression in the
latest stable 6.9.4 kernel. I'm using Fedora 40 and 6.9.4 just got
pushed to the repos recently. Upon updating, my wired USB Xinput
controllers no longer get detected.

I've tried two 8BitDo controllers, the one being the 8BitDo Pro 2
Bluetooth (with a USB cable) and the other being the 8BitDo Pro 2
Wired Controller for Xbox. Neither of them are being detected on
Kernel 6.9.4, despite previously working throughout the lifetime of
Fedora 40's 6.8.x kernel versions, the latest being 6.8.11. I've also
tried the vanilla kernel, as well as the latest vanilla mainline
kernel from Fedora's COPR: 6.10.0-0.rc4.337.vanilla.fc40.x86_64.

To reproduce, simply load Kernel 6.9.4+ and plug a USB controller in
with XInput (either an Xbox controller or something else that emulates
one). It won't be detected. I plugged in a PS5 controller and it
worked, but when I plugged in an Xbox Series S controller, it didn't
work. The 8BitDo Pro 2 Bluetooth controller has four different
settings (Switch, Android, DirectInput, Xinput), and it was detected
and worked on every setting except for the Xinput setting. Reverting
to version 6.8.11 fixes the issues immediately.

-- 

Respectfully,

Edward Wawrzynski

