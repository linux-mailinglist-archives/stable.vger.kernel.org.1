Return-Path: <stable+bounces-19385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5640684F99D
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884FB1C2518C
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F64D768F8;
	Fri,  9 Feb 2024 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zpPyT+KE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879EC76047
	for <stable@vger.kernel.org>; Fri,  9 Feb 2024 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496152; cv=none; b=LIbJ7oiM3DAQ3KBw8c9ru99rhVJbAlqq0R8QLajvTP+OqE1je+BZ6ggfS6JDmmWS9DdNs0IkJ8NtYXEAQjbHarTIdxiMuoeZJRDNv/frXP+I6yDfnKXD9Ok1P85MVZ3c8hIYzHiRGZzM9schBf6mA5TppwvIC+ZYpW0sv2mvBEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496152; c=relaxed/simple;
	bh=kVG4rmAX1MzvfP4plhvh6t2XV6btpWEjQfp2YBQC/uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQ3t5XF9sIJHbdZEG4CWHfhuJkiXUr+WtDXQhfSpffR+nmPufjxz8hxNb7XNG+xH8rsa0HCZRa4VxVV2wbOw0Ht8vEQckH+yX/xxvC+6jBSLfnGF5gEpFMzwvKvEX5FWdnH9DLAX392yAJk85du4HhzcqI68Y9pMxDcfER5ogNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zpPyT+KE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a39e31e1aa9so140622366b.0
        for <stable@vger.kernel.org>; Fri, 09 Feb 2024 08:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707496149; x=1708100949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kVG4rmAX1MzvfP4plhvh6t2XV6btpWEjQfp2YBQC/uk=;
        b=zpPyT+KE/FQ7atHuoIHYrwDBrq7V1TK+l+feSZCMu/dy26oCxBAPqsp+Fyb36MNaSr
         nwU6Qw8a/JTR7DY6Lt7UmARff9RajK1rUUERzDZGHxiv9VdrIuaMlbljBMBklTqifmyz
         lqAol8E0kX3X3zceU5DkrwObcr5Q1WpTKoXlL8OmF+TOos11PTrl5Pb70eKsvlcYrZ+r
         F1fJ2TPub+ZRFf0VW3qasvf0xHQRiaZLKPTx35GNdHhmGdzr54QVDqitX90yyIBQ9FGf
         3C13x8+bjV8+unT+VQtYphz5cqXw0Xmd6DPABetaZSn+sGqrm45EdV7fsrWyn8PMq3tx
         AU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496149; x=1708100949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVG4rmAX1MzvfP4plhvh6t2XV6btpWEjQfp2YBQC/uk=;
        b=nJ6U5ed2r9ICmrciXD4GE7EhvjbbCWORgGtyzmHyMNVhofjLDywDmq6/gt56HE/f3l
         DgC7oNyCz+9WqiqbkBZVQck/KvltXDmWHK4Yjs18SSRLC0qPcsmg7gwQQKFH3IrWZaPi
         +nG5dxLHGJbYoVQVOyb/bxSYxeHARVzrJ+egYptUreQdLKqo0lnncbEVIA2Sy65R2DRu
         zUnGJGCCtP/kjq/MqoPpuJy7DHOOsK0AJ0EAaOoVJLOObofB0EWgUq4emW07njlxZDaJ
         u6kJnWzsWetXOTo1JeeV0riQaP20CLBI7HkzPbW5p1AOj+l1XkbcOoJ1mpTgYoHyS8Ck
         SIZA==
X-Forwarded-Encrypted: i=1; AJvYcCXshtN/o5yUCtoXTpofe75Oq0dgyJWwo6JQp9+v4ZQf1d/tO4miTp3N5ypFlF1YGaIBR/bjg3kZBVEOuJyE0th97TZqG1J1
X-Gm-Message-State: AOJu0Yxd/kIw+d0PZmp22iooTwDSBWP08WOhLTUlwTmrUJojyKH5w2Jt
	sRf1waoHvuuMkUy7WNjNdH/3AcpHaWsK1XmO4sb05ITc7zQ4HhIOUthls6N8bmORak129KwxbD5
	RCUJ0RzdqDCD4irjENYia01GWEhG9LrnEhijCdV8VTgT/mMk5yUW2
X-Google-Smtp-Source: AGHT+IFIjW6afRZSpR9rGbKLm/rdPxyNG0Z79tvHaAuAYu4k5p6b6BVAISbXhE/E21/MzIbNn74/BFd1oyH24+ZmDyE=
X-Received: by 2002:a17:906:2b53:b0:a3c:177d:cb1b with SMTP id
 b19-20020a1709062b5300b00a3c177dcb1bmr43168ejg.10.1707496148741; Fri, 09 Feb
 2024 08:29:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at>
 <ZcNdzZVPD76uSbps@eldamar.lan> <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
 <1d4c7d06-0c02-4adb-a2a3-ec85fd802ddb@vrvis.at> <CADKFtnQUQt=M32tYhcutP0q6exOgk9R6xgxddDdewbms+7xwTQ@mail.gmail.com>
 <CADKFtnQnz0NEWQT2K1AGARY5=_o2dhS3gRyMo-=9kuxqeQvcqQ@mail.gmail.com> <cf6b1264-8639-46e7-8dae-5aff0306e958@vrvis.at>
In-Reply-To: <cf6b1264-8639-46e7-8dae-5aff0306e958@vrvis.at>
From: Jordan Rife <jrife@google.com>
Date: Fri, 9 Feb 2024 08:28:56 -0800
Message-ID: <CADKFtnS3gkGWfwD80intR906y4Hn39WHOraY65mFtqzE_-iMyw@mail.gmail.com>
Subject: Re: [regression 6.1.76] dlm: cannot start dlm midcomms -97 after
 backport of e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
To: Valentin Kleibel <valentin@vrvis.at>
Cc: Salvatore Bonaccorso <carnil@debian.org>, David Teigland <teigland@redhat.com>, 
	Alexander Aring <aahringo@redhat.com>, 1063338@bugs.debian.org, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I sent this patch out to stable@vger.kernel.org. Everyone should be
CCd. Thanks for your help in confirming the fix works.

-Jordan

