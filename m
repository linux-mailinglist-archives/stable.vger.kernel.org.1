Return-Path: <stable+bounces-74046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F78971DF3
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2F4B2109F
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA1544C64;
	Mon,  9 Sep 2024 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk3wagcL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2BD3BB47;
	Mon,  9 Sep 2024 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895297; cv=none; b=JO8qUysZOM/6ED8RPBPFhYGMhsB5g9kQtUrz5x4auz9ZeasYfgJA8RLehmZcHzQKV1oWKP3pdl4ex5eBE8qm4NP/nOatM9Qkin1C6xtklHcrwEVCpqlYRgGHrXvPBgju1lLn2540e1SuvLHODrTyIhquQCiMKrFr9tXebhgGYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895297; c=relaxed/simple;
	bh=yMfFl94GModg4Vv5/SrYk/4bQKr9V7XUKEwzukkKqiY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=puEc7rsOIXKYU19qGO2XtPSBVyVMgGEIyLThOYfWQaW99c1uiB+EEcTGwUV8FdyO/fAjZQI5aNQwmTcGc/QUdxX8JzVzrObj0cbDshmEuLiBg0f1fC3PV1+DaoMEjf04PRyTWmmdYzMsj/c3+jUm0PwOumdksdNx8Bm9xycAAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk3wagcL; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9ae8fc076so110983385a.2;
        Mon, 09 Sep 2024 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725895295; x=1726500095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjIaUM+1pKmqbHqzzDzIkXQ8s5dYbGM6O4ICBX/Xct4=;
        b=Hk3wagcLS7+jOy30H+LMGh+4yK1Iuu/FAqZz33DNgbbYrOvMVgUdTGqKhYtdA59pf5
         gbrXbS8SzNbu33Gndb+DY7vTd0JaJz2EN4tmw/pxkeL8wjJ6l2JwjKnDn8D/QJ0nCnxR
         QfYce5/xW08eZOxnb07/ChzwQXLh8GuGRpaHm+knK1prNZmjYxMKoexZJdYdg1DaYREA
         lbwo6Pqk460xILsJpfHRQP+UaM4Bd0l22HArQ/xf8wzpYbHEdfSaZKpcfe2NL3Dsw5aK
         8dVzyFrgxMtXopgZAfKJaxdEn0t+omOjwxip0JFK3M69ciaaY12BtTINNHBdIxfv4PIa
         5ZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725895295; x=1726500095;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pjIaUM+1pKmqbHqzzDzIkXQ8s5dYbGM6O4ICBX/Xct4=;
        b=HijyHdnhTeSWptkv1ZGxDpKBnup6H7Fk7L3Ls7mjwb2usAJvDtwu1KJjj84DF+e8eb
         +w8VmwdvH5zHccpyM/K2K7LI5+4XPWWyDjxvZNVLQNDGDp3bJxRZBHAu7bFHE30WR8Ke
         Y7zIMEJgZm3o8s80I6aCFIltahrJVUBAtmpVCP4dCIKGnCBMG/2+TcjtE5a10DY0bq6y
         ooseSPRo0OaDDDQkzb2Vizrdrd/1RY2UfxHVh8FZDvLKtd51Gsu+FnO0fDxwd9QBpgxy
         XF+m5MnxWHvC1tFLvLtKIkfMDsxJstS+MRClDRggrTeUIW+qyeI4kIRnt61i0RoXFXoT
         GHXw==
X-Forwarded-Encrypted: i=1; AJvYcCV8sFuqZp3RfvZKyhiqsqtCjIfzaG+JHux9iwo2B9204/6paLsWRQUdTIPZHgQmeh3LpRM7b+8=@vger.kernel.org, AJvYcCWPq5cvSuz5wQBtdEKqgdqnBuHkWLHjQiOZtxTYoMimGDJDUwsuHa98iWFiJvEfD7rHbY+O6cE+@vger.kernel.org
X-Gm-Message-State: AOJu0YwpDmxtHfIZ+0ydRv3/q10A7T/yXg50vzQiWMxDR+s0S3uUgudq
	Rv2RAA5jaUrDwvqfhONWCUVUYFgF3joiAtA1a9ngrpM6c8qfsc+G
X-Google-Smtp-Source: AGHT+IHtxTRzZ309pu/Nln+VlED4Kz48R8OZhsSiVjc2YtpgfYVgrBa0Gr35Id8txduujy8vztnf3w==
X-Received: by 2002:a05:6214:3110:b0:6c3:5af7:4a2 with SMTP id 6a1803df08f44-6c52850dcdfmr98511256d6.35.1725895295410;
        Mon, 09 Sep 2024 08:21:35 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d732sm21622756d6.91.2024.09.09.08.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 08:21:34 -0700 (PDT)
Date: Mon, 09 Sep 2024 11:21:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Szabolcs Nagy <nsz@port70.net>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Szabolcs Nagy <szabolcs.nagy@arm.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 mst@redhat.com, 
 jasowang@redhat.com, 
 arefev@swemel.ru, 
 alexander.duyck@gmail.com, 
 Willem de Bruijn <willemb@google.com>, 
 stable@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Felix Fietkau <nbd@nbd.name>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 nd@arm.com
Message-ID: <66df127ea688d_38b8b2942f@willemb.c.googlers.com.notmuch>
In-Reply-To: <0b14a8a8-4d98-46a3-9441-254345faa5df@sirena.org.uk>
References: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
 <ZtsTGp9FounnxZaN@arm.com>
 <66db2542cfeaa_29a385294b9@willemb.c.googlers.com.notmuch>
 <66de0487cfa91_30614529470@willemb.c.googlers.com.notmuch>
 <20240909094527.GA3048202@port70.net>
 <0b14a8a8-4d98-46a3-9441-254345faa5df@sirena.org.uk>
Subject: Re: [PATCH net v2] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mark Brown wrote:
> On Mon, Sep 09, 2024 at 11:45:27AM +0200, Szabolcs Nagy wrote:
> 
> > fvp is closed source but has freely available binaries
> > for x86_64 glibc based linux systems (behind registration
> > and license agreements) so in principle the issue can be
> > reproduced outside of arm but using fvp is not obvious.
> 
> > hopefully somebody at arm can pick it up or at least
> > report this thread to the fvp team internally.
> 
> FWIW there's a tool called shrinkwrap which makes it quite a lot easier
> to get going:
> 
>    https://gitlab.arm.com/tooling/shrinkwrap
> 
> though since the models are very flexibile valid configurations that
> people see issues with aren't always covered by shrinkwrap.

Thanks both.

From what I gather this affects any device passing packets with GRO,
so should not be limited to fvp even.

