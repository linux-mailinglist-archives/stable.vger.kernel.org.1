Return-Path: <stable+bounces-108109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C1AA076DF
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 14:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91547188B637
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE0B218AAD;
	Thu,  9 Jan 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VZgq4P8M"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED019218593
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428438; cv=none; b=oTNoDdHgSggC6qvvjZlX9EZ5dnyQFOPupb0b72DibMagQxkfpoCxGwOP5JlVZivSmCGi34D/eqBnmRxUxUUhatEwTpTLzGK6UVLtOhkC4jNkQ6tlPq9YTC6CxPxiNJ03YRcsuuuYmyGfsOI/tchexkddNl5nY1ZbUGQnkz+AHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428438; c=relaxed/simple;
	bh=TwqBlKCo/5ENazwKpYfsYMgEwFOcQaBDDaRLL6b7F0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhulrUwCEPpbNJFchp2BTfJ+BvkGB3JxQud3D9GAoP1Y0uuXMgB4lHJRPM2e3Sexxvel5j6/zt9JALmWeuwvG1CSlI96PHu2nJqDkX02lxKZ2aVaswz1acuiqFOn8v4ONWqQMjDSery3dQ8qEG7fGc1iTJKYTiBxzYZStzmZc8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VZgq4P8M; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46b1d40abbdso5519021cf.2
        for <stable@vger.kernel.org>; Thu, 09 Jan 2025 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736428436; x=1737033236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TwqBlKCo/5ENazwKpYfsYMgEwFOcQaBDDaRLL6b7F0Y=;
        b=VZgq4P8MzzCxCeL4uDMp4vnX5xbYFma5IQHgNdf2FJkHIxzJ8xIm2uIeSMLB4PWMfY
         uhkouWeV2ZKEoOTDKG5dkosJIe1wZBBTit3fTuTCROfG1bWQJuucu8dBTluU34PqdHad
         t8zXwi+XF4bOljc3v5otAc1pBORXchCox8+ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736428436; x=1737033236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwqBlKCo/5ENazwKpYfsYMgEwFOcQaBDDaRLL6b7F0Y=;
        b=JZzCL/i/DnDuon8oAdWOm/omP/BpjifEON42+5lIL1Wp946mZrhshucSK6XhcJ64Fr
         REV82yud10/DyMLq704IVYN9lza8SNS2DbWnYsW/VM+/3QZUir9u/1r/sHum6GC3v2Le
         BnUW7qVwyzAeOaqqwT7W1XODcVKq8LBKZTURJ4g6zqjcXXauERaxGwsuvqrNQEt1ICMj
         by/F50DyJ6lKfLZ1vTwtmcT/USdB/pTeK/VXQCaaInk1W2SmIJkB6R8Z6+9FHukSm47X
         tgneRmdocbgGCABXHRxu6kA5RtuZTWoNwCCh3cSVbFzT3WyPCYY5uruVTn88hkTTfOFH
         fz+A==
X-Forwarded-Encrypted: i=1; AJvYcCVGFhYZOHW7kPFvoD14eddFOWAwswUxLIDTw0a0gFLwYIuMToFdtXAMGiQWq4lhFB/ifYq51lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGEXMfM8mZBtrkrJny+g9VJQmomQvxi1b35dYnJoMHzlyiPR3
	e8JctEGIkf1V9lJpDAt+/1J8FZxSYpOfNmmtfIJz64yhpMqvuu7v8IAMK5ouCBeYKQ6aMwj33d8
	7QwEFPRX9HM4cW6R3V1PIIas7YrWkGOzw427pCQ==
X-Gm-Gg: ASbGnctIrIZsOx0iiZam1bu0Asa+HLzOJ/mb7uCCDKio632PyvZuISSnDXm+IRIZBHR
	GNuXqk+wTlPgnwfO5QxImj5M4jTjX/kSxOp7F3dU=
X-Google-Smtp-Source: AGHT+IFG9GJ09B4FJOZ+YFICJgZdpqOWtmk2iKM62UmCr1P+AGqCNFgZVmbiuXdIM4c1ctKzMWFGlhfolaoLVp2CoEQ=
X-Received: by 2002:ac8:5a48:0:b0:467:5712:a69a with SMTP id
 d75a77b69052e-46c7102fcb6mr96531341cf.29.1736428436036; Thu, 09 Jan 2025
 05:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003d5bc30617238b6d@google.com> <677ee31c.050a0220.25a300.01a2.GAE@google.com>
 <CAJfpeguhqz7dGeEc7H_xT6aCXR6e5ZPsTwWwe-oxamLaNkW6=g@mail.gmail.com>
In-Reply-To: <CAJfpeguhqz7dGeEc7H_xT6aCXR6e5ZPsTwWwe-oxamLaNkW6=g@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 9 Jan 2025 14:13:45 +0100
X-Gm-Features: AbW1kvavAsEfIUw5DyroXkQiIKTKKS9TDRTAdAT2RB5wVAD6b1Ef2WcW4M0Jvo4
Message-ID: <CAJfpegsJt0+oE1OJxEb9kPXA+rouTb4nU6QTA49=SmaZp+dksQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] BUG: unable to handle kernel NULL pointer
 dereference in __lookup_slow (3)
To: syzbot <syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com>
Cc: aivazian.tigran@gmail.com, amir73il@gmail.com, andrew.kanner@gmail.com, 
	kovalev@altlinux.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: BUG: unable to handle kernel NULL pointer dereference in
lookup_one_unlocked

